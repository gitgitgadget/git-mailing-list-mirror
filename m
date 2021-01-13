Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PLING_QUERY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EA6C433DB
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 01:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92BA230F9
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 01:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbhAMBQS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 20:16:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726468AbhAMBQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 20:16:17 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83FD3C061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 17:15:37 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id j12so375441ota.7
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 17:15:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ul1/SHXmy8RAokC6GX+zkvnGn4ZUSgOqMjZjmdVMZnU=;
        b=k+qMM14fz2g8iNnQ7Vx0OZMxk6T/jANPbJ2ipZYNGslz8n9kAMemzUbFzytgGSaEBn
         7OxBwgy49hHy1bPyZz/ZMuQ+6km0pW3KU95+R0AtT5kMbszso+SSTiE07ywoHJsmpfZs
         9RDoGyVE/gSzzNXugGe2RqQzAt32VZfjdpkB++eE0gAn+9IeEkTq01qcJbq1J4A8jSwy
         LCUhaR+FO/a2RN3rSnIxApRCBjnpPlyZ2nITQxhNHfHoJ+YmOHkuftgBhucGXRgkKnuc
         vFGCwDpamzBWCcEsEN3EsMyjL+exXey/tfsNFDx36aW8NLgOrTAZKZuaoSrs6D+DvcNg
         Gygw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ul1/SHXmy8RAokC6GX+zkvnGn4ZUSgOqMjZjmdVMZnU=;
        b=piLxn3k/BXPHgN4hUBsKcZf+RiAHl1ukDpdmkIx5nw3t/OlSsv2bP7ttjTCl103NMT
         5zOOLY/kZJ2GI1x2WUAAwu9ESWa/lA0qgJwyX74Nbav3y2ddxLXhOs58OdYItLCRyNSD
         vOMG5F966iOWmhXSNDxy5wPvmxu8eVPrXctxvveqtYhTkgyROHvHGeao1Lp+30RifyFE
         zHxXZ7k88N5bRDJoE44blqz5pzTDKJe+rjsr1FaE7KNYUi03+RHzk+J2H3gdEz1GBbAP
         s+U9FOP6plzXTE47qg+8CeTdovrK/bkowKAkzP8cpiO9mu2MAw79qNljpUzHf2QYg5gz
         bMPw==
X-Gm-Message-State: AOAM531DgDb+0QEeSyTjQTFgS96KiPKlQum/vHMLTBtAzzpdPUQFWsk+
        X/QhbF2eEUFT4oJpGN7ZPrOLDajo9NTqn/b4BCnylNMQBLU=
X-Google-Smtp-Source: ABdhPJya85aRDG6oRWPEYfOgavfrFrEynN+DIzmhfNBx/FeInCMCuKq6h7EmKj9BwP5ImbURweEQAlpKTAjWVsxJ1Qc=
X-Received: by 2002:a05:6830:230b:: with SMTP id u11mr1435115ote.184.1610500536618;
 Tue, 12 Jan 2021 17:15:36 -0800 (PST)
MIME-Version: 1.0
References: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
In-Reply-To: <CAPSFM5c2iqBn8_Dih2id7q6RRp0q=vfCSVUHDE5AOXZ8z3Ko9w@mail.gmail.com>
From:   Charvi Mendiratta <charvi077@gmail.com>
Date:   Wed, 13 Jan 2021 06:45:25 +0530
Message-ID: <CAPSFM5f+cm87N5TO3V+rJvWyrcazybNb_Zu_bJZ+sBH4N4iyow@mail.gmail.com>
Subject: How to implement the "amend!" commit ?
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Everyone,

Implementing "amend!" commit would be an alternative to the
fixup!/squash! commit that addresses the issue as opened here[1]. Also
the related patches[2], adds the options to `fixup` command in
interactive rebase and supports the "amend!" commit upon
`--autosquash`. Next, after discussing with Phillip and Christian,
there could be 3 possibilities to implement the "amend!" commit (UI):

Firstly, the `--fixup=<commit>` to have option like,
`--fixup=reword/amend:<commit>`

So, `git commit --fixup` can have 3 options:

a) `--fixup=<commit>`, work as of now, make fixup! commit.
b) `--fixup=amend:<commit>`, make "amend!" commit, takes changes and
also opens the editor for a new message (Here it adds a new message to
amend! commit's message body and upon autosquash it will fixup up the
content and reword the original commit message i.e replaces the
original commit message with the "amend!" commit's message).
c) `--fixup=reword:<commit>`, makes (empty) "amend!" commit, do not
take changes and open the editor for a new message(Here, upon
autosquash it will just reword the original commit message).

Secondly,
As an alternative to above, we can use `--fixup=<commit> --amend` and
`--fixup=<commit> --reword`.

Next,
To use only, `--fixup=<commit> --edit` to make the "amend!" commit.

Also as discussed earlier[3] we are avoiding the use of additional
options like `git commit --amend=<commit>` inorder to avoid confusion
of doing similar things in different ways. So, I wonder which could be
the best way to proceed with or if any other way to implement "amend!"
commit ?

Thanks and Regards,
Charvi

[1] https://github.com/gitgitgadget/git/issues/259
[2] https://lore.kernel.org/git/20210108092345.2178-1-charvi077@gmail.com/
[3] https://lore.kernel.org/git/95cc6fb2-d1bc-11de-febe-c2b5c78a6850@gmail.com/
