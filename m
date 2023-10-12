Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD89CDB465
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 00:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjJLAXB convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 20:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjJLAXA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 20:23:00 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8824790
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 17:22:57 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EBE6E90144E;
        Thu, 12 Oct 2023 00:22:56 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 0314B901020;
        Thu, 12 Oct 2023 00:22:55 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697070176; a=rsa-sha256;
        cv=none;
        b=LaQ2xKhZg9mVB5dppa/tVfMcWUNQL235SJ3nJIhtLt7mcLODKw4kvoNm8V/9MBRP27BUpK
        Yax+n5QhlZIhacE1FPpBTn3nZmS2GGOuh/D0CgIJyIbA+pYkZh5CBZPGDmXB5sGZuw/V3w
        r2a6ZOzWkh3UT5ltd2tuzk0Y6BjEe9zywBdi18d+WhmthDOjU8s52B5cN9p7G3UeiKwM0Q
        Vt+xqJcjxJ5BGXwJj/s0yHVu6BBUTWWpOQofCBLTJ9Rw0+F8egaIYNvmSno1DenGUZhjsq
        XI4yOjc4wgXGww8MoSGM0ytMYj4waFJWBmthStUH37jklyusv+deC9lKUUlh/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697070176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iKQpNHi+vymATfNoGkQkFahJQ1QlIxv3M5XD5xgP8PU=;
        b=simvT6n8Sngwb2wFYvHqOWdExjOi0c013McRjV9NfFzpJEJRRaHa7kyr9ocVsxCf9nF7gy
        oG6DulnqEJB+Ie0QDuA4M13uiJ3AvHQWfhLk6kW8Z9RoRnc//c/zDEZipgwiLb67G6XPjc
        fxLqIvgIkBOs2aJ+BpRQl8tVqvoZZ/MzNnxZ9c2OaNXM2m5pqKx4VWvh4an2dtnETct1GR
        tUf0Vkr2lpdEJ5N6OuhAKcuKRLuwX3Mu8OOfOW9TyQt4foLhTRCDo2go3MbCpwwpos8inU
        BIx9tqz3K96YJvxv01NPd9EFoVZcyNC+dvcs8KSmIn7rJVEs5N5XQGy19EGTbw==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-7djj6;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Eyes-Arithmetic: 0d11897e1b4fcd34_1697070176776_1671618078
X-MC-Loop-Signature: 1697070176776:1291917396
X-MC-Ingress-Time: 1697070176776
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.99.68.32 (trex/6.9.1);
        Thu, 12 Oct 2023 00:22:56 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:54928 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qqjTX-0000ue-2V;
        Thu, 12 Oct 2023 00:22:54 +0000
Message-ID: <8f3bec2752f4c2d3ebdd29d20910a4a94f75f608.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Thu, 12 Oct 2023 02:22:49 +0200
In-Reply-To: <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
         <xmqqa5sokdd3.fsf@gitster.g>
         <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
         <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
         <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
         <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
         <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
         <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2023-10-12 at 02:06 +0200, Dragan Simic wrote:
> There's also scrollback in the terminal, which can be used to show
> more 
> of the contents that was displayed before exiting the pager.

Sure.


> > Everything that would have come after that is of course not
> > visible.
> > The place where I exited may be some "well defined" border, like
> > the
> > end of a commit... or anywhere it the middle of a patch (making the
> > left over remains on the terminal perhaps even ambiguous).
> 
> If you didn't select some line or page to be displayed, by scrolling 
> within the pager, it obviously isn't going to be displayed, which is
> the 
> whole point of using a pager instead of "spitting" the whole contents
> out at once.

It's also clear that it's one point of a pager :-)

But that doesn't change that it's rather a user decision, whether or
not it makes sense to leave that, what's already been shown by the
pager, on the terminal after exiting the pager or not.

I don't think people always select the lines in the pager to some
reasonable border (e.g. end of a commit, end of a hunk, whatever).
So it's likely that after leaving the pager, the terminal's scrollback
buffer will contain something that is not complete and may thus be
ambiguous.


> 
> That sounds like some issue with your terminal or terminal emulator, 
> which should be debugged and fixed separately.  Such misbehavior
> isn't 
> supposed to happen at all.

Are you sure about that?

Well it happens at least in gnome-terminal, xterm and (KDE) konsole.


> I see.  Actually, removing "-S" was a good decision, IMHO, because 
> chopping long lines isn't something that a sane set of defaults
> should 
> do.  Many users would probably be confused with the need to use the 
> right arrow to see long lines in their entirety.

Sure.

And having -F is IMO a good default (that virtually everyone would
want), too.

With respect to -X, I'm less sure whether it's that clear.


Cheers,
Chris.

