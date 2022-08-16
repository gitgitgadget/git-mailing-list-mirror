Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70BF6C25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237028AbiHPSJA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiHPSIH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:08:07 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7823C82F8E
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:07:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v3so13594167wrp.0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc;
        bh=Qvm/2dxHdFH45yLS4BnZhuJMzZ1T8qIYsuvQhC2I6e4=;
        b=hPNu0oldEtKviK1GGkLK/Gi4F+qXh48rsrczzuiRg9SUNoPUe+3V4pcmbbpYDm9JFj
         sYlGRB0yxzPPEq1QqS+zNkeYBVZhfV9NKW/sEEmmwwKcJgKRIJvm1MskytsYHI9FEGHQ
         50Q+e4OBs+4Tdprg0GbjDzUEovHpo0yJL1huyIj90N+7u+AdsX6gKkcTbgAiZofdAtUa
         wS1rmmFaEm9tiY/mV7pcAG1D+8BajkL3yBK7n6srJlxWuI19jHOWgrq4mLkRJuBVjXF0
         l7Oc6P/1EFqlqyFugjM+ERvfn8yMx9H0iVB/8o+FXaw4/UO+LjNkf3ngijiOuoU35JD6
         PfCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc;
        bh=Qvm/2dxHdFH45yLS4BnZhuJMzZ1T8qIYsuvQhC2I6e4=;
        b=G3u3vhKuLty3a0EOUe9Rdtvd61xkkvrYpRPQhT41Cxz1d5e5xa0QTHybC1vs3zLh5s
         rwmAjSpKMLSpDDVnAkH8ZI+nzAtzBd8HyZjHBN7hs8Gk/sX4fQmFEjW1iPej6xL4fQkN
         5kBMEMi2EJIWwLL0X4Kf3uGBfLHxkU6iUgus3uKrA5iz9+Y6HcfIMbXIoVcROetYzhMo
         fAPrNsxURFE6/AaUybr5UttMhOH4ZyCj/GJJP+uSwBUP/eOWYEgDJL3nTyLYY4hdOpPU
         z6FQmRMxNQH0cn074oAojzHnnB16Ixt8RoxmmcRuN34eRrU7nkaj8nDPZXoNAfiSMF2p
         PLfQ==
X-Gm-Message-State: ACgBeo2sMcgEs6dFRLqbcEgtaORw/IDN/Kski5TewLU81FZWzL5F+fa3
        407pzpTS39q5mh7rt2kPrpnOadGovh4=
X-Google-Smtp-Source: AA6agR5gkSxSf6NgzqZy+FqQ/xBT+wUNdglBqmW6O7xgeywlojnBwgMTnSFjlhS6ybM3vgRV+WC6HQ==
X-Received: by 2002:a05:6000:381:b0:221:7542:61bb with SMTP id u1-20020a056000038100b00221754261bbmr12259576wrf.305.1660673270681;
        Tue, 16 Aug 2022 11:07:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p185-20020a1c29c2000000b003a4f1385f0asm14396041wmp.24.2022.08.16.11.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 11:07:50 -0700 (PDT)
Message-Id: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 18:07:46 +0000
Subject: [PATCH 0/3] scalar: enable built-in FSMonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series enables the built-in FSMonitor [1] on 'scalar'-registered
repository enlistments. To avoid errors when unregistering an enlistment,
the FSMonitor daemon is explicitly stopped during 'scalar unregister'.

Maintainer's note: this series has a minor conflict with
'vd/scalar-generalize-diagnose'. Please let me know if there's anything else
I can provide (in addition to [2]) that would make resolution easier.

Thanks

 * Victoria

[1]
https://lore.kernel.org/git/pull.1143.git.1644940773.gitgitgadget@gmail.com/

[2] The conflict is a result of both series updating the Scalar roadmap doc.
For reference, my merge resolution (from git diff <merge commit> <merge
commit>^1 <merge commit>^2, where <merge commit>^1 is
'vd/scalar-generalize-diagnose' and <merge commit>^2 is this series) looks
like:

------------->8------------->8------------->8------------->8------------->8-------------
diff --cc Documentation/technical/scalar.txt
index f6353375f0,047390e46e..0600150b3a
--- a/Documentation/technical/scalar.txt
+++ b/Documentation/technical/scalar.txt
@@@ -84,20 -84,26 +84,23 @@@ series have been accepted
  
  - `scalar-diagnose`: The `scalar` command is taught the `diagnose` subcommand.
  
 +- `scalar-generalize-diagnose`: Move the functionality of `scalar diagnose`
 +  into `git diagnose` and `git bugreport --diagnose`.
 +
+ - 'scalar-add-fsmonitor: Enable the built-in FSMonitor in Scalar
+   enlistments. At the end of this series, Scalar should be feature-complete
+   from the perspective of a user.
+ 
  Roughly speaking (and subject to change), the following series are needed to
  "finish" this initial version of Scalar:
  
- - Finish Scalar features: Enable the built-in FSMonitor in Scalar enlistments
-   and implement `scalar help`. At the end of this series, Scalar should be
-   feature-complete from the perspective of a user.
 -- Generalize features not specific to Scalar: In the spirit of making Scalar
 -  configure only what is needed for large repo performance, move common
 -  utilities into other parts of Git. Some of this will be internal-only, but one
 -  major change will be generalizing `scalar diagnose` for use with any Git
 -  repository.
--
  - Move Scalar to toplevel: Move Scalar out of `contrib/` and into the root of
-   `git`, including updates to build and install it with the rest of Git. This
-   change will incorporate Scalar into the Git CI and test framework, as well as
-   expand regression and performance testing to ensure the tool is stable.
+   `git`. This includes a variety of related updates, including:
+     - building & installing Scalar in the Git root-level 'make [install]'.
+     - builing & testing Scalar as part of CI.
+     - moving and expanding test coverage of Scalar (including perf tests).
+     - implementing 'scalar help'/'git help scalar' to display scalar
+       documentation.
  
  Finally, there are two additional patch series that exist in Microsoft's fork of
  Git, but there is no current plan to upstream them. There are some interesting
-------------8<-------------8<-------------8<-------------8<-------------8<---------


Johannes Schindelin (1):
  scalar unregister: stop FSMonitor daemon

Matthew John Cheetham (1):
  scalar: enable built-in FSMonitor on `register`

Victoria Dye (1):
  scalar: update technical doc roadmap with FSMonitor support

 Documentation/technical/scalar.txt | 17 +++++---
 contrib/scalar/scalar.c            | 69 ++++++++++++++++++++++++++++++
 contrib/scalar/t/t9099-scalar.sh   | 11 +++++
 3 files changed, 90 insertions(+), 7 deletions(-)


base-commit: 4af7188bc97f70277d0f10d56d5373022b1fa385
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1324%2Fvdye%2Fscalar%2Fadd-fsmonitor-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1324/vdye/scalar/add-fsmonitor-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1324
-- 
gitgitgadget
