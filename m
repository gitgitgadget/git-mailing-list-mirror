Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41FF41F404
	for <e@80x24.org>; Thu, 22 Mar 2018 14:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754458AbeCVOQM (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 10:16:12 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:52544 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754280AbeCVOQK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 10:16:10 -0400
Received: by mail-wm0-f46.google.com with SMTP id l9so16308895wmh.2
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 07:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikHp6EN8ETy2p5RluPXSiKSVrK/6Y5DvC92f/iokyH0=;
        b=id+tCWILiS7AgNMiqeFJamt+vhfGAa6aQYhjFgvA3nfyAyo7KhIpn/Z7FGGFmCv7Vu
         HKj6W1v5hN/KPL3+1FlgtDSPHKDJsEu0D75a0a4geDP8Tb+YjtQOUnjh2d5YBzUT9++s
         uXD8C8aapxThLFbwmkD8KZqTRhCgLZH6x4q/PeamC7ham5kmVQbYUH+FthDpcdF8UeZr
         x3HziIrKlWN/gaty/48qsyJ81HN6Imcu+ibSM8tMiDdQAuUmefPT/S8RpCsf743BIKn1
         9Awqg13H5/mfoxzIeN/StIcS39s5y/1mFFIA8fbN1plqDIML3FxXikph3wy1zY8HDbjF
         f/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ikHp6EN8ETy2p5RluPXSiKSVrK/6Y5DvC92f/iokyH0=;
        b=LJ1/LYXsb3Z7AUgJCnoH0D3w4ufQDumyEvFshzbYAx/MdietQaVNi0dXiNxDhClJKi
         2tK9JpDU8IdjeytGKPShJnD+4frs0bi8Vzfpa4h1EMkewB97UahWRi72LBwpsXWHICK6
         46dgY9csIXROZtpJYuTuvU7c4hxnsPFtmbWHSUifQT+ORRRulGdPVKlgHMb1ZqplPR98
         n/JUsnPJV//Jrd/VDAm3aPUpbXJC+K9cPZeNoB4N3IG4I4WKZ0ip0oAE8sVtk+wLeTov
         YdPI7dktoPmEqEOmY+eRmJxrfMN6AWmxrLTWTgoCs59GI53njgGfGojuTPbgJKtzkoff
         pFOg==
X-Gm-Message-State: AElRT7GUNdoecbmmNEnFAMBN8ixdLaocbyWtBH7EJPmeZjScOFwsPJEn
        VK8CF9X/2lYddTXRpw3cdFI=
X-Google-Smtp-Source: AG47ELufzw4bfioYSdP+Ie4gSqKRfl32bItIKs/xpnLPQNT4dL+3KELpnwp12wGIepxRpocxKzdXpQ==
X-Received: by 10.80.153.68 with SMTP id l4mr1587158edb.179.1521728168990;
        Thu, 22 Mar 2018 07:16:08 -0700 (PDT)
Received: from localhost.localdomain (x590d0944.dyn.telefonica.de. [89.13.9.68])
        by smtp.gmail.com with ESMTPSA id p7sm5178472edc.20.2018.03.22.07.16.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 22 Mar 2018 07:16:08 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] completion: clear cached --options when sourcing the completion script
Date:   Thu, 22 Mar 2018 15:16:04 +0100
Message-Id: <20180322141604.15957-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.103.gbdc5836ed3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The established way to update the completion script in an already
running shell is to simply source it again: this brings in any new
--options and features, and clears caching variables.  E.g. it clears
the variables caching the list of (all|porcelain) git commands, so
when they are later lazy-initialized again, then they will list and
cache any newly installed commmands as well.

Unfortunately, since d401f3debc (git-completion.bash: introduce
__gitcomp_builtin, 2018-02-09) and subsequent patches this doesn't
work for a lot of git commands' options.  To eliminate a lot of
hard-to-maintain hard-coded lists of options, those commits changed
the completion script to use a bunch of programmatically created and
lazy-initialized variables to cache the options of those builtin
porcelain commands that use parse-options.  These variables are not
cleared upon sourcing the completion script, therefore they continue
caching the old lists of options, even when some commands recently
learned new options or when deprecated options were removed.

Always 'unset' these variables caching the options of builtin commands
when sourcing the completion script.

Redirect 'unset's stderr to /dev/null, because ZSH's 'unset' complains
if it's invoked without any arguments, i.e. no variables caching
builtin's options are set.  This can happen, if someone were to source
the completion script twice without completing any --options in
between.  Bash stays silent in this case.

Add tests to ensure that these variables are indeed cleared when the
completion script is sourced; not just the variables caching options,
but all other caching variables, i.e. the variables caching commands,
porcelain commands and merge strategies as well.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

Fixes a recent regression introduced in 'nd/parseopt-completion'.

 contrib/completion/git-completion.bash |  4 ++++
 t/t9902-completion.sh                  | 31 ++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 7c84eb1912..602352f952 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -280,6 +280,10 @@ __gitcomp ()
 	esac
 }
 
+# Clear the variables caching builtins' options when (re-)sourcing
+# the completion script.
+unset $(set |sed -ne 's/^\(__gitcomp_builtin_[a-zA-Z0-9_][a-zA-Z0-9_]*\)=.*/\1/p') 2>/dev/null
+
 # This function is equivalent to
 #
 #    __gitcomp "$(git xxx --git-completion-helper) ..."
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index e6485feb0a..4c86adadf2 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1497,4 +1497,35 @@ do
 	'
 done
 
+test_expect_success 'sourcing the completion script clears cached commands' '
+	__git_compute_all_commands &&
+	verbose test -n "$__git_all_commands" &&
+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	verbose test -z "$__git_all_commands"
+'
+
+test_expect_success 'sourcing the completion script clears cached porcelain commands' '
+	__git_compute_porcelain_commands &&
+	verbose test -n "$__git_porcelain_commands" &&
+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	verbose test -z "$__git_porcelain_commands"
+'
+
+test_expect_success 'sourcing the completion script clears cached merge strategies' '
+	__git_compute_merge_strategies &&
+	verbose test -n "$__git_merge_strategies" &&
+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	verbose test -z "$__git_merge_strategies"
+'
+
+test_expect_success 'sourcing the completion script clears cached --options' '
+	__gitcomp_builtin checkout &&
+	verbose test -n "$__gitcomp_builtin_checkout" &&
+	__gitcomp_builtin notes_edit &&
+	verbose test -n "$__gitcomp_builtin_notes_edit" &&
+	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
+	verbose test -z "$__gitcomp_builtin_checkout" &&
+	verbose test -z "$__gitcomp_builtin_notes_edit"
+'
+
 test_done
-- 
2.17.0.rc0.103.gbdc5836ed3

