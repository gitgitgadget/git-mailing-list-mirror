Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48D322092F
	for <e@80x24.org>; Sun, 22 Jan 2017 22:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750714AbdAVW4A (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 17:56:00 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35354 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAVWz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 17:55:59 -0500
Received: by mail-wm0-f68.google.com with SMTP id d140so22149551wmd.2
        for <git@vger.kernel.org>; Sun, 22 Jan 2017 14:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SP9N+/5W2JWTWe9UxLnd1B0+9HJCKXacKl1FGkxKmDQ=;
        b=YVBHkjldQEPf91O9mBA8CUofi9z63Nuxp4Cvxt6fIk/dbcmKhoTvLRr3doyNkCv/9T
         j3pcEfAjFXdjxpV4SB5rIsTezGGbmpecvJP+al9VHJmQ0HOCxqCKpFFx2i7/BwZrSUGg
         dVgG0lqED9f9hhDNynfPmt7jA64uALv1trGSnsubBO0YaEDraQCD6zx7jE6X02b59xke
         F0+xViSvWxrHmirYMhFX8mapleixnwgFQSULivRtHhu1t8gqfQ+OELmoEG6wZ4lDPJ5x
         3hPyfKfbdjIlsQQcbEhvubFj+MNGb+QvLdRHNkJYfhNoz6S0CtN/mTHqiOi5isBC1vdu
         2llA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SP9N+/5W2JWTWe9UxLnd1B0+9HJCKXacKl1FGkxKmDQ=;
        b=UfAwBIdbbcTtH7xscLbmuE+Ist7zYVaOm5VT7NQsZpKuEYwV3mskF7C+LwEdHGzd+m
         tm5pShPxmLaAWIm3O83g9+DJ55W27f76/L5Yy2ZxAFpgqVsmh79UfEuiqtZyHTSMN38P
         ZcK7I+rwnB+Z6PkGXPnjdVWbzvtDHBHDalaHIhqFGZWGPNzQaGCU9xDAGLrMzWXtxDGn
         QDGOZePEI1Zelbcs8+A1aiV/ROYvG3DpjKKwTyP35GU7wsPjD+DPY+qMY5JIaLA14B2q
         8lDgXgxq/lJMzq31PyYu4q203ruRyxj9/7rKKIxEKXGcM+RGxB1DoTzeFW9llXshGIac
         DY4w==
X-Gm-Message-State: AIkVDXJG9Rj2C3EjwckdjBo+3SXLa8mFDoaahC2qb4YsgvWduAPApekWOePb/Y39m33X4w==
X-Received: by 10.28.139.141 with SMTP id n135mr10762979wmd.50.1485125758071;
        Sun, 22 Jan 2017 14:55:58 -0800 (PST)
Received: from localhost.localdomain (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l140sm18034294wmg.12.2017.01.22.14.55.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jan 2017 14:55:57 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v2] travis-ci: fix Perforce install on macOS
Date:   Sun, 22 Jan 2017 23:55:50 +0100
Message-Id: <20170122225550.28422-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

Hi,

this small update removes one more unnecessary line and makes the
formula name lower case (no functional reason - just looks better ;-).

@Junio: Do you prefer such a v2 as "--in-reply-to" to v1 or as separate
        thread? What eases your workflow?

Thanks,
Lars


Notes:
    Base Commit: 787f75f056 (787f75f0567aa8c7347544c65e9d3bc6640a27d4)
    Diff on Web: https://github.com/larsxschneider/git/commit/a8ec423355
    Checkout:    git fetch https://github.com/larsxschneider/git travisci/brew-perforce-fix-v2 && git checkout a8ec423355

    Interdiff (v1..v2):

    diff --git a/.travis.yml b/.travis.yml
    index c6ba8c8ec5..9c63c8c3f6 100644
    --- a/.travis.yml
    +++ b/.travis.yml
    @@ -76,12 +76,11 @@ before_install:
           ;;
         osx)
           brew update --quiet
    -      brew tap homebrew/binary --quiet
           # Uncomment this if you want to run perf tests:
           # brew install gnu-time
           brew install git-lfs gettext
           brew link --force gettext
    -      brew install Caskroom/cask/perforce
    +      brew install caskroom/cask/perforce
           ;;
         esac;
         echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";

 .travis.yml | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 3843967a69..9c63c8c3f6 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -75,20 +75,12 @@ before_install:
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
-      brew tap homebrew/binary --quiet
-      brew_force_set_latest_binary_hash perforce
-      brew_force_set_latest_binary_hash perforce-server
       # Uncomment this if you want to run perf tests:
       # brew install gnu-time
-      brew install git-lfs perforce-server perforce gettext
+      brew install git-lfs gettext
       brew link --force gettext
+      brew install caskroom/cask/perforce
       ;;
     esac;
     echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";
--
2.11.0

