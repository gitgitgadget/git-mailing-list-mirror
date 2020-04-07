Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA5BC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:54:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37FDD20678
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:54:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JTelawm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgDGPyk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:54:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51631 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgDGPyk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:54:40 -0400
Received: by mail-wm1-f68.google.com with SMTP id z7so2264129wmk.1
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LWUFA9d9oO8S1dcbIJKBZp4PYjiDOBRiNJBcX5lWNeQ=;
        b=JTelawm+A4kJORhP/bunzXWNkn9XgLgux63OtiRHVuArqlcoJedGlwVIVX3NBbzU40
         Ja8GO668VVLo+9zclnm9sibjeDmIqvhpHNC/OVeiubr9vEoPd7M+MAAY2bghUCuF/RLj
         zTSuduBTYKXQQxLII2lAhxngCK73XExYMVOOZ6W/iFzkAZEEIko9biOr/V+y3FBmskew
         aNBhkJyKgTTBuQX+Fiq49dTFDxoXkwBgwQxKE3AgXfxR7gQY1hk2wA8COwoxdf6fFVtv
         /r7nSmHYHvUiyUxPksCPsvfIqph+IEt1dSoescABgmA8LX0i6QdK+N6yaZ4U2REhfboA
         GodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=LWUFA9d9oO8S1dcbIJKBZp4PYjiDOBRiNJBcX5lWNeQ=;
        b=Yx73udcZv5sL6A/20O2MTAkNx1yVSpVDlvkaKoLFgz/j58cFzNma8ACLqRRExKK/y0
         JP+r2f0BgFrRLDHuZmxaDRVAzDpkdxUvPYDYremyIAcmlstBSRfwTemq6O6n3RETP7m7
         ha78CYhMf3ppPPYZrLPWjDq5BaS4elHXZA+US1c/t2tDIq4dk1iD1y5KDoe7YoFA52Me
         iSusl2ocUIaa+dya8kV3A0Qekp8a56FrV6KM1njvFMKvw2OUGbu2IWQhvpRoXXa9+mOo
         v8w9oVXI10Qv5ERvabsnEq/TY0Coc2DdyJSW4HlMFe/HRWOJg4+KJM7bzJwnhzALegVy
         mpqQ==
X-Gm-Message-State: AGi0PuYrzAxI0WTkpx19Z0eYDMWLGRmxMadbobAcI8/A1nfAx1e6QZvq
        BsMvqtnjh2eagULaI4YpAQzcAAee
X-Google-Smtp-Source: APiQypKvSjnfFJK3uVdMOaQduTouqvV4hSIRSCHsq4AWI0jVFZckK1PhCOyrVRiTY1GDPzJ7ZsKxWg==
X-Received: by 2002:a05:600c:414b:: with SMTP id h11mr2972269wmm.9.1586274877375;
        Tue, 07 Apr 2020 08:54:37 -0700 (PDT)
Received: from [192.168.1.240] (85.25.198.146.dyn.plus.net. [146.198.25.85])
        by smtp.gmail.com with ESMTPSA id j11sm31540612wrt.14.2020.04.07.08.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 08:54:36 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     Philip Oakley <philipoakley@iee.email>, phillip.wood@dunelm.org.uk,
        George Spelvin <lkml@SDF.ORG>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
 <20200328163024.GA26885@SDF.ORG> <20200331000018.GD9199@SDF.ORG>
 <7fbe0ddc-74a3-b6b5-09b1-bff171382d0e@iee.email>
 <ef1a1475-45b3-8696-ed1e-b28f7b655ece@gmail.com>
 <60cd00c2-7aba-3d74-11fa-d4443f6cd83e@iee.email>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7babcfdb-5b01-ca6d-2709-4fae582c50e1@gmail.com>
Date:   Tue, 7 Apr 2020 16:54:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <60cd00c2-7aba-3d74-11fa-d4443f6cd83e@iee.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philip

On 01/04/2020 17:43, Philip Oakley wrote:
> Hi Phillip,
> 
> On 31/03/2020 14:36, Phillip Wood wrote:
>> Hi Philip, George and Johannes
>>
>> I really like the idea of being able to extend or rewind an existing
>> rebase to reedit commits.
>>
>> On 31/03/2020 11:57, Philip Oakley wrote:
>>> Hi george,
>>>
>>> On 31/03/2020 01:00, George Spelvin wrote:
>>>> Thinking about Philip Oakley's suggestion, it dawned on me that
>>>> we can *already* do a nested rebase manually, and having a less
>>>> manual alias for the procedure would be reasonable.
>>>>
>>>> Suppose the last four commits are O-A-B-C, and whether they were
>>>> created
>>>> by this rebase or existed before is irrelevant.
>>>>
>>>> If I want to rebase --nested -i O, then I --edit-todo and
>>>
>>> Maybe `--rework` as a possible alternate option name, if the concept of
>>> it being truly nested process does not work out?
>>
>> or `--rewind` ?
> 
> A possibility, though it feels a bit narrow in suggesting the capabilities
>>
>>>> prepend the following four lines:
>>>> reset O
>>>> pick A
>>>> pick B
>>>> pick C
>>>>
>>>> If a nested rebase command does just that, I think it would cover my
>>>> use case.  If it adds a comment saying "nested rebase ends here",
>>>> it's easy to cancel the nested rebase if there was a mistake.
>>>>
>>>> A slightly fancier thing a nestrd rebase could do is see if any of the
>>>> newly created picks are also used in merges that were already in the
>>>> todo
>>>> list.  In that case, follow the pick by a label command and update the
>>>> later merge to refer to the label.
>>
>> If we're going to support rewinding a rebase that creates merges then
>> this is a prerequisite otherwise it wont work properly. It will also
>> need to update any existing labels that refer to a commits that get
>> rewritten when rewinding.
> 
> I would agree that the `label` instruction would need expanding to allow
> arbitrary refs (e.g. specific oids and other branches) to be labelled
> rather than just a presumed 'HEAD' ref. I did notice the man page
> doesn't actually define the format of the extra instructions (there was
> fun with awkward chars in label names on Windows).
> 
> I'm of the opinion that we don't re-label/rename the previous labels -
> they are what they are, but we do offer the ability to provide new
> labels. Hence the extension to the label format to allow the labelling
> of arbitrary refs, not just HEAD, along with showing existing progress,
> so folks can _see_ the new oids etc.

I'm not sure I understand how this would work. Say in the example below 
I decide I want to rework abc while editing fgh and run 'git rebase 
--rework abc^'. If we don't update the labels automatically how do I 
ensure that the merge will pick up the reworked abc as it's parent.

#pick abc
#label topic
#reset cde
edit fgh
merge topic

>>
>> When cancelling the nested rebase we need to take care to restore any
>> labels to their previous value if they have been updated by the nested
>> rebase. We also need to restore the list or rewritten commits so that
>> we don't report that we've rewritten the commits from the nested
>> rebase that we're aborting. These two requirements unfortunately make
>> it difficult to implement the nested rebase just by updating the todo
>> list.
> 
> I'm against the original conceptual idea of 'nesting' (or rewinding).
> What's done is done, it's in the object store, as is all the old
> original work, so we have a wider foundation to build from.  Clearly we
> are not in a clean work-state, with the half complete jobs, so it's more
> of a recovery activity than clean coding (from the user perspective).

I don't like the idea of nesting either but I think it would be useful 
to be able to get back to a known state when the changes I make with 
'rebase --rework' turn out to be a bad idea so I don't throw away all 
the work that I did before running 'rebase --rework'. I've been using a 
script that rewinds and I've got myself into situations where a 
speculative change made while rewinding turned out to be a bad idea and 
I want to get back to the state before the last rewind. When working on 
a patch series I can rewind multiple times before completing the rebase 
as I jump back and forth modifying and rewording each patch.

Best Wishes

Phillip

>> It needs to save the current labels (and reference the commits
>> somewhere so they don't get gc'd) and the rewritten-list. `git rebase
>> --abort` (or whatever we end up using to abort the nested part of the
>> rebase) needs to restore the labels and rewritten-list. I think it
>> should probably restore the todo list as well - if the original part
>> of the todo list gets edited during the nested rebase should we drop
>> those changes to the list or keep them when the nested rebase is aborted?
> 
> If we haven't aborted, then we just have the actual sequence of work,
> with some of the commits, ultimately, being left as unconnected stubs
> (once their temporary tips have gone upon completion of the rebase -
> could they be explicitly dropped?).  On completion, those abandoned
> commits could be explicitly marked as having been removed in the various
> book-keeping lists and logs (if it was useful and helpful). I think this
> is a different conceptual view of the work of the rebase - resolve process.
>>
>> Best Wishes
>>
>> Phillip
> --
> Philip
> 
