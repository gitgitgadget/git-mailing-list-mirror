Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1083F20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 23:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751477AbdINXWE (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 19:22:04 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:24700 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751380AbdINXWD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 19:22:03 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id sdSLdBrYMpb8rsdSLdFepM; Fri, 15 Sep 2017 00:22:01 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ZM2noTzb c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=pGLkceISAAAA:8
 a=_m_o4SWaNBETMJ7gp_wA:9 a=wPNLvfGTeEIA:10 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <04DDB36236444FFD8C3668AA7B62B154@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Cc:     "Pavel Kretov" <firegurafiku@gmail.com>, <git@vger.kernel.org>
References: <CAOZF3=Ouvk8ccME+fXr_T=GL1j4Gx3Hgj3ao_-GQng-noeOubg@mail.gmail.com> <E8C827ED458648F78F263F2F2712493B@PhilipOakley> <alpine.DEB.2.21.1.1709131322470.4132@virtualbox>
Subject: Re: [idea] File history tracking hints
Date:   Fri, 15 Sep 2017 00:22:02 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 170914-2, 14/09/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfBBMUu8LHQugvwVlvLNfsGq9kReBolayWKOu54EnWyID0V5cNnb/gXWT/v3zS4rNtgiHdCu5mQDEJmSVUUJ743qpF9QQ2VWpuMCCTNiTc3NV1wR0dyL8
 ZiL/ZUMyxOZ3JOr5FopHK4Woa/jT9EUhZ+IoT9bSElT8CBImWCD7inK6DYvyugh6D6gLWBEVeLHeqaHrSjTSrQCpj46wan45UKmUbwxSNZQxjjhpNLY9PBND
 Rdgo/zxz9nYZ9e5tpbCDjQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
> Hi Philip,
>
> On Mon, 11 Sep 2017, Philip Oakley wrote:
>
>> From: "Pavel Kretov" <firegurafiku@gmail.com>
>> > Hi all,
>> >
>> > Excuse me if the topic I'm going to raise here has been already 
>> > discussed
>> > on the mailing list, forums, or IRC, but I couldn't find anything 
>> > related.
>> >
>> >
>> > The problem:
>> >
>> > Git, being "a stupid content tracker", doesn't try to keep an eye on
>> > operations which happens to individual files; things like file renames
>> > aren't recorded during commit, but heuristically detected later.
>> >
>> > Unfortunately, the heuristic can only deal with simple file renames 
>> > with
>> > no substantial content changes; it's helpless when you:
>> >
>> > - rename file and change it's content significantly;
>> > - split single file into several files;
>> > - merge several files into another;
>> > - copy entire file from another commit, and do other things like these.
>> >
>> > However, if we're able to preserve this information, it's possible
>> > not only to do more accurate 'git blame', but also merge revisions with
>> > fewer conflicts.
>> >
>> >
>> > The proposal:
>> >
>> > The idea is to let user give hints about what was changed during
>> > the commit. For example, if user did a rename which wasn't 
>> > automatically
>> > detected, he would append something like the following to his commit
>> > message:
>> >
>> >    Tracking-hints: rename dev-vcs/git/git-1.0.ebuild ->
>> > dev-vcs/git/git-2.0.ebuild
>> >
>> > or (if full paths of affected files can be unambiguously omitted):
>> >
>> >    Tracking-hints: rename git-1.0.ebuild -> git-2.0.ebuild
>> >
>> > There may be other hint types:
>> >
>> >    Tracking-hint: recreate LICENSE.txt
>> >    Tracking-hint: split main.c -> main.c cmdline.c
>> >    Tracking-hint: merge linalg.py <- vector.py matrix.py
>> >
>> > or even something like this:
>> >
>> >    Tracking-hint: copy json.py <-
>> > libs/json.py@4db88291251151d8c5c8e4f20430fa4def2cb2ed
>> >
>> > If file transformation cannot be described by a single tracking hint, 
>> > it
>> > shall
>> > be possible to specify a sequence of hints at once:
>> >
>> >    Tracking-hint:
>> >        split Utils.java -> AppHelpers.java StringHelpers.java
>> >        recreate Utils.java
>> >
>> > Note that in the above example the order of operations really matters, 
>> > so
>> > both lines have to reside in one 'Tracking-hint' block.
>> >
>> > * * *
>> >
>> > How do you think, is this idea worth implementing?
>> > Any other thoughts on this?
>> >
>> > -- Pavel Kretov.
>>
>> Maybe use the "interpret-trailers" methods for standardising your hints
>> locally (in your team / workplace) to see how it goes and flesh out what 
>> works
>> and what doesn't. Trying to decide, a-priori, what are the right hints is
>> likely to be the hard part.
>
> I think this adds a very valuable insight to this discussion: the current
> state of Git's rename handling is based on the idea that you either record
> the renames, or you detect them. Like, there is either "on" or "off". No
> middle ground.
>
> However, if you understand that there is also the possibility of hints
> that can help any erroneous rename detection (and *everybody* who
> seriously worked on a massive code base has seen that rename detection
> fail in the most inopportune ways [*1*]), then you are on to something.
>
> So I totally like the idea of introducing hints, possibly as trailers in
> the commit message (or as refs/notes/rename/* or whatever) that can be
> picked up by Git versions that know about them, and can be ignored by Git
> versions that insist on the rename detection du jour. With a config option
> to control the behavior, maybe, too.
>
> Ciao,
> Dscho
>
> Footnote *1*: Just to name a couple of examples from my personal
> experience, off the top of my head:
>
> - license boiler plates often let Git detect renames/copies where there
>  are none,
>
> - even something as trivial as moving Java classes (and their dependent
>  classes) between packages changes every line referring to said packages,
>  causing Git's rename detection to go for a drink instead of doing its
>  job,
>
> - indentation changes overwhelm Git's rename detection,
>
> - when rename detection would matter most, like, really a lot, to lift the
>  burden of the human beings in front of the computer pouring over
>  hundreds of thousands of files moved from one directory tree to another,
>  that's exactly when Git's rename detection says that there are too many
>  files, here are my union rights, I am going home, good luck to you.
>
> In light of such experiences, I have to admit that the notion that the
> rename detection can always be improved in hindsight puts quite a bit of
> insult to injury for those developers who are bitten by it.

Your list made me think that the hints should be directed toward what may be 
considered existing solutions for those specific awkward cases.

So the hints could be (by type):
- template;licence;boiler-plate;standard;reference :: copy
- word-rename
- regex for word substitution changes (e.g. which chars are within 
'Word-_0`)
- regex for white-space changes (i.e. which chars are considered 
whitespace.)
- move-dir path/glob spec
- move-file path/glob spec
(maybe list each 'group' of moves, so that once found the rest of the rename 
detection follows the group.)

Once the particular hint is detected (path qualified) then the clue/hint is 
used to assist in parsing the files to simplify the comparison task and 
locate common lines, or common word patterns.

The first example is just a set of alternate terms folk use for the new 
duplicate file file case.

The second is a hint that there has been a number of fairly global name 
changes in the files. so not only do a word diff but detect & sumarise those 
global changes. (your class move example)

The third is the more simple global word changes, based on a limited char 
set for a 'word' token list.
The fourth is where we are focussed on the white space part (complementing 
the word token viewpoint)

The move hints are lists of path specs that each have distinctly moved.

It may be possible to order the hints as well, so that the detections work 
in the right order, giving the heuristics a better chance!

--
Philip
 

