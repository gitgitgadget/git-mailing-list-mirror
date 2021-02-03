Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B3C433E6
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 587E364E46
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 05:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbhBCFGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 00:06:25 -0500
Received: from mail-ej1-f52.google.com ([209.85.218.52]:40992 "EHLO
        mail-ej1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhBCFGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 00:06:24 -0500
Received: by mail-ej1-f52.google.com with SMTP id f14so9317661ejc.8
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 21:06:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+a/XYmA8++maKXOjjlGOvvrRSudZJia6jkZVC82Qjqo=;
        b=ULHrIvWtliu3RdXqftPtt8LF4lbNZgf2p3fWBloNThcsT+abKkcdKwzfS8XfU2scfi
         FYdtiGz7zeQ3epHaFKifzNUl6fi63g73LuEKO0piEtdfUXOKmI3Wjwiw4SIXzVJGuuCr
         lI0JBbh5FrzbfgcfdCnmGhLcUYS4eZRZTjgA6FtSN//sX2zG3dPq2NGCiiGa2Rg5aBYc
         GLmlaxgtW0yQbscHUvz2vp+IQxhAsansOjQSFIN4N4vdWHrGahkcGYrFB+Nq+4BUAYc5
         FJ1iePNYRK4gnivbXrZKJe+EMXmdBR56+JVkQ5h7k9ryP8L8WjT4/2NCkJUrsLQH5Mpp
         Whbg==
X-Gm-Message-State: AOAM533j8N2qWMaQt8tgneUIzJwHWUVAZ6OHKKicV2mGaA5Ef7srUbbw
        vok0H6pqJfwVN54DKV5ypqjnCadfm98Qe//8w9da3f1I6Ok=
X-Google-Smtp-Source: ABdhPJzR6WO2wugQ/Fq83adfDJSLI381nIZz6YugDdwyNmJRJEX0L8nBmFStgiNA5KRW/H1ZF739C5C9Hkkh2sV/wDM=
X-Received: by 2002:a17:906:4348:: with SMTP id z8mr1419558ejm.371.1612328742498;
 Tue, 02 Feb 2021 21:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20210124170405.30583-1-charvi077@gmail.com> <20210129182050.26143-1-charvi077@gmail.com>
 <20210129182050.26143-7-charvi077@gmail.com> <CAPig+cQeBE7m8wf1e_soVrpvL3==u50MPyb90NwWLnFiUz1Byw@mail.gmail.com>
 <CAPSFM5fZHZDnmRD2GzwPVKwBjogKD=GJbC7e=6aQSbu_iXBdNw@mail.gmail.com>
In-Reply-To: <CAPSFM5fZHZDnmRD2GzwPVKwBjogKD=GJbC7e=6aQSbu_iXBdNw@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 3 Feb 2021 00:05:31 -0500
Message-ID: <CAPig+cRxmFr_Sbwdf4OFMr8Vp1q6O6J7AbgYAD5cgdD--hgDuw@mail.gmail.com>
Subject: Re: [PATCH v4 6/9] rebase -i: add fixup [-C | -c] command
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 2, 2021 at 10:29 AM Charvi Mendiratta <charvi077@gmail.com> wrote:
> On Tue, 2 Feb 2021 at 06:17, Eric Sunshine <sunshine@sunshineco.com> wrote:
> > When `-c` says "edit the commit message" it's not clear what will be
> > edited. The original's commit message? The replacement's message? A
> > combination of the two? If you can come up with a succinct way to word
> > it such that it states more precisely what exactly will be edited, it
> > would be nice, but not necessarily worth a re-roll.
>
> Here the editor shows the commented out commit message of original commit and
> the replacement commit message (of fixup -c commit) is not commented out.
>
> So maybe s/edit the commit message/edit this commit message  is better.

Yes, that would be clearer and is just as succinct.

> > This code adds to the confusion. In the function argument list, `flag`
> > has been declared as a single enum item, yet this code is treating
> > `flag` as if it is a combination of bits. So, it's not clear what the
> > intention is here. Is `flag` always going to be a specific enum item
> > in this context or is it going to be a combination of bits? If it is
> > only ever going to be a distinct enum item, then one would expect this
> > code to be written like this:
> >
> >     return command == TODO_FIXUP &&
> >         (flag == TODO_REPLACE_FIXUP_MSG ||
> >         flag == TODO_EDIT_FIXUP_MSG);
>
> I admit it resulted in a bit of confusion. Here, its true that flag is always
> going to be specific enum item( as command can be merge -c, fixup -c, or
> fixup -C ) and I combined the bag of bits to denote
> the specific enum item. So, maybe we can go with the first method?

Sounds fine. It would clarify the intent.

> > By the way, the function name check_fixup_flag() doesn't necessarily
> > do a good job conveying the purpose of this function. Based upon the
> > implementation, I gather that it is checking whether the command is a
> > "fixup" command, so perhaps the name could reflect that. Perhaps
> > is_fixup() or something?
>
> Agree, here it's checking if the command is fixup and the flag value (
> which implies either user has given command fixup -c or fixup -C )
> So, I wonder if we can write is_fixup_flag() ?

Reasonable.

> > I was wondering if the above could be rephrased like this to avoid the
> > repetition:
> > [...]
> > but perhaps it's too magical and ugly.
>
> I agree, this [tolower(bol[1]) == 'c'] is actually doing all the
> magic, but I am not
> sure if we should change it or not ? As in the source code just after
> this code we
> are checking in a similar way for the 'merge' command. So, maybe implementing
> in a similar way is easier to read ?

Keeping it similar to nearby code makes sense.
