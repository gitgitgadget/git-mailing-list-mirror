Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD90DC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E041223E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 23:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbgLWXIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 18:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgLWXIf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 18:08:35 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D20BC061794
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:07:55 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id g24so458538qtq.12
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 15:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=d/7o9JF2KykjBHcUWPG9cM9l8XnaRQBdGhTTL2oBQfg=;
        b=obKp4nFOwMBAJ4ynTMs4xwaJSZyGBeaQHv4FAkw0dLUJTSA6cW4/mhuWsCnCeH64FZ
         BGek2S9xrKFhTiQhTDgt0q9DAGWWrix/Jt9oHCdKtxcOLfWnQaxs6SOa3zb2sZwpZcfo
         Q+xEsD+xu0pWJgCli77D2poaUg3zt9Yku3jYGRcSwDNg8znJ/VwZ8Ithb+rZ7Q/P3ZeF
         EX+psw+T9GFqr5vCulY32JeFuIbe+YLiu+hAjzP4xcZeS7YdXP41Ct2jqJTtH1+m2Bhv
         Hf8sYIe3h3FfExgOYfnOGeKhPlTUyjyyIDMwTdQze8PeCk+B+HRraYScWV9dLTaaOuPp
         r7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=d/7o9JF2KykjBHcUWPG9cM9l8XnaRQBdGhTTL2oBQfg=;
        b=rULE9DjbwLxU+lGe6T4/OCBJ2ZcPVx/c7BatZSzHMIN74agKWuPCN1hPiSHTeC5Xoq
         u/FZbYduFYOCwzxVtgJbVDLt6eRhFX7byhf1B0/Qd+VHPax3VC9gGkcUEC0qIuwvkbkv
         vWu/jbGM2AyVEATO/XnHCurobLnWgq703jpihk+LZe9sgNpzFWGr2myTBTVWtRtFh7Mj
         voMzCB7YxbE5wIffQUt+uka8PP01Ymm2+akvyooilNZtFrSWKmpE/JjIUmd7UjJOFTcg
         oly5Ppl0xwVqc24agJAMuHq1dlPOUejEbDO9Lomq8no8lglu2Cia15Trnj4xl5evNgOw
         jlVg==
X-Gm-Message-State: AOAM530rjUcTLtjp3jgy1FREG/BAIAEVJSUUqun5XEB9UdP3PDbUSP87
        DFb9LfJ5g19P4OvEm4igM/10MY9EsEezsZf74ztuLm2l
X-Google-Smtp-Source: ABdhPJw5uEpvM4R7awamGLk/pwoeHkwaxxni3xkuVygBHzKjxwWgtRDcEmuzKRH8zVVNEbLGpCxKZzL+Mt8BJn6ORIg=
X-Received: by 2002:ac8:3ac2:: with SMTP id x60mr27803843qte.333.1608764873919;
 Wed, 23 Dec 2020 15:07:53 -0800 (PST)
MIME-Version: 1.0
References: <CAM0jFOfx+vxvUAqZqnxeOvGmn0F0Q6vyTKWPjtsSh1bmq__SsQ@mail.gmail.com>
In-Reply-To: <CAM0jFOfx+vxvUAqZqnxeOvGmn0F0Q6vyTKWPjtsSh1bmq__SsQ@mail.gmail.com>
From:   Mike McLean <stixmclean@googlemail.com>
Date:   Wed, 23 Dec 2020 23:07:43 +0000
Message-ID: <CAM0jFOfvNFva98PNjO33HW3Y4+L1SufvEHQYzwGLHgOkfhmUDQ@mail.gmail.com>
Subject: Git Feature Request (Commit Message editing directly from interactive
 rebase control file)
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I initially raised this as a FR with my git UI of choice, and was told
that it was actually something that git itself would need to do ...
and that the standard way to raise Feature Requests was to email this
list.

Apologies if that's not actually what I should be doing - please let
me know if this is not an intended use.

=-=-=-=-=-=-=-=-=-=
When you do an interactive rebase, you are presented with a file
listing all the commit hashes, their current message, and the
command/operation to perform.

To edit the commit message you set operation `r` and then are later
given the opportunity to set the message. But that control file is
only using the commit hashes to determine which commit is being
referenced - the message text in that file isn't being used to
identify the message.

So can we allow the user to (optionally) set the new message directly
in that file?

It would make the flow a lot quicker (don't have to open a new editor
instance each time.), and would make it a lot easier to make similar
changes to a bunch of commits (e.g. prefixing them all with Ticket
number, or fixing a consistent typo in a bunch of commits.)

Indicator that the commit-rename should use the text in the control
file (rather than the later editor prompt) could either be A) a new
command (rename-inline, or similar) or B) existing rename command +
"the text on this line is different from the text on the original
commit".

Obviously this wouldn't support multiline commit messages - those
would still use the existing workflow, but adding this new feature
wouldn't impinge upon them, so they've not lost anything.

Am happy to suggest names and/or shorthand keys for it, if the idea is
acceptable.

Yours,
Brondahl
