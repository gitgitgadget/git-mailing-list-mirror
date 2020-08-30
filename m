Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603FCC433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E99F2083E
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 22:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTLojd0m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbgH3WB1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 18:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgH3WBY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 18:01:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E66C061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:01:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id h15so4047427wrt.12
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 15:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=VhWM8i0+sAQwDaLpThoULAaIjM2BQzjYmEulRyfq+S4=;
        b=YTLojd0mbcYB877PqTq5C/IWF3vTVc9iXnBkRAbi+ttr64zgQF4wiD3hA4zfHHnbK3
         MM551Vj3fWBorkTBuTwyBSgeiklw42mYBGKCghNlLWxLFOyLmMnwbI2YTWP4MCwZtkQC
         s0baTvEsPu3YXTnT4JcrHHJ3v5p+csyuwm3q2Lf0vWtj4SxOHPGW2LwvO6uAOcPBErv6
         ybLVNCfQ9iX/NyvOryezLo+q+MkmtIhYTEz8IH3EVokgARUQGu5/BTf7NAh7q23+bVXN
         0Nk1+DUvhu2j8IhhF40/GZoQTkZhBLYSPbtKMbmUeKz/lM2lPw079vpLPvyUjKmKVg7r
         9QNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VhWM8i0+sAQwDaLpThoULAaIjM2BQzjYmEulRyfq+S4=;
        b=GmzH6N3ymBPTP4kXdwZNao7WpFoi8pcKEVg38Yqmcm9ArZ40Ox0d9Wqw4uSgbHhiGp
         tI0TQY5SRzuhGo3mS/rDCk9zE99lCD33rka2H6HTKqpLpB/qMudLImYiwza9vt3wLmDw
         4/m8uuRa8osIbnp8JvnZjz7mt3rmQ0EL+IW1eBa32YNXfXHgSdWOQxSkhtiRmvyuEGac
         PcIUsPO1PTSmkKxP+PD3P1UR/iFUv6B+6iuHUdJEH8BM76lLpVKMmdNNgbaom8KyW0Cx
         d7jvlBOVhJrWh7tnGQZo9I7bGKc6OEim+JQsth+WPkN+ZLL75sGwsWAjIvr6WbO6CZGP
         6pdg==
X-Gm-Message-State: AOAM530QmQvOcUkJVfWp2L8xRVEXhue5Q8FL8ZR/xmVCpgAWZzC4U6E8
        o8VTTb/TqQ7qMAcDLPRFmWYuXOBwNEg=
X-Google-Smtp-Source: ABdhPJwmQ3oEFDUk0yCdG7tDJ9MDOt3+dSfm9zusnKu5Vd2k9VndLWNpc8+EGRlnjKh0GWWlVf5QRQ==
X-Received: by 2002:adf:ee06:: with SMTP id y6mr8720741wrn.225.1598824882104;
        Sun, 30 Aug 2020 15:01:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y17sm8520461wma.17.2020.08.30.15.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 15:01:21 -0700 (PDT)
Message-Id: <pull.715.git.1598824880.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 30 Aug 2020 22:01:17 +0000
Subject: [PATCH 0/3] Clean up and improve git-imap-send.txt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series cleans up the documentation page for 'git imap-send', removes
the sslVerify config from the Gmail example, and uses more appropriate
Asciidoc syntax.

It is a rework of [1], incorporating Junio's suggestions from [2]. 

I split the suggestions in 2 commits to make reviewing the patches easier.
The third commit adds a note about localized Gmail folder names, which bit
me when I was configuring 'git imap-send' myself.

[1] https://lore.kernel.org/git/51758EE8.7030800@gmail.com/[2] 
https://lore.kernel.org/git/7vr4hzetki.fsf@alter.siamese.dyndns.org/

Philippe Blain (3):
  git-imap-send.txt: don't duplicate 'Examples' sections
  git-imap-send.txt: do verify SSL certificate for gmail.com
  git-imap-send.txt: add note about localized Gmail folders

 Documentation/git-imap-send.txt | 34 ++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)


base-commit: d9cd4331470f4d9d78677f12dc79063dab832f53
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-715%2Fphil-blain%2Fimap-send-ssl-verify-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-715/phil-blain/imap-send-ssl-verify-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/715
-- 
gitgitgadget
