Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64679C2BA2B
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 06:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 307AB21473
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 06:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="yf9YTbw3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725953AbgDSGdj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 02:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgDSGdi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Apr 2020 02:33:38 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D64C061A0C
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 23:33:37 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c63so7196039qke.2
        for <git@vger.kernel.org>; Sat, 18 Apr 2020 23:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h+eHe2QOjujX6GXe6e6fgHV7koJVQxzsut36QV1V12g=;
        b=yf9YTbw3o7W1snMgYEBExfxnBiytPmAnzyUBzRbdlEb0OUyzK5QPWhMRISUZBqJocw
         9bZ5ZTkDFGvnOAN13oazqCYTArqvIFwlfLxrCRTR/01q99B2VOobAhtrNZsIOrRjPqXP
         pzLiznwgf7ioUdeF8/DGpLI4oV4ABiv+OZA05FSCEJfThiPZX/AVg57Dq6yiMFE3xyH7
         EJuTdzTqTYTtL+tCLjyR/RGgphrVKehM0WwQe26/+xMfM8cD68Yus+Ong3Gs3OPs15LM
         94M8chQhRvzgrpau9Qrgh2C4xOuY9/pY6/sMQYaY22WmjMLZMKAKjU8iK9IdQmk8XhdT
         1W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h+eHe2QOjujX6GXe6e6fgHV7koJVQxzsut36QV1V12g=;
        b=O0O8wprvrNeBxnnK8dvYpbBW+byq6sweU+7JZq45cAkF51U+2ss2Is7MzmgxMu02AZ
         gbqcoePMP05IH4cIYT1U3QQMsb5x+p9Z61p0Ildn9ByZaj9uEkPBTXZgoBmUTSCJTGDs
         Aq86hULYbm7JkTE5Ub23px/QPkDEC7J76+xGM108zIa3htq4nMxVEe03ZAdhIrlSJ5zB
         VYL26LHqnjAmU+tG/LDIJwpmQMCtjGrTy//+hAUFEZVmZubB/B43bOExnkbPI/C3E9o9
         fEDPrxq/rYjtFBtsgZcqKwzR6QohyWGeSK5MFCK6q/hoV2sT/RcnBR6fhmSmzuh5TuQs
         FC3g==
X-Gm-Message-State: AGi0PubE3z/rkCILBSqXBtmXnnsaPmZiSDIzZvQIUJvhVVv2LWWzJACd
        Hm+oJCnYmo4COis6u/Wv7bipcw==
X-Google-Smtp-Source: APiQypL07/VCDSzyZeReLSegzmyIOs0DlNeD0WxVWQcmwiiG1nuJjSpIMGENjcwcwCZBFlaBFxCw4g==
X-Received: by 2002:a05:620a:1289:: with SMTP id w9mr9582123qki.263.1587278016100;
        Sat, 18 Apr 2020 23:33:36 -0700 (PDT)
Received: from mango.spo.virtua.com.br ([2804:14c:81:9a16::3])
        by smtp.gmail.com with ESMTPSA id s15sm21995468qtc.31.2020.04.18.23.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 23:33:35 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     gitster@pobox.com
Cc:     asheiduk@gmail.com, git@vger.kernel.org, greg@hurrell.net,
        l.s.r@web.de, Johannes.Schindelin@gmx.de,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2] grep: follow conventions for printing paths w/ unusual chars
Date:   Sun, 19 Apr 2020 03:33:24 -0300
Message-Id: <77218d98948a19f91e88859519eb3c8b0e6b3bb6.1587277808.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
References: <eaae7214925189f562056b1ee6972c05dcf76a32.1587103366.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

grep does not follow the conventions used by other Git commands when
printing paths that contain unusual characters (as double-quotes or
newlines). Commands such as ls-files, commit, status and diff will:

- Quote and escape unusual pathnames, by default.
- Print names verbatim and unquoted when "-z" is used.

But grep *never* quotes/escapes absolute paths with unusual chars and
*always* quotes/escapes relative ones, even with "-z". Besides being
inconsistent in its own output, the deviation from other Git commands
can be confusing. So let's make it follow the two rules above and add
some tests for this new behavior. Note that, making grep quote/escape
all unusual paths by default, also make it fully compliant with the
core.quotePath configuration, which is currently ignored for absolute
paths.

Reported-by: Greg Hurrell <greg@hurrell.net>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Changes in v2:
- Squashed in Dscho's patch fixing the tests' failures in Windows by
  adding the FUNNYNAMES prereq.


 Documentation/git-grep.txt |  6 +++--
 builtin/grep.c             | 46 +++++++++++++++++++++++++++----------
 t/t7810-grep.sh            | 47 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index ddb6acc025..3109ce8fbe 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -206,8 +206,10 @@ providing this option will cause it to die.
 
 -z::
 --null::
-	Output \0 instead of the character that normally follows a
-	file name.
+	Use \0 as the delimiter for pathnames in the output, and print
+	them verbatim. Without this option, pathnames with "unusual"
+	characters are quoted as explained for the configuration
+	variable core.quotePath (see git-config(1)).
 
 -o::
 --only-matching::
diff --git a/builtin/grep.c b/builtin/grep.c
index 99e2685090..bdf1a4bbc9 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -295,6 +295,38 @@ static int grep_cmd_config(const char *var, const char *value, void *cb)
 	return st;
 }
 
+static void grep_source_name(struct grep_opt *opt, const char *filename,
+			     int tree_name_len, struct strbuf *out)
+{
+	strbuf_reset(out);
+
+	if (opt->null_following_name) {
+		if (opt->relative && opt->prefix_length) {
+			struct strbuf rel_buf = STRBUF_INIT;
+			const char *rel_name =
+				relative_path(filename + tree_name_len,
+					      opt->prefix, &rel_buf);
+
+			if (tree_name_len)
+				strbuf_add(out, filename, tree_name_len);
+
+			strbuf_addstr(out, rel_name);
+			strbuf_release(&rel_buf);
+		} else {
+			strbuf_addstr(out, filename);
+		}
+		return;
+	}
+
+	if (opt->relative && opt->prefix_length)
+		quote_path_relative(filename + tree_name_len, opt->prefix, out);
+	else
+		quote_c_style(filename + tree_name_len, out, NULL, 0);
+
+	if (tree_name_len)
+		strbuf_insert(out, 0, filename, tree_name_len);
+}
+
 static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 		     const char *filename, int tree_name_len,
 		     const char *path)
@@ -302,13 +334,7 @@ static int grep_oid(struct grep_opt *opt, const struct object_id *oid,
 	struct strbuf pathbuf = STRBUF_INIT;
 	struct grep_source gs;
 
-	if (opt->relative && opt->prefix_length) {
-		quote_path_relative(filename + tree_name_len, opt->prefix, &pathbuf);
-		strbuf_insert(&pathbuf, 0, filename, tree_name_len);
-	} else {
-		strbuf_addstr(&pathbuf, filename);
-	}
-
+	grep_source_name(opt, filename, tree_name_len, &pathbuf);
 	grep_source_init(&gs, GREP_SOURCE_OID, pathbuf.buf, path, oid);
 	strbuf_release(&pathbuf);
 
@@ -334,11 +360,7 @@ static int grep_file(struct grep_opt *opt, const char *filename)
 	struct strbuf buf = STRBUF_INIT;
 	struct grep_source gs;
 
-	if (opt->relative && opt->prefix_length)
-		quote_path_relative(filename, opt->prefix, &buf);
-	else
-		strbuf_addstr(&buf, filename);
-
+	grep_source_name(opt, filename, 0, &buf);
 	grep_source_init(&gs, GREP_SOURCE_FILE, buf.buf, filename, filename);
 	strbuf_release(&buf);
 
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 7d7b396c23..991d5bd9c0 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -72,6 +72,11 @@ test_expect_success setup '
 	# Still a no-op.
 	function dummy() {}
 	EOF
+	if test_have_prereq FUNNYNAMES
+	then
+		echo unusual >"\"unusual\" pathname" &&
+		echo unusual >"t/nested \"unusual\" pathname"
+	fi &&
 	git add . &&
 	test_tick &&
 	git commit -m initial
@@ -481,6 +486,48 @@ do
 		git grep --count -h -e b $H -- ab >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success FUNNYNAMES "grep $L should quote unusual pathnames" '
+		cat >expected <<-EOF &&
+		${HC}"\"unusual\" pathname":unusual
+		${HC}"t/nested \"unusual\" pathname":unusual
+		EOF
+		git grep unusual $H >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success FUNNYNAMES "grep $L in subdir should quote unusual relative pathnames" '
+		cat >expected <<-EOF &&
+		${HC}"nested \"unusual\" pathname":unusual
+		EOF
+		(
+			cd t &&
+			git grep unusual $H
+		) >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success FUNNYNAMES "grep -z $L with unusual pathnames" '
+		cat >expected <<-EOF &&
+		${HC}"unusual" pathname:unusual
+		${HC}t/nested "unusual" pathname:unusual
+		EOF
+		git grep -z unusual $H >actual &&
+		tr "\0" ":" <actual >actual-replace-null &&
+		test_cmp expected actual-replace-null
+	'
+
+	test_expect_success FUNNYNAMES "grep -z $L in subdir with unusual relative pathnames" '
+		cat >expected <<-EOF &&
+		${HC}nested "unusual" pathname:unusual
+		EOF
+		(
+			cd t &&
+			git grep -z unusual $H
+		) >actual &&
+		tr "\0" ":" <actual >actual-replace-null &&
+		test_cmp expected actual-replace-null
+	'
 done
 
 cat >expected <<EOF
-- 
2.26.0

