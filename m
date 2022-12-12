Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7245C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 21:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiLLVFq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 16:05:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiLLVFO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 16:05:14 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DEE167E1
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 13:05:08 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|joshua@azariah.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CDEDB6C0F80;
        Mon, 12 Dec 2022 21:05:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a300.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 364E36C11D3;
        Mon, 12 Dec 2022 21:05:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670879106; a=rsa-sha256;
        cv=none;
        b=62wCGC/Ed7j/BlRph1F8OQ9+CnjW2+XwQDHwIBGW0eZCf6x2zm1rztZYUsxOGekMnlq3bq
        yg2VYqDLcAZNvayQ3Q4PWq6rTQRVAXl1TlryU0qplFM2RdLHWXlbUYn1DkwIXh5C3uOP7R
        57sHMjxbOgejNo5Xu9ov3ucX3XLpZaHkFDiQ2ZCpajIMnDLjvCv8ajBvTagnYnu1WXqgwP
        PNcHyda7XApxYPBzWK9Y89LgWf3SXZsnuGX/8/l7zpXxOlc39zpbIWlK+C6UDxKVj/cdOp
        VDgZM7acr3GkNBCXH/I0g5PQdfUjS8r/iOuk1sOFPtCv3FYOeEVQxpU00MFD0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670879106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=9cLBCI+1QXI342tytrWJy7DRudi/k8PikPOVn2tVv5g=;
        b=OYRUis4i0N8ki29NGcSSaZ7Qb/foF5/96VXf3txKUrHeUFv6nyTV4vcbOKCxUzHUd1gb7+
        EIgQeQRidYGH1yJh0W94J2p56l6ryZmZPdm7MMK0I+YD9qJ3NKG4zp+1ERABjkyIwPpgkQ
        LyFAc4U23isSMVzrEgv0elE6+ozXd4nt4RXHPcMNqz9nAGSioSedykkwiD73YGoC586srK
        W+/AyMNfcuOVsBe5ICRNQmZAXpc/vm6gfOpxBBRh9JSpp8D9aKGiY2vMx+aDgjcw+Pg0iP
        pmFnPcFBRX4Z0JnX7OBAKBn6uACJ9EBZMAGlzgM4hms0W20sqqyJRHaI5C86QQ==
ARC-Authentication-Results: i=1;
        rspamd-d48c5ddb-fm2bt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=joshua@azariah.com
X-Sender-Id: dreamhost|x-authsender|joshua@azariah.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|joshua@azariah.com
X-MailChannels-Auth-Id: dreamhost
X-Cooperative-Reaction: 146db99f2b3de5d9_1670879106639_352365583
X-MC-Loop-Signature: 1670879106639:597950649
X-MC-Ingress-Time: 1670879106639
Received: from pdx1-sub0-mail-a300.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.107.134.104 (trex/6.7.1);
        Mon, 12 Dec 2022 21:05:06 +0000
Received: from hosanna.localnet (216-67-98-32.static.acsalaska.net [216.67.98.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joshua@azariah.com)
        by pdx1-sub0-mail-a300.dreamhost.com (Postfix) with ESMTPSA id 4NWDfT456wzC9;
        Mon, 12 Dec 2022 13:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azariah.com;
        s=dreamhost; t=1670879106;
        bh=9cLBCI+1QXI342tytrWJy7DRudi/k8PikPOVn2tVv5g=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding:Content-Type;
        b=DSWl0B7IlPw8K6e85/d9k1hbTIbI9krxaONQ58VchP5F6RtubSEBxRZHav7OJsq9z
         LcElgtDb+AKXjYvDyqYBcmcCdgO19p753SacYFC0uWtW3vmLecMJ7Ve+W1eFNhOAbO
         3QHDEUEkAk/ztNiusQ5ZSSB/dADkfqvbNWtslJyz0LlL7F17+f7acCkQDO6Z8pmv5K
         evgqo+rzQnCs2rkW4G/AVWGIfAWuCjfDwpYXBS7kUeZOm9oMxoIw1C9FYDCU45kuMq
         VtVY8O+PwNbxTbXvEYTnnMd1AwLx9GC5Uw0FGwIqkE/VnheVivCa8zeve6N0Ew0VYl
         n8o3N49L51FPA==
From:   "Joshua J. Kugler" <joshua@azariah.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Sean Allred <allred.sean@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: includeIf appears to not be working
Date:   Mon, 12 Dec 2022 12:05:04 -0900
Message-ID: <5349174.mvXUDI8C0e@hosanna>
Organization: Azariah Enterprises
X-Face: "i;.9?eoq[n1J]7NP093Nf-le\(f:apL[8Qcc^@FG*Lx!`q`1/iCg7oGU/gv&"yx=8K|o: 8e=hQB,0w,`~p}'#>'NF8L3xcI>;?O-ABM#&^UN@Vh{4ktY],7O]OhEyW8tjIdHtN<G<q` Ha]]!@7D)vzKnV!!*{Y>`(&+f>TErbn'9J)'=2RU+3I_OdR)P_I/Bl+l@5)o5,KV}BKhi; DzH7ih^d}V6{2aa8qe&)\B}h;\Tje;[6E4K1Gu-M`>WM7-}cZ'&n(`nk.!coGBc<WTQO.# ?~JA)i#GH)W(jZRI<p]Il-NRMeEX+X/MTW8?T
In-Reply-To: <CAPig+cRv02F2yw3Ej1_7PKUV5stKcff82GtdUe5X3wnPfDhfmw@mail.gmail.com>
References: <8316344.DvuYhMxLoT@hosanna> <CAPig+cRv02F2yw3Ej1_7PKUV5stKcff82GtdUe5X3wnPfDhfmw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

All -

Yep, that was copy/paste verbatim, and yep, that was the issue.

Thank you to all who spotted the missing "e".  Siiiiigh. I looked at that so 
many times, and didn't even see it.

Sorry to waste your time, and I much appreciate the quick response!

j

On Monday, December 12, 2022 11:54:48 AM AKST Eric Sunshine wrote:
> On Mon, Dec 12, 2022 at 3:36 PM Joshua J. Kugler <joshua@azariah.com> wrote:
> > So, I've set up includeIf before, and have had it working, but it seems to
> > not be working in my latest attempt.
> > 
> > Contents of ~/.gitconfig (truncated):
> > 
> > [user]
> > 
> >         name = Joshua Kugler
> >         email = joshua@personal.com
> > 
> > [includIf "gitdir:~/repos/work/"]
> 
> Missing "e" in "includeIf".


-- 
Joshua J. Kugler - Fairbanks, Alaska - joshua@azariah.com
Azariah Enterprises - Programming and Website Design
PGP Key: http://pgp.mit.edu/  ID 0x68108cbb73b13b6a


