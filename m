Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74040C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 00:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245221AbiBXAXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 19:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235703AbiBXAXj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 19:23:39 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DFD060CD5
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:23:10 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id g12-20020a17090a714c00b001bc25476de3so270025pjs.6
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 16:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=GTaZ0tpil6uj+2/CS+oomP8K96DAgmDmFV4gvINMnGw=;
        b=luCdI2exlq4zOTrHCrkhinrsK/MuvbXZExMT809DV+4L06p2btN/dtTfGurA1OmpmF
         ixZ67MFdnB4y+GWZmgFbNLADo9V3RH0Kchll1cdneiLsJET+3gSxQe+fUPT136ljkRJO
         GkyJusqiqcnsXbCujDNyLM3UJCE85z5Ux+6Xvd3r7/dAEd9Shpjrqk3Xwb+BttqoR+LY
         Xj33WqN6SorTomHWw3IQZYvmqfMnJLbhYNqxgVecbZuQJeu0yD7RiqgR7S+8wTDSEYrj
         2aZKvXV7rIdJ5uXU6G1Knb1FxrEJFneIJdxCXesfnFfkwOsuFA4N3cVkwZSW2P/fZw22
         kxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=GTaZ0tpil6uj+2/CS+oomP8K96DAgmDmFV4gvINMnGw=;
        b=uwoBGTaRjxsmqcK6+ZbsBQbAOvCnGrVeaexefmkXMG2JphxhEPRVWQ5882FVcwLg5o
         7D84xLGkysTzhdyHBw3eFn9j1Zt+mrX2d6LgRHZFVRit8xNJ7SylQIlCF8JfAxjDWpsy
         juMBpqtmt7B1QYLOkdR39qznpaYKL8NQt8wmcWUNBzdoWnFsHNF2bKzv69r2dU0b0GJM
         Q/8Oek8UBV7niHhmjt7LrbZuyojUcKZg3kDDEDTtWQ5SrRKa98ROLLNPX3GY7MIXPdDO
         Z6EVO1ruEk69X71g/4NDmNhTnFJ6qCpaRIRQHDo+BXZZrI9cZakPxINV0vCfwzh7IkA+
         xDNA==
X-Gm-Message-State: AOAM532/b0FaWyRXeJran++Sr+ManGYGNSMfPhEcReewGmMbi8ml1nOB
        PmuU9PrYTN21EONS5w9Z7fn+HPMRlcGAIXn8mJlniSWfhsfJ2wEVPgm5+PrZyKlOxXMpvXobopi
        HtiJ1PfWNyr+BZiOLjj9zIblcohvoUS00es3ioKnlRjgv5ITBmE9G03zXB6mT2/1tqDzDWKbIzY
        qp
X-Google-Smtp-Source: ABdhPJwf99g8tgWKF6JzKkshZvao+KRyVTNmhsaIIv47CKo7r+PrfwpNUkEzfMEIe5ub8s3lh9ChfCKMCsIZomrxLgrU
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:90a:ac09:b0:1bc:3e9d:158 with
 SMTP id o9-20020a17090aac0900b001bc3e9d0158mr11654970pjq.235.1645662189922;
 Wed, 23 Feb 2022 16:23:09 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:23:03 -0800
In-Reply-To: <20220218223212.1139366-1-jonathantanmy@google.com>
Message-Id: <20220224002303.2363189-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20220218223212.1139366-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2] ls-files: support --recurse-submodules --stage
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, avarab@gmail.com,
        me@ttaylorr.com, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

e77aa336f1 ("ls-files: optionally recurse into submodules", 2016-10-10)
taught ls-files the --recurse-submodules argument, but only in a limited
set of circumstances. In particular, --stage was unsupported, perhaps
because there was no repo_find_unique_abbrev(), which was only
introduced in 8bb95572b0 ("sha1-name.c: add
repo_find_unique_abbrev_r()", 2019-04-16). This function is needed for
using --recurse-submodules with --stage.

Now that we have repo_find_unique_abbrev(), teach support for this
combination of arguments.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
Here's version 2 with an updated test.
---
Range-diff against v1:
1:  d61268bcc8 ! 1:  17f3f77b86 ls-files: support --recurse-submodules --st=
age
    @@ Commit message
    =20
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
         ---
    -    I got the similar-hashing object contents from =C3=86var's work in=
 [1].
    -
    -    [1] https://lore.kernel.org/git/patch-v7-1.6-28c01b7f8a5-20220111T=
130811Z-avarab@gmail.com/
    +    Here's version 2 with an updated test.
    =20
      ## Documentation/git-ls-files.txt ##
     @@ Documentation/git-ls-files.txt: a space) at the start of each line:
    @@ t/t3007-ls-files-recurse-submodules.sh: test_expect_success 'ls-file=
s correctly
      '
     =20
     +test_expect_success '--stage' '
    -+	# In order to test hash abbreviation, write two objects that have th=
e
    -+	# same first 4 hexadecimal characters in their (SHA-1) hashes.
    -+	echo brocdnra >submodule/c &&
    -+	git -C submodule commit -am "update c" &&
    -+	echo brigddsv >submodule/c &&
    -+	git -C submodule commit -am "update c again" &&
    ++	GITMODULES_HASH=3D$(git rev-parse HEAD:.gitmodules) &&
    ++	A_HASH=3D$(git rev-parse HEAD:a) &&
    ++	B_HASH=3D$(git rev-parse HEAD:b/b) &&
    ++	C_HASH=3D$(git -C submodule rev-parse HEAD:c) &&
     +
    -+	cat >expect <<-\EOF &&
    -+	100644 6da7 0	.gitmodules
    -+	100644 7898 0	a
    -+	100644 6178 0	b/b
    -+	100644 dead9 0	submodule/c
    ++	cat >expect <<-EOF &&
    ++	100644 $GITMODULES_HASH 0	.gitmodules
    ++	100644 $A_HASH 0	a
    ++	100644 $B_HASH 0	b/b
    ++	100644 $C_HASH 0	submodule/c
     +	EOF
     +
    -+	git ls-files --stage --recurse-submodules --abbrev=3D4 >actual &&
    ++	git ls-files --stage --recurse-submodules >actual &&
     +	test_cmp expect actual
     +'
     +

 Documentation/git-ls-files.txt         |  2 +-
 builtin/ls-files.c                     |  4 ++--
 t/t3007-ls-files-recurse-submodules.sh | 18 +++++++++++++++++-
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.tx=
t
index 48cc7c0b6f..0dabf3f0dd 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -156,7 +156,7 @@ a space) at the start of each line:
=20
 --recurse-submodules::
 	Recursively calls ls-files on each active submodule in the repository.
-	Currently there is only support for the --cached mode.
+	Currently there is only support for the --cached and --stage modes.
=20
 --abbrev[=3D<n>]::
 	Instead of showing the full 40-byte hexadecimal object
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index f7ea56cc63..e791b65e7e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -244,7 +244,7 @@ static void show_ce(struct repository *repo, struct dir=
_struct *dir,
 			printf("%s%06o %s %d\t",
 			       tag,
 			       ce->ce_mode,
-			       find_unique_abbrev(&ce->oid, abbrev),
+			       repo_find_unique_abbrev(repo, &ce->oid, abbrev),
 			       ce_stage(ce));
 		}
 		write_eolinfo(repo->index, ce, fullname);
@@ -726,7 +726,7 @@ int cmd_ls_files(int argc, const char **argv, const cha=
r *cmd_prefix)
 		setup_work_tree();
=20
 	if (recurse_submodules &&
-	    (show_stage || show_deleted || show_others || show_unmerged ||
+	    (show_deleted || show_others || show_unmerged ||
 	     show_killed || show_modified || show_resolve_undo || with_tree))
 		die("ls-files --recurse-submodules unsupported mode");
=20
diff --git a/t/t3007-ls-files-recurse-submodules.sh b/t/t3007-ls-files-recu=
rse-submodules.sh
index 4a08000713..dd7770e85d 100755
--- a/t/t3007-ls-files-recurse-submodules.sh
+++ b/t/t3007-ls-files-recurse-submodules.sh
@@ -34,6 +34,23 @@ test_expect_success 'ls-files correctly outputs files in=
 submodule' '
 	test_cmp expect actual
 '
=20
+test_expect_success '--stage' '
+	GITMODULES_HASH=3D$(git rev-parse HEAD:.gitmodules) &&
+	A_HASH=3D$(git rev-parse HEAD:a) &&
+	B_HASH=3D$(git rev-parse HEAD:b/b) &&
+	C_HASH=3D$(git -C submodule rev-parse HEAD:c) &&
+
+	cat >expect <<-EOF &&
+	100644 $GITMODULES_HASH 0	.gitmodules
+	100644 $A_HASH 0	a
+	100644 $B_HASH 0	b/b
+	100644 $C_HASH 0	submodule/c
+	EOF
+
+	git ls-files --stage --recurse-submodules >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'ls-files correctly outputs files in submodule with -z=
' '
 	lf_to_nul >expect <<-\EOF &&
 	.gitmodules
@@ -292,7 +309,6 @@ test_incompatible_with_recurse_submodules () {
 test_incompatible_with_recurse_submodules --deleted
 test_incompatible_with_recurse_submodules --modified
 test_incompatible_with_recurse_submodules --others
-test_incompatible_with_recurse_submodules --stage
 test_incompatible_with_recurse_submodules --killed
 test_incompatible_with_recurse_submodules --unmerged
=20
--=20
2.35.1.574.g5d30c73bfb-goog

