From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: git pack/unpack over bittorrent - works!
Date: Thu, 2 Sep 2010 19:07:07 +0100
Message-ID: <AANLkTi=kO9USQYoTLQZyCRrjCHWRtPtd4S5EuFk4-gPv@mail.gmail.com>
References: <AANLkTik-w6jWgrt_kwAk2uNGhF_=3tMEpTZs3nyF_zGA@mail.gmail.com>
	<AANLkTinu=RoGfq93d+yjHiQwCt0HXx4YtqfvhXyZdO=F@mail.gmail.com>
	<AANLkTimpE6rf0azHtrz6BFK5d7YojF+G1YuSA1gusSC=@mail.gmail.com>
	<4C7FC3DC.3060907@gmail.com>
	<AANLkTikBnKQJmgOms2wK1+6fCLtHWiWkhuCVMN7kKLXP@mail.gmail.com>
	<20100902155810.GB14508@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitzilla@gmail.com, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 02 20:07:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrEC0-000607-2D
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 20:07:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752629Ab0IBSHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 14:07:10 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:35493 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750761Ab0IBSHJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 14:07:09 -0400
Received: by ewy23 with SMTP id 23so501414ewy.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 11:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=vKer0Bsz7KyXLGxHhCbx/WHbnP8X9rherJL+Y0dobpk=;
        b=KMH3jPncIVs5GLbLKISYFA62gCgywI5gGxmqpLDAUbKoMvAmmYEZo43GyImT4aU1uR
         7fEy/Hp2rN/aNt2hY1dnHEaIojnAd2w0vZfI1MMwHCCSO7Us70UybgzE02QwtwgC/awF
         mqGs4xxuCqaAhJuB7WyaCtAll+p1Kb/Wy3IiY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mTW5+PufkztBoR3+Pok8sanDJ3mNRStadeZ/YROg9Ky4QVppSRDG0fKNsJtKOtBptl
         oSPCQl6RZTG5Gd97cr718g6+X/VvTF6neaIov734DPv08BvtfyJK7Nm7TF8jxghofV9I
         Jvv8WEcFht+vccasnR/Ez3TgyhPkqSmBS0lgM=
Received: by 10.213.28.8 with SMTP id k8mr425292ebc.55.1283450827868; Thu, 02
 Sep 2010 11:07:07 -0700 (PDT)
Received: by 10.220.98.8 with HTTP; Thu, 2 Sep 2010 11:07:07 -0700 (PDT)
In-Reply-To: <20100902155810.GB14508@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155154>

On Thu, Sep 2, 2010 at 4:58 PM, Jeff King <peff@peff.net> wrote:

> pack-objects will reuse previously found deltas. So the deltas you ha=
ve
> in your existing packs matter. The deltas you have in your existing
> packs depend on many things. At least:
>
> =C2=A01. Options you used when packing (e.g., --depth and --window).
>
> =C2=A02. Probably exactly _when_ you packed. You could find a good de=
lta
> =C2=A0 =C2=A0 from A to B. Later, object C comes into existence, and =
would
> =C2=A0 =C2=A0 provide a better delta base for B. I don't think we wil=
l ever try A
> =C2=A0 =C2=A0 against C, unless --no-reuse-delta is set.
>
> =C2=A0 =C2=A0 You have a different pack than somebody who packed afte=
r A, B, and
> =C2=A0 =C2=A0 C all existed.
>
> =C2=A0 =C2=A0 In practice, this tends not to happen much because the =
best deltas
> =C2=A0 =C2=A0 are usually going backwards in time to a previous versi=
on. But it
> =C2=A0 =C2=A0 can happen.

 jeff, thanks for explaining (and to nicolas, i see, since beginning th=
is)

 mrhmfffh.  just been reading Documentation/technical/pack-heuristics.t=
xt.

 so... options include:

 * writing an alternative "canonical" pack-object algorithm.  i'm
inclined to select "git format-patch"! :)  but that would be the lazy
way....

 * taking the seeder's pack-objects as the "canonical" ones,
regardless.  cacheing of the results would, sadly, be virtually
unavoidable, given the situation (multi-threading etc.)

 * throw away bittorrent entirely as a transport mechanism.

 * force-feed one peer to be "the" provider of a particular given
pack.  doesn't matter whom you contact to _obtain_ a pack from, as
long as you solely and exclusively get the pack from that particular
peer.

 * slight improvement / variation on the above: if two peers just
coincidentally happen to create or have the same pack (as can be shown
by having the same SHA-1, and/or by having the same data in their
cache) then ta-daaa, you have a file-sharing network for that
particular pack.

i think.... i think i miiight be able, hmmm... i believe it would be
possible to implement this last option by creating separate .torrents
for packs (one each!).  by splitting things down, so that pack objects
are named as {ref}-{objref}-{SHA-1}.torrent and by providing a "top
level" torrent which contains the refs/heads/* and the associate
rev-list(s)... each set of rev-lists would have the SHA-1 of the
pack-object that happened to be created (and shared) at that
particular time, from that particular client: you then genuinely don't
give a stuff about who has what, it's all the same, and...

hmmm, i feel a modification to / deviation from the bittorrent
protocol coming on :)

l.
