Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE770C43460
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1C73613BF
	for <git@archiver.kernel.org>; Wed,  5 May 2021 12:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232974AbhEEMWq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 08:22:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhEEMWn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 08:22:43 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFADFC061761
        for <git@vger.kernel.org>; Wed,  5 May 2021 05:21:45 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 4-20020a05600c26c4b0290146e1feccd8so1016081wmv.1
        for <git@vger.kernel.org>; Wed, 05 May 2021 05:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w1bq2Nra/OHUW861Ju1r7w+NgWqM22fpkw29SxsLqho=;
        b=QUxeyZBVei5fTPx9KqjjnNu0XUWw2CAw426XnYgrkulOZhZnIiggz79ySQQYZgB13O
         TPmlKPNL+Ap2DqQeXZWsbgEOn0zxTABVHR+2Efil9sKb/+P/2egQmAv47oY7/PuXjfbX
         lO61Mz/np4MH4uTy27ogoW5J+/cuKbIv2+gQK76f1xKsi8ASgy14hdbtjWAM0ez7dyDK
         Z7yPYD+jxbJGmag+LjY9F5oBIyNHwm8pUqAt7zWVZBy2kIw3KRj6/TGk8S5h0E/HWhR0
         ayRC3Sw5QUgzAfdbNcdVQVB35pKkWAVTqalTQCaTmiWuQXzbOGoQ6ZyilI5AEAFUx+Y+
         X8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=w1bq2Nra/OHUW861Ju1r7w+NgWqM22fpkw29SxsLqho=;
        b=nGGtTlUtIdJnEw3hJj2Nc5zr3JTFTIsceF54qHcg4b5DB6Zr+jj6epVH9IVIK6+tof
         vcNQplEZyEpjPE5EUqcMoXcD0CVNW5owunEXIKxuLttUkkQzgXLEFdYjkdKHkt5C5yQz
         TYKoa1lPGP5NcB2D9vGT1QP6vn0dwtFYp151JwAzO2+PMqIFuRH09e2BwUA2N6IzHrdy
         b1jSwjsDdsdAJ6Qk+kw+98lFsv3OaktfaZIFtu1cB6SCVCel4yQSSeFH3+ejy0ySy7Th
         q4XVCTz4PsBAofzO1Rn5WpWMHiJvKzhYfUhJPwHxOpbDCGDuyOnGgvFCtJ6alZ8gEpjD
         /2bg==
X-Gm-Message-State: AOAM5334I1BdEHv69lyvhJc5qzK9IIRVo4r8Uf4sXOcFEYVRro85+LCD
        AicWGRw56OkK5X7kurXwCoETMsL4T+C1GQ==
X-Google-Smtp-Source: ABdhPJz1p6fzEBjcovj9O9OHMYEJZaDhKToGv0QtbAFu4CU6k6ujDzVjkvitYEjsspIPGMXjBuaNYw==
X-Received: by 2002:a7b:c382:: with SMTP id s2mr28500083wmj.75.1620217303906;
        Wed, 05 May 2021 05:21:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k15sm19886643wro.87.2021.05.05.05.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 05:21:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/4] Makefile/perl: correctly re-generate build/* + speed up under NO_GETTEXT=Y
Date:   Wed,  5 May 2021 14:21:37 +0200
Message-Id: <cover-0.4-00000000000-20210505T121857Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.838.g7ac6e98bb53
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These patches are relatively trivial fixes for bugs noticed when I was
working on recent send-email patches. We don't re-build perl/build/*
assets when variables that affect them are changed, and needlessly use
our non-mock gettext Perl i18n framework under NO_GETTEXT=Y if the
system happens to have Locale::Messages installed.

Ævar Arnfjörð Bjarmason (4):
  Makefile: don't re-define PERL_DEFINES
  Makefile: regenerate perl/build/* if GIT-PERL-DEFINES changes
  Makefile: regenerate *.pm on NO_PERL_CPAN_FALLBACKS change
  perl: use mock i18n functions under NO_GETTEXT=Y

 Makefile         | 13 +++++++++----
 perl/Git/I18N.pm | 10 ++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.31.1.838.g7ac6e98bb53

