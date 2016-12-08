Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A0501FBB0
	for <e@80x24.org>; Thu,  8 Dec 2016 15:37:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932411AbcLHPhG (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 10:37:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:50128 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752208AbcLHPgp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 10:36:45 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Mhdex-1c20AI0rxr-00MtoB; Thu, 08
 Dec 2016 16:36:29 +0100
Date:   Thu, 8 Dec 2016 16:36:28 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH/RFC 6/7] WIP read_config_early(): respect ceiling
 directories
In-Reply-To: <cover.1481211338.git.johannes.schindelin@gmx.de>
Message-ID: <07c329e9d4875c2137d7b9ceedcb9241fc372b31.1481211338.git.johannes.schindelin@gmx.de>
References: <cover.1481211338.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ed1kpIBj/+HRcF2bQAlc+QcLqpcb3S+ywhcuVdO4cRjA/XAD7Ur
 znhmEOwItUcShnRql+NKDKNZ7vF0GGa/GsMFAb9C6ZF8A9P+Hw8+wmuF2DRnLZDAeYXJsJ/
 4QaqChRGK08H5CzDRGgMi2v+kuTxuFFS6KMXIaxaMh/Fjzeh1vo4uLk1PojkZdSjQB98jlX
 OHnkmsPjVH+NJh7PBO+eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YNF1ozj2g90=:fKsypJf8POG8m6VkvUSn7C
 Mvl11GV8mcLjXOsrIueaOAB4UtScAk/D3r5PBvKsMoNAnMuUUwzymi8akoPBSWDqBOfRejrDM
 9azExNV9HactZ9BAdALKkSM8inHwo7yfiQP2l1GBeoBv0GsQtkxRjvkXhginaTa10fcbEQv8x
 wk/6JFdN8JhqjJ3LHMhhiW9kVx8Hwlgu86jEtkx2KzR0Z6v0VIEu3cEjmi5ObFvnXTWgBx/ki
 KQneyopY+o9qpElrfXiH1hEliazMKBsAs/tdmk6bEBUgxriQiVN7rbnwTiIiIPsI8NI+msMx7
 ZBm4hnclE1FFRXypSKXuh8g4tDv6f4PsAcb2w8jXd78e0yTfkLGwQnXx1C6b1qXOsP/BBPwLR
 Onry2CpwuA+78wkn8VR+e5T1hARoGWSWA+zio2OfMXOIvIoMbHiHpew/z34uI1oBxq84oGGVg
 E2iA9tJxypiwvvqlfitydqe8grdFnJBpH94lZUIpMC40zJVkmZPDwjN6dFfTim4srGPfD2/Gq
 uvmSYJD3wqKF/o9FfH94ciY8vl1/eCH05SZuTrFsLNhrYA5jDJuPSZqTPjcGMJdPLh9ihrK9f
 AgINEorOhyd1KDIW+kEgFWV7SghmQJ6PAqy2MHVDIjXuhXj7mRU2r4FPVlBqVTsLSxpkyZVAN
 MQaejYuoWtIyw2qEg70GFdrXJFD7Zm7+t9vgCo8TIY6mYs3HuN2sDuoq6r2q7m5RXaWq3yjuk
 x0OKw79+8rHmjTfxg2EfPrYIOivTOc9NLYnFW7xvgudIVEWjyk59mQsztfDMkELP8f+DpT+m6
 JGVLemj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This ports the part from setup_git_directory_gently_1() where the
GIT_CEILING_DIRECTORIES environment variable is handled.

TODO: DRY up code again (exporting canonicalize_ceiling_directories()?)

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.c | 56 +++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/config.c b/config.c
index 286d3cad66..eda3546491 100644
--- a/config.c
+++ b/config.c
@@ -1386,6 +1386,37 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 }
 
 /*
+ * A "string_list_each_func_t" function that canonicalizes an entry
+ * from GIT_CEILING_DIRECTORIES using real_path_if_valid(), or
+ * discards it if unusable.  The presence of an empty entry in
+ * GIT_CEILING_DIRECTORIES turns off canonicalization for all
+ * subsequent entries.
+ */
+static int canonicalize_ceiling_entry(struct string_list_item *item,
+				      void *cb_data)
+{
+	int *empty_entry_found = cb_data;
+	char *ceil = item->string;
+
+	if (!*ceil) {
+		*empty_entry_found = 1;
+		return 0;
+	} else if (!is_absolute_path(ceil)) {
+		return 0;
+	} else if (*empty_entry_found) {
+		/* Keep entry but do not canonicalize it */
+		return 1;
+	} else {
+		const char *real_path = real_path_if_valid(ceil);
+		if (!real_path)
+			return 0;
+		free(item->string);
+		item->string = xstrdup(real_path);
+		return 1;
+	}
+}
+
+/*
  * Note that this is a really dirty hack that replicates what the
  * setup_git_directory() function does, without changing the current
  * working directory. The crux of the problem is that we cannot run
@@ -1394,6 +1425,8 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
  */
 static int discover_git_directory_gently(struct strbuf *result)
 {
+	const char *env_ceiling_dirs = getenv(CEILING_DIRECTORIES_ENVIRONMENT);
+	int ceiling_offset = -1;
 	const char *p;
 
 	if (strbuf_getcwd(result) < 0)
@@ -1403,6 +1436,23 @@ static int discover_git_directory_gently(struct strbuf *result)
 		return -1;
 	strbuf_reset(result);
 	strbuf_addstr(result, p);
+
+	if (env_ceiling_dirs) {
+		struct string_list ceiling_dirs = STRING_LIST_INIT_DUP;
+		int empty_entry_found = 0;
+
+		string_list_split(&ceiling_dirs, env_ceiling_dirs, PATH_SEP,
+				  -1);
+		filter_string_list(&ceiling_dirs, 0, canonicalize_ceiling_entry,
+				   &empty_entry_found);
+		ceiling_offset = longest_ancestor_length(result->buf,
+							 &ceiling_dirs);
+		string_list_clear(&ceiling_dirs, 0);
+	}
+
+	if (ceiling_offset < 0 && has_dos_drive_prefix(result->buf))
+		ceiling_offset = 1;
+
 	for (;;) {
 		int len = result->len, i;
 
@@ -1418,10 +1468,10 @@ static int discover_git_directory_gently(struct strbuf *result)
 		strbuf_setlen(result, len);
 		if (is_git_directory(result->buf))
 			return 0;
-		for (i = len; i > 0; )
-			if (is_dir_sep(result->buf[--i]))
+		for (i = len; --i > ceiling_offset; )
+			if (is_dir_sep(result->buf[i]))
 				break;
-		if (!i)
+		if (i <= ceiling_offset)
 			return -1;
 		strbuf_setlen(result, i);
 	}
-- 
2.11.0.rc3.windows.1


