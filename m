Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B666C4321E
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 08:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbiK3IYx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 03:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbiK3IYW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 03:24:22 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E351A697E0
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 00:23:56 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id ml11so14590107ejb.6
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 00:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLYjpmgfMU2rbBCCxXMPaNpeYb2p5bvoIO+hRWJISuY=;
        b=e6d5+f1kY5BemoyYD4uI/SL6ieFjF9W6TxMYZ4Lv8435sNqfmg5w98HWJ9kc5WLtEX
         OK7GyHQmw2E+a2x6efqcZ2L36MMqYPRE75K1OjVsNIBhDP6yaD2/eZOuC1yw1eo0sUoS
         EbAn8eprp50irz+Cc+Lkl7at+O+cg+OkJ1z1cJAywtpXsh0W8+roaXZAucQ+nsIb+Pxn
         5B3lSo9UW8IHWg/lBkrcf6gIKsum/KRjCDUbH5kcYeUDELLGOMUQcwlPXSCNLhnknB7z
         Eq8Nj3h5HMsMllRwTzdLSra3YieR0wudBU6QCsszBZ8NdVBWZgVwaTFmY5AucOPkCEu9
         oUIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLYjpmgfMU2rbBCCxXMPaNpeYb2p5bvoIO+hRWJISuY=;
        b=oS+CFgFpvv50jwfdSBX/1rd7horgsixVy+XuP4Fca2IWkVmSqpCiK5oFk2KaPMAkdB
         8qqYuq1smuOz6aLNvWTtcjUkbiJTjFsR62Jnq7GC3bSxYypuBphOtTKDDqblWOzUO0MM
         /Xb6c5fVQD4WbTeK6AGsRiSa/makazpbV53aCnBOEsykVamccKSqGp7793YW4ZoYDec9
         Jxorzwbblv0DkiM/FEd0MEiCd7a8LqD3NKkkIgHHvdLDmxKXX0YbfJH14mBv++LXjSaa
         KdHJ5G5ak6JL34cmKzHzMHtilrlPnYBiTGHnyJmoafRyX1twAe82+dg32ggr/GvdyCJv
         oysw==
X-Gm-Message-State: ANoB5pk2Em9dc/qPOIZkeeI6nHqM3ujAsWn1SovxgsabGtutjequrbEB
        wtxHdsZzee6RsDw0jzidGiodOc0AYOb+UA==
X-Google-Smtp-Source: AA0mqf4AIHB131qeeszP7BMmJJU51slNC0QpWCbWLwBhygSTKLKGmkIQO5CKzhStJIp5isBFHwXy0Q==
X-Received: by 2002:a17:906:30c1:b0:7b7:eaa9:c1cb with SMTP id b1-20020a17090630c100b007b7eaa9c1cbmr36525489ejb.745.1669796634933;
        Wed, 30 Nov 2022 00:23:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b007adf2e4c6f7sm352064ejh.195.2022.11.30.00.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 00:23:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Paul Smith <psmith@gnu.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/1] Makefiles: GNU make 4.4 fixes
Date:   Wed, 30 Nov 2022 09:23:48 +0100
Message-Id: <cover-v3-0.1-00000000000-20221130T081835Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.1028.gb88f24da998
In-Reply-To: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
References: <cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A now much-smaller re-roll of a potential for-v2.39.0 fix for GNU make
4.4 compatibility.

Junio: Sorry about the overlapping submission, at the time I didn't
see Paul's in the "What's Cooking", and thought it hadn't been picked
up at all (maybe I just forgot to look at the actual branches).

This v3 is just the "MAKEFLAGS" patch. I agree with your [2] that we
might want to leave this post-release, i.e. it'll just be (a lot) more
verbose, but does it break anything? Probably not.

On the other hand the fix here is trivial, and literally just the
exact solution to this compatibility problem suggested by GNU make's
"NEWS" file, and nothing else. So merging this before the release
should be low-risk...

1. https://lore.kernel.org/git/cover-v2-0.4-00000000000-20221129T140159Z-avarab@gmail.com/
2. https://lore.kernel.org/git/xmqqk03dyskc.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (1):
  Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4

 git-gui/Makefile | 2 +-
 shared.mak       | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

Range-diff against v2:
1:  42b4f241c97 < -:  ----------- Documentation/Makefile: de-duplicate *.[157] dependency list
2:  e232f308e40 < -:  ----------- Documentation/Makefile: avoid multiple patterns when generating one file
3:  6db7dd74e52 = 1:  432518b2dd7 Makefiles: change search through $(MAKEFLAGS) for GNU make 4.4
4:  f1bc3c16904 < -:  ----------- Documentation/Makefile: narrow wildcard rules to our known files
-- 
2.39.0.rc0.1028.gb88f24da998

