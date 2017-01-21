Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 78ECA1F89C
	for <e@80x24.org>; Sat, 21 Jan 2017 14:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751030AbdAUOnj (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jan 2017 09:43:39 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:35218 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751025AbdAUOni (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2017 09:43:38 -0500
Received: by mail-wm0-f48.google.com with SMTP id r126so74717631wmr.0
        for <git@vger.kernel.org>; Sat, 21 Jan 2017 06:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=76+sYfjn9PmEkLYKrgFKVdbh7GvmgGi8OoAXXkqhDvo=;
        b=UAxBGK3WU0ewvHGLZAxtmC0d/il6IPq0bsvey891G2tNk2o2oHx7WcGW3jk96cC1Rb
         +05FPBrw6ZxPW2kt+mmuuZgxGOZJoM34mD9a0PXtiS6rOZViSJ5IQtbLRXeFAXjKZSOU
         pUKY4r1ELAW09Vi1RNBdNBUkH/NJe6Jy2k2vlWWxsqL52ybawSphmqDi4pEPa5ZW0++1
         4wsoYNMTPGIrO6KtZfsjfpTI3FStLD16kIEm/7Nd11vvU6Rd86ZbROqtjOSLKYFD70oW
         FBXQJa0Q3iU2fz7/NivQozU4TkeHbGoHV6IosKiwVinVUB22H4NshhR8om76eQDQJwtL
         +sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=76+sYfjn9PmEkLYKrgFKVdbh7GvmgGi8OoAXXkqhDvo=;
        b=jauoC+G1dGnpFaeKZks0R6XQ2K0+muTSDtpJYlZU4AtvlC0IB6Vdmmp84D4DOyn3lJ
         7HNH6nFrowkMugXhqUdW3FedNoFbJbXbuP/voEXUz41PCJOYqChWqdp38cMW19aFYmOG
         SwI7clb6oDPaHZSl3MNvrtRJfpIQmHmthv19IXwanxe+5ZnM3kGLJiVlezY9YmSjVvd2
         sbIVLL2BKie3xUOE5PTNIFOf27lN8kPJKgP1mM+AKjBN9ZlVHrv+Hl3a1OHm/MW6aRHM
         +vBzdVwjItQ8ATJteosy7qGoGG1pF3AcwWfe2B4K9l0gfYeT2qeroUzV/XpZBNGU4nLa
         JlXg==
X-Gm-Message-State: AIkVDXKPLyW5muYf7dUJlqgVPgmfpfcKkLVLx0ed/Tib73BBHxRr+QsXjoB4LhfHR2G1QQ==
X-Received: by 10.223.154.109 with SMTP id z100mr16190185wrb.145.1485009772687;
        Sat, 21 Jan 2017 06:42:52 -0800 (PST)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id 53sm4761067wrt.20.2017.01.21.06.42.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 21 Jan 2017 06:42:52 -0800 (PST)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] travis-ci: fix Perforce install on macOS
Date:   Sat, 21 Jan 2017 15:42:45 +0100
Message-Id: <20170121144245.31702-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The `perforce` and `perforce-server` package were moved from brew [1][2]
to cask [3]. Teach TravisCI the new location.

Perforce updates their binaries without version bumps. That made the
brew install (legitimately!) fail due to checksum mismatches. The
workaround is not necessary anymore as Cask [4] allows to disable the
checksum test for individual formulas.

[1] https://github.com/Homebrew/homebrew-binary/commit/1394e42de04d07445f82f9512627e864ff4ca4c6
[2] https://github.com/Homebrew/homebrew-binary/commit/f8da22d6b8dbcfcfdb2dfa9ac1a5e5d8e05aac2b
[3] https://github.com/caskroom/homebrew-cask/pull/29180
[4] https://caskroom.github.io/

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

Hi Junio,

this patch should fix the TravisCI builds:
https://travis-ci.org/git/git/builds

Could you fast track the patch to `maint` if it works without trouble on
`next` (as it should!)?

Thanks,
Lars

Notes:
    Base Commit: 787f75f056 (master)
    Diff on Web: https://github.com/larsxschneider/git/commit/ec7106339d
    Checkout:    git fetch https://github.com/larsxschneider/git travisci/brew-perforce-fix-v1 && git checkout ec7106339d

 .travis.yml | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 3843967a69..c6ba8c8ec5 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -75,20 +75,13 @@ before_install:
       popd
       ;;
     osx)
-      brew_force_set_latest_binary_hash () {
-        FORMULA=$1
-        SHA=$(brew fetch --force $FORMULA 2>&1 | grep ^SHA256: | cut -d ' ' -f 2)
-        sed -E -i.bak "s/sha256 \"[0-9a-f]{64}\"/sha256 \"$SHA\"/g" \
-          "$(brew --repository homebrew/homebrew-binary)/$FORMULA.rb"
-      }
       brew update --quiet
       brew tap homebrew/binary --quiet
-      brew_force_set_latest_binary_hash perforce
-      brew_force_set_latest_binary_hash perforce-server
       # Uncomment this if you want to run perf tests:
       # brew install gnu-time
-      brew install git-lfs perforce-server perforce gettext
+      brew install git-lfs gettext
       brew link --force gettext
+      brew install Caskroom/cask/perforce
       ;;
     esac;
     echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";
--
2.11.0

