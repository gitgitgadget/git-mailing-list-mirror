Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF4361F461
	for <e@80x24.org>; Sat, 11 May 2019 14:08:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728559AbfEKOIm (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 10:08:42 -0400
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:29588 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbfEKOIm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 10:08:42 -0400
Received: from [192.168.1.22] ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id PSg3hoaqWniZTPSg3hohJV; Sat, 11 May 2019 15:08:39 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=B8HHL9lM c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=5rxgeBVgAAAA:8 a=xtxXYLxNAAAA:8 a=UlqV6C1OAAAA:20
 a=mLdvbiE05gHgHIVpi6kA:9 a=QEXdDO2ut3YA:10 a=PwKx63F5tFurRwaNxrlG:22
 a=xts0dhWdiJbonKbuqhAr:22
Subject: Re: Merge commit diff results are confusing and inconsistent
To:     Robert Dailey <rcdailey.lists@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?Eckhard_Maa=c3=9f?= <eckhard.s.maass@googlemail.com>,
        Git <git@vger.kernel.org>
References: <CAHd499BEHd79zL76um2oB4YMdScM2icrMXstg1g=xwdBqk43EQ@mail.gmail.com>
 <20190503191231.GA5426@esm>
 <CAHd499CUOnFVkNGEG-MmG5OsUPpmWHET2X1j1fjNuGUkELf-5w@mail.gmail.com>
 <874l67i1ie.fsf@evledraar.gmail.com>
 <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <7cfb151e-346a-0eb5-aaa9-0a3e1da0fb2a@iee.org>
Date:   Sat, 11 May 2019 15:08:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAHd499BkdpsA2BdB0Hsv3xXzpMyMzW8CSuYf2gQX0Jf7OoYBGw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfKPvMz/ppHiRgZWF7d6tMiiveN+3S2L7IkPtYL8mwRvrnT/FyDaThqWM86NZzi0y2Injf2Kuf6wtuRE4aKxIXBjJdsLb2lyMqe9p4DxDV9dp8FejRQfV
 iQcehPLftdTllt7RsRCrFsLx5kyxLiT6t0Ou0HCVhsZRqQjmMqUcNwKwFMYri/qDJEs/igbnHLhmLCI4gOaSx3v4mE4q+iPrYDKJKSyYXn4//I5Zs0BUCGc3
 omm9kXbSV/31EiRpjZCq/w35kz1EsKj4yQGRlQwVo7k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Robert,

On 07/05/2019 15:10, Robert Dailey wrote:
> The majority use case I'm interested in is seeing net-positive changes
> that happen in merge commits. Normally I take for granted that merge
> commits have nothing meaningful in them (meaningful here defined as
> something unexpected for a merge commit). But what if someone makes a
> poor decision and does some crazy refactoring in 1 file and amends it
> into a merge commit? Let's also say that these changes are done to a
> file that wasn't modified in any parent (say a unrelated.txt next to
> your color.txt). Since neither parent cares about that file for the
> purposes of the merge, I am trying to make sense of a revision
> specification that can be used to see what they did to that file.

I see that you are specifically interested in seeing 'net-positive' changes.

Part of the problem is that for a merge commit there are multiple 
choices as to the implied initial central merge, where A and B are 
combined to create X [which I just called the central merge], to which 
further changes are made to create the final merge commit C. (Note: X is 
never committed, and is somewhat 'mythical')

These cases where there needs to be 'further changes', either to resolve 
conflicts because we never got a cleanly merged X, or the user added 
changes, we an "Evil Commit/Merge". Definitions vary slightly between 
different protagonists in the VCS world as to the best evil merge 
resolution starategies.

For your 'net-positive' changes, what is needed is to effectively 
generate that mythical clean initial merge X where either we delete from 
both sides, or we have a simple addition only from one side 
(addition/deletion normally being of whole lines). It is only that way 
that allows the changes from X to C to be addition only.

Unfortunately there is currently no diff representation that does that, 
as there is no method of indicating that middle X state. In the worst 
case there are always pathological cases.

A similar problem exists for the “reuse recorded resolution” (rerere / 
redo) storage of conflict resolutions. At present there isn't a way of 
exchanging such resolutions in a mechanism similar to a diff. In fact I 
was only just asking about that [1]  within the last two days! There is 
some discussion about the rerere database in [2], should you want a look.
--
Philip


[1] rerere - 
https://public-inbox.org/git/b8e56556-6c83-9e37-38e9-ac67f51b5cd2@iee.org/
[2] 
https://github.com/git/git/blob/master/Documentation/technical/rerere.txt
