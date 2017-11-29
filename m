Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC4CF20A40
	for <e@80x24.org>; Wed, 29 Nov 2017 14:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753517AbdK2OiZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Nov 2017 09:38:25 -0500
Received: from mail-co1nam03on0102.outbound.protection.outlook.com ([104.47.40.102]:44064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751486AbdK2OiX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Nov 2017 09:38:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=0BKIx9BLg7ROrjxHimeagpuKXukq6OCuTZ0b9d5ca4U=;
 b=ei8EYubK1ZI9dlnYB5NiBVr9EWkB8EX+sHpNEwmnr/5vUyaMSfr+YrA0FmHXvf6r69OTxciRlvvjxQgYqrOCDtU4FYMsKtFnxQUAbHb6Bf4i5A5Ot5KtrKzgrBM44ifGnYB/RcT9ymTvOGdD7dlZWLHd3+BkyK/tIL7GCIhTXUs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.239.11; Wed, 29 Nov 2017 14:38:19 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v4 1/2] refactor "dumb" terminal determination
Date:   Wed, 29 Nov 2017 15:37:51 +0100
Message-Id: <20171129143752.60553-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171129143752.60553-1-lars.schneider@autodesk.com>
References: <20171129143752.60553-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: VI1PR04CA0066.eurprd04.prod.outlook.com (10.170.225.37) To
 BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM (129.75.91.24)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 369708ad-8215-4bce-91a5-08d53736d65f
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603271);SRVR:BN6P136MB0017;
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;3:x5L44XbZ5R5e5FVOG58qJZnlbdkSz+i7hDoq4vb2/+wsZFgSM5c5ZNIP0tUJ7vEJmObqEOnxiZbAHCACJ0sRSlOhg37t7Nh6AEMFQWBfNFFyXGetWy3qqU5unFi3ixFYtY+t9OwPAmO2Soc+A4NJgjXO9+3oMeext6apV1rBwfVZnd/nJ6djK6YZIlzTXhG1IsaTbWadT6fXLYhr3Tsfkd2/aSqXjaDnWIRwEyqFpA+XoKV725sAnPljWy1eGKGa;25:0VLm3Qghomg21K/1Takxv0ERtFLZgL/gVfw8EPbadosdyWScx5eXbLEkOV5XNWfHaoHgsSuric5Lcg7TtIMxWHCtdMF95/gvSTWlN68vrVCkRkilQv2reZcxdivFYdSGr84Di5IfzYZfecV43N6js5M4NUeStR+duf7Fz3cmx87jh6vGe1vLDp46mm1UuU12yL+Q/rCQiaj9prb/3jv0bbBN2mKI8EXPG1oKi723cJzC7DGg5jcL4zOALbnY1FBYOLCm9rUOIdeG89hxR3c97dKHX4iQA5T5L8In7VGm83w2yg+gFOtql7fzPQCGJ0Nx3q6T3j1nbQzK2Z4HGB5zvg==;31:k1hIWNgnK7yAlHM1uxhSKei5RIBr+jtRHd2M1To9K7O8C702JgeNyrr+80gH5iTw2+Hj1+nsmF9fH3S7LTuqLrk2uOg8VBwNnHiCheeEUIfTKQQNUrayYJ2tsNG1dalN6qyXIY1oikPwMxozKQNTDsyS55N01uzTU5KYj9IAFyP5y2hZRQSTEBSoFDwnH3Vv9i+bJPJ66OtCcDvO8olTYuV74Zni/dW1Tbk1KcFxwCE=
X-MS-TrafficTypeDiagnostic: BN6P136MB0017:
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:gfKP3sb0hUCyvsxVYCzRindKFWg71vUR0LY2JScbFjG9ix3i/q2OKFKo8UN0vpZkvpofVkadmhEp+V738EXKpnfuMWgIzH1q0HepTckgN77mK3VAwCBm5u0Pz7IgPyyYei6qqVVwoIpGp83x1xhnjva918U8wr2xmh4oUhtS+Nso3k6IFaxnZ8FynsaoUSJSseocp56xXwSYBc3lrJ6zfWlBT8H9qpZSqKGmWtWgRxMDOpk80Ek1ql9elaU/RzpC5CnK7Ex1WS6vsw1DtDGkMd4FEw5p7tLaw+BstDJ4MqoxOsdc+ppOs9FcN6PdsZEIcCQhguGBKUWt968+vl3Oy6jy0yoIPD8dJZFySV1nC6QL718+Lx2RpwglKMk539et0ODUU0H1C3d4Xa4BRUYz9gWvRQ7nod9EHj+jnpELzc1zHrinPaK9GCMMyM97ah2UUykfHrNIejI5bsEimX/0i8bXHJfjc89DWC9cGzsL89g/hqgwhI8tGbaTdLcPw79yzzPjmyaT6MsAO2APKtoVcK1IaD1LgQljXUPGbMrC4frQv4fa8lccjVVyoLtr1E4MgQMQ9gavCTGvtscyUBPMexyV0Tj8Zrf49+sGMUo+Xe4=;4:J4CpAnNvQt1EiTFJKvDaMkN0Eo+FHRMkcH1Xmxv+b8b1XzugGHuBUFihxcWUajUa/E9JoxamdsPJ0jmuGlMz7gTnp5csQgdVCCWyoY8LNnJxiiUftBOdR7lkJPEWoditCydSXRueQtgZIgltXXrbV/DjqFGFnQSchV5MblW+yOVWZYvpc8GCJHF0yAM1SorsgykgtvLFVUvTRjrsPE5XcRR3XzqvyQ/XC+g5vWIP4KsYWO+zA7ICDiGKqpPMOx4h4KwQ2l1hEQbOVY7Z9NJIdg==
X-Microsoft-Antispam-PRVS: <BN6P136MB00174F88D1FF23BF824080FAE83B0@BN6P136MB0017.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(5005006)(8121501046)(3231022)(10201501046)(3002001)(93006095)(93001095)(6055026)(6041248)(20161123555025)(20161123564025)(20161123558100)(20161123562025)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123560025)(6072148)(201708071742011);SRVR:BN6P136MB0017;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:BN6P136MB0017;
X-Forefront-PRVS: 05066DEDBB
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6009001)(376002)(39860400002)(346002)(366004)(189002)(199003)(5660300001)(2950100002)(53936002)(6666003)(6916009)(101416001)(50986999)(76176999)(9686003)(305945005)(8676002)(86362001)(189998001)(36756003)(8936002)(16586007)(25786009)(81156014)(81166006)(4326008)(85782001)(105586002)(51416003)(52116002)(7696005)(6116002)(66066001)(8656006)(1076002)(7736002)(2906002)(50226002)(478600001)(106356001)(3846002)(68736007)(2351001)(2361001)(39060400002)(16526018)(47776003)(316002)(33646002)(6486002)(48376002)(97736004)(50466002)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN6P136MB0017;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6P136MB0017;23:bmn3uXnDOTGnwHmDnxfsoGLuWo2XV22CR39QeDq4a?=
 =?us-ascii?Q?+uCIAhht1iILINnC131YqNWy56xxpbgI9BkGIH6szaOJ65a8RIeXw8KXBv6A?=
 =?us-ascii?Q?jaIenVGY3PpE9fun2tbEVEkefNcOoZhfTt96xkkPa03ue1z5P6XaaDRDiNql?=
 =?us-ascii?Q?EhK/MNl0fQ6b5AfexfXg5UTRfxkjeJhUTFn2r6tO8cLGgRSqcSgh5+vPrKbA?=
 =?us-ascii?Q?uMe/lqOops5tmoN64x/KctzRZ3Dtt0EORjTqHIcuQSjegEjQojIxDjH2GK/8?=
 =?us-ascii?Q?vfkNly682B89RUkoHB5OjpNbffSDAXD5BL8IqoVHopmIbooJtl4GxVUEbZ/O?=
 =?us-ascii?Q?EQwuK0bjjUTCxIri2QWEx1lD5ABZKrQap6FXgwAqVdr76ewPY+FK0cYIwuys?=
 =?us-ascii?Q?3boeNGb2bbgrre6HoJXQub+efs+Uf6OPsEpTiZWG0/NxDV0zUhb3rPy/3jNd?=
 =?us-ascii?Q?th8erUqZOl06kuPXEyQIz5kUoMTB1R6dbQuogW+HnSsgdzQ1RWp4zS+rZUR2?=
 =?us-ascii?Q?DznCbd+6OsfSijUSN3iTBOGjAD7AuQ6eeTtqaGzwYBF1ZgEmrB/2XfIg4puy?=
 =?us-ascii?Q?goJfv1md5v14aWnuhSigv38HWaZFdS9Jg35uW4pD3uECMEcWx9Vj881pc1/i?=
 =?us-ascii?Q?9VSVwU3fHDEfDyiFtrOnnJRj5glgv4cVAE5sQaGuPGbiF1J8SmXinEwwts47?=
 =?us-ascii?Q?vk26mk3eBRNI90ouJ/WwRT/oztZ3WFxwDO4nL0E1qjrUsDk+DB15GIlzePHL?=
 =?us-ascii?Q?yDYAwNVAwwgcZHYwTFcIa0Q8ZzfPLI07feut+UTQ5wkBybVxSaDqay5qeB1G?=
 =?us-ascii?Q?PPHTubeceTKfpedcnUpXqLi3XVI6oOSiI7PSpfTR1GdZ1qSPVfZyFrIrIZda?=
 =?us-ascii?Q?VtXN2ytAwGpQ544B/wPRXnd2ufbYO0NrbRGsdSsw77rzS2/rlJvw3FawH7bG?=
 =?us-ascii?Q?20r5exeoDLwEX0MvEGo+zb/K4gdWisXXhrFqHaCC+hRgwXk9M2h071v/iQD3?=
 =?us-ascii?Q?bhoC/23CHp52i572+/npfdxNsAVfcc/Pbg85+Mq7XzGzruy4x8dHHny5e1ol?=
 =?us-ascii?Q?Z3lNryTEfx1xBRppz8t30hbB8EtQzdkWKjIfeB8fcT+ccg7Bg/UqHg+/MoN/?=
 =?us-ascii?Q?BGZZ2UAPwggStWj99PxaRlkvIcd8cbGJ8LjMywt8I/JsmCiIG4iNJ4OI2Xkd?=
 =?us-ascii?Q?Knny4CmW9ZI5YytPHqx0U5eq28MsAOdS909qL9fJCC8cptbkc4pL2IyJqUhY?=
 =?us-ascii?Q?2LpvmvgAlNXlIThbKjeWGjOw6co//94hWsvxTFJ?=
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;6:RkKSyr50fkySALVxgy9gU3C99ZSWM+HgzjzGGjDmp2mCrpwOHgikj9BoGzmC2LWxTi5jeR6R13sJICPkYnjzUhLxSG4LLR2p94/ZYlU8gCn2jugUOhU68YIHMYQE4MauwH515PrrDBHd0Pu35017y0eDUpUvuNReXAON6ArAKZbPI65Mwa/pAksKCszqWojQjx5/D6aFVfdJ76XvYXxEXXBPH4LZW9MPTet68s9J9hkCrr0RLVaROoz83hNl5fV+SU7NhIzHSIs2QXEiVDLnRlcPfmzOfb/9SrCTb9rBoeTnP3mWOjBe9SV5KS0HWgZ8KgXGQJDTjfkUN4CVPbVZYq1GN4YRT4kDYGiT9LXrybE=;5:v529WhxERHG/goN6gTc+uDHL6YmLOL7NUu7HUz8B9QrK8seMowsXVQB0AzVfCFMEyMsX7aGV3TdPytcoK62YoXX6bO7PQR3NHw8Bg6dOM461P/rdxcd4W8IFtnO2I7ujVBHLEonxvX+C04w5QUmW/JoAHtH0HVwR3C07X8SNf1g=;24:lBNegYk3UNUKgl2qTDQnlI722uhyJX1MatIBDXqiQ5YMNQ5RFuu4MpCVR/irz3cFHUve7miztwC2rX91emzwlO0y6MYURi17DlWH1sng4bg=;7:bopbcS1LTfyypKLFkm0QPfzmcvlngGD8sNolsM7auMebYuvr/f+vryh1O7twqPyY0ijyAi+F3fCqMFnhtYAZvqZZdIb8EUki1ZB+3Kl/vqqa3p/eFQfDnPx6NDXPbBQPoyB63jqyja/ahK4iCa1nvAZ2DEIY9x5wrhp8F0GIy9pChGoZwRImnQ6hT+NlDAHcjyOkH5TQpbP/18bNGZlN5NdOLEol2ULwMRLWKCv9ZZqZuRf7O9rBk0IdcL9/vq7k
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6P136MB0017;20:G9p+BgiU8CwWWRl/JF81ZXYi+tnoPZgRkhl70UcHmtd3Ob5oWn2wXR3DLS1jzOhlNFOWRGmbfnl9RqBxOceLRc9P4tL1vq18QR+oQLyPoS6AT0G2aClHjtlLo6bDi8OBrL+ISsK/OdNo1nhOBccG+GuPu/odS9V1lma8CHBVOLQ=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2017 14:38:19.3079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 369708ad-8215-4bce-91a5-08d53736d65f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6P136MB0017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

Move the code to detect "dumb" terminals into a single location. This
avoids duplicating the terminal detection code yet again in a subsequent
commit.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 cache.h    | 1 +
 color.c    | 3 +--
 editor.c   | 9 +++++++--
 sideband.c | 5 ++---
 4 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 89f5d24579..3842fc097c 100644
--- a/cache.h
+++ b/cache.h
@@ -1469,6 +1469,7 @@ extern const char *ident_default_name(void);
 extern const char *ident_default_email(void);
 extern const char *git_editor(void);
 extern const char *git_pager(int stdout_is_tty);
+extern int is_terminal_dumb(void);
 extern int git_ident_config(const char *, const char *, void *);
 extern void reset_ident_date(void);
 
diff --git a/color.c b/color.c
index 9a9261ac16..d48dd947c9 100644
--- a/color.c
+++ b/color.c
@@ -329,8 +329,7 @@ static int check_auto_color(void)
 	if (color_stdout_is_tty < 0)
 		color_stdout_is_tty = isatty(1);
 	if (color_stdout_is_tty || (pager_in_use() && pager_use_color)) {
-		char *term = getenv("TERM");
-		if (term && strcmp(term, "dumb"))
+		if (!is_terminal_dumb())
 			return 1;
 	}
 	return 0;
diff --git a/editor.c b/editor.c
index 7519edecdc..c65ea698eb 100644
--- a/editor.c
+++ b/editor.c
@@ -7,11 +7,16 @@
 #define DEFAULT_EDITOR "vi"
 #endif
 
+int is_terminal_dumb(void)
+{
+	const char *terminal = getenv("TERM");
+	return !terminal || !strcmp(terminal, "dumb");
+}
+
 const char *git_editor(void)
 {
 	const char *editor = getenv("GIT_EDITOR");
-	const char *terminal = getenv("TERM");
-	int terminal_is_dumb = !terminal || !strcmp(terminal, "dumb");
+	int terminal_is_dumb = is_terminal_dumb();
 
 	if (!editor && editor_program)
 		editor = editor_program;
diff --git a/sideband.c b/sideband.c
index 1e4d684d6c..6d7f943e43 100644
--- a/sideband.c
+++ b/sideband.c
@@ -20,13 +20,12 @@
 
 int recv_sideband(const char *me, int in_stream, int out)
 {
-	const char *term, *suffix;
+	const char *suffix;
 	char buf[LARGE_PACKET_MAX + 1];
 	struct strbuf outbuf = STRBUF_INIT;
 	int retval = 0;
 
-	term = getenv("TERM");
-	if (isatty(2) && term && strcmp(term, "dumb"))
+	if (isatty(2) && !is_terminal_dumb())
 		suffix = ANSI_SUFFIX;
 	else
 		suffix = DUMB_SUFFIX;
-- 
2.15.0

