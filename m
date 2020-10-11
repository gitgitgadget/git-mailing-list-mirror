Return-Path: <SRS0=tPyM=DS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19FBC433E7
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 21:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A64942076C
	for <git@archiver.kernel.org>; Sun, 11 Oct 2020 21:27:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsptX747"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387584AbgJKV1O (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Oct 2020 17:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387413AbgJKV1O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Oct 2020 17:27:14 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00455C0613CE
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 14:27:13 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id n18so16869905wrs.5
        for <git@vger.kernel.org>; Sun, 11 Oct 2020 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=HyaBPBQDbaAPQocoPEPVm1DbljOihKYxN7xD3Occwls=;
        b=MsptX747fPGtuZeqt2z6wrPVAIIzWxv6MWfQuwb2vKfUaGzH5XuDJs7Ea9N4NLOycW
         G0dwoNVjt13GT/mIemGw6ss+NfifqqnjuYdV6qkHxIeeRtihZCBTkIOe4wf5zu54xWrQ
         UcF+AukVteFAyx28J5Dy942i/mNUWQVEVwoAEWWVXjdeAc6qeVtnbMAgxswnmHT8rj/B
         +b6r6Nb3EvawEkcAyMfZHWP2FVuVxhfHEJ1ufIHhjVm56zKi7cERtRvSmfas6Eh/I/la
         Zc6L3+KbxLtNvOtw/j427jQAKSMC31wkZdvUt48DQsbTjOLpfRtxe8BcSPQsj5gIEISd
         RjUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HyaBPBQDbaAPQocoPEPVm1DbljOihKYxN7xD3Occwls=;
        b=UcoNcFPORSsVJYSSeFtI7OCLO7ns5cYMMz16lqgLRxmi0RKfh3Xv5gG7V46mgqqTbH
         dZBWPEOjYvaH2Ix5CNp7q/K4q06gmDDMtEetfj4IHSQMQhd6f4ahhAIGQmrjZxcgpED0
         8ti6r0M5oVV0QC69wq3VBHgMlUXW4xlstvoYPgS0Rh7xsGSNogMI2xFmPp6O/57+b+gl
         8IOq7yulyKjvLdhxy25rt3shDJ0aJvwTVpSvx2BNtMNlSsnVIlrJ6FsxE8HjI8etIuip
         IvANFQjXQLCbqJK7+KlGGidmyzAYOzeIjkl8qinr7Kiu2pqwmSRdQJxSxFw/PznPc7Hx
         mt4w==
X-Gm-Message-State: AOAM531mzMsbWcnolIsrkT4xZ/jDU4HTPU5xounY2lsFKWDXqthu0+Qn
        6TMDXLjL0Qi5iENbDrMA+GkkoP2YwwY=
X-Google-Smtp-Source: ABdhPJzG1A6VVF2HZHhspi7um2LiM1gOKb7ke0FXkwBEYsyZ18RIFHwWQ+76RuzyrXI6QnqG8zdVDQ==
X-Received: by 2002:adf:fb8b:: with SMTP id a11mr8159170wrr.407.1602451632543;
        Sun, 11 Oct 2020 14:27:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g14sm21769916wrx.22.2020.10.11.14.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 14:27:12 -0700 (PDT)
Message-Id: <pull.748.git.1602451631.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 11 Oct 2020 21:27:09 +0000
Subject: [PATCH 0/2] ci: make the new GitHub workflow logic more defensive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil just reported that the check I added failed miserably
[https://github.com/phil-blain/git/runs/1238660958] in their fork, and the 
entire run would be abandoned. That's totally unintended, and was caused by
a different metadata format for older recorded runs.

Let's work around this particular issue, and then make the entire check a
lot more robust.

This patch series is based on js/ci-ghwf-dedup-tests.

Johannes Schindelin (2):
  ci: work around old records of GitHub runs
  ci: make the "skip-if-redundant" check more defensive

 .github/workflows/main.yml | 58 ++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 27 deletions(-)


base-commit: 4463ce75b7eea47f9b484b05957def655d3f46d5
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-748%2Fdscho%2Fci-ghwf-dedup-tests-defensive-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-748/dscho/ci-ghwf-dedup-tests-defensive-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/748
-- 
gitgitgadget
