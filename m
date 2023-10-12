Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 348B5CDB465
	for <git@archiver.kernel.org>; Thu, 12 Oct 2023 01:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234066AbjJLBkK convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 21:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234055AbjJLBkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 21:40:09 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A591A9
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 18:40:07 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EA865C0C9C;
        Thu, 12 Oct 2023 01:40:06 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id F39DBC0B8E;
        Thu, 12 Oct 2023 01:40:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697074806; a=rsa-sha256;
        cv=none;
        b=WqSsVcfzl7H6pFiSFlGGDTT8/u3d8dQOuaxr6G8L4AWJfmk5E69dLbu2TJIl4SXBShjfgZ
        EFm6q/S8G2XqoUKii5Wj3BPqbfq7XhvqiH/VBpaH+f6UaiHBHreTJlNs2+n9RbP2gLuJTL
        fBOT2TqkPuHT3Vr5rvnOoPS4ibr8C7dJDWTbsjE+U03NYz0eFauCC4AR8YDEimsDC/Z/Tm
        FOG2czstpewF6TFXtfB46PmoMcqCzS4mAV1omwOMiYg5gb1WH0t+MwgU7eVCkNk9qyxXr1
        /W+etwn52f+2A25BUoFI1fid0Ul+D8/nrVW/ZWU6DOGoK2xj2yX+vNYdvGOMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697074806;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2iU0O+uV1zRdQmcj7G0o5528xRLfWNjglteu9xaAeFc=;
        b=iopAhZYP/BOPlcHIYDNbnCMf8iXJMOAEryHTwgz01OQbgLbzVLXQj84pxceagrDzmrSOA2
        KVBYzWMbPdgfyk9c6dAh6gBs22cTpWKXiWmqjyyTbl/77kUSLUlVOXH9LMa/n45u4FM+Md
        fkiOTtu9z6TumsvBPZlEaQCiJp86ithlGpLrsS+Hd02hvcb6CrnweCvW70h3dX58P6Sc44
        /PjiPQHgEeQrkNTC22XJ6amgSTkBcK2sBTZKz7tebMTCYliyzc38FeTVDpx5UODYaJR5KV
        oC4Q8fDisCfDcSX1KpNnPoKJOuM+vLRs1xgf6S5Hkjpq7Xah4RitW0LWVNaS9g==
ARC-Authentication-Results: i=1;
        rspamd-7d5dc8fd68-7rqm2;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Industry-Plucky: 13a551833a43bd7e_1697074806773_1072549423
X-MC-Loop-Signature: 1697074806773:2206190680
X-MC-Ingress-Time: 1697074806773
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.126.222.7 (trex/6.9.1);
        Thu, 12 Oct 2023 01:40:06 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:56784 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qqkgC-0003Dd-17;
        Thu, 12 Oct 2023 01:40:04 +0000
Message-ID: <2f3ef5568ed19ac5bdcd23f84ddfb13dc6901043.camel@scientia.org>
Subject: Re: why does git set X in LESS env var?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     Dragan Simic <dsimic@manjaro.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Date:   Thu, 12 Oct 2023 03:39:57 +0200
In-Reply-To: <23cc509bfb433e19c7683c97314e4ac8@manjaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2023-10-12 at 02:31 +0200, Dragan Simic wrote:
> 
> Makes sense, but please see also my other reply on the list.  To sum
> it 
> up, we can have either the current behavior, the inconsistent
> behavior, 
> or an even more annoying behavior.  I believe that the current
> behavior 
> is the best choice among these three options.

Well as I've said... I don't demand that it's changed, but I simply
think it's a wrong assumption that it's in any way better or worse.

Leaving back partial output, or when scrolling up&down completely
messed up output, is surely not per se more annoying or a bigger
problem than leaving back no output at all in one case (when it doesn't
fit on one screen) or leaving back output (when it fits).



> Yes, I'm sure, because I'd be fixing that already if that were the
> case 
> in my environment. :)  I use Xfce and its default terminal emulator, 
> though, and I don't know what it's like in other desktop environments
> and their terminal emulators.

I just tried it with xfce4-terminal 1.1.0 (which AFAICS is the most
recent version) in Debian, and unless they break anything with custom
patches, or you distro fixes anything with custom patches... I'd say
you must suffer from the same issue and probably just try something
different.

Since Debian's less is pretty outdated, I've even compiled a quite
recent less 643 (there's not even a tarball yet for 644, only a git
tag).


A made a screen recording... it's not 8K ;-) but I guess you can see
what I do:
https://youtu.be/KMs3sLk9nXY



Cheers,
Chris.
