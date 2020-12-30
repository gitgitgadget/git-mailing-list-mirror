Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6965EC433E0
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29346207A9
	for <git@archiver.kernel.org>; Wed, 30 Dec 2020 23:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgL3Xad (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Dec 2020 18:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726276AbgL3Xad (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Dec 2020 18:30:33 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD2EC061573
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:29:52 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id d20so16819545otl.3
        for <git@vger.kernel.org>; Wed, 30 Dec 2020 15:29:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idmbvrBGDxTtKMRP0JIiDUGmFxYkgTLXZLlXOxGMAi0=;
        b=K4EAZZ03ZhdcE++ecSfxkh1b4ehEMFGs9C1ezy/bsq0xye7AwNfxBzgOS+8EVxfA2W
         Fd+CqnGu0/R+ODnNyMmwZJq55Xy/o+I27oHqzzdgtoM3JywlXXMNXfIqWcefs0v/WvWM
         hcX1d5dNCwB/1WPVQ7UZjaeHBnFQaAXA9N9NY19s1ot5f04gIUi/RHTUPZInAwiRxUXG
         rDoI/Yu4fgmOTmRWrC1A/RLjjj1Z4aTEwY+a9y3vDYhcf1npKPggmxVkMWmUGIAh2Z7A
         0QqLonT+GrIhTywmkJ1++1GCo6B4KJKFyQ6k2dgsJ+y+p01C+p7Kl+GzcGPC41RvHi/u
         Znfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=idmbvrBGDxTtKMRP0JIiDUGmFxYkgTLXZLlXOxGMAi0=;
        b=i4x8si6KryeVKbkpfS9tp0mtIM95N/uUXUbwy+zsZMPlrIjI9E5M+R4PQ56ZDCnzTt
         y3kplsezivQSunU0MfnJv4SM0BghQbXk9bw7w73BokvYByZDOLVn05SGNEkNBy5ejd0y
         6EiOYPHY51rJV6MWMlgBw6DFHDNrMuDRXPaN0THVrwDvmQh/ygqvlLP2r1Q6mYAvAKNe
         zcDXd9oKfCdwwZX53hovvQQVr8sMFFY1vDzQP5dpud6W/Bsql13hGbw5lPmh3sm/oDzF
         e8EFzeeC7ADbjg+jYu8D16sewTmZ6b+bbprAP4dISCDDD7l5NjnqNwE9YqfKUmlGCcX5
         XeCA==
X-Gm-Message-State: AOAM533pCOqAP5xrW3f+eIqoxxo3bZoL2sq5Hiq2JctRAzXkL2IyZFTd
        GTtHoOCscXn4NYRweUiyyDs7tuF6f4WYFA==
X-Google-Smtp-Source: ABdhPJyTxqVq4IVL6tydzA8fw5lFfmX+pkWaBR+aYt+gzb8SaNoRcGlW+ZdS6KuTOBWxMVlCFf3NPA==
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr5156559otq.22.1609370992060;
        Wed, 30 Dec 2020 15:29:52 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id r15sm10538215oie.33.2020.12.30.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Dec 2020 15:29:51 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 0/4] completion: make __git_complete public
Date:   Wed, 30 Dec 2020 17:29:46 -0600
Message-Id: <20201230232950.582152-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Back in 2012 I argued [1] for the introduction of a helper that would
allow users to specify aliases like:

  git_complete gf git_fetch

There was pushback because there was no clear guideline for public
functions (git_complete vs. _git_complete vs. _GIT_complete), and some
aliases didn't actually work.

Fast-forward to 2020, and there's still no guideline for public
functions, and those aliases still don't work (even though I sent the
fixes).

This has not prevented people from using this function that is clearly
needed to setup custom aliases [2], and in fact that's the recommended
way since there's no other.

But it is cumbersome that the user must type:

  __git_complete gf _git_fetch

Or worse:

  __git_complete gk __gitk_main

8 years is more than enough time to stop waiting for the perfect to
come; let's define a public function (with the same name) that is
actually user-friendly:

  __git_complete gf git_fetch
  __git_complete gk gitk

While also maintaining backwards compatibility.

Changes since v2:

 * Improved the safety of __git_have_func with suggestions from René Scharfe
 * Added documentation to the top of git-completion.bash

[1] https://lore.kernel.org/git/1334524814-13581-1-git-send-email-felipe.contreras@gmail.com/
[2] https://stackoverflow.com/questions/342969/how-do-i-get-bash-completion-to-work-with-aliases

Felipe Contreras (4):
  completion: bash: add __git_have_func helper
  completion: bash: improve function detection
  test: completion: add tests for __git_complete
  completion: add proper public __git_complete

 contrib/completion/git-completion.bash | 50 ++++++++++++++++++++------
 t/t9902-completion.sh                  | 20 +++++++++++
 2 files changed, 60 insertions(+), 10 deletions(-)

Range-diff against v2:
1:  0993732142 = 1:  0993732142 completion: bash: add __git_have_func helper
-:  ---------- > 2:  6a3fe8b79b completion: bash: improve function detection
2:  7918c34d0e = 3:  b211eebc0d test: completion: add tests for __git_complete
3:  8a6cc52063 ! 4:  a5bfe5376b completion: add proper public __git_complete
    @@ Commit message
         Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
     
      ## contrib/completion/git-completion.bash ##
    +@@
    + # tell the completion to use commit completion.  This also works with aliases
    + # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
    + #
    ++# If you have a command that is not part of git, but you would still
    ++# like completion, you can use __git_complete:
    ++#
    ++#   __git_complete gl git_log
    ++#
    ++# Or if it's a main command (i.e. git or gitk):
    ++#
    ++#   __git_complete gk gitk
    ++#
    + # Compatible with bash 3.2.57.
    + #
    + # You can set the following environment variables to influence the behavior of
     @@ contrib/completion/git-completion.bash: __git_func_wrap ()
      	$1
      }
-- 
2.30.0

