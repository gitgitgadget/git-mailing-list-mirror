Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 725D3C77B75
	for <git@archiver.kernel.org>; Sat,  6 May 2023 21:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbjEFVaA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 May 2023 17:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEFV36 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 May 2023 17:29:58 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE851155E
        for <git@vger.kernel.org>; Sat,  6 May 2023 14:29:57 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aad5245571so20875315ad.1
        for <git@vger.kernel.org>; Sat, 06 May 2023 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683408597; x=1686000597;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rzLLUB1QIIH1IjD27sP4IfLGAib27hhdeaPxGuv6rLo=;
        b=AY8Ga+SPl3oawWm3pyQTOgL07wY7Ikfm1LPKv30cWRAAO/MsUhDkNYlx1hijyb3F64
         IyQ+fBVLvXwibByXNJCkEQjfZMKTco3vJizLEcNzJaltgFMki6U/J2HrFstZcL9JFBLg
         KSsXcCDxJfMaYOc4gn4NbLieQWpCo5ogD2dcPr1SRek77GqOh09nvcrnI171P+Nsj74I
         lGVDH8e1sDhZo7mcbCC8uqqbtLaDYLunLOGP/MSX11nZx0V9w7VysiqvA3MWKx1JaQHF
         /UKULVLrUAG82P0SZqS12QYSapj7wbEga7RZPIZsN2h6LJuj/4kLMEJ9On2WYDGD96zV
         Y2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683408597; x=1686000597;
        h=mime-version:user-agent:message-id:date:subject:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rzLLUB1QIIH1IjD27sP4IfLGAib27hhdeaPxGuv6rLo=;
        b=QoKEEnu3Hw7RRj/+u8u9rEnB6p/V6T3hXxjbPAfbA96qXXTXz1t/CL3P+hfmAF8AiD
         dkZ4Q05OhAx4LM9F8sDM4+6KPjMrmob8DjmcmF2GPudzDp8H2tV5NzFA3U94s11shrMf
         Pwo3gkzt+jqhi/hzerezu+cIX3Us7ZuEBysxXnqRuWwiB73mTjHmhGQv1mKCDtJTOe6a
         BrgBdsR4uaz+2Pvuvs9IAHp4knSYqMgccDwNhu6AX3gdYflbytirLm/7x/Le3xQne/lk
         dPTYDvuZt3RL80iPTczOV5gjdwJZHdrJRaxGhp4u6jGOPYS8CjjNApC1hX0phtGExSnv
         oiWQ==
X-Gm-Message-State: AC+VfDwsOTnBoUiT20LBzO5YGKPY4gZGAVSsStNRF5cWYZHGKzCz8uZa
        P6zQWSpVPl0nbb7eAdtduJZFmI0w0CM=
X-Google-Smtp-Source: ACHHUZ6sBgNGL1v1ocJ0UZF2XgeL5mYt8fFocE3zX+0iKrosegIZji07wtb0Xzi9a9u5uylRRO9hKg==
X-Received: by 2002:a17:903:234b:b0:1ac:6573:dae5 with SMTP id c11-20020a170903234b00b001ac6573dae5mr904779plh.55.1683408596644;
        Sat, 06 May 2023 14:29:56 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id lx11-20020a17090b4b0b00b00246cc751c6bsm7057089pjb.46.2023.05.06.14.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 May 2023 14:29:56 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] t9800: correct misuse of 'show -s --raw' in a test
Date:   Sat, 06 May 2023 14:29:55 -0700
Message-ID: <xmqqild5rvvw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is $(git show -s --raw --pretty=format:%at HEAD) in this test
that is meant to grab the author time of the commit.  We used to
have a bug in the command line option parser of the diff family of
commands, where "show -s --raw" was identical to "show -s".

With the "-s" bug fixed, "show -s --raw" would mean the same thing
as "show --raw", i.e. show the output from the diff machinery in the
"raw" format.  And this test will start failing, so fix it before
that happens.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

* It appears pretty obvious that the original wanted to just grab
  the %at timestamp of the HEAD, and with the fix to allow output
  format options to take effect after "-s" is given, the existing
  misuse of "--raw" after "-s" that ought to be a no-op breaks the
  test.

  https://github.com/git/git/actions/runs/4897931294/jobs/8755228452#step:4:1847

  is CI run with the "-s" fix merged into 'seen'.

 t/t9800-git-p4-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9800-git-p4-basic.sh b/t/t9800-git-p4-basic.sh
index dc88d0e064..a4b3cb9492 100755
--- a/t/t9800-git-p4-basic.sh
+++ b/t/t9800-git-p4-basic.sh
@@ -330,7 +330,7 @@ test_expect_success 'initial import time from top change time' '
 	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
-		gittime=$(git show -s --raw --pretty=format:%at HEAD) &&
+		gittime=$(git show -s --pretty=format:%at HEAD) &&
 		echo $p4time $gittime &&
 		test $p4time = $gittime
 	)
-- 
2.40.1-476-g69c786637d

