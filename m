Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70E8720C13
	for <e@80x24.org>; Mon,  4 Dec 2017 20:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdLDUh1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 15:37:27 -0500
Received: from mail-bn3nam01on0091.outbound.protection.outlook.com ([104.47.33.91]:55869
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752034AbdLDUhZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 15:37:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sYwCYUnzA0VA9lG/XvX9BpIQBYG2WtiaDc4X9DKpwho=;
 b=W1DGLR+ShxPz0w9hnqdCtw90wei26UiGJFUTCLbtKfqnc5j8bXC227sORV++un5MGlpExhsC8x3tq8dUZZBdFWngr/ObN73b4O3aB6rk6S/C1MIC5xXwV+mpyntb8PA4sbJsdeUPOUWjfC/teFNQUMmvCQlYVw+wby6e/4AVyrg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxBook4.fritz.box (93.219.107.112) by
 MWHP136MB0032.NAMP136.PROD.OUTLOOK.COM (129.75.96.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.260.4; Mon, 4 Dec 2017 20:37:21 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, nico@cam.org,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] progress: print progress output for all operations taking longer than 2s
Date:   Mon,  4 Dec 2017 21:36:47 +0100
Message-Id: <20171204203647.30546-1-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [93.219.107.112]
X-ClientProxiedBy: DB6PR07CA0020.eurprd07.prod.outlook.com (10.175.239.30) To
 MWHP136MB0032.NAMP136.PROD.OUTLOOK.COM (129.75.96.219)
X-MS-Office365-Filtering-Correlation-Id: 57afef8d-f133-42ab-2dcd-08d53b56d2db
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603286);SRVR:MWHP136MB0032;
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0032;3:qL1TZfiYrJNmCknJO4I38AqPUtQZLyzKZmK8HBC3t4UHikvqw//IY6gCDMFDmiDCA5KvEqzGIAiE/EYUffx6+XtbV8oKYszxAwx+QI/lUqZjG+/eOEzdRiwqHErbessptHfvO2P6GqoiVTaWM3OBIe08mE8BHHyFx9ayEFBUNbRi2sQzzxFaeL05fX/sdpl8MLSTo3sy2X4UloHADSGLMRWa6+PwJIkmWldM8ZUhWP2mfntYeezFb4K0c8JkOC1z;25:KyRBgjrocMH+E9dUB7ABTCrDJcoAAATrgVxGOk9fllNPRbZZ15wgLydaETHXw5OATSU/w1o4MFzMqZrJUR9tVpwpt04tyVr4H3WcSNoJQCtcyV0+IMShYSIw2azKkglk6ov29qQqwHlffHkJ1xKvEwzzzbvItcpnDVdVTF5MIsjk9fNIR8w6DZpMxrQ5KLq4PsiyLwVCB3O3OiWlurOcmQW39Arjeg8sNoNLvAaVyuXIbgzxTj9jDi0ZnSmCpciL6Sxhh8qS+oMx+xobuhXhlL0wHJChIlWbC7G/OF9rTMGN8rT/anxOkUzzcjJanLs8H+/squme2z0Vt2SuOsQPMA==;31:jH7Z7c1clScl82TMOcVF3FOoJMIP29UzjjZMp7/n9EcuBBhyA/q2UjUxELzrCBQNgZYtEeXOl4QY7QuRCf4ZXkNzv/1fSa/5eebgfKQZBOg2hyOp9DgP4TGlV3w+Q5kMghq1SChoaqvb1AKA38qvBMQvWGQCfuJCBfwMxyCFQdYdpoPu6UQ2NYCeURU/JVgFrFyn3GR1xxfkOBtirchyjfVao1cvAc35tH7MnASVhmk=
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHP136MB0032:
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0032;20:tptBPEX5PusMr+oCW2qygwXh8Mtm9eu6bzLXA58SWEwGk/+mhk6yvjwj3O1m5/URgkDyCmiALjQjy5at2qyAQeXMEc5nYDjQGEoc7qoKKN+/+8V6IyrjKAWdG1QTDT+hmMMUzzMdA9MbzRINBiwJfBSlRVO2rL3DXJLxOTac8QZfR6NvGUoPyrVGOwXwCiRsC48pdcjeeBIvAY7ld/Ksx66UC49h62AqwZ6qzqGkeBc9R4ofykBrtCX4xhnrocAY10wfUV236ZUAUZWwBb1eaITF4kKzi12FsWMpaZrO31ntkr9n/YMeYijmfBFCzgiOLP+iatOGms+cV604dPTSSl98BHYArAHkhyYailu5D+h79Hx/4xw6fR78b+s9HFflCtspiK+ptgrjCoYH04BXXpWcBX4zjT0/HPKDCjfe3U5u+G5yE45chW2d9Pb71SxT4Dn1pWCubvJH9mlosB2b8HfTdd63EbS+f/ro/setUBWjhx4nrid8IJNXNjVtmocyJX+CySRLh/jF131A0+46PTef/Li/1LxrxmYorQeCp91HM7osKjDB7NBQ95GfkbaN19Q1f212VkIALFW9LNJjaB0mjpEqMEQvmG7QlnXBXHw=;4:58PQTGnLWcGWTJCytfsWXyBM2gW27zLYhrSurz+aEyc7mSSdB9MxFfktaUUZoawCqdZgNZEAxeiz6IVunEZUKsW0Rt6Q0UR5FHYniSrmNec2RbyaiBy/Q8Pn+N0S4NCOKSe7Zqvk7l+PnhI/mlzJ5bQ13Pn3gndZykD71ZyIa70NscNsp7XpqGN8TuYus+Pod06MMdeg218BOrNKSBY3PoP2tApz1VmNDzHKaf99Uryp+YtHPx3RHSVrOSjVEFHiDa3qJCD108HiprfOKN0NtQSB4LI0PaXlqVslUp1BuWF0scAsy4noo2NIeXP0Ivaq
X-Microsoft-Antispam-PRVS: <MWHP136MB003212126B9FEDF19F8DD82CE83C0@MWHP136MB0032.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:(166708455590820);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(10201501046)(93006095)(93001095)(3002001)(6055026)(6041248)(20161123558100)(20161123560025)(20161123555025)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123564025)(6072148)(201708071742011);SRVR:MWHP136MB0032;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:MWHP136MB0032;
X-Forefront-PRVS: 051158ECBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(366004)(346002)(39860400002)(376002)(189002)(199003)(478600001)(6306002)(2351001)(105586002)(106356001)(2361001)(189998001)(50226002)(53936002)(51416003)(25786009)(86362001)(575784001)(52116002)(4326008)(8936002)(39060400002)(53416004)(966005)(36756003)(69596002)(8656006)(68736007)(7736002)(305945005)(101416001)(6666003)(6916009)(85782001)(48376002)(5660300001)(6486002)(1076002)(6116002)(3846002)(50466002)(81166006)(81156014)(33646002)(8676002)(6512007)(2906002)(9686003)(97736004)(47776003)(16586007)(66066001)(316002)(16526018)(148743002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHP136MB0032;H:slxBook4.fritz.box;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHP136MB0032;23:qaiGUZVe3OsNKKs5XxFAIB61rMlCu6faQbd0b612A?=
 =?us-ascii?Q?qY9/jHmAcqtQrQkUr4m5fM3ZzRuG99QI6q7rQLr5bgEGYnOcWDHXNfP+r4nO?=
 =?us-ascii?Q?1DWy+g3j1ewD5eB75Rqyw5XRoVBwHMcZaNjEa9m7fmXzGFtQV9ylraGH22C/?=
 =?us-ascii?Q?7AC0I6sJWmYY/PqLEOKEaKWhnNKIZyvlBSUEJb0d3S1WC/vRnjZXZkR+E7rs?=
 =?us-ascii?Q?YbvODvcPun6wvlOdl0Bbn2+JLODoNMwQRbT9rYQUtGyWvp8AhP+f9g5OpyUm?=
 =?us-ascii?Q?3T2Sj0aS2XGrbutoNYecoJX6RO9GloUu6xtmAKtuRfb2OFQUpm45b2eydjxR?=
 =?us-ascii?Q?6oIaTy+kIePljVnfSh/PBBMviUS6hah8z4mCoefDLPzlTqRKzybE6okxmsif?=
 =?us-ascii?Q?wddv+pTUPqh0MIJxwNnE7qyEU9M+qEneve02+eUCtPkB+ma4SnKsBexuB/Ps?=
 =?us-ascii?Q?DtRfBrQVaeM5a0vgiL2Hnvqat1x8cNTIX5NSMwa1N54TlY8ABduX74pQoE3b?=
 =?us-ascii?Q?3RffZMDrZyffkFALhCXSY+lAgtLq/PaBhoK12PFTlfqwxbxLdcMt5gxJuZ58?=
 =?us-ascii?Q?KDqCEvkSdheoeiuZ7eIZ23pMr6K5+qxdIe3PBup7rqm6AzoRnLp0L6GynT1R?=
 =?us-ascii?Q?H8WQKxVCoapDJOn+XUEdEMdQdL9s3+gmCMnFCZmImX4SVqlkpQeahMMx36U3?=
 =?us-ascii?Q?MZVOXsbRQ3ijs03qZCPGsELvwlybMB0ghyGhiiz86CX2UIJz2EVKmjZ7CjNH?=
 =?us-ascii?Q?wDXX7PsWfTKMlNQo4FL46/Iz/0W5zJtMSdzIBpR/OxD59NFX93TxBnBjhKod?=
 =?us-ascii?Q?61iWgssOH1fPa9XTcKgS/3aW3xZ6MTyEDI5v5zBz5UrGnDIFGRNyHgBx4HxB?=
 =?us-ascii?Q?JnJoWVZTAtMtV1epAdIFKGVh8kta53tYtDSesRjW1fp8TvF6KmPqw9CachfA?=
 =?us-ascii?Q?8HposD/0x5EwHzlLW02EddxDMkLgLPDhZrR0aa6pN8COwPUjFkoJwnYmcdOg?=
 =?us-ascii?Q?sLtzESUEQRwOptBrwiNQBvYmhmJrNmWX054G9WdRA+RCce2IYME9nZeGHswH?=
 =?us-ascii?Q?h0tPd7uJPfXnD+sTvgtBAAvV2YC6i87eJTZHSOONXKs80BNnteTSrBygEHKM?=
 =?us-ascii?Q?p8PXhZHnpPmKLD45HaTtMPqJY/Zz7k1QuzC14rjNTJS1LRrrDgOr5yteqISh?=
 =?us-ascii?Q?tG8zHDBqCfx1dPqKp86+OeGpAoDj4/jZB4WUI071GWh8j32BLWKZIKoHPjcH?=
 =?us-ascii?Q?LnawsVBV9Aa2gDk2GrShT39Inmv9aBzieo5juS0DjXmkEHYtfabctWmGaxYC?=
 =?us-ascii?Q?kbejDJs5KUHHxuS57UwFLk=3D?=
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0032;6:rwDrQY860n3JpOZwSGdF5/jL0c92OyLNxd+HsDQ9THZCWqGgHiZG1e94ZHIPEP5SgcGIIdegbfEGXH7sT/mjvLIg/GMM2kGKUPSakLTeaua7lsD4Pg7kWfsgwX3jBC38r1bED44iQ8VuHFx/CEspzhn0APC3+yFgh20gYZAzM3uGp/mW8dmNDxpZw1fyJlT7zINuiZhYV0cVeLIiOZNeUhrDLJ99HLBvwa+lX5WB56n7CKf/JMhPaLJ7qa0QEvJy4+WT+Mysz/mUebaX85v/O8Xt16+6fCdQCTZS2DBpV/M7gbufyxxqNVuV5eYnQNnIA30bBbfgpWgIJHHSPXxKk04utkSvHeKxBvc9ZHXlot4=;5:axZvDukB4KvB3alIvBqbqqYlFgD1SB9NJ2p54RRGUX2nlmaJNckqHNfbqg4wn4VuAV+t3iAbERGNAuz1wXo1HKQAR5Gus9cFrWucIQg82xhFNgWGxzfvOX/7WmEgFV6SfhO6FRj9jLt/7VZN+CH1by3jjR8iZieriOOweWhZaX0=;24:r1Y/N4cueR98rKS8mKutJCLrvkXBddmzqNL45EjB2NXVjNIYxLikzYno00NMOUEkIUqJo/dXqZYenrUV0VWBsyljxzkd5F/O0QDjI0Dd5gA=;7:x9kadiU1vfnkzlhHBIzUYWjV08oaqGrQbpIhyj3kj1yZNozvh1Zt3Dc6hAGomPF9dYSpLKHxeLUHJgGId9GE5br5yh3qte+E7k0LzBvS2cSad4ejvQkK6VZYuSqiKlyCTYKMwaupYsRrjWiKRqhNTWr/4k7hTroSjxY3S6l7jtj5xCRn+N1U2htI7nuBy3620s3DLR90a+SdaJgW7N0w/bPMgc48Rl86mtyLVF5Pwtl8bnPL7W3F8Cxs5uuvd1xu
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHP136MB0032;20:fp60I7xd4HIRS5aPl0TONQnbcMbhoK/lJMP3MRaimS4IJNO4fX5vJtmQ6hOBOtA7+A5HtuwSv8m3415QEr6OybOqH14dlIH4bpWjqHSyrv8NrAhmFbfVZqdB0iwScUGYVv7v0eMww8v7PNRo5/CodOcle1gJMWzk24eRDtuH6u0=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2017 20:37:21.9848 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57afef8d-f133-42ab-2dcd-08d53b56d2db
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHP136MB0032
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

In 180a9f2 we implemented a progress API which suppresses the progress
output if the progress has reached a specified percentage threshold
within a given time frame. In 8aade10 we simplified the API and set the
threshold to 0% and the time frame to 2 seconds for all delayed progress
operations. That means we would only see a progress output if we still
have 0% progress after 2 seconds. Consequently, only operations that
have a very slow start would show the progress output at all.

Remove the threshold entirely and print the progress output for all
operations that take longer than 2 seconds.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi,

a few weeks ago I was puzzled why the progress output is not shown in
certain situations [1]. I debugged the issue a bit today and came up
with this patch as solution. It is entirely possible that I misunderstood
the intentions of the progress API and therefore my patch is bogus.
In this case, please treat this email as RFC.

Thanks,
Lars


[1] https://public-inbox.org/git/DC84FB2E-A26E-4957-B5FA-BE6DDEC3411B@gmail.com/


Notes:
    Base Commit: 1a4e40aa5d (1a4e40aa5dc16564af879142ba9dfbbb88d1e5ff)
    Diff on Web: https://github.com/larsxschneider/git/commit/3e5fdc512a
    Checkout:    git fetch https://github.com/larsxschneider/git progress-fix-v1 && git checkout 3e5fdc512a

 progress.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/progress.c b/progress.c
index 289678d43d..7fa1b0f235 100644
--- a/progress.c
+++ b/progress.c
@@ -34,7 +34,6 @@ struct progress {
 	unsigned total;
 	unsigned last_percent;
 	unsigned delay;
-	unsigned delayed_percent_threshold;
 	struct throughput *throughput;
 	uint64_t start_ns;
 };
@@ -86,16 +85,6 @@ static int display(struct progress *progress, unsigned n, const char *done)
 	if (progress->delay) {
 		if (!progress_update || --progress->delay)
 			return 0;
-		if (progress->total) {
-			unsigned percent = n * 100 / progress->total;
-			if (percent > progress->delayed_percent_threshold) {
-				/* inhibit this progress report entirely */
-				clear_progress_signal();
-				progress->delay = -1;
-				progress->total = 0;
-				return 0;
-			}
-		}
 	}

 	progress->last_value = n;
@@ -206,7 +195,7 @@ int display_progress(struct progress *progress, unsigned n)
 }

 static struct progress *start_progress_delay(const char *title, unsigned total,
-					     unsigned percent_threshold, unsigned delay)
+					     unsigned delay)
 {
 	struct progress *progress = malloc(sizeof(*progress));
 	if (!progress) {
@@ -219,7 +208,6 @@ static struct progress *start_progress_delay(const char *title, unsigned total,
 	progress->total = total;
 	progress->last_value = -1;
 	progress->last_percent = -1;
-	progress->delayed_percent_threshold = percent_threshold;
 	progress->delay = delay;
 	progress->throughput = NULL;
 	progress->start_ns = getnanotime();
@@ -229,12 +217,12 @@ static struct progress *start_progress_delay(const char *title, unsigned total,

 struct progress *start_delayed_progress(const char *title, unsigned total)
 {
-	return start_progress_delay(title, total, 0, 2);
+	return start_progress_delay(title, total, 2);
 }

 struct progress *start_progress(const char *title, unsigned total)
 {
-	return start_progress_delay(title, total, 0, 0);
+	return start_progress_delay(title, total, 0);
 }

 void stop_progress(struct progress **p_progress)
--
2.15.1

