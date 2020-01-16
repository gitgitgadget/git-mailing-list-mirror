Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE71C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 07:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823172075B
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 07:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha5nVtqA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgAPHmd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 02:42:33 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:43358 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgAPHmd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 02:42:33 -0500
Received: by mail-lj1-f173.google.com with SMTP id a13so21486210ljm.10
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 23:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZW0v/46DQGIziWJSz+r2PkkY//avItFA4TE99sbXxM4=;
        b=ha5nVtqACRiACTG0Xb21Y9OYHJo1HUtF/5OO5zakqTk3P9xYe0a7CAhMw0sG5Ri71S
         cDCV0wGvjcdzUV58UKa3xPGvYwzigMSqPawNNyy3NpzUoSyYn1NwsO+qNuE7RSp5NsK+
         WpLPm62HGA4NQJYh8111QhyQP2v1oqYwflwTNq350yn4PUyvHHTIKiguKlwCbObn/ax3
         es5jUmF1Hvd42yi9glChjJIL74O4xIYhqoL0lh982wvNl4Riddr1itFp0GodVOyJEeu9
         yEDK8CFJ54ShvoIjlEnblG9cmCZWqHUxlxtVVQjlL5TfOOqgEbZOnT3nEcfhzR4vo3gF
         jAVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ZW0v/46DQGIziWJSz+r2PkkY//avItFA4TE99sbXxM4=;
        b=DNkD2viThmWrJbLBaiRY0ofatH6X129WmaHw2uvn3Y1k0aMDxvsUZ6YoXEpoirCQnY
         L9p8yz5x/Ds9D0K0BcCKkvUKNvSoFTMre4FA4GlA5RkMEM6+bmyx1RtMuQCAt0ziivXz
         wU/+BCIg0hccN8MIjV+xpUGhw9p6wNZS6emRLurQqNOOQ2112UOKDj98vEgs8IBIBnkA
         VVWayFXlWnQMPf8Hi5eV5i7xSyWPByl3Gc/+dI/VrPjmOIJtM5jn24nTpfd9QfBJbIIw
         487fWHUfsrTpcgwJfv9syycC/kHz4i4laJ5n/RsfU5jixsSir+3MMrhjVMmEYjEXWGXL
         pW1A==
X-Gm-Message-State: APjAAAXZgJ7KnvY2M1xS7d3tZ7YOKsPtCCtzZN1zAOwdXWtLikcAJA0b
        OZkffz9A+68ArwzZyAtYJ7ZPzR2h
X-Google-Smtp-Source: APXvYqyWWcCzZ0vqFh/i7L/Jadd1EcyiOzuzRxD5ekq5Xqow+PCo32ntAlnTfg1M7XtCOZTbDLc96w==
X-Received: by 2002:a2e:868c:: with SMTP id l12mr1509039lji.194.1579160550496;
        Wed, 15 Jan 2020 23:42:30 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m21sm10019226lfh.53.2020.01.15.23.42.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 23:42:29 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Rebasing evil merges with --rebase-merges
References: <f2fe7437-8a48-3315-4d3f-8d51fe4bb8f1@gmail.com>
        <089637d7-b4b6-f6ba-cce1-29e22ce47521@gmail.com>
        <xmqqeew4l6qf.fsf@gitster-ct.c.googlers.com>
        <xmqq5zhgkwxx.fsf@gitster-ct.c.googlers.com>
        <xmqqy2ubjkeo.fsf@gitster-ct.c.googlers.com>
        <xmqqpnfnj9p3.fsf_-_@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.2001151458100.46@tvgsbejvaqbjf.bet>
        <xmqqftggk2oi.fsf@gitster-ct.c.googlers.com>
        <9355c545-08a5-ef63-f7bf-65201d50acc8@gmail.com>
Date:   Thu, 16 Jan 2020 10:42:30 +0300
In-Reply-To: <9355c545-08a5-ef63-f7bf-65201d50acc8@gmail.com> (Igor
        Djordjevic's message of "Wed, 15 Jan 2020 22:23:34 +0100")
Message-ID: <87h80vg849.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

> On 15/01/2020 19:14, Junio C Hamano wrote:
>> 
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> >
>> > Having said that, if you ever find yourself wanting Just One Feature 
>> > in `--rebase-merges` that would make it worthwhile for you to think 
>> > about switching your patch-based workflow to a `rebase -ir`-based 
>> > one, please let me know, and I will try my best to accommodate.
>> 
>> Another thing I noticed was that we may want to attempt to recreate
>> an evil merge and then stop to ask confirmation.  The "rebase -ri" I
>> did to sanity-check my revert for example failed to bring in the
>> change made in the existing evil merge when trying to recreate the
>> merge of the dl/merge-autostash topic into master..pu chain and
>> silently created a fails-to-build-from-the-source tree instead.
>
> FYI (and anyone interested), it`s something we actually brought up 
> some two years ago, at the time of introducing `--rebase-merges` 
> (known as `--recreate-merges` back at the time), see[1].
>
> It ended being a lengthy and heated discussion (inside a few 
> different topics as well, like original RFC[2] and it`s v2 update[3]), 
> myself being guilty for dropping out eventually and not following it 
> through, though, life taking me in another direction at the moment...

For reference, there is a nice summary in "Git Rev News Edition 38":

https://git.github.io/rev_news/2018/04/18/edition-38

> but I still find this functionality to be very useful, not to say 
> essential, even, for reliable complex merge _rebasing_ (meaning 
> keeping "evil merge" changes, too), and not just merge _recreating_ 
> (loosing "evil merge" changes, and worse - doing it silently, as you 
> experienced yourself now as well).

Yeah, dropping user content silently and by default is still the most
weird thing for git to do, be it a merge or not a merge.

As an additional note, I came to conclusion that there is actually no
such thing as "evil merge" that is somehow different from "evil commit"
in general (a commit containing unrelated changes).

Then, as "evil commit" belongs to user domain, we need to finally
realize that "evil merge" belongs entirely to user domain as well, and
thus, as it's out of git domain, we should stop using the term "evil
merge" to excuse any kinds of weird git behaviors.

Regards,
Sergey
