From: Luke Kenneth Casson Leighton <luke.leighton@gmail.com>
Subject: Re: Resumable clone/Gittorrent (again)
Date: Wed, 5 Jan 2011 18:07:19 +0000
Message-ID: <AANLkTikn+89iGbkt90Bv1Hndiimf4brcCNOo0HBX-oPy@mail.gmail.com>
References: <AANLkTinUV9Z_w85Gz13J+bm8xqnxJ9jBJXJm9bn5Y2ec@mail.gmail.com>
	<AANLkTimHb8O6s_KfhSGqvStZkEGWvPeAVcqQkYoyk49j@mail.gmail.com>
	<201101051813.57603.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jan 05 19:07:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaXle-0004in-Pb
	for gcvg-git-2@lo.gmane.org; Wed, 05 Jan 2011 19:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab1AESHV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Jan 2011 13:07:21 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:41385 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751170Ab1AESHU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jan 2011 13:07:20 -0500
Received: by qyk12 with SMTP id 12so17641674qyk.19
        for <git@vger.kernel.org>; Wed, 05 Jan 2011 10:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RbHCQ/QvBqPkJgZrmwNhbKdMW6q1VxGB1zxy6gKcZ+A=;
        b=HjJdTPj3iqtg6cmiElYIWuixa5nJZvmgjMkGtStws/LJ4sEvRsCDL7FSWeff0hBDb4
         CUGzYTl1SR5tLm+yJgzLWtRM3toJBXHoV8QueVytttWIAok0hNmOI5jjxGrLGtzYNRuJ
         HqFDxPQ4oi4ng9zOvnWjv6zXv8hB1HTcuFW1g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=VaXJSgC+odlVVi4jQbaOzeYgnrZHxfc6IQyAHS3LGMPrH44bOgxjGs39BhRjBeS5zZ
         DrIiXA073+ES/nL/PRjINb9dzayJH1yDnz2qrJDLgy8GS5gCO5KCI6lwURhephTUYkEB
         AIOgr0wI86CJ6mkrujUOmM0pEfCfeqRBdMV68=
Received: by 10.224.19.133 with SMTP id a5mr22512494qab.19.1294250839952; Wed,
 05 Jan 2011 10:07:19 -0800 (PST)
Received: by 10.220.190.203 with HTTP; Wed, 5 Jan 2011 10:07:19 -0800 (PST)
In-Reply-To: <201101051813.57603.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164578>

On Wed, Jan 5, 2011 at 5:13 PM, Thomas Rast <trast@student.ethz.ch> wro=
te:
> Luke Kenneth Casson Leighton wrote:
>> =C2=A0now that of course leaves you with the problem that you now ha=
ve
>> potentially hundreds if not thousands or tens of thousands of
>> .torrents to deal with, publish, find etc. etc.
>
> Umm, I'm counting 202400 objects in my git.git and 1799525 in a clone
> of linux-2.6.git. =C2=A0So I'm not sure how far you want to split thi=
ngs
> into single transfers, but going all the way down to objects will
> massively hurt performance.

 yeah... this is a key reason why i came up with a protocol which
transferred the exact same pack-objects that HTTP and all the other
"point-to-point" git protocols use, to such good effect.

the problem was that i was going to rely on multiple clients being
able to genereate the exact same pack-object, given the exact same
input, and then share that pack-object.  ok, that's not the problem,
that was just the plan :)

 nicolas kindly pointed out, at some length, that in a distributed
environment, however, that plan was naive, becauuuse whenever you
request a pack-object for use e.g. normally with HTTP or other git
point-to-point protocol, it's generated there-and-then using
heuristics and multi-threading that pretty much guarantees that even
if you were to make the exact same request of exactly the same system,
you'd get *different* pack-objects!  not to mention the fact that
different people have the same git objects stored in *different* ways
because the object stores, despite having the same commits in them,
were pulled at different times and end up with a completely different
set of git objects that represent those exact same commits that
everyone else has.

that's all a bit wordy, but you get the idea.

 so, nicolas recommended a "simpler" approach, which, well, apologies
nicolas but i didn't really like it - it seemed far too simplistic and
i'm not really one for spending time doing these kinds of
"intermediate baby steps" (wrong choice of words, no offense implied,
but i'm sure you know what i mean).  i much prefer to just hit all the
issues head-on, right from the start :)


so, in the intervening time since this was last discussed i've given
the pack-objects-distributing idea some thought (and NO, nicolas, just
to clarify, this is NOT grabbing the git packed objects that are
actually in the .git/objects store, so NO, this does NOT end up
bypassing security by giving people objects that are from another
branch, it really IS getting that lovely varying data which is
heuristic, store and threadnum dependent!).

 the plan is to turn that variation in the git pack-objects responses,
across multiple peers, into an *advantage* not a liability.  how?
like this:

 * a client requiring objects from commit abcd0123 up to commit
efga3456 sends out a DHT broadcast query to all and sundry who have
commits abcd0123 and everything in between up to efga3456.

 * those clients that can be bothered to respond, do so [refinements be=
low]

 * the requestor selects a few of them, and asks them to create git
pack-objects.  this takes time, but that's ok.  once created, the size
of the git pack-object is sent as part of the acknowledgement.

 * the requestor, on receipt of all the sizes, selects the *smallest*
one to begin the p2p (.torrent) from (by asking the remote client to
create a .torrent specifically for that purpose, with the filename
abcd0123-ebga3456).

 in this way you end up with not only an efficient git pack-object but
you get, to 99.5% certainty *THE* most efficient git pack-object.
distributed computing at its best :)

 now, an immediately obvious refinement of this is that those .torrent
(pack-objects) "stick around", in a cache (with a hard limit defined
on the cache size of course).  and so, when the client that requires a
pack-object makes the request, of course, those remote clients that
*already* have that cached pack-object for that specific commit-range
should be given first priority, to avoid other clients from having to
make massive amounts of git pack-objects.

 a further refinement is of course to collect statistics on the number
of peers doing downloads at the time, prioritising those pack-objects
which are most being distributed at the time.  this has fairly obvious
benefits :)

 yet *another* refinement is slightly less obvious, and it's this:
there *COULD* happen to be some existing pack-objects in the cache,
not of commit abcd0123-efga3456 but in a ready-made "chain": commits
abcd01234-beef7890 packed already and in the cache, and commits
beef7890-efga3456 likewise packed already and in the cache.  again:
the requestor should be informed of these, and make their mind up as
to what to do.

 it gets rather more complex when you have *part* of the chain already
pre-cached (and have to work out err, i got this bit and this bit, but
i'd have to generate a git pack-object for the bit in the middle, i'll
inform the requestor of this, they can make up their mind what to do),
but again i do not imagine for one second that this would be anything
more than an intriguing coding challenge and, importantly, an
optimisation challenge for gittorrent version 3.0 somewhere down the
line, rather than an all-out absolute requirement that it must, must
be done now, now, now.

 what else can i mention, that occurred to me... yeah - abandoning of
a download.  if, for some reason it becomes blindingly obvious that
the p2p transfer just isn't working out, then the requestor simply
stops the process and starts again.  a refinement of this, which is a
bit cheeky i know, is to keep *two* simultaneous requests and
downloads for the *exact* same git pack-object commit-chain but with
different data from different groups of peers, for a short period of
time, and then abandon one of them once it's clear which one is best.
this does seem a bit cheeky, but it has the advantage that if the one
that _was_ fastest goes tits-up, you can at least go back to the
previous one and, assuming that the cache hasn't been cleared, just
join in again.  but this is _really_ something that's wayyy down the
line, for gittorrent version 4.0 or 5.0 or so.

so, can you see that a) this is a far cry from the "simplistic
transfer of blobs and trees" b) it's *not* going to overload peoples'
systems by splattering (eek!) millions of md5 sums across the internet
as bittorrent files c) it _does_ fit neatly into the bittorrent
protocol d) it combines the best of git with the best of p2p
distributed networking principles...

=2E.. all of which creates a system which people will _still_ say is a
"hammer looking for nails" :)

=2E.. right up until the point where some idiot in the USA government
decides to seize sourceforge.net, github.com, gitorious.org and
savannah.gnu.org because they contain source code of software that
MIGHT be used for copyright infringement.  whilst i realise that the
only one of those that might be missed is sourceforget, you cannot
ignore the fact that the trust placed in governments and large
corporations to run the internet infrastructure is now completely
gone, and that the USA and other countries are now putting in place
hypocritical policies that put them into the same category that used
to be reserved for China, Saudi Arabia, Iran and other regimes accused
of being "Totalitarian".

 thoughts, anyone?  (other than on the last paragraph, please, if that'=
s ok).

l.
