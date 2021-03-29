Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F9BDC433C1
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63FEC6188B
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 13:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhC2NnV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhC2NnI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 09:43:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A993CC061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:43:07 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id j18so12929693wra.2
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 06:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UkpWPxGjdPSP9bG6kv7wZPaxquPMOv1C+c+gpL/8XFA=;
        b=Yci7Cx02wD881BDjDeUB0X7NywqtkM1gT/AvHz1S0nAxfSW+cd6JBOo9AMTC0/rwAe
         rp62TboNIs003CpakXYrEZodDFfX4o7878ZZkJrCEybouO/e20L0hNO8KxAMOJC989h5
         AD8cw6uj8KV0HNGLp0QDccivbJF5NClyw+kGzHqU1A6XD7pHWl/4sgs//zQV18k/OgtY
         DglEUDHk/hiNa7L4/2d0CcuGW4sg5GSRJyrEr41hv87dCROI6aDLnag5mAE4449+2muK
         2nV9h6veygoWLQdpArv1Lm6oRsl0Ilri0RHk/JsRDbT1Htc91pd5b2A7QOin3VxFu5R8
         nbTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UkpWPxGjdPSP9bG6kv7wZPaxquPMOv1C+c+gpL/8XFA=;
        b=auFglmQtT+UVY5l902eSaPe1noGtD75JtqD/R9jmaecVukeEySaR66uuy24Xmqxo79
         VK1g5Rg+7TBGNSk8XSHnKabOJurY5sNCvLq2JSpn16uS40ZlL8CGrqSHnf3A3iilrTCv
         xbmxeCSUqVU2kULALmvSIBDSsWNNx3hHcEgwwjuIc5GG6aPcH9wxHqFztE0x3Q2JcBN+
         2qQhovyb7r8cPikUhk30rFtPT1ZaPRYJUYyIegJoJjfbqO7n6Aqwj/uvsnWQN14Hv1ZK
         iY2PMkk29CwWaBg5854i94O9nljGe1odgMHzTlZhPcpgbstQzE9AdOKBoGCHSqnv9iwe
         8OIA==
X-Gm-Message-State: AOAM531GHDjz5QIG4UCbnLKmmRwnS0hLDiHT4ADHg2bimtQ6GS1qQ0QY
        yOlmZQ3Mtx/5YHFz10tA8o8/PEb+0mw=
X-Google-Smtp-Source: ABdhPJw5n4fcY2RL+JGSg0hvsnd2vMO5Q69/8Pgab0bEyb530c+zDeyx/tb+Elj0gN5Y7QnCbG8s1g==
X-Received: by 2002:adf:b313:: with SMTP id j19mr28065485wrd.188.1617025386501;
        Mon, 29 Mar 2021 06:43:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm29152674wrw.69.2021.03.29.06.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Mar 2021 06:43:05 -0700 (PDT)
Message-Id: <pull.917.v2.git.1617025385.gitgitgadget@gmail.com>
In-Reply-To: <pull.917.git.1616796767.gitgitgadget@gmail.com>
References: <pull.917.git.1616796767.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Mar 2021 13:43:02 +0000
Subject: [PATCH v2 0/2] Describe Git's security policy
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On GitHub, SECURITY.md files are the recommended way to describe how to
report vulnerabilities, and to set expectations how far back maintenance
tracks are updated with security bug fixes.

For example, when navigating to https://github.com/git/git/security/ users
would be guided to that SECURITY.md file. If it exists.

The purpose of this patch series is to add this file, describing Git's
security policy.

While at it, I also want to document the process how to coordinate the
ensuing embargoed releases. This is what the second patch is all about.

The reason for that is quite selfish, as I did two of them, and while I am
happy that such embargoed releases do not happen all that often, the
downside is that I keep forgetting all the details. So this document is not
only meant for knowledge sharing, but in particular to help me the next
time(s) I coordinate an embargoed release.

Many thanks to Junio who reviewed the first draft of this patch series
(where I had not yet separated out
Documentation/howto/coordinate-embargoed-releases.txt).

Changes since v1:

 * Fixed typo

Johannes Schindelin (2):
  SECURITY: describe how to report vulnerabilities
  Document how we do embargoed releases

 Documentation/Makefile                        |   1 +
 .../howto/coordinate-embargoed-releases.txt   | 131 ++++++++++++++++++
 SECURITY.md                                   |  51 +++++++
 3 files changed, 183 insertions(+)
 create mode 100644 Documentation/howto/coordinate-embargoed-releases.txt
 create mode 100644 SECURITY.md


base-commit: e6362826a0409539642a5738db61827e5978e2e4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-917%2Fdscho%2Fsecurity-policy-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-917/dscho/security-policy-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/917

Range-diff vs v1:

 1:  2c9f5725d96f ! 1:  3f5d866de195 SECURITY: describe how to report vulnerabilities
     @@ SECURITY.md (new)
      +- Ideally a short description (or a script) to demonstrate an
      +  exploit.
      +- The affected platforms and scenarios (the vulnerability might
     -+  only affect setups with case-sensitiv file systems, for
     ++  only affect setups with case-sensitive file systems, for
      +  example).
      +- The name and affiliation of the security researchers who are
      +  involved in the discovery, if any.
 2:  41efaaf62864 = 2:  565d7982d870 Document how we do embargoed releases

-- 
gitgitgadget
