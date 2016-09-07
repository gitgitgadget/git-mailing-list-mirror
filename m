Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E135220705
	for <e@80x24.org>; Wed,  7 Sep 2016 08:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756854AbcIGI1l (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 04:27:41 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:44099 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756637AbcIGI1h (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 7 Sep 2016 04:27:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2212C20821;
        Wed,  7 Sep 2016 04:27:36 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute3.internal (MEProxy); Wed, 07 Sep 2016 04:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-sasl-enc
        :x-sasl-enc; s=mesmtp; bh=ciAdlZW7MTT7RdR5WV7IDZUiWPg=; b=Ad68eB
        kCpq2f2LtsMJccMvbnNuciJ2zuJ1yX67BMDB5BVAZi7OvSxwgOIMc2O/P0fxtoQd
        lZzAkR88QNrcRedaeJCs3k2KNDinV32aDZuGyMop0R1di/Qr1s8x6wT4gH8sf5Gx
        b1I0HKfGNFdcExIMiR/1vENFO7sLZg+V8zRjo=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=ciAdlZW7MTT7RdR
        5WV7IDZUiWPg=; b=qfD3uhyAHdpKejZfblbna3/Z3wtwIO9BE4RQb/klnVvNfGM
        UIFUEMxKMZL/yOpXQBPvEsduODyH2FmfCtCKQIT+/iIP+n2fJNijVy8JQ/gb0f9L
        X5Tz3fVg0OzjnuxG7qB7qfQTc7xamTaCpxCqU1ehiX9zM4j0NCeZtQcMKM+E=
X-Sasl-enc: Qsg+MhZwYAelrCR/gg2nPbYJPIIauUHDnkqRXcOtFvlq 1473236855
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
        by mail.messagingengine.com (Postfix) with ESMTPA id 699E7CCE81;
        Wed,  7 Sep 2016 04:27:35 -0400 (EDT)
Subject: Re: [PATCH] gpg-interface: reflect stderr to stderr
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <ced7502d-0095-bd90-19e3-c14d0e4d4f07@drmicha.warpmail.net>
 <18a7e2984121d988137c135ec560fee56506981b.1473167263.git.git@drmicha.warpmail.net>
 <alpine.DEB.2.20.1609061827290.129229@virtualbox>
 <alpine.DEB.2.20.1609061839370.129229@virtualbox>
 <alpine.DEB.2.20.1609061843120.129229@virtualbox>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
From:   Michael J Gruber <git@drmicha.warpmail.net>
Message-ID: <655b42d8-baa9-e649-2b3c-5b7bfc914bc5@drmicha.warpmail.net>
Date:   Wed, 7 Sep 2016 10:27:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1609061843120.129229@virtualbox>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin venit, vidit, dixit 06.09.2016 18:43:
> Hi Michael,
> 
> okay, final mail on this issue today:
> 
> On Tue, 6 Sep 2016, Johannes Schindelin wrote:
> 
>> Your original issue seemed to be that the gpg command could succeed, but
>> still no signature be seen. There *must* be a way to test whether the
>> called program added a signature, simply by testing whether *any*
>> characters were written.
>>
>> And if characters were written that were not actually a GPG signature,
>> maybe the enterprisey user who configured the gpg command to be her magic
>> script actually meant something else than a GPG signature to be added?
> 
> I actually just saw that this is *precisely* what the code does already:
> 
>         if (ret || signature->len == bottom)
>                 return error(_("gpg failed to sign the data"));
> 
> Why is this not good enough?


Assuming "this" refers to error():

You said it's not good enough - because gpg's stderr is not displayed.

And I agree with you on that point.

Assuming "this" refers to the exit code check:

gpg documentation says so over and over again: do not rely on exit
codes, parse status-fd instead. (An often ignored advice, oh well.)

As for most of your other remarks, I would appreciate if you could take
a breath and reread what I wrote and what you wrote - before you send it
- and curb your remarks about who is working on resolving issues.

So, trying again to structure the issues and solutions, there are three
issues:

A) relying on gpg's exit code (and stdout) is not enough. Secure use of
gpg requires checking status-fd.

This is what my old patch solved.

B) "gpg --status-fd=2" and swallowing stderr hides usual stderr from the
user.

This is what my old patch introduced and a Windows user reported. It is
solved by my new additional patch.

C) With that old patch, that Windows user is not asked for a passphrase
on tty any more.

Reverting my patches appears to solve C on Windows and reintroduces A on
all platforms, obviously. C is not present on Linux. B is solved either way.

Now, I can't reproduce C on Linux[*], so there is more involved. It
could be that my patch just exposes a problem in our start_command()
etc.: run-command.c contains a lot of ifdefing, so possibly quite
different code is run on different platforms.

It would be great if someone with a Windows environment could help our
efforts in resolving issue C, by checking what is actually behind[**]: I
can't believe that capturing stderr keeps gpg from reading stdin, but
who knows. Maybe Jeff of pipe_command() fame? I'll put him on cc.

Michael

[*] Maybe that even depends on Linux environments (terminal emulator),
so input from others would be helpful, too:

Without a passphrase-agent/wallet etc, does "git tag -s -m test test"
ask you for a passphrase on the terminal?

I does for me with this stack:

X11->i3->st->tmux->bash->git->gpg

[**] "--status-fd=3" instead of "--status-fd=2" in my old patch would be
a check whether our capturing of stderr is creating problems on Windows
or gpg's writing status to stderr (which --status-fd=3 would change, at
the expense of breaking the final check): Does gpg ask for the
passphrase now?
