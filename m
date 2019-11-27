Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F250C432C3
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 724E92071A
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 02:09:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmD5Z/YJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfK0CJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 21:09:23 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:42133 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfK0CJX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 21:09:23 -0500
Received: by mail-pj1-f65.google.com with SMTP id y21so9186287pjn.9
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 18:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WduSD2IPzjEU0/WgYXmAZ9p6BxEYXVae+cF+2ORr6kg=;
        b=YmD5Z/YJW2FGtcAU0ciktGznv8OtPmK5rdcsuGg6l+Soex9/Jvcd47QEY/flJLpeev
         sk9ksCDB/z/8MuhIamswIU3mnL9b6sHtk6ZRO42kOwu3cc40f0ytn/Eb8m12tWKiuRGQ
         ywxAoeNvpChBEzOueB/R56sRPiPeJADsgveeC1ZiHCU1rOZ5cSsKF12WATc1SqtTIUf2
         2RQqgZel4mzzL4Use1Cg6mMjsRdcglwHSibIrBSeCGj2UAJ6FYi9wznr4/EZq+vWFwJc
         5ChbV8bLXwQRYfCLu7cmgkleHZ3c1XgmwDy0pXgJZ5jWm7RE7vwjEdvp+Uc060LrOXdJ
         Tzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WduSD2IPzjEU0/WgYXmAZ9p6BxEYXVae+cF+2ORr6kg=;
        b=VfKB2xjgOVSsqgsDnuSbMTi4+IvV1Sp5FIOYUuZct7r4Bbo9SFG9QSa8pn0yO9LX89
         bGme6OOMqFzv4qYqXOBtn70l9cBiVjZYRhbBNbjNcAJTJFROz47snbGiz6BDJ2NRrcYS
         oisWPpRF0mIoqaB3nTOiQa1IQX/WGMsBYBrdwVwSERoR/LRgDHze4B3hcihOvTkRJJNW
         8iw+mcojutT6UvtOTMkiIPNcEbQtkOxzvgjfYQtIH2iHV7cpeKE5xe2rezED7YqcaTtw
         iWjY6J6J6NEQa+8IZGm7GZubqtBiddXxP//c0KCaBtJAOaQGDlEeWRxtx4vFDeXx2X16
         BVpA==
X-Gm-Message-State: APjAAAX4Z9yjPc2Fc/jiPh3+oNZX8dtW6sRH3IuV3+cjK7Rn4dLQs+s2
        mSMuEDJUTLa4Z2kUx+F0kYlzx1z7
X-Google-Smtp-Source: APXvYqzOVP+YdPx1xN7Ljt3eqYruHlN59Ts1Iz4QlLBZf4eB3n0TvvNbAwqc34au1uvGg1wlVpKtqg==
X-Received: by 2002:a17:90a:bf81:: with SMTP id d1mr2808326pjs.125.1574820562290;
        Tue, 26 Nov 2019 18:09:22 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id s26sm13935204pfh.66.2019.11.26.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2019 18:09:21 -0800 (PST)
Date:   Tue, 26 Nov 2019 18:09:19 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>
Subject: [PATCH 4/5] format-patch: teach --no-base
Message-ID: <e072c36e6a41ef70d2a15c052c672f94b54ce930.1574820308.git.liu.denton@gmail.com>
References: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
 <cover.1574820308.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574820308.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `format.useAutoBase = true`, there was no way to override this from
the command-line. Teach format-patch the `--no-base` option which
overrides `format.useAutoBase`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt |  5 +++--
 builtin/log.c                      | 24 +++++++++++++++++++++---
 t/t4014-format-patch.sh            |  6 ++++++
 3 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 00bdf9b125..0d4f8951bb 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -333,11 +333,12 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
   Output an all-zero hash in each patch's From header instead
   of the hash of the commit.
 
---base=<commit>::
+--[no-]base[=<commit>]::
 	Record the base tree information to identify the state the
 	patch series applies to.  See the BASE TREE INFORMATION section
 	below for details. If <commit> is "auto", a base commit is
-	automatically chosen.
+	automatically chosen. The `--no-base` option overrides a
+	`format.useAutoBase` configuration.
 
 --root::
 	Treat the revision argument as a <revision range>, even if it
diff --git a/builtin/log.c b/builtin/log.c
index 9c44682f61..c017df4056 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1388,6 +1388,23 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int base_callback(const struct option *opt, const char *arg, int unset)
+{
+	char **base_commit = opt->value;
+
+	free(*base_commit);
+
+	if (unset) {
+		base_auto = 0;
+		*base_commit = NULL;
+	} else if (arg) {
+		*base_commit = xstrdup(arg);
+	} else {
+		BUG("arg is NULL");
+	}
+	return 0;
+}
+
 struct base_tree_info {
 	struct object_id base_commit;
 	int nr_patch_id, alloc_patch_id;
@@ -1676,10 +1693,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback },
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
-		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
-			   N_("add prerequisite tree info to the patch series")),
+		{ OPTION_CALLBACK, 0, "base", &base_commit, N_("base-commit"),
+			   N_("add prerequisite tree info to the patch series"),
+			   0, base_callback },
 		OPT_FILENAME(0, "signature-file", &signature_file,
-				N_("add a signature from a file")),
+			N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
 		OPT_BOOL(0, "progress", &show_progress,
 			 N_("show progress while generating patches")),
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index c7cc643adf..a5b6302a1c 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1958,6 +1958,12 @@ test_expect_success 'format-patch --base overrides format.useAutoBase' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch --no-base overrides format.useAutoBase' '
+	test_config format.useAutoBase true &&
+	git format-patch --stdout --no-base -1 >patch &&
+	! grep "^base-commit:" patch
+'
+
 test_expect_success 'format-patch --base with --attach' '
 	git format-patch --attach=mimemime --stdout --base=HEAD~ -1 >patch &&
 	sed -n -e "/^base-commit:/s/.*/1/p" -e "/^---*mimemime--$/s/.*/2/p" \
-- 
2.24.0.504.g3cd56eb17d

