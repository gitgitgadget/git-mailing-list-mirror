Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3847D1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 16:29:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751474AbeBXQ3j (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Feb 2018 11:29:39 -0500
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com ([104.47.37.121]:55968
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751416AbeBXQ3g (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Feb 2018 11:29:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=8o3sHu6rkjUymqBr30CM6mUK0fpAASLNdWncZq/XpwY=;
 b=gmOeSFI02+d8v8/1GN+DdRzmBXCDCE2vWgdvyLpO6cy8F7SLFcsnZs+e/HBOe0KcuswPwZLs1sCjT7FigEWc9mY8ujRR7rwoX82le1c/4bXIuOuwQU/EE5rliXdX8m5L00JoCGpLla7Th1GbeKJJukqH/YlXyvMulYJsZ9/7Na4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from localhost.localdomain (132.188.32.100) by
 CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM (2603:10b6:923:12::22) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.506.26; Sat, 24
 Feb 2018 16:28:33 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v8 1/7] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Sat, 24 Feb 2018 17:27:55 +0100
Message-Id: <20180224162801.98860-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180224162801.98860-1-lars.schneider@autodesk.com>
References: <20180224162801.98860-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CY4PR1201CA0003.namprd12.prod.outlook.com
 (2603:10b6:910:16::13) To CY4P136MB0007.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:923:12::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ac2d9352-d107-401a-f925-08d57ba3a6f4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4P136MB0007;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;3:qyX6Zxv94kL8BeD+cG28mt3YK67IP8ancv1Y4fzRnvL64gbdbDU9zFLEAvHFPW9TatoFYVg44vfNiJM7f8SKGfvj2GjMN8Wj2mIPOVPfXRyB/HDTKeQQ8ZC35AE35175SQznKxhysp+UcsRB3aE+Rjx3u9MTeeZKoVk0YWH54u9ODQ1FpAZfiG/HuOv6dff8uncnbqzCF3I/oLA9bRNNiJSTRyPhFGCU8R0VCkyZa5XBpN1yL963NRCWv67UsNxm;25:dIPS1IA3+BuY3EHmqas0ALA4pmFzkQP7wrFkIs2GkO1nzIEZW+YpXskY1O3pFK00VIg9RFzGcHmtCoE+664wk2Wk2MsZ249hSzD0KxKO57BkDYIbdTos1bvs4+URNXwfHgY29ssk0yHzyyC12MMvXSfUX76V6KzVmgtAikvtb84tM+XZlNsuYLnLYjo74CAB3eqXoeHXj8qL8W7lVKMyxMXAqAFZb1oWMhSuCyFqVoQljBUgzoPuKXeAr32oMM2SKoOPly59I8nim22vPcjcKV/52UJrgSphPkmQyxrUpz89u9c3QuhgxkD8/XB/8m7W3lkpKr7lZUyqN4mHGzKVzQ==;31:uoNVMel1Hut7DA/9ei3UCt4TJ+6xMX5FEXm1EdzPsoDE6VeNMSusNUcpV68Co4sB08YTfTNIpLUq3t85eAw/LBTLSrs34QQjeAZ5LFJji0JH+D52mktwi6K34t1Cgxny5N7CQvgDgjNEgx9pMGDXizWbe4VLMJsmXo9b0ZN9TgVXRvHg5GaqSk1mMASGn6251nsX+lohxdcVqjdbHs9RFANgH6FBwwJZ0/Jkwfju7/o=
X-MS-TrafficTypeDiagnostic: CY4P136MB0007:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;20:DA8uBmFRumNhNVBzH7AsNlDgP8KG32i2/bdVHAp4AvOWGHuqW9q3IYq2S09gNjg1u4ZIOhyKfgt9wmQkxlkshIXDoP3IzGCbBcH1bOuIIVQ0fymXbHOssetiLoZmqyvrPBkLgbRB+OI31lRULXaGtmh4Jf5rq7cOr/S4XHTn7R/PuzbFik9YFUjDVwb0fDxjQKZLq7wuIWP/UP9vdclosb00Tsh8FAV2+mwIYS0SlsUCIUez5VnCp1QKBt5naWnVBbqnH1/5m8hJ9HSDqMKKaSv9Pxid27lXRVl1M5CQ1fTRpgmSZUdqlLFzi6K8JwJHzRRZH4OT3GyKebm3zaVZ1C6BptvdADFwgPgxe3WfFMVGftvMe7vZea7mDRiflQW+j0Cc6qZ8i9gs1xB1un9axR8pV8+BQ4zKjf3sNAwmgeH8BlFsM6mbMSJyNGiyfvjCKEnZFKB4VANh7/KzFW4SPeCqjiPwVNYVfdNOv098XXojM2eKNINUjZqqLewab8W3cYYbhQY8W6IYEj9q/3aTOYrGUj+ERyqFGBENJlpaBBfFsQyS8p4za4Yaj5RWfuVxTa8wQRrFebvplqKhTE3V8Dg9W09V327sZZ2L5/0+pbo=;4:8rVCwaEXHdZ3AIRQ2ppj7ByX9q8EvAsRvPkL/dUXzhkCR5SzUqB/SQ5PO/kioqVluwOE4SNQ8MOKqRIJYLaUVDMJYgare9aISOB5Da6qKBfnEu3i1uCG8ZOp/66zfBLQf7y5Ojh/+WWy+p63R6p+WR8tuaea/4U9OU9gwRFl929HG2rWrXVuXb52lNFrHyEjKCJ0/r9cCSdJyn0K90gvpc1WyJ3g3zZGlYMZ4r9BciIXIgcnJekX2my0XyKIEexH
X-Exchange-Antispam-Report-CFA: BCL:0;PCL:0;RULEID:(3231001);SRVR:CY4P136MB0007;BCL:0;PCL:0;RULEID:;SRVR:CY4P136MB0007;
X-Forefront-PRVS: 0593E261C4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6069001)(366004)(199004)(377424004)(189003)(8656006)(5660300001)(7736002)(66066001)(50226002)(47776003)(97736004)(8936002)(6512007)(9686003)(305945005)(8666007)(6486002)(106356001)(36756003)(2351001)(2361001)(8676002)(81156014)(48376002)(68736007)(50466002)(85782001)(16586007)(33896004)(59450400001)(6506007)(386003)(105586002)(86362001)(26005)(6116002)(3846002)(1076002)(16526019)(186003)(52116002)(2950100002)(51416003)(39060400002)(76176011)(6666003)(4326008)(25786009)(6916009)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0007;H:localhost.localdomain;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0007;23:qCEEeoZKh52muS6pLBLaQmZRWqxwF1CjoxfU0V2uZ?=
 =?us-ascii?Q?0Uu765rzmdu2rSHye7ZtzZLcnn5oyk1Q8ISJL36scQDBcGpcHUwpxmpDVM2h?=
 =?us-ascii?Q?tM9XSOef6/MGWSAVHaYTf5pTZoU4ZKUF5/yo+2i09uLxNlyAtKAGSS6pW07D?=
 =?us-ascii?Q?oqmPoCEh47B8KqS0brnMstddwjafL8bRTA2VpHifbjLT5iv7s5vf674FGkP6?=
 =?us-ascii?Q?bY9ug5o2mrAV4ZipTnN1KKUNtgs4KAba6gUc79tSRy75rBkPusfDMAAYY4u8?=
 =?us-ascii?Q?VD7wpDeneKUXoMzzaUMuduCVosIcD2a5P58iomhar9pOjFE8PqdEMe8Ddsh1?=
 =?us-ascii?Q?AbMJjQgzCNY4ffhNMEWhWeTwHWVHR6hWAm9wQFLNKhgSj3LigPLTzL7+sdB4?=
 =?us-ascii?Q?XfT6D3U8/oopYpWkwBWPrSTacYIJRMteG4NF7Z7NERk/hvya8yQn0uNKwau7?=
 =?us-ascii?Q?9hlpSSYTFhvFbkOiNwRtmU7uU9WyOWyePxtv2vfUpNrbH/uOB4BIhNA6OmM9?=
 =?us-ascii?Q?khKne6wRadFitxnierL8xM9+VurTc9FJBozH9pSXJB0+3K1kY6tzT439r5ya?=
 =?us-ascii?Q?wGo077g3EThNYC//g+KjU+mtYzJSFrE0FD7limRfuCMaU0tLlGBv747VaGAy?=
 =?us-ascii?Q?WveV+1J2K3O3EWhRepGap6gEzfhi7dmlFkeitN9Or+M4HYGjUN8IjC/quK8U?=
 =?us-ascii?Q?0gh4eKyf5SZ/nho1LUVT3ENlIUhX2vRBAcR7bFcMZza5uVhgXWOWXN4Gwjcm?=
 =?us-ascii?Q?6ju4ijiWkSQu5As9COWLvdeubfvjWnwha92OqbqODqNgGG3xxdVJ4NLodIZu?=
 =?us-ascii?Q?af1CdCyR0TGSMx6cN8bgzTMIoSaLbWOYnIbiTEBFw7zG3mbYqsLod3mlnpga?=
 =?us-ascii?Q?A0udp+1set3tr0HOeOJ3siEx/S1r2yfeaDlv9E0AdURuRtSZr/qFe3Adcpq2?=
 =?us-ascii?Q?gCVEUiSWw2zvf/RAeDWZxGS8XrfYHtIDti58agiaYVkpauI2lzvUvofMaPmk?=
 =?us-ascii?Q?QIhZmFBQy2Y0VAa7Phq49P5HecB2y0HGK85PvKHXBgi9qsU7qapEconprvC4?=
 =?us-ascii?Q?4nxX/7zuRwI9NVKMSbf18k/cEz5h7LCsaWSJsjmZ5qFj/WYKgpyU29R2Exkt?=
 =?us-ascii?Q?X1xZSuGLfs1/aE0CctFySAaA0XFvK5wiXUoVPAFc0rsBVrO6HMrTQ=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0007;6:HeIGuvAfPKflUPWkZY1KT1PxV9EKhkyGVRyGcX2xSk4FShZ4We5OhXNpTnhbJrBSeFfPfqDD+lDae/ZI8kJ9XKlhlRD/xtZb0yMj4NvFhzUoXwGGvRSHUeOiF5y7KsACDOYlDbjw0S8n/Tr7HykJRDxWsNhUKdTXTyUTjayvQf1HVQ/NHCQ/td7pK5SiLZivb3mojz0rOTtMx7KETo+ZkIB/DW4tZT10mqByFbW1046yHCu/EsKGA7wQLvGgnh1TOaAeZJQ4yyTpVTGNgOOR2fj8aD3Y1N7dM+Pe4/cyiLS1J4yA845sa6VVn+ZnPd1OWiV8IaJ9aBNHD1uXFOHyTL2jIxfTg5PnsMXL6bnj+oU=;5:eZ4i+qYCZ31IGfRuALc60Y4UUurh/Iwafvjh8nN8R1CNyj7SjQd5tXCnfIHlcpG17mBgcYzddEOlMIlcDywrpqeZDzZ5HfdjdR3qs3CaonH8HOUal4Lm6w7NCrQffJGAAuq0mhIp7JHA9H+NbZGStCiYNu0fNBAOSmvPm/v5CcQ=;24:QZqYkRFBZbdx9KkrsAsgH24FS4zTYxomVZMkvPXORDzGkT/rwV7dWraDxXaPnE3776RRiZ7Kn1bUjJyC9C1a+Elxwrl1ssAyezKmR55jFy0=;7:MYO1oqVpLm4VC4Ap+/u2JTtI1OmZizU/PBh2IxXX+OAaGydKGeu9zwlaqi1WtZ8H/TCScddjumPdy4V4RfP495GbwLe14hb7D6CnrXlaWoao1sTx9o0K8Rxg+dmOtGLvz08jO//BEjmdo8L3ayq5rN4IEqz+usTfkzTuxOicbMSIN7bVjy+60UNrH9aa1jjhch6At0xrPDc9lgr0yQ6ewilw5bViAtfsW4pnmm7OevmXBivPvVQlVP1gI2HL0Z/q
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2018 16:28:33.2813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2d9352-d107-401a-f925-08d57ba3a6f4
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0007
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Since 3733e69464 (use xmallocz to avoid size arithmetic, 2016-02-22) we
allocate the buffer for the lower case string with xmallocz(). This
already ensures a NUL at the end of the allocated buffer.

Remove the unnecessary assignment.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 1df674e919..55b7daeb35 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -781,7 +781,6 @@ char *xstrdup_tolower(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
-	result[i] = '\0';
 	return result;
 }
 
-- 
2.16.1

