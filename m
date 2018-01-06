Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 153E91F428
	for <e@80x24.org>; Sat,  6 Jan 2018 00:48:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753466AbeAFAsq (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Jan 2018 19:48:46 -0500
Received: from mail-sn1nam02on0106.outbound.protection.outlook.com ([104.47.36.106]:56393
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753459AbeAFAsk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jan 2018 19:48:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=P5gPsB1e7uqbRu5iq3g+dS1lSrQcSxnKNVk0nCHelb4=;
 b=EUFrx0Fw+fzLXygSOenlMljAZZnBdTShRjhA80JhkJltIygZbm3YGmhUQg4el4aNKqVdPNNDEMeBbhGeQqmJ9mpRDjn+VI/QQJMC5HOSg/EdpMKPU4PAJase5F3Xkvgmc0W2u3RrfdErXB/IK2WGa+6p6OXzmHT7ntL3soP108o=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.88.245) by
 CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.386.7; Sat, 6 Jan 2018 00:48:36 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v3 1/7] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Sat,  6 Jan 2018 01:48:02 +0100
Message-Id: <20180106004808.77513-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180106004808.77513-1-lars.schneider@autodesk.com>
References: <20180106004808.77513-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.88.245]
X-ClientProxiedBy: HE1PR0102CA0039.eurprd01.prod.exchangelabs.com
 (10.167.35.16) To CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM (129.75.90.88)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1fa443bc-7071-45db-a5c3-08d5549f39a2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(48565401081)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060);SRVR:CY4P136MB0021;
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;3:grhRs6xUl2xndC0Ik6KnZdaqo1JUIb2aNktmF10P/U85j5yZzrQKIUft6dMD1A4BbvGeTthVkJjTXr3LvtqHFkl9Qefzv+o25lMvlrzBO/NYpMh5mhh59Ftvspcj0BN6JdP2dQWdLx0OfjaSIYcB73XLCY5/2BUWJWDq6inHDdh4AqMq1iSwG9yIFn+5TyCzkjyxIhMP1IaFZ67/51Kloconr7FKZClLZcKGXEn5KgXDd9AE3TG+gha/iV8v9lrs;25:eDCmjmwiFkTOUOQ2BCzXRwB/D7IbrF/snrIhYtSVfjUC6/xMEAqVfN9dSMGhlRHJX4hrhq5O/IhAxHNJgmuU91oeS5gJfu7iGj4ByLsYLIzM2ogmgIt5q7NIwiD79V2FU9girfMpwHNYYE+mKSKF/VyHwVRsGfKVBTllj1q4Sj5vQ0qNOAMt5aDsK3kf8w2H56fl8IDIaTC81USwqzHQmIp/wc9wvABOMa64Hujleh67sODowFYQiGG3lRTQAjWMQAb6L14RKgyXspx0dGNQoSDngf5UxSh9k72uqFGuj4PpHI7/BvXnWSGPrajt1GgF4fnlJqbStlwY/LTcIwEJrg==;31:T/i6MyTNhFYgO6YoKHNSk0bTsw5VB9PKzAk3lD9GYHWLTh833LeEQX+EvCeiaItDFkHyEynfet9NgGlzRBSbDp8NVS4YeZGpVOPI2uk/j3ax941I2YuUHI2FsLULVR961K/ZEXrbz85Jr8kLnAFeP9NtOURhSoqsleE7J2I6ExDTh4Ljnjj+3D2JVL2hsivjDqPTJ8jFWT22QA6WexBsU+II0R/CrNJtQdwhMfVMjFI=
X-MS-TrafficTypeDiagnostic: CY4P136MB0021:
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;20:8Z26FZ74iF8tBUcutzC1YvQE3xC/uhqXgsloIc9Ym6lLUa1oWTF4OUdqG8l0PIN0KcfxIfLZJQZCTTfpMbIAwHuF91Bw8GhH1B4y2gKNeBwSR6wQHvjE8/2JQFFeHVk7pWy3vJM8GhE9tcHSggrGccW1vRw17Agn933cFeINHLcbVtGiHpFdxs1TAm51HU32EvSpx7VAogF88OqmySHyMYvXzjtlDc8hFMfiLv8fk5Qodug0S2NB2x/pkp+O4lGXB3xcOocfc3Xgdh7svAbu5FUPx8RnpyZ8DIki3THC+TvW9cpdjFMDnvLDL7hxBASTTrPa08yEPYGea1rw01MfpuHnElcFOTBDkj8UAI4eS1rz+FEEEA8i4ysbJA2xBT+JuT2+drKu+IdLR5Ra9XeG8ddc/lcoUzIyluv3tqKm4VyuQhs3vg/JoHpZR6K4vPbVU0G2+DvbW8R/srBW/rxXTqzl6RxGkmylRv1Lo2uYt9g6MUTZoAuJHH+X3wU3y4WlEOTiKTbDK+prpFqXtYDp4Nbr1Lrjw1sTzTtaV19rTIMBSDQsZTTCmUD1hmV8/MlhYfWbLesEEGvODx1cmFy2pHEvNrClVbSm6blr9BGerYw=;4:ZyK2du3bq1LKk0GBqtG+DSuZvl+9h+E3qLkjMXg6yjcFRoIyAdHkigZJsgR6FKb57Fe2ckfM4ohZy1V7NXx6W9qK7SXvKnRQ6fF/217ajNupl2E2K1pYgtp3CheNlNKSaj1lAAe2rqwLafQphPyRE/bCcwDkuAnhTk+X2Z3AcSK44I73/ttPjGXmVroETdsZfeNgBWRu/kJpy5nmC9tMxzR+2tevHojJz0MXCQerImQiLoFffxXadqyO7VNtjGPNw1F6zGRj52/ySHzecAeN7A==
X-Microsoft-Antispam-PRVS: <CY4P136MB00211977C3FBD7C37011F8B2E81D0@CY4P136MB0021.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040470)(2401047)(8121501046)(5005006)(3231023)(944501075)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041268)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:CY4P136MB0021;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:CY4P136MB0021;
X-Forefront-PRVS: 0544D934E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(346002)(376002)(39380400002)(189003)(199004)(377424004)(5660300001)(2950100002)(6916009)(86362001)(478600001)(6666003)(50466002)(97736004)(106356001)(52116002)(2351001)(6512007)(53936002)(7736002)(50226002)(2361001)(6116002)(3846002)(305945005)(105586002)(1076002)(85782001)(9686003)(4326008)(8656006)(66066001)(33896004)(16586007)(316002)(6506007)(68736007)(2906002)(51416003)(69596002)(39060400002)(76176011)(8666007)(386003)(6486002)(53416004)(8936002)(48376002)(25786009)(16526018)(81166006)(59450400001)(81156014)(36756003)(8676002)(47776003)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4P136MB0021;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY4P136MB0021;23:Q+aQbw7RR9QFfa2/UjrPNFk+jw1XWeiCIzpTeAX3s?=
 =?us-ascii?Q?gPwQ/ODsC9dQmoWf1/0/3Cim2dTL4KkHZ80I6YcPPlse+5RLifudmUlFoG/I?=
 =?us-ascii?Q?UyiNjP1CDLnmsn8csh5wEF7eKVAeApBcP3/53pYmrVB8RP77khUOaGIGjmwv?=
 =?us-ascii?Q?pZqKOWjGjpTUtbC2Wry4qVXcfC+zfhYDZA0AfG9fdp2vFzqRe3HixdBey6rR?=
 =?us-ascii?Q?yWWtfUJMmFH5cdSXtHFdK40vVGucv8E7VDIcdNzZtqyGL1/E8ZPOx71xrtTZ?=
 =?us-ascii?Q?HsuNtCNWamxpaR57NpK9djo5MmMQ94ZbxrEjYqZfZIIpedA80cFAOWZwyVtv?=
 =?us-ascii?Q?jT0bvHVdeoPh1HgEr4nqueDbzGVBiHufn6a0RhwOI4HlacqxOIhuuZXpHrQS?=
 =?us-ascii?Q?AN4yZvK4uEGc6JsdBYz9IXvbOB3Onczmikn5RQQpihGA5hTZdad9sXwyLlp5?=
 =?us-ascii?Q?9K1CvPHHNwsHRgMPknuQdeW1biNHAcru8PyCYqBPETEFvV1tufPoj2pcjFtO?=
 =?us-ascii?Q?lkoXt5SVy8WKRvjy3JPiQqOEc+EMiNvJ2VkLm9tlfVkAquXmkeUwbLrRqJo+?=
 =?us-ascii?Q?8rlSIevOCUluxVSh/rUqDmcidGRf/IXmkEsRSmzTdNHZFgxv/GVzg0lNUObk?=
 =?us-ascii?Q?t61dHDIdsm4OPGEdV8FUpSRTOBoZhlY/aASBSVmYmDppfRBQo2dMvxHHrQ8P?=
 =?us-ascii?Q?aNx2ZOYfKoWBh3ptLy2YyxKnni+i17efVyYvZwCOdRtDK52ktPuMi+8fqwmx?=
 =?us-ascii?Q?DIdHekKCPJ7yxK7p1+KXP4JGULjeJqPpVZInVg0smqzDnLKga5DO0XCjMqCz?=
 =?us-ascii?Q?CVa2DtaFbqQIPWDFBry3tTk3TY+hWaB45w6SOh+SiSMrevus4U1TDZRWkeb4?=
 =?us-ascii?Q?ICmkALcNVkSyQH+3oeEYx/m2B+b3P1csZBYRhJonHb8vzb+TfSx5dZjhaJJl?=
 =?us-ascii?Q?E9qKPpZs1lrZmvmpN3Iw2bwFIfWhhaRNnQxQljKub4vIe5AcsGekR5LdWQWT?=
 =?us-ascii?Q?Uxm7TLUvXERI7j6oeWWI+0qiMDIsHSu75eLbCSIB9R6cQdi0/xD8xSVF/J/l?=
 =?us-ascii?Q?LxOxPyYylkgbLWoILl6O2sfjils1BpcJxDifxBXn5RvbX9VZE+mQBYDGH/8R?=
 =?us-ascii?Q?YtNlf0qySMPH3+GCAqG/ViM1LJOatik5Y4XI3XxjtqmJM2sHkd37XWpqGzrH?=
 =?us-ascii?Q?8YcsWh0l73o9I9ruFZhHQVhONXOwbyUCI/Hp7D6uRO/s5JqxD2UDLxAe9b3E?=
 =?us-ascii?Q?huUdoj9uaLYQJJFQRDtNquR5OpMCS1hMlX3QUz150Cfp21KQoISiDUz6J9Q5?=
 =?us-ascii?Q?92FGwj97j7vUoMa/ti0ZdSuz3aZUkgnVVdwy0DTtk/1E2452Sr2iMrHKMo4e?=
 =?us-ascii?Q?muGoY3bhAObRHpVz51PbsVSjA4=3D?=
X-Microsoft-Exchange-Diagnostics: 1;CY4P136MB0021;6:o7ypP1/fAwyj+vF79+xqiYwXzOCRaao9A4T46bOg8OMdcHLqsFSvShFY/ojApyCfipQTXT8/wrwU0KAP82bzmy37qDXe6MiwBaa5UUzuRPAIe/CReWqEXO2kki0GRU27Q4n3BnTbYKZEouvrAs1xm09XOVRXY/kMakzGCqttrWhKzrGivIMRUfAqyQznXv+jFgHEMiUhw1yzmcDMtnCdUppsLzXvVJNWWDo2NftI4jrtirfoCwWzfUTbR8jUN51xqtMY/DrGSaSJOMQK4ORLNei9pYhx42iBeO4NM061ZEgQeaat4R3HR5wHWw1ke4ODprlaLeNzeQB9SPspdq8Oabvr3Ljbb+VLNyJUPtfqmdg=;5:XFY7Jwd6EaPzlLbEA8ayAQrov2PbfgqpDNQbevECTa595yqzibBmt98PwWuMD8lUCfxNTZtya1slftbEN3UQigI8fU0IaGLZ+qmm/qigCHHKyFBBxyU9slJOPw5HKTuFrEm42fVKn8x4YcL0t5OXYi4h6BB0ujpsAxlQofZJegE=;24:DhZWNPOaYpJQYtgO6afppRwcrqPZS4P3oVbkZmeKYLUSr1sCjzFRdwimdmq1ZxeW5mJKNuO9WSmKwTq/3NO27qy+iOGtfWWvFF+RT6psc4U=;7:596eLmRYG2VpOBuXdbizYWiayjvj83tlTToXILJrari2Ey9VfBYGaZSWXBbVUVY/TDVAnE3F3IOOktFAY8xrqoUhe5xFo2rhVGsgOxpqsK/lb+fWIYojo2Iso1mbXUxgrENs6UqPV1Df8P1ubxNdo0oTYKO/cdMRQigkn6eQsYQwycX/cy5UmW/h9XhHcKOOpzcRag+HsziJ0JJ7+f/yOh/7flvlgoAaDyQQ/u2I6CuN/E9CvZ6uZQMCT+/MztlH
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2018 00:48:36.1599 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fa443bc-7071-45db-a5c3-08d5549f39a2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4P136MB0021
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
index 323c49ceb3..b5d03a5029 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -756,7 +756,6 @@ char *xstrdup_tolower(const char *string)
 	result = xmallocz(len);
 	for (i = 0; i < len; i++)
 		result[i] = tolower(string[i]);
-	result[i] = '\0';
 	return result;
 }
 
-- 
2.15.1

