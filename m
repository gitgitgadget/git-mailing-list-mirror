Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5B71201B0
	for <e@80x24.org>; Sat, 18 Feb 2017 22:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750792AbdBRWKH (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Feb 2017 17:10:07 -0500
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:27565 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750746AbdBRWKG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Feb 2017 17:10:06 -0500
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id fDCdc1bDigKstfDCdcSTzk; Sat, 18 Feb 2017 22:10:04 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=EXqp801FARq2IAb0GIgA:9
 a=QEXdDO2ut3YA:10
Message-ID: <6545FDC46D2741A289D0D5E9A84ADD75@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Alex Hoffman" <spec@gal.ro>, "Johannes Sixt" <j6t@kdbg.org>
Cc:     "Stephan Beyer" <s-beyer@gmx.net>, <git@vger.kernel.org>
References: <CAMX8fZWe2HO78ySonHX0adtPUxVPbj5_vo-NUGrjwpb7gPdGrQ@mail.gmail.com> <d4991e4b-cbc4-da14-381a-88704e457a19@gmx.net> <3ff5ce3c-285f-cb9a-d1d4-46323524dab7@kdbg.org> <CAMX8fZVkBU6M8fkUcRr69V97_NTSOGGmPB1U-ObhmVv3i6wQhg@mail.gmail.com> <477d3533-d453-9499-e06e-72f45488d421@kdbg.org> <CAMX8fZW2y+iPRfSbXVcHufbM+CsqgekS_0WnCEJ++=njy_TvKg@mail.gmail.com>
Subject: Re: Git bisect does not find commit introducing the bug
Date:   Sat, 18 Feb 2017 22:10:05 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="utf-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfF88/zHud26FRknpaLUbXDAY4cHP+5XV1HFFxnEGyjcH/Y3cb1KFzX+kTyPPOsYS9vqUXUH1sJSdVEF5UqueOzjjSORVbe9EOUeZB+vNO5XtoOicupnw
 UwCV7cLOVjFLgmhc0fCxoHZ473C+Bsjf2+7UhBsGS2n/UZf5uGExiVJoei5ctAOd6NTadjGQtNWCCHGUTDgojliPffAS0dHl4M/rampkIFZM1Ltr8E1UNv+B
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Alex Hoffman" <spec@gal.ro>
>> But this is not how Git works. Git computes graph differences, i.e., it
>> subtracts from the commits reachable from v.bad those that are reachable
>> from v.good. This leaves more than just those on some path from v.good to
>> v.bad. And it should work this way. Consider this history:
>>
>> --o--o--o--G--X
>>    \           \
>>     x--x--x--x--X--B--
>>
>> When you find B bad and G good, than any one of the x or X may have
>> introduced the breakage, not just one of the X.
>>
>
> Thank you for clarifying how git bisect works. How did you find that
> out? Did you check the source code? If that is not documented in the
> man page may be it worth documenting it in order to avoid future
> confusion for other users.

Any suggestions for improving the documentation are always worthwhile. As 
someone who asked, what extra info would have helped?

Even beetter if it looks like a patch ;-)

>
> Let's consider your example with distinct names for nodes:
>
> --o1--o2--o3--G--X1
>    \                \
>     x1--x2--x3--x4--X1--B--
>
> It makes sense that git bisect is expecting a single transition, as
> this is a precondition for a binary search to work. My definition of
> "the transition" is a commit with at least one of its parents as a
> good version, but the commit itself a bad version. I hope we agree
> that git bisect's mission is to search for this transition (as I
> suppose that most of people need such a functionality from git, if not
> exactly from git bisect). How could be x1 or x3 be the transition, if
> chances are that o1 is not a good version? Of course it would make
> sense to me if bisect would check o1 whether good and only then to
> check also x1-x3, but this is not what git makes (at least not in my
> initial example).
>
> If you consider that git bisect's mission is different from finding
> the transition, could you please explain what exact commit git bisect
> is supposed to return (ideally with terms from the graph theory) and
> when it makes sense to return that? Because I do not see any sense in
> looking in the path x1-x3 without knowing that those commits may be a
> transition.
>
>
>> Oh, IMO git bisect was well thought through. If it considered just paths
>> from good to bad, it would not given the correct answer. See the example
>> history above. Bisect authors would not have deemed that sufficiently 
>> good
>
> You definitely convinced me that git MUST search more than only in the
> paths between good and bad commits, as the good commit G does not have
> to be the first good commit (thank you for that). My problem/confusion
> is that it returns something that does not make sense to me, because
> it does not make sure it returns a transition.
>
> VG
>
> PS: thank you for continuing this discussion.
>
--
Philip 

