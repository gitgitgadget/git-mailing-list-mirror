Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FDDCDB47E
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 20:24:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442741AbjJLUYC convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 12 Oct 2023 16:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442679AbjJLUYA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2023 16:24:00 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD2FBB
        for <git@vger.kernel.org>; Thu, 12 Oct 2023 13:23:58 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 261648145E;
        Thu, 12 Oct 2023 20:23:58 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id 22EDD81398;
        Thu, 12 Oct 2023 20:23:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697142237; a=rsa-sha256;
        cv=none;
        b=h40Hifuqbc4q14FiU+oYjGpoKbQ1EXl25vfMHwqt0WwkxNBWZrJIHPMJdEkIK5O6uZPj6c
        FMLZ1OYGSbyT4xjAbRDZRHffkLnAMwarMB7N6nobbNiX6kct3oIxpoEvXP1sS7jL74NVZ3
        0GoA3VaxECIyJN6WArtbnDwvgHrcQSGNh6QvnVhUtaV6teF5XPs215/2T3aeinlW7LA8cI
        ieGIcernizamWhb1kUP5Ih655L4/nbDhgpVG2Aesg9AXL9WZXMyIJVo8pcLU9jer7li1ZK
        aDcqnZKCSxpB8f1uU43oHKxk5sz9NVLubCc8iDaIXY4UKjWC90nCjLm1WdAE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697142237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h3IUXrhNgcmiZudB6lrqRgtwAeVwqot4vx+p6jyNscg=;
        b=UCl1v3NcWMsjsIB6Uc+wen3wvCE45qE61CbDwuIy8Jwi4UKg0RtmK5yWsaau+wzGm/h/rP
        EQiSMyQxee8JHXJnbNgOjG6qgENIbqG8/oCwk8CKlTQX+2u0QYlLQR/vJ2OYc1KkxtcspC
        QbgAaLylSlXgj/1lFY+BQkPQ/SL5UmpUeWmzL1Nw2ocBJ6Lx6A7JkFDgd12tJRgNdk3Go/
        sO7fJd9lMrMrX4+9L3bPH5+BcdVVjZ0kJS02OaUDnYJwy+2AKkfHVhhmFzWweCNwEcO9HV
        JISfxWYKwrWRmpaPym3Uftqx1qO5exJlIP6C9A3N/Rl3iMypRSxW3NrjxCpp4g==
ARC-Authentication-Results: i=1;
        rspamd-554cd65b86-pzqwv;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Soft-Zesty: 79bfc97e74db1a81_1697142237785_2345802923
X-MC-Loop-Signature: 1697142237785:2459601418
X-MC-Ingress-Time: 1697142237785
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.222.7 (trex/6.9.1);
        Thu, 12 Oct 2023 20:23:57 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:45304 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qr2Do-00021X-03;
        Thu, 12 Oct 2023 20:23:55 +0000
Message-ID: <e1e187ca3d970c18e1a11d51ff93b6cb212bcbaa.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     git@vger.kernel.org
Date:   Thu, 12 Oct 2023 22:23:49 +0200
In-Reply-To: <161b9584c6c9a004c01bda98cea4f1f8@manjaro.org>
References: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
         <xmqqa5sokdd3.fsf@gitster.g>
         <0c10c4b95f2a947a5d569a2c3d51fcb02b35e81d.camel@scientia.org>
         <eadc03fc56d530ea31790f8a4b47a16e@manjaro.org>
         <ec43820562198de078db7df54d0338edf1f333ea.camel@scientia.org>
         <6457310b8ca0e7d3b288a3bbbe264012@manjaro.org>
         <fbb3c2bf1c832f0f16cb913da6b862dd313359ef.camel@scientia.org>
         <ace230a469fabbbbceb38cc884a40b4c@manjaro.org>
         <8f3bec2752f4c2d3ebdd29d20910a4a94f75f608.camel@scientia.org>
         <23cc509bfb433e19c7683c97314e4ac8@manjaro.org>
         <2f3ef5568ed19ac5bdcd23f84ddfb13dc6901043.camel@scientia.org>
         <161b9584c6c9a004c01bda98cea4f1f8@manjaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2023-10-12 at 07:46 +0200, Dragan Simic wrote:
> Let me repeat that the messed up output you're experiencing isn't
> normal 
> and has nothing to do with the arguments passed to less(1).  That's a
> separate issue of the terminal emulator(s) you're using, or in issue
> of 
> your specific environment, and should be debugged and addressed as a 
> separate issue.

Be it as it may...

As I've told you before it happens at least in gnome-terminal (and thus
presumably and VTE based terminal), xterm, xfce4-terminal and konsole
(all current versions of Debian unstable)... with less as of Debian
unstable as well as 643.

That affects at least on major distro, and there's a good chance that
it affects any other distro based on Debian (*buntu, etc.).


I further tried on SLES 15 with both gnome-terminal 3.42.2 and xterm
330 as well as less 530.

Even tried with the terminal emulator started via env -i and only TERM
set manually.


*All* cases affected by the same problem I've described before.


Same with the command you've used in your follow-up post, here a video
of it in HD:
https://youtu.be/MsxtQgrKM50


> To me, having inconsistent displaying of the short and long outputs
> is 
> simply not acceptable.

Which is fine - and as I've said: I personally also tend to prefer it
like that - but even if the above would be just some bug (which however
seems to affect all systems I could test on a short notice, except
yours)... one can IMO still not generally say whether on or the other
behaviour is generally accepted to be the better one.

Even if output may be just chopped of and thus ambiguously incomplete,
some people may still prefer to have rather no output at all.

And in fact:
This is the default mode of less alone.



> > 
> Perhaps something is wrong with your specific environment, because I
> see 
> no other reason for this issue.

Well may be, but seems unlikely from my PoV, given that I've now tested
even on other distros and systems not under my control.



Anyway... I think this got a bit too off-topic here :-D


Cheers,
Chris.




