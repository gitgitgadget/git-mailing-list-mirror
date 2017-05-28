Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67F2620D0A
	for <e@80x24.org>; Sun, 28 May 2017 11:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbdE1LVz (ORCPT <rfc822;e@80x24.org>);
        Sun, 28 May 2017 07:21:55 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:56248 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750981AbdE1LVy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 May 2017 07:21:54 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id EwGedzP6hcpskEwGed1UlB; Sun, 28 May 2017 12:21:53 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=ILRAMUnG c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=IkcTkHD0fZMA:10 a=ybZZDoGAAAAA:8
 a=xtxXYLxNAAAA:8 a=0LGf6R-glRmD_T8Jo1MA:9 a=QEXdDO2ut3YA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=xts0dhWdiJbonKbuqhAr:22
Message-ID: <48CB2547397B471C99F54CFB3F113C3F@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Jeff King" <peff@peff.net>,
        =?UTF-8?Q?F=C3=A9lix_Saparelli?= <felix@passcod.name>,
        <git@vger.kernel.org>
References: <CACQm2Y1QtKD3M6weNhGrAQSLV8hLF4pKcpHDD7iUc78aWrt6Cw@mail.gmail.com>        <xmqqa864mea3.fsf@gitster.mtv.corp.google.com>        <76BD8B6A1511438B8CCB79C616F3BC5B@PhilipOakley>        <20170524141947.2gguzcvyu6lch373@sigill.intra.peff.net>        <xmqqshjtg1kh.fsf@gitster.mtv.corp.google.com>        <xmqqa861fx34.fsf@gitster.mtv.corp.google.com>        <20170525155924.hk5jskennph6tta3@sigill.intra.peff.net>        <20170525191115.tqd6zlj5mxqls4wp@sigill.intra.peff.net>        <CEF93B59EA3F49608B41892952454B1D@PhilipOakley> <xmqqh905c0tm.fsf@gitster.mtv.corp.google.com>
Subject: Re: [Non-Bug] cloning a repository with a default MASTER branch tries to check out the master branch
Date:   Sun, 28 May 2017 12:21:50 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-CMAE-Envelope: MS4wfK1R7Om+jwu4pVBBOnF1OMnWHU7qI9gvvnZLmUYtJ93PJeGnOz7a2kxXxE7BLBmgg5bQz+cYc+m3ar4gcazy/fEiwdtvdIZIIAEELeVadeTcrWRC5vGW
 ONd9+SJx3ZqRO2+fDwcgqg3aHWIlIZTIyExzqM7gIC3u1XiBLA1yzB7bKdkKJZD9pqbdy3CsGT2yua293w3NvS+4ipn9y07EfxPwfX8ccsh6ncvri2dkoeaj
 vjJwHYadAxCdITxZzZ6PQA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> "Philip Oakley" <philipoakley@iee.org> writes:
>
>> However given the discussion about an unborn HEAD, the option here
>> would be to also pass the NULL sha for the symref and then add the
>> annotation 'HEAD' after an extra \0, in the same way that an active
>> symref could be annotated with the '\0HEAD'. This would kill two birds
>> with one stone!
>
> Are you aware of the symref capability that is already advertised in
> the initial upload-pack response?  Right now, we do so only when
> HEAD actually points at something, and the earlier suggestion by
> Peff is to do so unconditionally, even when HEAD is dangling.

The suggestion is the otherway around. I would argue (as a viewpoint) that 
what we advertise are object IDs and their associated refs, sorted by ref 
name. (I'm thinking of the git/Documentation/technical/pack-protocol.txt 
here). My suggestion was that when we get to the sorted ref that HEAD points 
to (including the unborn oid) that we annotate that ref.

I didn't quite follow Peff's suggestion as to where the list change went and 
if that was a protocol change.

There are two current fault scenarios.
a. The currently reported case where HEAD has an unborn symref
b. The multiple ref HEAD case, where the HEAD oid matches multiple 
advertised refs, and the correct symref is not the first listed (which is 
the case I had looked at a few years ago, a prompted me to respond).


With the above discussions, we would have both a NULL oid for the unborn 
(sym)ref sent (if needed), and the (sym)ref for HEAD would have the extra 
annotation. That would at least not break the protocol rule that "If HEAD is 
not a valid ref, HEAD MUST NOT appear in the advertisement list at all" (it 
is now an annotation to another valid ref [or the unborn symref]).
>
> Existing clients that are symref aware do not do anything (good or
> bad) when a HEAD that is dangling [*1*] is advertised, so such a
> change will not hurt (but it would not help by itself either).
> Ancient clients that are not even aware of the symref are not
> affected.
>
> Then new clients _could_ start paying attention to the advertised
> HEAD that is dangling.

My main step was that for case b, so that we don't need to 
guess_remote_head(). The annotation would have already told us.

>
> The bundle transport is a different beast.  I do not think it
> advertises where HEAD is pointing at, whether it is dangling or
> not.

My understanding was that the Bundle was a tiny wrapper and that it has that 
same protocol header, which was then decoded using the same code. Hence the 
hope that it could fix both the bundle and remote clone problems. I'd just 
avoided stepping into remote clone arena because of other implementations.
>
>
> [Footnote]
>
> *1* A HEAD symref that is advertised in the upload-pack response is
>    dangling when its pointee does not appear in the set of refs
>    that are advertised.  Félix's case would have shown HEAD
>    pointing at refs/heads/master in the symref capability extension,
>    but the list of refs and their values would not have included
>    that ref (there was only refs/heads/MASTER "for joke reasons").

I hope I haven't confused the different parts of the negotiation and 
transfer, which can be confusing.

Philip 

