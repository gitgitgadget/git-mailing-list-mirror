Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 327991F404
	for <e@80x24.org>; Sun, 15 Apr 2018 18:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752900AbeDOSQq (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Apr 2018 14:16:46 -0400
Received: from mail-sn1nam01on0092.outbound.protection.outlook.com ([104.47.32.92]:64364
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752871AbeDOSQj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Apr 2018 14:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=yw5Cre1wefirxNri6ORzCepBwKORD3Rrurh/nB5Yu1o=;
 b=A4ypIHjpRFwf9DZa420VjzpRN1tWO6J3EW6ZCY+8tlICJ31fY5vDZwUjH02jAvdlFZyyD3gJCPoYHyGad7t5aCH0xp2habyImgg5VtEQmt2OwI1vhOPtk5AWPuIRIh83nJX1IZWtWe4RUD+NC/yljiLAeytiz6O8aDSDvQ05iGU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from remj8gtty1.ads.autodesk.com (132.188.32.100) by
 MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM (2603:10b6:320:1c::21) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id 15.20.675.14; Sun, 15
 Apr 2018 18:16:35 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, tboegi@web.de, j6t@kdbg.org,
        sunshine@sunshineco.com, peff@peff.net,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de,
        pclouds@gmail.com, avarab@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v13 01/10] strbuf: remove unnecessary NUL assignment in xstrdup_tolower()
Date:   Sun, 15 Apr 2018 20:16:01 +0200
Message-Id: <20180415181610.1612-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180415181610.1612-1-lars.schneider@autodesk.com>
References: <20180415181610.1612-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [132.188.32.100]
X-ClientProxiedBy: AM6P193CA0010.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:3e::23) To MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM
 (2603:10b6:320:1c::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:MWHP136MB0014;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;3:80uI7LvrGa3TndGOrKm9vtM/fY31okX8pXLPGjiclfQSsCvd+VnFs4rdIxYT3MT3tjj6JI99B+RPZetrNWiOoPrWYrxiIL1Mbzx39y5/JEjIf3Be9jz9fgBfWjqCLC7SYW39TGEBp6/SP+qoi7vI598q5s9y3P1ovySDXqtboKH2mZgm3HssIm6LxHQ0jvFPSU/RKr54BejU7mEtLEeb8jzC91kechxS/ERkCjy+RU50EDDT7PMMdgTp1Zux/CpC;25:gQ+4Qo0oiPRtNpg6RD2oyEYxP4YfaPrKfmTMFy5JNcFz55suOPy+NyRz+IjwLyaX1wLKfKDM5CyXclxeilTwXnDyuo1qqKz9jk2f+2qTq4E79PNQDWwqO6WafXqMDZY3kDh0Ml+P/fctbS1TJe6ypj59QzhZ3098DJ3rOmKcvRH/So/KTkoYK3lXNuu3WhTAvBnG8XBaUhFlLT6CMjgRTL2Xq4pgTtJ6eIVNxyg4YJ+CEW1SFtybbkHXlcerWSm9B3vvmuUF+Q/xGMBZzWp1KHQk0bE9AevsS06yfbvUQaK4vvPbRL/jt6YuXeJCJATsD5eTl41OM/6iLegLYf/TZw==;31:0MLpCb3+L3k19zcNUu5wlCxuxHz+xae0Mbg8PhkkuksP5gGZP+BMzrhflVu6YQcG1hj3MvvpotHpRhDvro03IrQPim0OnSfdFEVGJCC1OTmES+bXmSFp6/Vq5Htn8Z9MYAd5m4PsQ1zMaG2N2SvU086PkSwfMgNT+I+j4yrdQw845sW0NCCXx0/hTXjF/iySXveTYVIlqEzzFtTf/TVCDBx/y1iwKrYyzemRkCYzekg=
X-MS-TrafficTypeDiagnostic: MWHP136MB0014:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;20:iswRkMwc3KiRIRcBg9eXdKhGO1FeoIsbXtq5ZNwfrpf6tyPeeBVdqVQFVvFConzCqOSK/Gy1D71WQwgRwBjNxuJ5xDY1pSgM9KfhaPYaBWuucRT7hc8MTg2G5lSWY+1ZhSnMMjbKCiFB4jyp/03tzWWP6+2zHdT17SqiyOpvaT1uwt9VLZkuovgA/kLLIrAKo9Gp8hu+UR4Ue7JT9XEVB3SeUSM5qgGn+xXDCSwODLPIQ8Oriu4jY5dukw6v4Kt/qRQshxoTgz6y5xA4+Tc/OnNKeMMIaSDaGwqJtV+uPipy1tzzEUMfCfJDXj4GHYup3RGsqrYkuwUd09A0agO/4IP+JVjLLISFNI5gvNwBvaKxpDV4HBqSWAqwJXa7vgvtsEae1vtTx+dvp2VsxCktLjewyerjxU5zjkhMQDd+KEwVzBZZWsOWAxG+IOYz7bTdFkoRnXxeB1wWrnRMn2hICAJdeTJzzG5BG6Nf1WWdHi3KekBXbUG7r1IDQMbEuNXJXzzqhRla9qLRXHIiaHVGsT0JBZHIecdTTG2bJ5cnue/N/m1me/LtOAa01bVNwOWRjnTbIJRIDPnaCqsatY7Vxl8mHR0GMA74D+ZSvuYWElw=;4:6/zZwZwOKSbltmKGS5wS4VP0tVitEXU1zPpvfyUrX/HHwUCm876tM9WVVCnJ3lD6zr1s7Z/TlE/r1ryb5q8fsEwDQK9xXHWdW1ks7G5lEvkm96sZrODTNCICbxdt3IC+FCVzxR7QI6JcIT1+6R/wgSrB7BfCQrBlPriXKzf6id491CL9BxrIKnRVt/ibjs9U1gmgKMPu15hGr4dUSZBB6pHAZV26d3iMZHyJppQG19yP6kjthU4D/1vTnuFK88N4JT9k1BKOzE53U4XwXEJaKxjvUorXAXDYmKNoau9uevM2gdCNTimMcLavCp2QTcDZ
X-Microsoft-Antispam-PRVS: <MWHP136MB0014446038DB0982CC1962EFE8B10@MWHP136MB0014.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6055026)(6041310)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MWHP136MB0014;BCL:0;PCL:0;RULEID:;SRVR:MWHP136MB0014;
X-Forefront-PRVS: 0643BDA83C
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(376002)(366004)(346002)(39860400002)(396003)(39380400002)(377424004)(189003)(199004)(53936002)(86362001)(8656006)(7416002)(9686003)(106356001)(76176011)(478600001)(52116002)(7696005)(51416003)(386003)(6116002)(97736004)(446003)(476003)(1076002)(4326008)(50466002)(26005)(68736007)(16526019)(186003)(85782001)(59450400001)(486006)(3846002)(36756003)(48376002)(2616005)(956004)(11346002)(105586002)(2351001)(50226002)(8676002)(7736002)(305945005)(39060400002)(8936002)(66066001)(2361001)(81166006)(81156014)(5660300001)(25786009)(6916009)(316002)(6666003)(47776003)(16586007)(2906002)(8666007)(6486002)(85772001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0014;H:remj8gtty1.ads.autodesk.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0014;23:yM2to0nfL7or0YXy4vvEHhgyPuqUBvcjQOrCtwDa9?=
 =?us-ascii?Q?xiNr4lZo+78RVh8ko8vqob6djR2rW60Piua1Dx/QqVO5Vsge5zl2bvOyAshu?=
 =?us-ascii?Q?DLbznic87APSaqBmS9iAMY56crqmcAuc0txebdj9PvNZjXnNpt9e8EvNoGt2?=
 =?us-ascii?Q?BqOLdP+onNE1qTKl1bzsox6CCtX4w3sLhKXrPXirPzK90v4CqzUFJpQG8XnP?=
 =?us-ascii?Q?WOWLJZxfDtQ1Y1xXHzNIMZItc4u/asXxVfXElLKdln5c6bjM9s40bhk/SYIu?=
 =?us-ascii?Q?9NBHbIBanmD+zlO4N/KUK/m4qoQTH7Od5OP6cfjwDOJideQHQmorZNXUVjEG?=
 =?us-ascii?Q?f5TcvLh/xp1UP82Mw0eZ8nLQDdzMsjzrFlVwKYExCHGW3jKnP3Dey3AvGvX/?=
 =?us-ascii?Q?BcRhY6UlQB68hq9PKtjvZbqSuTUkKrLJ35d2iloRbodiLAZYmHVn5b9ycibB?=
 =?us-ascii?Q?S6I0+CZ0Oqoa1Zsc5dyf/ePZcthTcTWnwghogzu77ENH+aVrYxW3mMIVQeig?=
 =?us-ascii?Q?RROG5N91vlCm3WQPGO5aR+t7ZSO4vJDZOOz26Mk9kacMMmcVk5h1S9nNjhPH?=
 =?us-ascii?Q?H3rsTmpw2CQSfBpqjTXzqnEQyAshtbPIzy8i/AUM4ht9drA6GdiRkFqbFeqd?=
 =?us-ascii?Q?Ql77YJvaSo/J2ssn0Ly4QO3mBuyFdrbHxmj/2tNNmVqKujazKyqOLBBTjOaV?=
 =?us-ascii?Q?4tG+dxRqZRmKw8YjepzRjxsRsFXzy9Y2ozhnXSDEyF3Q056oHCFFPoZ1cTg+?=
 =?us-ascii?Q?soEymSI0s+LO0SI4ye2/WKY9oJVf9HTcrXrXCDZxZ3WWoMYmE+iNNZkvdqSC?=
 =?us-ascii?Q?WB/lXzCISp6bNGi1X4HnIKvYdW42t5YQC7FJIDm0yfldkzbT1T79OmFn3D50?=
 =?us-ascii?Q?aRm9cIcL1aVMlSxXE+tMnfd8VLqKJJe+Kgyb2/Rmp3WYna2tuXXY/f+5nYkY?=
 =?us-ascii?Q?nJ4A6M9qaq6dzjl6MmGgDe8aRRsTn2kFv/1TszYoWBuH3a1LLnIg0Cjrs045?=
 =?us-ascii?Q?yXuigGLqyITAprx6jwFq5p2sfZGSD4+iPeDpKcY+OxzUytzWqleOmV5tY0i5?=
 =?us-ascii?Q?guDz72/pjtg/9uMR8c4MyGwoA8GEyKZtdaBu8MpUzHTslA99T/zrL329I9Um?=
 =?us-ascii?Q?WuoP/v/lHo2xm9WGfRW4mys5nl2QuX2Trem28Gi+YvyEME1Cx3r+iz6BzOJ1?=
 =?us-ascii?Q?KqSBP9IESeyZQ9N3DqPVgiEhMdQ2zOnJiomVEl0+X8iYNXXjMYEhYlrBoE+J?=
 =?us-ascii?Q?pZg6e1rS0T1CwC/DeyCLITh0+OULs+XbXJLlwPecRatVdPnkusGFNV8kDvce?=
 =?us-ascii?Q?VEWEswj6BQstwj1MZJpu6pzVsHk/Xi6t0TTf6pR+zoBYL0LWlXxReAiSeOmx?=
 =?us-ascii?Q?QcL+JkbTIU6lYajYhRz2KQaCnZKOqF9eTzd35NvqilLp8RkvF8MRAQIXIkH2?=
 =?us-ascii?Q?YxHIxZBqkzH3vok0TCuqp7y6UeC9Tqh6Rt6pA2HMKKZxmVnaT5tNQ1YLtNG6?=
 =?us-ascii?Q?RgSPt/5hM0btDZb6FhAPbP8vLyUJ1LFeXo=3D?=
X-Microsoft-Antispam-Message-Info: BdMkHcXKdIAC8kh85Rf5NFgqe4Yns4xYZyxB6/XKrR2Rsupi7gnj63yEyD5Fo5dH0AsBM4uwE8KbCoP0vSAF0VZ5SXdSxtP/JRmEX6xkPF74X1M+bTdmK/m+wPJDdwxfhuL6W2UPElYnA/hPePMhJgKwVJZV6bmdeLeByAJMgWL6KGYDYlbnGUTdiT3Dgbeb
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;6:QX7ueivdwSuR1dh2KErVRV/XlIFgH4A+DGlAH1LSWtldcGmYN0LKGNzcA40b4HTakxgDBPsbaBxM/QsqD9vt6nGuOHtlnWylnYm9oHuEPyq4NnelH/9v1TNyQ4ZRPoNH2lXcZWf5p0ZOi4FbWxZJoTHg9f0VPTczwC/0bGzDRwdso/GvOEWEN7ucW/dFNKhC2EZWKiIOSvcEHsdU0cmwSijiSK9yROA7hCX7v2WXgbO3tk6tY4UeXFOrRexj+WuCcNlglFanf74NoHWE9EdbCKrL5R4pklqYCy+HoSGKrk0nZ6aOsjjpQ0MYFDfHDtL0+pHp5f1hCC8MUZsAG8Gcn60xaVUhexvf+e/GKNEyMsNoDZGqYlAmru/y8+JytKTWwkPG5j7VQetqd7Gjzc1XlqgF+puzaTIFu8YAoU6DvGzFpvvmUJrnZKPw+cw1RZOVEb/yke1H0D0FWDuxS8n1Gw==;5:IsW1gHAx4EtVcH0ZWJooCAAz2mT6+Pf3p+ALGTZwZTEEdU2iwOmMxd7RKBY4irnbXe1kiIBRp7hyZeQ2Y1y1R71jdP4RENI84jAwVkwgCIc6Br0zhuNN+VIlGx4TgnxBKyP4laJMSBex26gmfgk1T7FfaenPQ6ern+aWx3yojkg=;24:B77QgT+3Wke7YIc+73C5YqylAnYGMwMxL2PNK+gHNRWVFVMVjkbsPyPgv/FxLeVcEVYonltFECWiB6gCwGYlDZk0Atum5X57rzLHxPrGbrM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0014;7:PUXoBCA1foWq1R4cfskNX6/fNDDX/CC+xMsVwf94Ym3ppFX8xgIK0n2hVwpveX2CdfAgDMO4CpEMjLUD/LYytJkE6FXEMthwoPhVYCywz7TJxkHCDYl3j3YMkELANDElqtGBlFPaDKUerUX1YIdAOJuUuwZx3VrrXf9XRVVaPzb87SXXyMVqy9yv0lp3i98bsfWuvKuqZzlGKW54JB8d29ARTMExLxPUwN2xNJQFCKAOSioqBhxWWrRt4ePUW7OT
X-MS-Office365-Filtering-Correlation-Id: 8be4449a-65b6-4f68-778e-08d5a2fd07ae
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2018 18:16:35.5217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be4449a-65b6-4f68-778e-08d5a2fd07ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0014
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
2.16.2

