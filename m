From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [Patch] Prevent cloning over http from spewing
Date: Wed, 10 Jun 2009 22:03:10 +0800
Message-ID: <be6fef0d0906100703j57d109d5mb38e41330caa089b@mail.gmail.com>
References: <20090602174229.GA14455@infidigm.net>
	 <m3vdnda9f7.fsf@localhost.localdomain>
	 <7vmy8p8947.fsf@alter.siamese.dyndns.org>
	 <20090603191050.GB29564@coredump.intra.peff.net>
	 <20090603191555.GL3355@spearce.org>
	 <be6fef0d0906040545j7bd754e0j2c60af833e2ac4a4@mail.gmail.com>
	 <20090604160152.GA13984@sigill.intra.peff.net>
	 <be6fef0d0906070331y5fd596d1k67893a96a4d872ac@mail.gmail.com>
	 <be6fef0d0906070421j7913b0d7w6f7bb97aa7fd6814@mail.gmail.com>
	 <20090608122430.GD13775@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, sparse@infidigm.net,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 16:03:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEOOe-0007Q9-Kk
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 16:03:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbZFJODM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Jun 2009 10:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754604AbZFJODJ
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 10:03:09 -0400
Received: from wf-out-1314.google.com ([209.85.200.174]:65293 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754525AbZFJODI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Jun 2009 10:03:08 -0400
Received: by wf-out-1314.google.com with SMTP id 26so317427wfd.4
        for <git@vger.kernel.org>; Wed, 10 Jun 2009 07:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=C1JLBjOboOMNfn60uUF/njn6IfBY9yLa725dDud1XrE=;
        b=Ay9tAwTR3/plAZ6SWUcgzCrOH8LgdkFrUqBRAqS5MWs7nVEvC77x2MTQssqr/Xmejd
         o8iCGoHgrA/awBfwGMuGVb0cK3IeiPD6y5CYCVYmrWRLi4eqW2Ggt58t1R1QRpCAuFFd
         nxvArG/R+Wa1X6/wqRD9PORkxX8+uk1avkWqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=EQeOIMuOck4h5cLjDjQPWdR8UzCpxsGnVBoHVs8flmfF6lpnLuyPTB5ZhDwdpuzuVh
         RrqOlhdDyvdIn2igNQyFp7yr7xkWEU8mblAnlI3BZDz/adPDNNtbUDuF5MeFG8QnX3Gr
         yUZWf8725i8l/RkHhyJKVEpKRiA03ySVfjaoc=
Received: by 10.142.246.20 with SMTP id t20mr556903wfh.348.1244642590631; Wed, 
	10 Jun 2009 07:03:10 -0700 (PDT)
In-Reply-To: <20090608122430.GD13775@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121276>

Hi,

On Mon, Jun 8, 2009 at 8:24 PM, Jeff King<peff@peff.net> wrote:
> Thanks, I just looked at it (though sadly it does not merge into what=
 is
> in 'next' right now).

thanks for taking the time to do try it out (and with linux-2.6, at tha=
t).

> My first complaint is that it is way too long. It wrapped in my
> 80-column terminal, causing all sorts of visual confusion.

The byte counts can really take up alot of space. Perhaps we should
just show the size (MiB) and completed percentage, sans byte counts?

>> 1. %d objects =3D number of concurrent objects being fetched, usuall=
y
>> around 4-5. Since objects are fetched alongside other files like pac=
ks
>> and pack indices, I separated this from (4).
>
> This did at times say '4' for me, but just as often it said '0' (even
> when stuff was obviously downloading). I hadn't thought about the fac=
t
> that we have concurrent downloads. That really makes things harder.
> Though it seems like we only do one pack file at a time (so maybe tha=
t
> is the reason for the '0' -- we are downloading a pack).

=46etching of objects and packs take place separately; it doesn't mean
that when '0' objects are being fetched, we're definitely fetching
something else (eg. packs). Perhaps we should "hide" the "Fetching 0
objects" part when the number of simultaneous object fetches is 0?

> In fact, while watching the progress go for the linux-2.6 download, i=
t
> is really hard to tell what is going on. The "% completed" number jum=
ps
> around between multiple values, even showing what appears to be
> nonsense:
>
> =A0Fetching 0 objects (got 2 of 320, 0 alt) and pack: =A0 8%
> =A0(241096602/302989431), 229.78 MiB | 668 KiB/s
> =A0...
> =A0Fetching 0 objects (got 2 of 320, 0 alt) and pack: =A0 4%
> =A0(270741882/302989431), 257.93 MiB | 690 KiB/s
>
> Those are two cut-and-pastes from the same fetch. You can see it
> progressing in terms of absolute numbers, but the percentage values m=
ake
> no sense. The "total downloaded" and throughput numbers look roughly
> correct. I don't know if this is caused by multiple simultaenous
> downloads.

It's likely that your guess (about simultaneous downloads) is causing
the inconsistent % completed, but then packs aren't downloaded
simultaneously. I'll have to check this again.

> Fetching linux-2.6, I spent a very long time on "got 2 of 320" which
> really wasn't all that helpful (because almost the whole thing is in
> packs). Probably a pack count would be useful there. Though I wonder =
if
> there is some shorter way to summarize what is going on to keep the l=
ine
> smaller.

We are of course assuming that the user is fetching from a well-packed
repo. Again, perhaps we could cut out the "Fetching 0 objects" part.

> But somewhat worse is that we start at '320', spend a lot of time, an=
d
> then magically it ends up at 1182387 at the end. So it is not all tha=
t
> useful as a progress counter, because we don't actually know the tota=
l.
> So we can show that we are progressing, but the end keeps getting
> farther away. :)

The total number of objects (320) increases as we "walk" the commits;
sometimes we need to fetch the "walked" objects, sometimes we don't
(eg. in packs we've fetched already). There's no way to know in
advance the total; hence, the continually updating of the total. I
don't think there's it's a problem; the idea is to let the user be
sure that git is active.

>> 3. %d alt =3D number of alternate objects. The way I'm counting them=
 now
>> is very inaccurate; I may drop this if it's too complicated to do an
>> accurate count. I added this because some people use forked repos, a=
nd
>> they may wonder why after some time, the number of objects fetched
>> doesn't increase. (The time was spent on waiting for the server, onl=
y
>> for it to return a 404).
>
> In the name of conserving space on the line, perhaps you should just
> count this as a "fetched" object and increment the fetched count by o=
ne.
> The user doesn't have to care which were alt and which were not, as l=
ong
> as they see a counter progressing towards completion.

Ok. I'll just drop this then. (The way I'm doing it right now isn't
very accurate: the "alt" count increases the moment git realises the
object might be found at the alternate location, not the moment the
object at the alternate location is fetched.)

> I wonder if you should start a newline every time we get to a new
> "phase". So you might see:
>
> =A0Downloading %d loose objects: Z% (X/Y), x MiB | y KiB/s, done
> =A0Fetching pack 1 of 2: Z% (X/Y), x MiB | y KiB/s, done
> =A0Verifying pack 1 of 2: Z% (X/Y)
> =A0Fetching pack 2 of 2: Z% (X/Y), x MiB | y KiB/s, done
> =A0Verifying pack 2 of 2: Z% (X/Y)
>
> That assumes we download packs one at a time (is that right?). It doe=
s take
> a couple of lines to show what is going on, but I think most repos ar=
e
> only going to have a couple of packs (though in theory, you could hav=
e
> more "loose objects" lines interspersed with your packs).

Yeah, we do download packs one at a time (as I said above).

--=20
Cheers,
Ray Chuan
