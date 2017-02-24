Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97D13201A9
	for <e@80x24.org>; Fri, 24 Feb 2017 17:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbdBXRie (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 12:38:34 -0500
Received: from mail-ua0-f195.google.com ([209.85.217.195]:34273 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbdBXRic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 12:38:32 -0500
Received: by mail-ua0-f195.google.com with SMTP id e4so1686244uae.1
        for <git@vger.kernel.org>; Fri, 24 Feb 2017 09:38:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zf2Fh0HKKGLqePfBSLkHncT8MHf9emf1h6MNPhQnNFE=;
        b=NUzaNAnGl6z0EoRf+HFMSxdRTSWCGTiMINQ06yLQ5vmE7zjVfd/bVM3GYTuGqFh0Gx
         L7qPZyrQB33r6qs7kemGcpKV40ud9gsEtsEOWpyer2PTH54tgXfB8iQp3aSbTCfx35+j
         jZvDkI3H7JuO72V9X/BfZaEQaz7/kyU06ffUfBaIaVaAhA8ZvHxIRdjL9btee54stGCe
         iO/1qRiCn5eFDq2hlKib2G43O9CIiynsAiSU2gH3i6NkaFpOFkHsqJ+ElbbyDVGFy1Rk
         Qii4GeO9rIqM9Lvhj4H+rrSQQoMuGs0s46HJ6i7F4My2p7Lc4PAXzwoAcdJtrDVWBUJ1
         jp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zf2Fh0HKKGLqePfBSLkHncT8MHf9emf1h6MNPhQnNFE=;
        b=U4q2h+JbXfmXEAddFKQ+U24XdKqwW4Rtmpj9scOhWyU1u5INeukx5aiU86qcVUC192
         Nt66u2eyJ78JcZIZBcbZAnkX0AAEHRedR1SEfziaWnVbcWPo55OU0Zet1DDIQD7fjCm8
         mgZiZFXtf/du4lwhwihatAPkXVaDqvHUoaptC+6SZkwlU8I2aGrHF/XtOVWhjboo7P8A
         IiBbSbzUfieXm5edewrnTGLhNVlqFIEWrPjPxkW2YND2Zf3ujflReeX6WQBK66LoBHEW
         pr62NEcpkL5lhD03r4pbvBcgDq16RVl0j+SyZRHKWWywdQfJQH3GBjq164xRWZI7TEtN
         z0Xw==
X-Gm-Message-State: AMke39lcHSN1Fkw7yhDk7aI1t2tR67oZOTo3v87FSi5D3rcxrot/egkD29UF1bj53vPPDJexFhMpKUvZyBcxAA==
X-Received: by 10.176.6.105 with SMTP id f96mr1789508uaf.118.1487957385719;
 Fri, 24 Feb 2017 09:29:45 -0800 (PST)
MIME-Version: 1.0
Received: by 10.159.35.17 with HTTP; Fri, 24 Feb 2017 09:29:05 -0800 (PST)
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Fri, 24 Feb 2017 11:29:05 -0600
Message-ID: <CAJZjrdXP3n5fOLx4rEEkbJT7JBMPUqk4Qdutm6KpvMVUMwCSPQ@mail.gmail.com>
Subject: [PATCH] travis-ci: run scan-build every time
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduces the scan-build static code analysis tool from the Clang
project to all Travis CI builds. Installs clang (since scan-build
needs clang as a dependency) to make this possible (on macOS, also
updates PATH to allow scan-build to be invoked without referencing the
full path).
---

A build with this patch can be found at [1]. Note that if reports *are*
generated, this doesn't allow us to access them, and if we dumped
the reports as build artifacts, I'm not sure where we would want to
dump them to.

It's worth noting that there seems to be a weird issue with scan-build
where it *will* generate a report for something locally, but won't do it
on Travis. See [2] for an example where I have a C program with a
very obvious memory leak but scan-build on Travis doesn't generate
a report (despite complaining about it in stdout), even though it does
on my local machine.

[1] https://travis-ci.org/sxlijin/git/builds/204853233
[2] https://travis-ci.org/sxlijin/travis-testing/jobs/205025319#L331-L342

 .travis.yml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 9c63c8c3f..1038b1b3d 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -20,6 +20,7 @@ addons:
     - language-pack-is
     - git-svn
     - apache2
+    - clang

 env:
   global:
@@ -78,9 +79,8 @@ before_install:
       brew update --quiet
       # Uncomment this if you want to run perf tests:
       # brew install gnu-time
-      brew install git-lfs gettext
-      brew link --force gettext
-      brew install caskroom/cask/perforce
+      brew install git-lfs gettext caskroom/cask/perforce llvm
+      brew link --force gettext llvm
       ;;
     esac;
     echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)";
@@ -92,9 +92,9 @@ before_install:
     mkdir -p $HOME/travis-cache;
     ln -s $HOME/travis-cache/.prove t/.prove;

-before_script: make --jobs=2
+before_script: scan-build make --jobs=2

-script: make --quiet test
+script: scan-build make --quiet test

 after_failure:
   - >
--
2.11.1
