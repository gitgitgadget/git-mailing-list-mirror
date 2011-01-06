From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Thu, 6 Jan 2011 17:50:24 +0000
Message-ID: <AANLkTimgpbzbu-cD0+fFPie4U2R_ZoG46cDJkNt43R83@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
	<AANLkTimHb8O6s_KfhSGqvStZkEGWvPeAVcqQkYoyk49j@mail.gmail.com>
	<201101051813.57603.trast@student.ethz.ch>
	<AANLkTikn+89iGbkt90Bv1Hndiimf4brcCNOo0HBX-oPy@mail.gmail.com>
	<AANLkTi=-gomYOpX6+RSboBXBytPry1Qhf31ohmv1dC5d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thomas Rast <trast@student.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 18:50:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Patz3-0001MP-2O
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 18:50:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab1AFRu2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jan 2011 12:50:28 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:57652 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753647Ab1AFRuZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jan 2011 12:50:25 -0500
Received: by pxi15 with SMTP id 15so2945614pxi.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 09:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=V8G2L/DRiFnae7auH1qXe6bTZvI2523FN/ylwJPqxQo=;
        b=edwlx1C0o9Ew6aWEAx+ZGlo0e5PQ3GNaHJjk9y3KqbV6JFWX9JXbebPtNUv/Smo9Ia
         aRS23zGlz7dQLoOpm+tTyGJ3fyKQyJzKWTyPp+7W32dHBx8eqPJdwtLFYjMwrR9w7B8o
         xdGVSXpTqX12loiLfzrZ6q9esvDvfMrJ3Y9XU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=T/5PmfJVy6oyO76LqBv8VkyB2OD0Bj1eHW8SD7YoGz0dY4n8OcXy8DaG4UaiLdAdGN
         +PSvQtCbTAHY0GCKR94WVxopAej5nUFOqKBpx4yowXq8Iri/rmJL7YL14BBRbws/ToZ4
         E2NQ1DvwnjpKF5N8LEZg6o3Al0VL2yhAnUOAQ=
Received: by 10.142.191.15 with SMTP id o15mr982418wff.29.1294336224657; Thu,
 06 Jan 2011 09:50:24 -0800 (PST)
Received: by 10.142.58.11 with HTTP; Thu, 6 Jan 2011 09:50:24 -0800 (PST)
In-Reply-To: <AANLkTi=-gomYOpX6+RSboBXBytPry1Qhf31ohmv1dC5d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164648>

On Thu, Jan 6, 2011 at 1:47 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Thu, Jan 6, 2011 at 1:07 AM, Luke Kenneth Casson Leighton
> <luke.leighton@gmail.com> wrote:
>> =C2=A0the plan is to turn that variation in the git pack-objects res=
ponses,
>> across multiple peers, into an *advantage* not a liability. =C2=A0ho=
w?
>> like this:
>>
>> =C2=A0* a client requiring objects from commit abcd0123 up to commit
>> efga3456 sends out a DHT broadcast query to all and sundry who have
>> commits abcd0123 and everything in between up to efga3456.
>>
>> =C2=A0* those clients that can be bothered to respond, do so [refine=
ments below]
>>
>> =C2=A0* the requestor selects a few of them, and asks them to create=
 git
>> pack-objects. =C2=A0this takes time, but that's ok. =C2=A0once creat=
ed, the size
>> of the git pack-object is sent as part of the acknowledgement.
>>
>> =C2=A0* the requestor, on receipt of all the sizes, selects the *sma=
llest*
>> one to begin the p2p (.torrent) from (by asking the remote client to
>> create a .torrent specifically for that purpose, with the filename
>> abcd0123-ebga3456).
>
> That defeats the purpose of distributing. You are putting pressure on
> certain peers.

 that's unavoidable, but it's not actually as bad as it seems.  think
about it.  normally, "pressure" is put onto a git server, by forcing
that server to perform multiple "git pack-object" calculations,
repeatedly, for each and every "git pull".

 so, the principle behind this RFC (is it an RFC? yes, kinda...) is
that a) you cache those git pack-objects, thus avoiding heavy CPU
usage b) you make the requests to _many_ peers that you'll likely find
already are in the process of distributing that particular
commit-range _anyway_ so will _definitely_ have it  ... etc. etc.

 so there's a ton of reasons why it's quite a big improvement over the
present star-network arrangement.

>
>> =C2=A0now, an immediately obvious refinement of this is that those .=
torrent
>> (pack-objects) "stick around", in a cache (with a hard limit defined
>> on the cache size of course). =C2=A0and so, when the client that req=
uires a
>> pack-object makes the request, of course, those remote clients that
>> *already* have that cached pack-object for that specific commit-rang=
e
>> should be given first priority, to avoid other clients from having t=
o
>> make massive amounts of git pack-objects.
>
> Cache have its limits too. Suppose I half-fetch a pack then stop and
> go wild for a month. The next month I restart the fetch, the pack may
> no longer in cache. A new pack may or may not be identical to the old
> pack.

 correct.  that's not in the slightest bit a problem.  the peer which
has that new pack will be asked to make a new .torrent for _that_
pack.  with a new name that uniquely identifies it (the md5sum of the
pack would do as the .torrent filename)

> Also if you go with packs, you are tied to the peer that generates
> that pack. Two different peers can, in theory, generate different
> packs (in encoding) for the same input.

 yes.  correct.  i _did_ say that you pick the one that is the
smallest of the two (or three.  or 10).  in this way you actually do
much better than you would otherwise in a "star network" such as a
standard HTTP git server, because you've asked 2, 3 or 10 (whatever)
peers, and you'll end up with _the_ most efficient representation of
that commit-range.  statistically speaking, of course :)


> Another thing with packs (ok, not exactly with packs) is how you
> verify that's you have got what you asked.

 ok - how do you verify that you've got what you asked, when you ask
from a git server using HTTP?

> Bittorrent can verify every
> piece a peer receives because sha-1 sum of those pieces are recorded
> in .torrent file.

 yes.  this is simply a part of the bittorrent protocol, to ensure
that the file being transferred is correctly transferred.

 these verifications steps should be _trusted_ and should _not_ be
confused with anything else (i've deleted the rest of the paragraph
you wrote, in order to reduce any opportunity for confusion).

 if you mentally keep git separate from bittorrent it helps.  imagine
that bittorrent is merely a drop-in replacement for git over HTTP
(nicolas kindly explained the plugin system for git which would add
another protocol for downloading of git repos, and yes this can all be
implemented as a plugin)


>> so, can you see that a) this is a far cry from the "simplistic
>> transfer of blobs and trees" b) it's *not* going to overload peoples=
'
>> systems by splattering (eek!) millions of md5 sums across the intern=
et
>> as bittorrent files c) it _does_ fit neatly into the bittorrent
>> protocol d) it combines the best of git with the best of p2p
>> distributed networking principles...
>
> How can you advertise what you have to another peer?

 you don't.  it's done "on-demand".

 the concept of "git push" becomes virtually a null-op, updating the
bittorrent tracker and that's... about it.

 it's where "git pull" that all the work is done, starting with that
DHT query [no i know "bittorrent the protocol" doesn't have DHT, but
many bittorrent clients _do_ have DHT, and Tribler has an extremely
good one].

 l.
