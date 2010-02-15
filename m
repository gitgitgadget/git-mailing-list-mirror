From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: [PATCH] don't use mmap() to hash files
Date: Mon, 15 Feb 2010 00:01:49 -0500
Message-ID: <32541b131002142101i226663cfk90d1ba14f1031788@mail.gmail.com>
References: <20100211234753.22574.48799.reportbug@gibbs.hungrycats.org> 
	<37fcd2781002131409r4166e496h9d12d961a2330914@mail.gmail.com> 
	<20100213223733.GP24809@gibbs.hungrycats.org> <20100214011812.GA2175@dpotapov.dyndns.org> 
	<alpine.DEB.1.00.1002140249410.20986@pacific.mpi-cbg.de> <20100214024259.GB9704@dpotapov.dyndns.org> 
	<alpine.DEB.1.00.1002141908150.20986@pacific.mpi-cbg.de> <37fcd2781002141106v761ce6e0kc5c5bdd5001f72a9@mail.gmail.com> 
	<32541b131002141513m29f9a796ma8fb5855a45f91e9@mail.gmail.com> 
	<alpine.LFD.2.00.1002142252020.1946@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Zygo Blaxell <zblaxell@esightcorp.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Feb 15 06:02:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ngt68-0008UQ-3S
	for gcvg-git-2@lo.gmane.org; Mon, 15 Feb 2010 06:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751091Ab0BOFCL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Feb 2010 00:02:11 -0500
Received: from mail-yw0-f179.google.com ([209.85.211.179]:42073 "EHLO
	mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983Ab0BOFCK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Feb 2010 00:02:10 -0500
Received: by ywh9 with SMTP id 9so4137411ywh.19
        for <git@vger.kernel.org>; Sun, 14 Feb 2010 21:02:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=ct3YY47B2UlrAbT0DvlOEKtj69UCE3cfve8hevbHSGo=;
        b=de9MkDZbIgk1npIVEZ/LiANwqwM+l/dW9xWygE0hd/wsl8+eDyHuB6MS+y8zw4MEXU
         kDPQDOFWfuPJMGl+rH44KsDsJy/tsQEqwJS7xXmfvA6vcXq4NtTJf4x4zigMWklX2PlI
         8F7rtbIXlE61fN9X80b6MguTPKM2nvlzmun+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=sLVwevhcTBtGXegsOxpwjOdGt0PPHA8Bn4gauoyp9LGZtKWcJKEEnl1mOE/MYw7CLC
         xjYMEMixboEWaCKvWGLqM8ZutMwTmQ/RT6cZlq5UyCbhZJDkBGA5sYkcmg2+pQMqu+Pk
         1eJ0VaBbwpVqUnNKov2X5oQutgOThWC9WT6lU=
Received: by 10.150.117.32 with SMTP id p32mr6474078ybc.279.1266210129074; 
	Sun, 14 Feb 2010 21:02:09 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1002142252020.1946@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139973>

On Sun, Feb 14, 2010 at 11:16 PM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
> On Sun, 14 Feb 2010, Avery Pennarun wrote:
>> In fact, arguably you should prevent git-add from adding large files
>> at all, because at least then you don't get the repository into a
>> hard-to-recover-from state with huge files. =A0(This happened at wor=
k a
>> few months ago; most people have no idea what to do in such a
>> situation.)
>
> Git needs to be fixed in that case, not be crippled.

That would be ideal, but is more work than disabling imports for large
files by default (for example), which would be easy.  In any case, my
solution at work was to say "if it hurts, don't do that" and it seems
to have worked out okay for now.

>> For my own situation, I think I'm more likely to (and I know people
>> who are more likely to) try storing huge files in git than I am like=
ly
>> to modify a file *while* I'm trying to store it in git.
>
> And fancy operations on huge files are pretty unlikely. =A0Blame, dif=
f,
> etc, are suited for text file which are by nature relatively small.
> And if your source code is all pasted in one single huge file that Gi=
t
> can't handle right now, then the compiler is unlikely to cope either.

Well, I'm thinking of things like textual database dumps, such as
those produced by mysqldump.  It would be nice to be able to diff
those efficiently, even if they're several gigs in size.  bup's
hierarchical chunking allows this.

>> > The other way to handle huge files is to split them into chunks.
>> > http://article.gmane.org/gmane.comp.version-control.git/120112
>
> No. =A0The chunk idea doesn't fit the Git model well enough without m=
any
> corner cases all over the place which is a major drawback. =A0I think=
 that
> was discussed in that thread already.
>
>> I have a bit of experience splitting files into chunks:
>> http://groups.google.com/group/bup-list/browse_thread/thread/812031e=
fd4c5f7e4

Note that bup's rolling-checksum-based hierarchical chunking is not
the same as the chunking that was discussed in that thread, and it
resolves most of the problems.  Unless I'm missing something.

Also note that bup just uses normal tree objects (for better or worse)
instead of introducing a new object type.

>> It works. =A0Also note that the speed gain from mmap'ing packs appea=
rs
>> to be much less than the gain from mmap'ing indexes. =A0You could
>> probably sacrifice most or all of the former and never really notice=
=2E
>> Caching expanded deltas can be pretty valuable, though. =A0(bup
>> presently avoids that whole question by not using deltas.)
>
> We do have a cache of expanded deltas already.

Yes, sorry to have implied otherwise.  I was just comparing the
performance advantage of the delta expansion cache (which should be a
lot) with that of mmaping packfiles (which probably isn't much since
the packfile data is typically needed in expanded form anyway).

>> I can also confirm that streaming objects directly into packs is a
>> massive performance increase when dealing with big files. =A0However=
,
>> you then start to run into git's heuristics that often assume (for
>> example) that if an object is in a pack, it should never (or rarely)
>> be pruned. =A0This is normally a fine assumption, because if it was
>> likely to get pruned, it probably never would have been put into a
>> pack in the first place.
>
> Would you please for my own sanity tell me where we do such thing. =A0=
I
> thought I had a firm grip on the pack model but you're casting a shad=
ow
> of doubts on some code I might have written myself.

Sorry, I didn't hunt down the code, but I ran into it while
experimenting before.  The rules are something like:

- git-prune only prunes unpacked objects

- git-repack claims to be willing to explode unreachable objects back
into loose objects with -A, but I'm not quite sure if its definition
of "unreachable" is the same as mine.  And I'm not sure rewriting a
pack with -A makes the old pack reliably unreachable according to -d.
It's possible I was just being dense.

- there seems to be no documented situation in which you can ever
delete unused objects from a pack without using repack -a or -A, which
can be amazingly slow if your packs are huge.  (Ideally you'd only
repack the particular packs that you want to shrink.)  For example, my
bup repo is currently 200 GB.

Anyway, I didn't have much luck when playing with it earlier, but
didn't investigate since I assumed it's just a workflow that nobody
much cares about.  Which I think is a reasonable position for git
developers to take anyway.

Have fun,

Avery
