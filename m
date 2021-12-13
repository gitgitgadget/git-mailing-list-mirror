Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FAEEC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 17:12:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbhLMRMf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 12:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233165AbhLMRMf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 12:12:35 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64DAC061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 09:12:34 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id k4so11625260plx.8
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 09:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ed7iVVk/tR9DUl1pSTor/90N0ya7JbmMl5YyrnUk9t4=;
        b=mae3wI5gwniECFSQRGcCJLHTUf2KfETLk+EBJRM+UMi8Vb0KvvBD0cgFGvcGIheAQy
         X2eGWz4ehECJOq/u0fsNW5ow9wATmQHRzqUhxrRcNnFFrPE9cBoNfAiq4Rx4ZejcQ4R1
         iu9DltTdYaMkBAMUCV4gKacb1biHq54tXdTJuzxti6NJpKDXZ1eMDeTJyFw2vy/m9l9L
         jrP2FidDBWwgLgQon3q/+Qo49VCF/vDaad6BtaerEVI3Vey8eH4i6saPUeZY6n65KKrb
         ZSF+cyg/Uvhz0LQI8nzR4xFG4yKE3O1eg++wkGlZu7BzSULsYgyYjE7A0hRU2fbgJMCy
         IhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ed7iVVk/tR9DUl1pSTor/90N0ya7JbmMl5YyrnUk9t4=;
        b=LdqeNhaDigohtN8ls18kuB+R+/1Pgk6WFTlpTPOJfVfH0dD7RJ5K0wr/lk51F7kgH8
         v6l27NX0vXnq6cdPfFL65X7PwTXrqawIDSTzw1thnztUctZ30w1TImMYU0Ga5XN5mLl6
         ttCu69sBvNRgwToLiFd436ceEII7T8VVqyVLTGIojqTfOJkrR5Gn6Oq+MH1RILBPIDNn
         lzPoYMmipYcrCjGdIfSQR659LcJwj+IneC8HDQfM9DXxAgwZVDO5RcMsNI8YTAtZxnLS
         0yXmzNyHJmBIpmo40M9rWZph20bwHIsLLTpF8jSofDig6HRFzp2fd6SN3O2PU6RENKGk
         8TUA==
X-Gm-Message-State: AOAM53146c5pgZXDCgPz4OHQ2C9pGpzKB25OFSqXxWkxlu3o6In3zXwF
        X5k+2h3aZgQIt34DuY+VYsYVJOZAIdvJKLCkJ25L/iqwB4i2nA==
X-Google-Smtp-Source: ABdhPJzUrc/EmjjXawQO4qnQ/qnFwyc79300nztgrVoaS9sZXutSTITKJeG0urVNuO0adp+zdNi9D1FZsStnxwcDw9c=
X-Received: by 2002:a17:902:f54d:b0:146:8d4f:1b68 with SMTP id
 h13-20020a170902f54d00b001468d4f1b68mr52240610plf.25.1639415554222; Mon, 13
 Dec 2021 09:12:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1036.v2.git.1632465429.gitgitgadget@gmail.com>
 <pull.1036.v3.git.1632760428.gitgitgadget@gmail.com> <2501a0c552ad5147f61a96b9ebe45c5199e1dbfd.1632760428.git.gitgitgadget@gmail.com>
In-Reply-To: <2501a0c552ad5147f61a96b9ebe45c5199e1dbfd.1632760428.git.gitgitgadget@gmail.com>
From:   "Jack O'Connor" <oconnor663@gmail.com>
Date:   Mon, 13 Dec 2021 12:12:08 -0500
Message-ID: <CA+6di1m91q70PfaFq0DKMsmd_Tb6XBB7H9AYPhwawX12cZgtGQ@mail.gmail.com>
Subject: Re: [PATCH v3 03/11] read-tree, merge-recursive: overwrite ignored
 files by default
To:     git <git@vger.kernel.org>
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> read-tree, merge-recursive: overwrite ignored files by default

When this patch shipped in v1.34, a test broke in a project of mine
(https://github.com/buildinspace/peru/blob/e9ba6e0024ea08105a8d027f958899cca39aeb9a/tests/test_cache.py#L111-L117)
that was relying on git read-tree *not* to respect .gitignore files.
(Obligatory https://xkcd.com/1172.) That peru tool is using git
plumbing commands to manage trees of files, but it tries to keep this
implementation detail internal, and behaving differently in the
presence of a .gitignore file belonging to the user would leak this
internal implementation detail. I've been trying to figure out a way
to reproduce the Git 1.33 behavior in Git 1.34, but so far I haven't
found any flags or configs to do that. (For example, putting !* in
.git/info/exclude doesn't seem to help, I think because a .gitignore
file in the working tree takes precedence.) Can anyone suggest another
workaround?

This is my first mail to this list, so please let me know if I mess up
the etiquette.

- Jack
