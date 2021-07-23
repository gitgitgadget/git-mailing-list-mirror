Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B49C4320E
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81BCB60EFD
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 18:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhGWRgc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhGWRgc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 13:36:32 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A553C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:17:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v8-20020a0568301bc8b02904d5b4e5ca3aso2048175ota.13
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 11:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FsSkpBd9w8FapzNSVOZwdnldpzIb60arX6vSZgmRFMg=;
        b=OCNyw95ChqxEOJNGkhRclzaS2CZxAdnzuVxCc2MXMWLb47g9c8z1qxjvx35F2tlHGb
         TmGMsZ12M85v8+/K9P5bGUz+fCZ6xImtffnO67NQT4oxuxI3+3SRCToN9pj4ptBeSUVe
         tHjio7LWXzoPRIV1lHK1ZvKXdU5gmGNrIkGO7SLrUDiVjcXNrSpzxJaj5O326Uc16b8H
         GomWOF1GNXv65joSqmD6bhG7vPedcdiFcRy/AIZB79mIa992PofrxfphqzXxFVLHWDvu
         i5cpcwrPyTN6kTG2hr712U/pw9GCEhlnNFWyyj/2HIWmGZO9AyUlbx+pMkIzmCQ02DiZ
         1xsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FsSkpBd9w8FapzNSVOZwdnldpzIb60arX6vSZgmRFMg=;
        b=f/1Gjjq7fS+GLPX6A6UGz1ynmAEtD/RIRxVRUy95rjTx+IfmKrX9E2Anu/Fh3jDOZp
         0BtmWFBgrfoz8b1KpNnhorwRljWZ1vksMAFQd58VhaczM8YBwv9EmpFbI46VPn3iis2T
         bQzZnyAIJ2fxBbpX7cuRSO1s9fGoqpBTxPr9omi35ZujTJ6aSnG5lBkvk6mJthxzq6QI
         6S9IQvbCiSfs9V4y6kjf8QIxrOoS2o5iF5WdcwKhRVKHWowBL14KvkC/4nPOZxlMKUa6
         rUK5arePyDistmdFqAjRWzhdHY3qzVsDF2Uj19vns9vLjw1sucsLMnDQy12HSrv4xaKx
         td/Q==
X-Gm-Message-State: AOAM5319WEQ9L+AyxDPP2UZwrSPJBJPQ/n+GPyXe72V8prjJwZmLesCz
        oKUESDj4Crotdk+pY5aTQBY=
X-Google-Smtp-Source: ABdhPJxOS5ApbWtwj6pZGnRHG5IYnbPU2KrG5dhzrALLFRv1ez+09o/FxI7pbyk0CsEa5iEul5QH0w==
X-Received: by 2002:a05:6830:1dfc:: with SMTP id b28mr3924609otj.282.1627064224054;
        Fri, 23 Jul 2021 11:17:04 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id v4sm5407897otk.75.2021.07.23.11.17.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 11:17:03 -0700 (PDT)
Date:   Fri, 23 Jul 2021 13:17:02 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Angelo Borsotti <angelo.borsotti@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>
Message-ID: <60fb079e38977_defb2087d@natae.notmuch>
In-Reply-To: <xmqq5yx1oty6.fsf@gitster.g>
References: <CAB9Jk9AafnUQr6q8t=b4Dh0PZHUA=fKJmtXxxObuGpF_w-_2wQ@mail.gmail.com>
 <871r7qvhhr.fsf@evledraar.gmail.com>
 <CAB9Jk9DqCR8C9qx6-gZmpTQfBAKnEupQTb1WkJgN3YOqSO0=2A@mail.gmail.com>
 <YPppNYOO26xAq2fn@coredump.intra.peff.net>
 <xmqq5yx1oty6.fsf@gitster.g>
Subject: Re: Extracting a file
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Jul 22, 2021 at 11:46:01AM +0200, Angelo Borsotti wrote:
> >
> >> Actually, I did not want to make git behave like a read-only filesystem,
> >> but only to be able to get what is stored in it using some easy to remember
> >> command.
> >> 
> >> I guess that:
> >> 
> >>     git mv A B &&
> >>     git checkout HEAD -- A
> >> 
> >> renames file A in the work, current, directory to B, and then recovers
> >> A from the
> >> repository. This changes the file on which I am working. After having
> >> read the old
> >> A, and understood what changes I make that are not correct, I should delete A,
> >> and rename B back to A.
> >> If something gets wrong with this, I risk to damage my original A.
> >> This is why it is
> >> better not to change it, and instead get a copy of the old one with
> >> another name,
> >> which is what
> >> 
> >> git show HASH:file/path/name.ext > some_new_name.ext
> >
> > You might also like "git checkout -p HASH -- A", which will let you pick
> > individual hunks from HASH:A and apply them to your working tree.
> 
> There is
> 
>     git cat-file --textconv --filters HASH:A >my-temporary-file-to-inspect
> 
> which would not touch the index or any tracked working tree file,
> other than the target of redirection.

Hmm, --textconv and --filters are incompatible with each other, did you
mean "--textconv | --filters"?

Also, this is simpler:

  git cat-file -p HASH:A

Although I don't know how that's better than Angelo's `git show`.

FTR I do often use `git show commit:file` myself. I'm not sure if
we could do something particularly better than that.

-- 
Felipe Contreras
