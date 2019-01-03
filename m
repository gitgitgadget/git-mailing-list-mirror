Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 843621F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 21:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbfACVvQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 16:51:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45164 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbfACVvQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 16:51:16 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so34921002wrr.12
        for <git@vger.kernel.org>; Thu, 03 Jan 2019 13:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WN1UNebWpCnGPG2rrPXBQj8haZH63z57xq88RP5cV2g=;
        b=CaGVxC5zfKdIMfooPyiftZjnsOrtGmcuURddOupARcfqu5wiFF3DNu0XorYt1h/qDO
         mMGzGj3UPKUIRr+mmt8ri6l9mnngBqFXvnIv3sfRyy3iD5YothqBuDzIsBZxq9F/6HK3
         882UOatX9ssM8VlIZ7eqBxnXUIhV07yKKyHt7JrKf1pavdDx3mgIZkZR4er7gsf0MhOq
         o4kYOV1CY5HXEdtEHEZPYhSHHx3aDe3g/JCTDXgvKANLyvx/FvDMzbabSAwhrk5H9wx7
         7FxaYLBJvglw6flZfD+sb1/Wd441iWrRGXzD1Q2u9oCDK90k5BJwBHQ6LcRxVNv2773d
         i+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WN1UNebWpCnGPG2rrPXBQj8haZH63z57xq88RP5cV2g=;
        b=f+A77DyS9IEFD54jlF201MpFxkElxMqRovxAJCDS7MwKfyGhp+ey2lb3pSTdeCrQdR
         cjgRkc5qZL0icRfCUyFZX//VCWT7HUpVFVmT2qbHAxyO1GwIyaomWRsOpiWQ4RUjlDkW
         t5IWSGde7SmHROdnjhx4fYvKqwk/WGaCUDo68gTxq5BwrTGc07oL/5cU5yjeWhLPWzd5
         OwOkNeSrD7RbpoV4VXxx0ShjQgXKHUemiBfnps5/Aj9wi66C6P5NERzTA4Jmwz3PmVfd
         9a2i9jMnZvopi7F+1zrKJD5dEAcXupWE7J4/RFCySmaZNpdpqA7/8kxDTEb2WHO4nB2S
         TX5g==
X-Gm-Message-State: AJcUukf8H9wYga7tkkFk0iMbyXIrGgnnt15qBWEP3AG+zR1Kk09EMXDb
        VObhCjpeg5DxJNGUwpVtSss=
X-Google-Smtp-Source: ALg8bN7NVoQSTDkuy0onKkpzll2An15DJXO0h6M6tNvrrwwXdoeU9SGwy+w5LuFT/Kov9AIddWtQWQ==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr41406209wra.282.1546552273123;
        Thu, 03 Jan 2019 13:51:13 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 200sm41919080wmw.31.2019.01.03.13.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 03 Jan 2019 13:51:12 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Anthony Sottile <asottile@umich.edu>
Cc:     Duy Nguyen <pclouds@gmail.com>, Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Regression `git checkout $rev -b branch` while in a `--no-checkout` clone does not check out files
References: <CA+dzEB=DH0irkFaRzkKERSjdZ=EJ+mG3Ri2Xeobx9Yu_eDd+jg@mail.gmail.com>
        <CACsJy8B=-V7XY+=5pwwSzg8B6Goa55DPPU3ErgjOEsSJVni18Q@mail.gmail.com>
        <CA+dzEB=TPxng4YBC4Vfh=ZcctAzRQ+drJ3y2sXwP=JXf+UweSA@mail.gmail.com>
        <CACsJy8C=O=ZDvD0ReSJOyAsNDEb5Yz-iFvs7oV5zAXaFf-dw5g@mail.gmail.com>
        <xmqqef9th4iy.fsf@gitster-ct.c.googlers.com>
        <CA+dzEB=+ROLVjp36SQjucouc8YUWTvYBrN4QyS5fsStMPtbw_w@mail.gmail.com>
Date:   Thu, 03 Jan 2019 13:51:11 -0800
In-Reply-To: <CA+dzEB=+ROLVjp36SQjucouc8YUWTvYBrN4QyS5fsStMPtbw_w@mail.gmail.com>
        (Anthony Sottile's message of "Thu, 3 Jan 2019 12:35:24 -0800")
Message-ID: <xmqqwonlfm0g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anthony Sottile <asottile@umich.edu> writes:

> On Thu, Jan 3, 2019 at 12:26 PM Junio C Hamano <gitster@pobox.com> wrote:
>> A "fix" to Ben's optimization for this particular case should be
>> fairly straight-forward.  I think we have a special case in the
>> checkout codepath for an initial checkout and disable "carry forward
>> the fact that the user wanted all the paths removed", so it would be
>> the matter of adding yet another condition (is_cache_unborn(), which
>> is used to set topts.initial_checkout) to the large collection of
>> conditions in skip_merge_working_tree().
>
> I think it might be simpler than that even -- the optimization treats
> the following as equivalent when the current checked out revision is
> deadbeef (even if the index / worktree differ), when before they were
> not:
>
> - git checkout -b newbranch
> - git checkout deadbeef -b newbranch
>
> If a revision is specified on the commandline it should be checked out.

If it were to be a "fix", the exact same command line as people used
to be able to use, i.e. "git checkout -b newbranch", should be made
to do what it used to do.

Forcing users to use a different command to workaround the bug is
not a usable "fix".  If we want a working workaround, you can tell
your users to use 

    git reset --hard HEAD && git checkout -b newbranch

and that would already work without any code change ;-).


