Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977FBC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 08:02:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F8046512F
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 08:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbhCIICE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 03:02:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbhCIIB7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 03:01:59 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ED2C06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 00:01:59 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id k2so11381927ili.4
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 00:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chetech-se.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=FD5kfgXWKy+1cYExVnIppTzTaIWEDRFKgzVn6UvG9wc=;
        b=bhYSwy/JZwcAEUCRcIC/R+7AHkuPDvr6WvWgdm1FCSaORqVGV0b85LMcrl+1tQwjFP
         9DhOHqok+J+r3u3MEi8TLvekJpzn1vpTMjRPH6t9iMMCmm+sed3xOzOyZJ6DxlbGseeE
         rgW4LwPbHBRsDBVZZIj80ysyJLBGyiuBj54I7zgdTkir5KWXyTNEI480j/CqIb+oamLr
         VaFfshsTzO/wQ2kUSgn4mwFtAYGsVlbZNsVnHYBe4EgZOddjdLQSd0MwI2GlothK3WLd
         wr5idU8VZb9W7Wu1zprcpV6vJGqNlLVxmYq9JNpH9X8Tgzv7yhm0EGA5qOUSxZ6K0jET
         1ctQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=FD5kfgXWKy+1cYExVnIppTzTaIWEDRFKgzVn6UvG9wc=;
        b=GxeUzC08Tmm1rqcad0M6sbV/o4uNPlTM2Sj290Os2jDl8iAieBQS4E1Lu8oDrfmFGi
         ALZ34EVgF5deFbfs96o0U8ppypFEj5gTM+n6UU00T+vQLvHdwLVg9pMNqu3aQw74zYd9
         cGBdjkM5wYNSFrr+3uR5wbWdGRoRBUPpLd80XHcmYEUEBl3pw4qgIwWnnUnQPF/D1roO
         ijllif5TRe9HIoxnjUCVLs3hEH761OqTXTKdj/Yl3cpxQFL7JDpZFt8SkEHEANBbagop
         ESkdFbDWijNrHUKGNQgyayj5y9sc0EMQGvwoMmCUrxw04wVQN7FzyezV5JDBO+/HMWxR
         CjZA==
X-Gm-Message-State: AOAM532wlYe9WA4azxnrT69o04AL/R2fONYXefb1dMD5gLb992H79nCZ
        RdeGFAVUnzYAFlbUBk31KVfyVpf6b9RrchlccH/MUbJ6k93t
X-Google-Smtp-Source: ABdhPJwVdxhp1DdByAY56KJt2k+Lswux5yTg10oSm1jcPpXXgwcTTG/yrfbYDnz0hNvXnDAgQOMrNqLto4i8DmaKF0o=
X-Received: by 2002:a92:1a4a:: with SMTP id z10mr23288681ill.284.1615276918300;
 Tue, 09 Mar 2021 00:01:58 -0800 (PST)
MIME-Version: 1.0
From:   Fredrik Reveny <fredrik@chetech.se>
Date:   Tue, 9 Mar 2021 09:01:47 +0100
Message-ID: <CAK9rnwaB2BJo-UVLkPd2cDVtvM7HnAjJg+Fcqm6JUt7g=fSeYQ@mail.gmail.com>
Subject: bug: git difftool does not respect submodule argument
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This repository is set up to reproduce the issue:
git clone --recurse-submodules https://github.com/Chetic/super.git

The following command behaves as expected and produces a diff to files
in submodules:
git diff --submodule=diff HEAD~1 HEAD

But the following command produces a diff of commit IDs referred to by
the super repository, i.e. same behavior as without the
"--submodule=diff" argument. I expected this to behave like the
command above but displayed with an external diff tool:
git difftool --submodule=diff HEAD~1 HEAD
