Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73C8C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9A0A22248
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 12:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lw2jtodB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbgIPMjw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 08:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbgIPKae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 06:30:34 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A24C06178A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:29:59 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k18so2412814wmj.5
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecbBmGKt69ydOLlptDo+dM4OrXVRXatgG66hPJMOUrY=;
        b=lw2jtodBa4QTvpr5mc7j6Q0u6xRLdLSjObiukKiYmBOoJZDdoa8pvDhIUvb84eVsYT
         /Lzasflk3N4JNdy4bBHpUrSLdlNQzPw5ylwI7DiQhXH8WfuXiJA0mj7tz1fEfJNUyaEH
         xxiiBTfHCkV6JhpndbAhTYwKIWCY5Bu3SFC6fjQff1XNbM0MU6k31mQtq1qbluPowaJM
         E+kKiBK+oVigsA7cPYdfJFr3Og9SzfU8bH46x5W2rz1XjCUOqgR1411sA2LNeByZ26eq
         HEZ7j0wX583TMRWJVHnUXfPUB795GDzAGeZIx63C8lu9ItZtUEeapJ9Rb0aPpLAQh/NK
         Pkiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ecbBmGKt69ydOLlptDo+dM4OrXVRXatgG66hPJMOUrY=;
        b=CntICEvwQeOTP272AsNpikVvar9Vl/CfwSmTdW9O81S5ME6hfDrPOsfQXahpZ6jXOo
         /hrSuvusRrQobwyERBfYAV5pjsic8P68xuSQKs6E0Czneuh7oLeo+7L15OVed05mmwva
         5dfWwi5H1NnW6jLb9vWqNj47it14cm57A9UVDLxoa5Drks1o4RPRWgobg+iFmvgpWDWy
         tBJ0rxP1/Zp2Isg6+x4nJBKumS6HJ2uVNbHtzhEfJgtu0InB6pyKa3GQMI/jBWu53X97
         o2QpqTST8zHrRRcbcJFN1szeAQnYbY9dd7rn28x6a/f+pNNJqPhiYO0TEENknl2MF77g
         lAqg==
X-Gm-Message-State: AOAM532VhMoblHfhz/kUDWdsarYH4aSiuR6IssQuI7k4Jvj3kyHjIV6t
        Pd/kNC0i/zpe0Bm8H0MGinKZBw13Tig0e4ko
X-Google-Smtp-Source: ABdhPJztP8VxE41N+IJU+4olyT0B3eEfAlFfX5dGmQg8v2NK07VC7uNYk1gKDS0+NOPz0WgP1QQVSw==
X-Received: by 2002:a1c:9ec1:: with SMTP id h184mr4036776wme.180.1600252198013;
        Wed, 16 Sep 2020 03:29:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n11sm32172916wrx.91.2020.09.16.03.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 03:29:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 00/15] remote-mediawiki: various fixes to make tests pass
Date:   Wed, 16 Sep 2020 12:29:03 +0200
Message-Id: <20200916102918.29805-1-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I had occasion to look at remote-mediawiki and I couldn't even get the
test suite to run. The patches below have more detail but there's
issues like a hard error on any Perl release newer than ones released
in 2013, and the MediaWiki release it tries to use spewing errors on
any modern PHP version.

This series fixes these issues. With it applied it's possible to run
the tests, and they all pass.

Simon Legner (1):
  remote-mediawiki: fix duplicate revisions being imported

Ævar Arnfjörð Bjarmason (14):
  remote-mediawiki doc: correct link to GitHub project
  remote-mediawiki doc: link to MediaWiki's current version
  remote-mediawiki doc: bump recommended PHP version to 7.3
  remote-mediawiki tests: use the login/password variables
  remote-mediawiki tests: use a 10 character password
  remote-mediawiki tests: use test_cmp in tests
  remote-mediawiki tests: guard test_cmp with test_path_is_file
  remote-mediawiki tests: change `[]` to `test`
  remote-mediawiki tests: use "$dir/" instead of "$dir."
  remote-mediawiki tests: use a more idiomatic dispatch table
  remote-mediawiki tests: replace deprecated Perl construct
  remote-mediawiki tests: use inline PerlIO for readability
  remote-mediawiki tests: use CLI installer
  remote-mediawiki tests: annotate failing tests

 contrib/mw-to-git/git-mw.perl                 |   2 +-
 contrib/mw-to-git/git-remote-mediawiki.perl   |   5 +-
 contrib/mw-to-git/git-remote-mediawiki.txt    |   2 +-
 contrib/mw-to-git/t/.gitignore                |   2 +-
 contrib/mw-to-git/t/README                    |  10 +-
 contrib/mw-to-git/t/install-wiki/.gitignore   |   1 -
 .../t/install-wiki/LocalSettings.php          | 129 --------------
 .../mw-to-git/t/install-wiki/db_install.php   | 120 -------------
 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh  |   8 +-
 .../t/t9363-mw-to-git-export-import.sh        |  15 +-
 contrib/mw-to-git/t/test-gitmw-lib.sh         | 159 +++++++++---------
 contrib/mw-to-git/t/test-gitmw.pl             |  22 ++-
 contrib/mw-to-git/t/test.config               |  23 +--
 13 files changed, 129 insertions(+), 369 deletions(-)
 delete mode 100644 contrib/mw-to-git/t/install-wiki/.gitignore
 delete mode 100644 contrib/mw-to-git/t/install-wiki/LocalSettings.php
 delete mode 100644 contrib/mw-to-git/t/install-wiki/db_install.php

-- 
2.28.0.297.g1956fa8f8d

