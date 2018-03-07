Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F72D1F404
	for <e@80x24.org>; Wed,  7 Mar 2018 17:31:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933352AbeCGRbG (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Mar 2018 12:31:06 -0500
Received: from mail-by2nam03on0136.outbound.protection.outlook.com ([104.47.42.136]:27224
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751241AbeCGRa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Mar 2018 12:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0FhNnc8vDSDGItH1ynWJkeHjAoBB3b49PCehSQPXGUw=;
 b=pnhHuidZ2WebR5b0dIDN3t7mJ6LxKrUjaoSo/hJxWMUNokP/jHk0NAhTBWIHNDnYPvl+PsDVO6ROLGrEbO2GT89oK96i71g9wz9Tx0ex+JBWyWoZ2xPCE3gR5W0QCwCBo9CXjhKELKZfOssnbgjNqvx2ql1ixF/LD0zcQ6uGIBo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from neu8r3hm32.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.548.15; Wed, 7
 Mar 2018 17:30:53 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v10 2/9] strbuf: add xstrdup_toupper()
Date:   Wed,  7 Mar 2018 18:30:19 +0100
Message-Id: <20180307173026.30058-3-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307173026.30058-1-lars.schneider@autodesk.com>
References: <20180307173026.30058-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: CO1PR15CA0083.namprd15.prod.outlook.com
 (2603:10b6:101:20::27) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 25d0f55f-39fb-4be9-3ab0-08d584512fbe
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:EQDg3aTQp//kQ0J6evTGTQuvmYb6U1cMgdxp6LkNhi0EP2iRBlNOakeu/gePc/A9WyR9X8/yO9IgxH8yA+GxKiLSU3k0CPP/fijuCNgP50iAKS8/DYE/w1qytv7zWGCpIuIe5gpeaUF3Ys1JgxElLG+DoqwOMko0dRHG7fDRlIQFCpqODeZTw1i57NA9xHtXSs/6USTuWX9Nyw3ubpHwMEIKIz2H+NffQykLbKbaPAPAoqVpj/HrUsb+WGrzml5W;25:6wsdXrzJ64jtq3gpHTH3oMTyKHABuy/s94OXuuR8Esu94ntkrIXnzeMI+gQLhZB2Li11Uaf80wUZJC+E3auZrUz2eBVvJmS504G9bKVLz20UCp4dYGX5rhUNU5nLFvGbAuM4BkoLuEFcml9e2dgCeYStNZHP43sJkPw+yDVpO2A2KemHxu+NTo7ReVRE0uqSFK86v+XFWNKZkYfVaBKcGyHvtV/qil6wy0dXaP+o9c/AZnvtUxrYZvZGLrk4YKh/dPHhgvglk6gLp9sjttj7UpvycjCsj7Nqph42ot1+CD9axypsWh8g7PXepVJlbbSAWNokvSaWFNVQLlzO4AcQEw==;31:2uXAi8jvyfIjM84noIi+pY/9XKsL2vQWsruk62ya8jBdLL+dhTXYI8djv9MrLJq8LIGAqt4spE9U+c746S4nkPwZkZZi731gz1tajapBwWdPVme9wrtRVJq5k92H2GSmOabIUrdoGt2dVR19vLlml44ifeM+nbNpDYPAKVLqXCoMtvRqWrRavX0iJsUFUHqH6MKUgYQHWloUL+KtqAL0mLX6Ue07aBm/vfn1bCzm//Y=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:MTFYruwFqlk39299zcHUkgbd5QUflsgMK6+sjGRVsLZ6EJS6DoWQRhTzNrMBBSqI/nSDY6fUAxSWg7N1ZZdiCEusksEhUX1Jq8mnBmefCaUj3hKdt8lX2tsOHmwNG01OUHVjX6aQPExgyIHQSjI6N+8c7HhFjaoGH7vs/9sWElvI6qUQ6ux1/7JTcvKnNcDVW+rWAemYd26Nx4zu0mY7Twi/DRXg1ZghqnjxWSBiRSYJ3FlGppW5MsoRJLSvvbIFbFt+bFf5GdKhp5r6DoxwASQ71gx5feYHcus6xOr8k16lBLm6M7rhA4eqXKbrK/4XpJZgP8aSfgnlJiRWRVEr9uAFiz09JBRivJLfRa5QJm7fpN/AjAuXCwIQDCs/WBJfSmXvi6zaa7z2rZVR78DrimzgWJeW5Wpq2lLJ38Vb+Cupez+j5tjEyIWGVyfAskKX2JnFyXwUy3Fy7SKBqzJm3u81adbofU9ND4QA1uBRhttgX/funPPj8I2+CgXkkfLDmMK7wDHlAZ3qbGAxqCtdlBgTVf7WSwFO9HuIUSNQld36HQyKLyh77eoDUBA93WUnPACA237VgTfbiMA9rhSvHhIbL4ez2r3N7etdvapqCfs=;4:lovv+kQRn7tqtss9rtfAb+iRRH4Lb18XwfBQeAqM4PShbRfMMQCQT4rw9ysd4wW2Ecs1zRq/Lw+LPsyM8a+8ERjOXLploLu2obMToCum3MFXKvxloeevbZzFtU2FxLRvqwj7SWcaQC/aFVpsza/eIpuyOHGyREOkpTMQs1R7xcTaaK/Tg4G8w4gF0TnPSTcyXdy+Ho/nXhphLfWhV/jEbFTCB4f2GX7T70mSCokLKayMJZX1JpIBCrY7fbMxPB3bckhDg576+FbbFcX+/RNV4IvQ67LZ4nUHr32P1HiG7h8AYssz7U4KcQXdJWqm41ej
X-Microsoft-Antispam-PRVS: <MWHP136MB00140329FDB63DD81D2F2193E8D80@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6055026)(6041288)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0604AFA86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(39380400002)(346002)(366004)(376002)(199004)(189003)(68736007)(36756003)(53936002)(9686003)(16586007)(16526019)(186003)(6486002)(4326008)(26005)(316002)(8666007)(386003)(8656006)(39060400002)(76176011)(52116002)(7696005)(51416003)(97736004)(25786009)(50466002)(2361001)(2351001)(105586002)(85782001)(50226002)(575784001)(86362001)(478600001)(6666003)(2950100002)(6916009)(2906002)(8676002)(7736002)(48376002)(106356001)(5660300001)(305945005)(81156014)(8936002)(81166006)(66066001)(47776003)(3846002)(6116002)(1076002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:neu8r3hm32.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:rk3mpEH6WmMsK3uRl32zOSI5NX2ii86g9r50rRDTv?=
 =?us-ascii?Q?P88U4lLzWKB4XX8SjGVCr89lsbeNvqqe5RwY4wLnn4adrJnX8NCXi2jxbHg+?=
 =?us-ascii?Q?RfEEpKoYi2L6TWgmjAuuduOvBuzxPVnKSo18CqNF4vOQsHLx6SIXKk8QEvQ8?=
 =?us-ascii?Q?dW8AtvlT39Tk3spVdsfGjS5TD29GxaxL64O3PNulhixYd9hwLj3mSChlOg2g?=
 =?us-ascii?Q?UaB2xWJCenBu9+gtcYU+/vbll6GWpkhGLpNAigus3p5Nl9OpddlqNQTtos8I?=
 =?us-ascii?Q?/KifX0h3fYi4DmwF0lXmHJDrTRkK4NQfubOhFQ1o3E6yizneztgw2CjVgvMs?=
 =?us-ascii?Q?xAR4qnNtzK758h4qvfL98DbwJdHmzT5wur6UgH9jQRjTz9R9334MYEM1TxwA?=
 =?us-ascii?Q?MnE3zcnvG0T/zygu3jDf5DAqI0dQWM32+ogEqlykej80vwFgAumJI7NeWg6B?=
 =?us-ascii?Q?oPEmrMFbSZGWIBwYhkSStYrRaiH1q8stbeLL6JS7K0i7PG6t9MFVs3CN5fAW?=
 =?us-ascii?Q?gcrmF43VKC5odp/hBpw/sI/k+3xFbuvtlC5HPTBIgf41Vp3vPMZyqpZaZAF0?=
 =?us-ascii?Q?5UAXsvcns3mY7BvtXsrNdbXuopoSkmnzcWYy/FJGAiT+tH5c0WlIcLK665gV?=
 =?us-ascii?Q?S8HOLAEu7NAUE+PIxhsjUF4CeppXA6dp6R7nuaxLL+fVp5xpfOg8GTCI4wEZ?=
 =?us-ascii?Q?6V96wzF4/bvALhNc3J0i55vCt+nWtOx0SDY+h4c36GoDqcp1baHfuvwJnrey?=
 =?us-ascii?Q?AMa/V4Xs4ZC/747HAR5yl9sKPJ/KfmgbyNzQv/s6q4P4aKZgHKYJqJB5e/tY?=
 =?us-ascii?Q?vmBcuB+3eQH6XzR0/Yx9dRKrydAh8eEB3KpFZmH5Ygauzf+oNB2HfN9EsZzq?=
 =?us-ascii?Q?vfaFHiehYz/peTUqA3JGxNbfD2HX0IsFZ7lnrqTwDqumsqUdowhQ286R0V2z?=
 =?us-ascii?Q?Ov3gEA9Mn5z59/g7xFxX4dh5LRsWCow8LbfK9a9ImWarVAIjpOUDfsHILpgB?=
 =?us-ascii?Q?8yxhNNy+4MRSmzZPOz3TjK0Wrvxn3NQ5afQx+5QaBnzmlVbUCtIwK9mVhqjm?=
 =?us-ascii?Q?H98IweZD6O6byXqCqX5pZR/ocO/1cImHzhMUl2/j6W9EnJwXcU/iNg9drdNM?=
 =?us-ascii?Q?xcUQkFbfV+lsixY1k3bNmNJLwtjpNugSyjubD9NiF/5UKJcPlhUJ9EdJ+YDV?=
 =?us-ascii?Q?jSTm7jjGrnKzN5xGuCQ54B8RTCxVLvZbES1kzJF366RADT/TqvlXZ+nNC7Gb?=
 =?us-ascii?Q?a+5Ml+vEZk27Xa6sxCv8+77gEYfUee9pDByEWBwlGBZr2mo4Tc7NdSxUOqIJ?=
 =?us-ascii?B?Zz09?=
X-Microsoft-Antispam-Message-Info: psmpC/sKC08cjA5ifrr5dBFbFrnlHmlhUdB1EqehupwUaQSyXTRPLiXyE5iL3hnIQCD+2YNmyGKKzqrQi5D632EL5NciEstIp+sRwfXzDVNp4jP2F0NPkNydiFRqAs4a2lVF4gDN5lF2clqkD+44RZocAO39ZjNpHs32saF8XhWecNl8nPCsuW+xgiA4YWIg
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:5DNGwsooo3XgywpNbNoWyPLPN884PdN4kw2DWfIH9seezQVjiaRKYO2E2/Cd5BjtMWXPreO5+CI4LZanHsaXBf+yxXJGeyOTuLkUCt5T1TfB41cnFvcQDuWqjr0mYqyfXaiKplO0oeBHN2ln/a8sZoNd9EJ+qdWs2whMANxmKrNpdC6zQRmcuAkITXrh7zKpbR+jO+BKefqL5cHFzAvl5JaiLZ1O0jPKTMZ9Du4n6qjV0zEDUGs7sqO9nLd0HgIOdJ3FItzN16Ka66iE2sPCMHVxj9Hbi9eCuWDqoUWMnd2imjq9aDjSyYLfiek49PFpe4AIDKp5FgYSf+sjoztUgq2MpBXQG0JzdancX2Yvufo=;5:c7mSLumKV8Taa7C2pPqYHCUcnJ+lgxvwohQRodYDmc98bB+OgaydNlvVvKDpleRA3otBTWZ2KBFAMDlmEuaEFMMhU4nxUBp48syC3zFdrPhrwL/8JwtwaY+OpfuPnOo6khc0Dpv+zVJi7Cfv7aj7+4sIQ5H9CiTaqnOAkLm2pqo=;24:26Uilgd/jDXpRmZrBxKpxPDbNYKtro/13tkb4kcmG821hXdeww48V6bLMDAhyzz1tAzyhjtEDB8fAsv2hctsZyExnz1x4r1ZKWOKSLU0GTo=;7:zcYIKPLbbyjhvFjmGzfScvY63zgg/bE/uy2vAyIeB8c2zv6hypvWW3ylVqrNV9jgQLCaiHwKDvgP81wz+/NSGH2gn1H9DnYSmpc80xz8Q5l2+C3KB+yndUn4434BgvDtqruuGqJD3pfbUm+TrxSRi09zeA2KnZakCRVD+oFF0MoVxPpyA9pnskHSue/hE4U2ZJQCer7e1Xkd4yy2grES2vflWEQ8+0JJAQad772QSrZ1sZVdB8QND6NLjzLRfYLe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2018 17:30:53.6631 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d0f55f-39fb-4be9-3ab0-08d584512fbe
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Create a copy of an existing string and make all characters upper case.
Similar xstrdup_tolower().

This function is used in a subsequent commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 strbuf.c | 12 ++++++++++++
 strbuf.h |  1 +
 2 files changed, 13 insertions(+)

diff --git a/strbuf.c b/strbuf.c
index 55b7daeb35..b635f0bdc4 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -784,6 +784,18 @@ char *xstrdup_tolower(const char *string)
 	return result;
 }
 
+char *xstrdup_toupper(const char *string)
+{
+	char *result;
+	size_t len, i;
+
+	len = strlen(string);
+	result = xmallocz(len);
+	for (i = 0; i < len; i++)
+		result[i] = toupper(string[i]);
+	return result;
+}
+
 char *xstrvfmt(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
diff --git a/strbuf.h b/strbuf.h
index 14c8c10d66..df7ced53ed 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -607,6 +607,7 @@ __attribute__((format (printf,2,3)))
 extern int fprintf_ln(FILE *fp, const char *fmt, ...);
 
 char *xstrdup_tolower(const char *);
+char *xstrdup_toupper(const char *);
 
 /**
  * Create a newly allocated string using printf format. You can do this easily
-- 
2.16.2

