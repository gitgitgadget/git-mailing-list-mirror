Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91A7EC43603
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DB7E206DF
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R28dlRZP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbfLDVZM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 16:25:12 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36404 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfLDVZM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 16:25:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id k20so262761pls.3
        for <git@vger.kernel.org>; Wed, 04 Dec 2019 13:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=oF1EKsTGUK9dL5hJenftgE4aUvn2WcznLGa6qvMFrX0=;
        b=R28dlRZPjABWY6Ib37ZZar4mxc+RfQCnHHX1vwyruWidPr4UXpFnPOXRxtvBfIuoXw
         FOPBaV5eyha/duw/3Qi9BOiwbr0DnGel4Ho22AFqw0eswf4NY6Ovpm4N0Ye3DA/bAvg6
         I29jyvX/Rh+ikOe5NIghChhRn8l00h2814/+CILhHEqhljC3dYzDZMj8INOvxxl2EZA1
         5lFtEgHXQXUvV2dVh5V8UPAs2E48QmGFPL77IT2h7iWtGIhFf3oFXtsBoBw9sZugWSdX
         fStz3Hc54ZRZPVO63OP5FO+Nkw61+lWgQ+AUbltTDUjWvcVD5Ym49c0gO8zMj4NE9H5m
         xv/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=oF1EKsTGUK9dL5hJenftgE4aUvn2WcznLGa6qvMFrX0=;
        b=tcmuEIQBiSlNZiAhnGqq5A1cFoXTFT+e8CiYZwZRmPcLNsa4uNpAA6nvwj60ohmid2
         e5cosB423kCKt81r2AYxYZT1k7MCVjsU586E/kNZ8iO8ogbWNDlkfjLAa0IQab8WizRs
         AfsInWSY6Beuq5+zfTna5WV2vVoy4AAe9sk3XgosnhTrSD5fhHAjGa2bT5A/1xl83o5r
         AnNHNJl1RqiKp2pH4fJhGO+EQrUurzPI0djPExklYEnIgbp3JumOLr1y4Q1ByagT9aPY
         1jShsEexDwuDMsSKslFn/kKOH28iN5Zf35Mxob7SnDYiBOVsqBwNvghm7pdyA750Uhcp
         Ac/Q==
X-Gm-Message-State: APjAAAV60ET3nYcOlXV7zlSsnOm3j1ht1pH+VL8SJacv/eYBPIbBUxYk
        VSw7457EYJizonD9zlIiL1jdynFt
X-Google-Smtp-Source: APXvYqxbHsYPpUEr+LOOHh4R0G9qb5OJH6mdSDVzsNXsh5LHlKNXOz+rkujuW32PuTkQA7mLWHlrSA==
X-Received: by 2002:a17:902:7045:: with SMTP id h5mr5542422plt.245.1575494711176;
        Wed, 04 Dec 2019 13:25:11 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id f69sm7898852pje.32.2019.12.04.13.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2019 13:25:10 -0800 (PST)
Date:   Wed, 4 Dec 2019 13:25:06 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Christian Biesinger <cbiesinger@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 4/5] format-patch: teach --no-base
Message-ID: <eb35de8f4917a406d886a6da4180d2d90e95e633.1575494618.git.liu.denton@gmail.com>
References: <cover.1575445582.git.liu.denton@gmail.com>
 <cover.1575494617.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1575494617.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If `format.useAutoBase = true`, there was no way to override this from
the command-line. Teach the `--no-base` option in format-patch to
override `format.useAutoBase`.

Helped-by: René Scharfe <l.s.r@web.de>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 Documentation/git-format-patch.txt | 5 +++--
 builtin/log.c                      | 7 +++++--
 t/t4014-format-patch.sh            | 6 ++++++
 3 files changed, 14 insertions(+), 4 deletions(-)

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
index 9c44682f61..bf904e887f 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1406,7 +1406,7 @@ static struct commit *get_base_commit(const char *base_commit,
 		base = lookup_commit_reference_by_name(base_commit);
 		if (!base)
 			die(_("unknown commit %s"), base_commit);
-	} else if ((base_commit && !strcmp(base_commit, "auto")) || base_auto) {
+	} else if ((base_commit && !strcmp(base_commit, "auto"))) {
 		struct branch *curr_branch = branch_get(NULL);
 		const char *upstream = branch_get_upstream(curr_branch, NULL);
 		if (upstream) {
@@ -1710,6 +1710,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
 
+	if (base_auto)
+		base_commit = "auto";
+
 	if (default_attach) {
 		rev.mime_boundary = default_attach;
 		rev.no_inline = 1;
@@ -1973,7 +1976,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	memset(&bases, 0, sizeof(bases));
-	if (base_commit || base_auto) {
+	if (base_commit) {
 		struct commit *base = get_base_commit(base_commit, list, nr);
 		reset_revision_walk();
 		clear_object_flags(UNINTERESTING);
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
2.24.0.578.g4820254054

