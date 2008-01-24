From: "Marko Kreen" <markokr@gmail.com>
Subject: Re: I'm a total push-over..
Date: Thu, 24 Jan 2008 15:19:46 +0200
Message-ID: <e51f66da0801240519u4c8e6ddfrb7af8df34552252a@mail.gmail.com>
References: <alpine.LFD.1.00.0801221515350.1741@woody.linux-foundation.org>
	 <4796FBB6.9080609@op5.se> <20080123091558.GP14871@dpotapov.dyndns.org>
	 <4797095F.9020602@op5.se>
	 <e51f66da0801230601n6edd2639lff70415afa9f9026@mail.gmail.com>
	 <4797518A.3040704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Dmitry Potapov" <dpotapov@gmail.com>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Jan 24 14:20:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JI20B-0000J3-Ur
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 14:20:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752706AbYAXNTu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2008 08:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752585AbYAXNTu
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 08:19:50 -0500
Received: from fk-out-0910.google.com ([209.85.128.184]:19802 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbYAXNTt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 08:19:49 -0500
Received: by fk-out-0910.google.com with SMTP id z23so178795fkz.5
        for <git@vger.kernel.org>; Thu, 24 Jan 2008 05:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=KMASYgVjjAnpM3gErHNR9agl5hKtoCxUOdMP/mM93pY=;
        b=DLgFFHEIKvuZ+8v7S0e5rRIfLiL7tcFi5PoAjqUFSgNchdSIXYHaNG2uYTnGgxYdvhzfmivH7JD6gGC2A3VLvu7jsp1j/9znulGviX3QvWOAkXA1U0Iny4Aq+Yd39NK78hhdba81FxsbA1xpf261ycjVEXxIzPjhJXCpoEDGdDM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uII4Kb9MWFhhP0TetjpBbeW9azgnFoAezf3eez+xo4urpNyL/ap3U6jFc5BOFI2RVx5NdeFt0+vK5o0BEbCPTHN/91Z+un4YEIg2vA4K6H1NltJqH4Av77VazllG/qKUJbFYl6rhtYdTsUjO51q8T0uJa++MLIHNLLKcrD00IJo=
Received: by 10.78.201.2 with SMTP id y2mr749905huf.56.1201180786809;
        Thu, 24 Jan 2008 05:19:46 -0800 (PST)
Received: by 10.78.200.6 with HTTP; Thu, 24 Jan 2008 05:19:46 -0800 (PST)
In-Reply-To: <4797518A.3040704@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71616>

On 1/23/08, Andreas Ericsson <ae@op5.se> wrote:
> Marko Kreen wrote:
> > (not lookup3) because lookup3 beat easily all the "simple" hashes
>
> By how much? FNV beat Linus' hash by 0.01 microseconds / insertion,
> and 0.1 microsecons / lookup. We're talking about a case here where
> there will never be more lookups than insertions (unless I'm much
> mistaken).

FNV is around 40% slower than lookup3 on my Intel Core CPU, on 4byte aligned
input. See below for more detailed info.

> > If you don't mind few percent speed penalty compared to Jenkings
> > own optimized version, you can use my simplified version:
> >
> >   http://repo.or.cz/w/pgbouncer.git?a=blob;f=src/hash.c;h=5c9a73639ad098c296c0be562c34573189f3e083;hb=HEAD
>
> I don't, but I don't care that deeply either. On the one hand,
> it would be nifty to have an excellent hash-function in git.
> On the other hand, it would look stupid with something that's
> quite clearly over-kill.

Jenkins hash is fast because it does not look at individual bytes.
If you _do_ want to look at them for unrelated reasons, (case-insensitive,
unicode-juggling), then it obiously loses the point.  That is, if you
want to process the string in one go.

> > It works always with "native" endianess, unlike Jenkins fixed-endian
> > hashlittle() / hashbig().  It may or may not matter if you plan
> > to write values on disk.
> >
> > Speed-wise it may be 10-30% slower worst case (in my case sparc-classic
> > with unaligned data), but on x86, lucky gcc version and maybe
> > also memcpy() hack seen in system.h, it tends to be ~10% faster,
> > especially as it does always 4byte read in main loop.
>
> It would have to be a significant improvement in wall-clock time
> on a test-case of hashing 30k strings to warrant going from 6 to 80
> lines of code, imo. I still believe the original dumb hash Linus
> wrote is "good enough".

Well, ad-hoc dumb hashes may have horrible worst-cases that you cant
see with light testing.  Therefore I'd still suggest some better
researched dumb hash (eg. FNV or OAT).

> On a side-note, it was very interesting reading, and I shall have
> to add jenkins3_mkreen() to my test-suite (although the "keep
> copyright note" license thing bugs me a bit).

Sorry.  I just used template boilerplate.  Considering all the
hard work was done by other people, it not proper to put under
my own license.  I tagged the file as 'public domain' and pushed out.

Btw, the reason I started cleaning lookup3 was that at first I was
scared of the complexity of Jenkins code and decided to go with
Hsieh hash.  Then I found out that Hsieh code is under totally
werdo license (http://www.azillionmonkeys.com/qed/weblicense.html)
so I could not use it.

====================================================================

Here is my raw-speed test of different hashes.  Input is 4-byte
aligned which should be common case for malloc()-ed strings.
This also is best case for original lookup3(), on unaligned
input the memcpy variants beat it easily.  Input string
length varies randomly in range 0..64.

own_memcpy - last 12-byte memcpy() calls out to libc
memcpy_hack - last memcpy is inlined bytewise copy loop:

  while (len--) *dst++ = *src++;

Note that is is raw-speed test, if you benchmark larger code the
hash difference probably matters less.

--------------------------------------------------------------------

Testing: seed=34 align=4 minlen=0 maxlen=64 trycnt=2 duration=10

lookup3 : try=0: ... 247.4880 MB/s
lookup3 : try=1: ... 247.6154 MB/s
own_memcpy: try=0: ... 223.5508 MB/s
own_memcpy: try=1: ... 223.5830 MB/s
memcpy_hack: try=0: ... 241.2241 MB/s
memcpy_hack: try=1: ... 241.2492 MB/s
lookup2 : try=0: ... 190.2697 MB/s
lookup2 : try=1: ... 190.3283 MB/s
fnv     : try=0: ... 153.0318 MB/s
fnv     : try=1: ... 153.0178 MB/s
hsieh   : try=0: ... 234.0468 MB/s
hsieh   : try=1: ... 234.0426 MB/s
oat     : try=0: ... 154.7804 MB/s
oat     : try=1: ... 154.8226 MB/s
elf     : try=0: ... 125.5892 MB/s
elf     : try=1: ... 125.5734 MB/s

Results compared to reference:

lookup3         : 100.000 %
own_memcpy      :  90.311 %
memcpy_hack     :  97.449 %
lookup2         :  76.872 %
fnv             :  61.815 %
hsieh           :  94.544 %
oat             :  62.533 %
elf             :  50.729 %


-- 
marko
