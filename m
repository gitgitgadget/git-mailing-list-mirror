From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Thu, 6 Jan 2011 08:47:40 +0700
Message-ID: <AANLkTi=-gomYOpX6+RSboBXBytPry1Qhf31ohmv1dC5d@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
 <AANLkTimHb8O6s_KfhSGqvStZkEGWvPeAVcqQkYoyk49j@mail.gmail.com>
 <201101051813.57603.trast@student.ethz.ch> <AANLkTikn+89iGbkt90Bv1Hndiimf4brcCNOo0HBX-oPy@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 02:48:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Paexe-0004aP-QV
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 02:48:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752953Ab1AFBsN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 20:48:13 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48039 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751650Ab1AFBsM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 20:48:12 -0500
Received: by wyb28 with SMTP id 28so15967710wyb.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 17:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=m6+AhhLujAcm1Wgzn8aig/zIiczSPe/GUSeUulSc4JM=;
        b=NQL0Ic3Q4IvbmvHPGZTiYm8wGG0DBGzWHhXArBg4a/4hU/opiGFW0BS0kdA6N9VjCo
         uvnrcRRMMfZ3Kd9SC7d5HZo2ihRC1j9ntjXIfo6GRVvUaQ3xr/05m4Xd4HmxFS38mPm7
         ftN3UQgRn7q4DGvPIM2+17wN6x0+165LX38lI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=iSzq4N3A/qmKuxE3N05T9sdrsxpyPKDf2kMGJa2SX4O4cqNM8A2I+22d13/IBUcbOf
         fD15tA4dgPwfA21zzpUbWj2jAXI/frDJ+ozYosCSkG4n2HjOGpNzt5YO1e2TRUy4q2Da
         dolvDva1ZsntjhJD+8DeNaa8ie0xOeant3FHA=
Received: by 10.216.142.101 with SMTP id h79mr23895257wej.49.1294278491075;
 Wed, 05 Jan 2011 17:48:11 -0800 (PST)
Received: by 10.216.63.14 with HTTP; Wed, 5 Jan 2011 17:47:40 -0800 (PST)
In-Reply-To: <AANLkTikn+89iGbkt90Bv1Hndiimf4brcCNOo0HBX-oPy@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164619>

On Thu, Jan 6, 2011 at 1:07 AM, Luke Kenneth Casson Leighton
<luke.leighton@gmail.com> wrote:
> =C2=A0the plan is to turn that variation in the git pack-objects resp=
onses,
> across multiple peers, into an *advantage* not a liability. =C2=A0how=
?
> like this:
>
> =C2=A0* a client requiring objects from commit abcd0123 up to commit
> efga3456 sends out a DHT broadcast query to all and sundry who have
> commits abcd0123 and everything in between up to efga3456.
>
> =C2=A0* those clients that can be bothered to respond, do so [refinem=
ents below]
>
> =C2=A0* the requestor selects a few of them, and asks them to create =
git
> pack-objects. =C2=A0this takes time, but that's ok. =C2=A0once create=
d, the size
> of the git pack-object is sent as part of the acknowledgement.
>
> =C2=A0* the requestor, on receipt of all the sizes, selects the *smal=
lest*
> one to begin the p2p (.torrent) from (by asking the remote client to
> create a .torrent specifically for that purpose, with the filename
> abcd0123-ebga3456).

That defeats the purpose of distributing. You are putting pressure on
certain peers.

> =C2=A0now, an immediately obvious refinement of this is that those .t=
orrent
> (pack-objects) "stick around", in a cache (with a hard limit defined
> on the cache size of course). =C2=A0and so, when the client that requ=
ires a
> pack-object makes the request, of course, those remote clients that
> *already* have that cached pack-object for that specific commit-range
> should be given first priority, to avoid other clients from having to
> make massive amounts of git pack-objects.

Cache have its limits too. Suppose I half-fetch a pack then stop and
go wild for a month. The next month I restart the fetch, the pack may
no longer in cache. A new pack may or may not be identical to the old
pack.

Also if you go with packs, you are tied to the peer that generates
that pack. Two different peers can, in theory, generate different
packs (in encoding) for the same input.

Another thing with packs (ok, not exactly with packs) is how you
verify that's you have got what you asked. Bittorrent can verify every
piece a peer receives because sha-1 sum of those pieces are recorded
in .torrent file. We have SHA-1 all over the place, but if you don't
have base objects to undeltify, you can't use those SHA-1 to verify.
Verification is an important step before you advertise to other peers
"I have these".

> so, can you see that a) this is a far cry from the "simplistic
> transfer of blobs and trees" b) it's *not* going to overload peoples'
> systems by splattering (eek!) millions of md5 sums across the interne=
t
> as bittorrent files c) it _does_ fit neatly into the bittorrent
> protocol d) it combines the best of git with the best of p2p
> distributed networking principles...

How can you advertise what you have to another peer?
--=20
Duy
