Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE17C433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 13:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbiEWNXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 09:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiEWNXm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 09:23:42 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B38344CC
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:23:37 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id rq11so6677831ejc.4
        for <git@vger.kernel.org>; Mon, 23 May 2022 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=TD0CkuivY4b9xs0PARLp3zJZ8K3mNiu+YCQ+j3kpPbw=;
        b=DTkR0vG7Ivta8bUckKkDPRlHkWkEwc48lR6IuG72lOo/Y8bAqc9F+VVg8hvxK7xQ7b
         IZ0KWCz92Hz1dTl1EVl45tlrzqMy32Fqsm/9KAOPTSn60GErZYBA0nDfrKkvmTZ8VVwJ
         TRnUgl0liGHSyAHinsZeaiPttMrJVpIfEvNYl2rePimkdLvkfSrrx19MDTrOZUfvsiX9
         xJkyOlK+ktbJO6mfmjo3y5g5MDiBD3ZiI+YJukIayAVPe6/kNyN7uFWjR5oAztNR4R26
         lUtQq/+va+NxPWtjlCslbBNH7P/p1xuVRR5YKuGTxI98XcAwedtadqzZqZkC7RnKfbHC
         +QTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=TD0CkuivY4b9xs0PARLp3zJZ8K3mNiu+YCQ+j3kpPbw=;
        b=SP4HbVaDV8j6toepT4YsDgxKCic1glaTeYvIQQDAV7YJ9SkTQUjPT0lHhUMXZ6UjjI
         4FW54yVmmxHErfZuquF521udpo4R5BMD8SBmox+aE9CUdD9IjszvaA1bNH6M5ng0/rOK
         seUcohFciOtHGMKtwSPvvZeLx1z6l5UZG6qTHB0Pv5sdI+GvnJRPEAp4fGO1mjt9Anjo
         ICZXXNeZHlkZYOGewNVJyFp3WK9mBCE0ZyYkfgY60RkUNWZl13obQgaRp39B/i/B4a5K
         1m9Y6rcA701ldVhQtVlD9tTaPvUg96PDFAXS55MKE5ChLX9JBHRfaPZpypV0WxPKi0y8
         9AkQ==
X-Gm-Message-State: AOAM530O1tlMQJyNSPUtgnC58zQCtO22eOecOLsmXNVwhhPsqpZO7bFt
        x/0cxQalDHee1t4OiVzM5W8=
X-Google-Smtp-Source: ABdhPJx1iU/Flx41/M6YfP6PmL5MDQrfxtuWexYq5QlZXOXEBoLokSM3hC3OE5mNF4U894beL+YNkQ==
X-Received: by 2002:a17:907:7da2:b0:6f4:dcb8:7b7 with SMTP id oz34-20020a1709077da200b006f4dcb807b7mr19685081ejc.443.1653312215385;
        Mon, 23 May 2022 06:23:35 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id v18-20020a056402349200b0042ac43be19dsm8711736edc.3.2022.05.23.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:23:34 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nt822-002wUf-5E;
        Mon, 23 May 2022 15:23:34 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Hrushikesh Rao <hrushikesh20thegreat@gmail.com>,
        git@vger.kernel.org
Subject: Re: Git commands version documentation
Date:   Mon, 23 May 2022 15:08:43 +0200
References: <ccb312dc-c2cc-ca3a-e659-0f87ceec0d15@gmail.com>
 <f3814646-4763-62e1-b64e-d1aab3fdbbc8@iee.email>
 <xmqqr14l87jp.fsf@gitster.g>
 <3067d8e3-15a7-75fc-20d7-90de0fc3fee6@iee.email>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <3067d8e3-15a7-75fc-20d7-90de0fc3fee6@iee.email>
Message-ID: <220523.861qwkz8kp.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, May 23 2022, Philip Oakley wrote:

> Hi Junio,
>
> On 23/05/2022 00:35, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> One manual method is to look at the history (blame) for the respective
>>> man pages to see when the man page was initially committed, and when
>>> appropriate options were added.
>>>
>>> Maybe use one of the hosting providers GUI if that is your choice e.g.
>>> https://github.com/git/git/blame/master/Documentation/git-gc.txt
>> I got an impression that blame/log is an overkill for the request,
>> which asks for "what tagged version?", to which the answer would be
>> to compare the manual pages for each release (or scan the release
>> notes), perhaps?
>>
>>
>
> I was also concerned as to which way the problem was being addressed:
> was it a need for a cross reference table for all commands, or was it 
> for just a select few?
>
> For me, who likes a good UI, I found the GitHub blame UI quite useful
> when looking at files from the latter direction. It was much easier to 
> scan the blame for the command's documentation page than try and scan
> through the endless release notes. Obviously this does expect that our 
> documentation is fairly complete, at least at the 'mention an option'
> level, even if the occasional nuance didn't reach the docs.
>
>
> I can see that a cli terminal representation is likely to be harder to
> scan, and that some hosters don't provide a blame page, so it would be
> a 'horses for courses' choice.

I think asking a git user to use "git blame" on our own source code is a
non-starter in terms of where we'd like to eventually get. It's not very
friendly, especially in the case of something like the log-family where
option parsing is implemented over more than one file.

Likewise some built-ins don't map to builtin/<name>.c, and all that is
assuming a lot about the user knowing where to look.

I think what the OP here really would like is something similar to
Perl's "corelist(1)" but for Git. I.e. a meta-command you can ask to
tell you what version introduced a given git sub-command, or even option
for that command etc.

Alternatively (or perhaps in addition to that) we could aim to document
this sort of thing, e.g. have an "INTRODUCED IN" section or similar in
the command documentation, or a similar blurb when we discuss various
options.

I have tried to add these sorts of mentions for some past changes,
e.g. the "<refspec>" section in git-fetch(1) is one example (search for
"Git version 2.20").

I think we could do with more of that sort of thing. One difficulty with
doing this in git in particular is that (moreso than most other
projects) when you submit a patch you can't be very certain about what
release it's going to be in, i.e. it might end up cooking for many weeks
& past a release window.

But in any case, I think adding this as a first-class feature (perhaps
to "git help") would be very useful, and it could be done in some way
that wouldn't be a pain to maintain.

E.g. we could carry a text file in our sources with a list of what
commands existed at what versions, and what options they had (as
extracted from the parse-options reflection mechanism). Rather than
manually maintain such a list we could carry a script to that would
attempt to build past releases, for any that were missing we'd attempt
to build them and fill in the gaps.

We could thus make this something (if Junio were willing) that would be
a relatively small addition to pre-release preparations.

For releases that couldn't be built anymore we could either manually
fill in the data, or just not care. What exact version older than 1.8
introduced some command or option is something probably nobody cares
about at this point.

But it is *really useful* when scripting against git to know what
recent-ish release something was introduced in, especially so if we'd
helpfully annotate which releases were known to have been part of major
distro releases, such as RHEL major releases, or OSX's Apple Git etc.
