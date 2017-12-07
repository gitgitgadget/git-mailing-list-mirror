Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09E820C33
	for <e@80x24.org>; Thu,  7 Dec 2017 15:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753583AbdLGPRJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Dec 2017 10:17:09 -0500
Received: from mail-by2nam01on0119.outbound.protection.outlook.com ([104.47.34.119]:13483
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753147AbdLGPRI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Dec 2017 10:17:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=autodesk.com;
 s=selector1; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CMNE7YkWajIgEVF3Oxd7ZzP6Hb0AjoPgcD5lu3kCRLw=;
 b=b39fWPrBPZNE5TQY9TZYf1nCCQrklpgDiTr6cI53HmVTy1Pl1VJq+u6TVGj3iGcMZyPh3nFN5BH0F6uUhXE/6xL+mmzybfdAI5F0fZABEYaQsHTRZfSxe4oR41BRuVGjMjxz+Somrk0oWef3NBDRNDl7gCmQqGZFCImO/9ku+a0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=lars.schneider@autodesk.com; 
Received: from slxbook4.ads.autodesk.com (62.159.156.210) by
 DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM (129.75.96.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.282.13; Thu, 7 Dec 2017 15:17:03 +0000
From:   lars.schneider@autodesk.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, sunshine@sunshineco.com,
        kaartic.sivaraam@gmail.com, sandals@crustytoothpaste.net,
        peff@peff.net, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v5 1/2] refactor "dumb" terminal determination
Date:   Thu,  7 Dec 2017 16:16:40 +0100
Message-Id: <20171207151641.75065-2-lars.schneider@autodesk.com>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171207151641.75065-1-lars.schneider@autodesk.com>
References: <20171207151641.75065-1-lars.schneider@autodesk.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [62.159.156.210]
X-ClientProxiedBy: VI1P193CA0018.EURP193.PROD.OUTLOOK.COM (10.175.177.156) To
 DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM (129.75.96.154)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b08279ab-28a6-4594-ad24-08d53d859335
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(5600026)(4604075)(4534020)(4602075)(4627115)(201703031133081)(201702281549075)(48565401081)(2017052603286);SRVR:DM5P136MB0027;
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;3:5tYFOOww5m7hrCJgpCBZmxRurcXb4nR/hGyZLWqRSm3zn5eJgFNl3fYYeqf0r04PB8h1SV/Bz3Y9EdDXd5Plw/VL63Yl4FRHIjH3/i36HKdWJFsIqj/iH8KbgDKJh8RsagxqdfHY8mFKx4tgJu7K+FoeG6owEw30RClSoYhAMUVfYGAmJqdRonHiYQnrKc67VbPN40euNepvbhqytG6zmynM2WACZLIzBaoaiusVmM7yXkm+U6CAtVui2H87INAX;25:zIHztr6RJoubG4y9FKvQY6KjxS/Ofbus0qJUNbOgjtuRSxBQzvTmdRtV13fenE5AWTR5po/fPCB3V724j1rUjyCjGIH9aBw0Ofv0FsuuzHjNA9DR+d/u1rwMuozL7tXXhnqvIIja3plHIFBF+gsQDHlv9ycMNaKbqyZlboTrE63zw9TcLeAcUixfqGNvOOfPjl4o4zhgkNHja4Evh9ot79jYWuMwNPyCvi11pJdWyGLqCOPhjVaaLo2jQ1Qfq5aN6Tg/sRYUOeL26ZprSkPr+6znWem/xomHj6duVp5gau5GNxNCe9oCqOr2te8/GP85155m2UM8AKPAK806fzCUGw==;31:LKsBkbYeyVJhNWLDv7MWgEZUexovfsCKHpI4bCZMlkVB8uaEUa7SNTYzJE6WUyco/EM80bDhXIgNod1qhyDghb+PhH9GioO9b4XlMIrgRBeyn2qFKNrpL4G9c7wxSyPkB1+NwjS0LFAW/JJQ0xT2V/+5HrgXafrYNe6NNB1s3qLgWCZIvoxJJA7JfW6C8Kl9ee/jTd3AUmaN/Y+mFNl6j4uevktRpsDWwBQz/NhA35E=
X-MS-TrafficTypeDiagnostic: DM5P136MB0027:
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;20:vXxeZyGsC7Ko3Rl6JcG8ydZx+vLfUyqyf33eaAyW0XXCjU7XA8WC3lzHPI8niLg8OjfHCiUgF4+w+MxgYbgyX9BCxhkwF51WqhdwkGV6P6spra5SK7Paz+p5Ou9/C1fJTxqWJSEL/22yTv9mnmW4qw6whZEDJ6xJW1zoZuQY9jQQQIweqaxavbENyiBsgdaY5FKuf1oNzFEylOSsY2tpjQUYihGwzm8se7MDgzB/L/opUuvWz+fBe2Rfwjdo2MK8h8bAL0uZehoGSeeZg9uu0gH8TN8M0k8aCAM4xcEuMDjVYBfL/1t7hSJDk5Z38o3d00FT5xF+4uJK73184S3QBb/O2vx7RtnL2v5BiiwXmR7zKJvQsECV6VTT4XTpuExPT5ZA1nT7CXg5BerGGHsab8QE6ZlwyuJ6RWlh0Q7XNPF0QqCvsLlNLTGDT8Irnrah0FT5yEWUAndfG9IEmaBPq6QiWRWGMxJJOW1H/ZkBUXOQFFyAfkrvbgC1Lq8BcE6nwHzMfbWC1/a9qgh5ZlUl3Ce59+te0zXLUMU/OTDK6Qk1BgXSKH0RfgafO7VkSICYH6vaVfaOB2IpJGBrgRhmvtKkuPbH9wCyloR+q4oPtJs=;4:bqM0TRh7LjX2OzTQIX8guKhSSX85dRsXyFBGwEg3QRBzKzKlaKbiTGDn81ai/JqdtKjN6n5OeME8/lxbyEYnvUUJyyIE0vflOSQcFctVCZRdGAi6UrMHnq+9Yz+bA1OeF57zHS57vC0O3MYuL//luOZEugvVIxqhQSp5NpXQzu2TuN2PCKl7ORFM6YLsX/gbnFKXRO9iU7gniEHHlQ3NOjB35g8N6NvveQTA09cVl4iWP872Ea2xzimpjONVAB9qfNRcqhNjAn7dh6hmymrj6g==
X-Microsoft-Antispam-PRVS: <DM5P136MB00275A9B5F1D8FD0E155989AE8330@DM5P136MB0027.NAMP136.PROD.OUTLOOK.COM>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040450)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231022)(6055026)(6041248)(201703131423075)(201702281528075)(201703061421075)(201703061406153)(20161123562025)(20161123558100)(20161123555025)(20161123564025)(20161123560025)(6072148)(201708071742011);SRVR:DM5P136MB0027;BCL:0;PCL:0;RULEID:(100000803101)(100110400095);SRVR:DM5P136MB0027;
X-Forefront-PRVS: 05143A8241
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39860400002)(366004)(189003)(199004)(81166006)(52116002)(7696005)(51416003)(76176011)(85782001)(16526018)(7736002)(8936002)(50226002)(68736007)(81156014)(8676002)(4326008)(478600001)(2906002)(6486002)(305945005)(9686003)(86362001)(53936002)(97736004)(39060400002)(2361001)(8656006)(316002)(2351001)(106356001)(33646002)(105586002)(6116002)(1076002)(66066001)(5660300001)(6666003)(2950100002)(25786009)(50466002)(101416001)(36756003)(6916009)(48376002)(3846002)(47776003)(16586007)(85772001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5P136MB0027;H:slxbook4.ads.autodesk.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (protection.outlook.com: autodesk.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5P136MB0027;23:NvDbQ+Sm/gQbsbZk+ZrwgNiA82eOMOCCx5uMOsdlj?=
 =?us-ascii?Q?D6Hz7PJEf1HYQB+9ALRpr/JTj8mCskIO9mncX+T17xbZa0IJRGbgZGs5eioW?=
 =?us-ascii?Q?RdJQSvbF+XZ1KIZsuBPsfcFCt8kj/OJuq0CnT3vANcRdEO/HryNGDmjzxAQY?=
 =?us-ascii?Q?uLpo7E8jPnnQbOQBHqJEjE9Toxzgr3Dok5+PkKaK0avjhA21Y/iYo+YVMynS?=
 =?us-ascii?Q?SxwrZlAM+BUtPG7DVaeFRwJ1agIVasFyZjcZVumEgFkCceuezbwMBqe7sY7/?=
 =?us-ascii?Q?BLOjPpRaKMjy/QuPCV6SIIbCryvY1PIQmdPmLyIYYhWgTOTb/HjbXhWtxH8y?=
 =?us-ascii?Q?alOUtI9YOcuJUtB/CZuskEv6URzoF/vs/vcMZ9iybNMFRkqJBp8HpT27+GnS?=
 =?us-ascii?Q?y4uFXJqrCgH7e5J8+HgxGFvOvPuJeq9a5YB1l1dWVRA21MppcDwQk7Xea5XJ?=
 =?us-ascii?Q?k2ku4HZ77MQ7OqgFejRTOvPrqNrZuYcB/VxZCaY7LCu6l6XEF7R84/XOZjFV?=
 =?us-ascii?Q?AbnPqH76rQADWEwSjxF/lVxNfoT8UOJ5msDZ2zn0f1faJXGFaioqOV5c0A18?=
 =?us-ascii?Q?Fzpy+8w8Q775aXo1LXXwqPnnRULPeUs3VdCBg6kf5W1rIcXeRviSXrhh+8ps?=
 =?us-ascii?Q?/Eg5mjr0P0vn5//kYeE/AupU4vXCoB5k21V8EDl4pZ7HCEiW+vRIsyyF5/vk?=
 =?us-ascii?Q?hJl6hBY9/JTxNrYRy0hTe4kKAAQsfspjeQkrnoAiZ6M4XYdzJXpFaT666js9?=
 =?us-ascii?Q?PWa7w6OPVQQ/NH+NJ3ffg2AgADbQ7morI1MWOCv/FnCBn+hlZuf6Zn1kqGBp?=
 =?us-ascii?Q?ZsHsxx5YpY1ZkNDLht3tzWnuorMwxvFtRbKSqRJI/NTD+VEvQKjl+7izpSNs?=
 =?us-ascii?Q?CKTFqy68RvaV/ipcttgKsqwMKom3k6vL6ezdrj4BokDswMTj+Er7H6baXNUM?=
 =?us-ascii?Q?ucBiQ8G137/3FX1HvPrI5sCsoUe8VShYwV0eCHs8i3Nq5iRyXxR9h5FXXcfY?=
 =?us-ascii?Q?Tf/HKbeuFe2dGMo1Bhel/4+8u4mRh+XtABljCvHmCWFOSKt0vUdq9tKeQTW9?=
 =?us-ascii?Q?tds6FXl8CgzTzEJW/QN3VGpgxyDAGb0InC8JXN3gcBqY6+MtP7VfBh2kxttn?=
 =?us-ascii?Q?U0Ftao1KLT/n9/zYex8NGl6L89ERmedxWoNF8qB1d2wbMqYSyB33YCZCb7CX?=
 =?us-ascii?Q?yCW+Su905i6HOdD0IUZNJvrFrmt3furgYv2?=
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;6:DPrIqNnXg0B533PVEKYtE9RtjaYuCM2liHQ8lS6q5GgjH/9bEMxcO/AmagFftgxgSlhAOsvY9Ln0A/tczko2lZMYYWNCtvDeGI98JfgRi7sdH/0rD1YqD1Ng5YrXS/c4Xyxl/VPL4W2EFDHE9bEHGcsS0mHqyJwrwTFz29WdVG2/hbDLoOxfRCE+w7HJWkpFETiEENzi0Lg99kYjgsLDEtwtDSX9SJCj+envEBYxJ49Rxd49hCVXvluK0k451qyluDY9KvsMv81nIpULrJOAgpZHD8eWkMJnpx7bl0lcPjtDpFIYL8a9L/2vMeFXfCghQpVmAMAW6MHBdYGZ25WBDuzrlbTgfjsWQOl+kWkFU5I=;5:e4oFVc6CHZiUpYCjDSNCJTES6XDAJNg6FHX65FiR94ILA9sDILLPqPpcVzjfoPmHjHUydN+9W7E/cN3XbXy3k8S95zMZ98GR/+ychyc0ACo090gq4EiGCzByqo6y1W2SxJjG2vTNOS/njM7DdzlsPvx21wJaVQirkGqQSSu+zwI=;24:GtvCk2VMjoH5tnQ1qP/dThFPkXsi8uG+NkPh6uQ2ftDfJ+nTYTtuWMSbzzPYfbRfMaFCpI1yZF7Dj/FQFt/y0SHtKFpWp8Ck+HheYaggaDI=;7:v032vPQFDXN2mVPD4YCUdeBCrMu0F2Qj1Zu984J/ALt5v+nHO/HzKWH8QSClLU2aOXdU2pnQ9XR+9W5nPw/KTfhvZ42qfU65AZaHr6PIq1jYKbQtmdKo1lC925iaY+Ic5nibsbvfn8jpy8MmR/f/fYlL5Eht9FfwBLu5wKpONWSJxuooSxsj9OnMKtMwEeHymSyAtJ0VVeT2qV2HK/U4yD3jgg5XF4MO+pE8GCQS7ZYnRXphpfM/CqPAbvZJ/3mA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5P136MB0027;20:DIjRXavbk+VPQ5BPyOhOZWpIyP4skPpaaacr8AhRu+WVQYF5wFKFVnry7WJ1uHe7kl+SkhRyvaLWqd8Fzp2h/Qa256xl2yTZ6u8UhId9rw47nmlzMm3CcHdgp222zYo3MROMjfBiavbse01pt2e6qWjsNRHYTGaSPTWGoO++zp8=
X-OriginatorOrg: autodesk.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2017 15:17:03.3443 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b08279ab-28a6-4594-ad24-08d53d859335
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bff79e-7f91-4433-a8e5-c9252d2ddc1d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5P136MB0027
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
2.15.1

