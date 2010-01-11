From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH] Threaded grep (was: Re: [PATCH] grep: do not do external 
	grep on skip-worktree entries)
Date: Mon, 11 Jan 2010 11:42:55 +0100
Message-ID: <4c8ef71001110242m160a63a8wd0294c0f26373c2e@mail.gmail.com>
References: <20100108174949.12458.10873.stgit@fredrik-laptop>
	 <alpine.LFD.2.00.1001080956270.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: peff@peff.net, gitster@pobox.com, miles@gnu.org, pclouds@gmail.com,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 11 11:43:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NUHjm-00074C-GF
	for gcvg-git-2@lo.gmane.org; Mon, 11 Jan 2010 11:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062Ab0AKKm7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jan 2010 05:42:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959Ab0AKKm7
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jan 2010 05:42:59 -0500
Received: from mail-fx0-f215.google.com ([209.85.220.215]:62072 "EHLO
	mail-fx0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814Ab0AKKm6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jan 2010 05:42:58 -0500
Received: by fxm7 with SMTP id 7so19598443fxm.29
        for <git@vger.kernel.org>; Mon, 11 Jan 2010 02:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JluC0rtTqStNVaum+hsSsYuNbESmcHomvIMiRF4lIw0=;
        b=O1s2UVGYwNbQ+UYmaOc0RgK33eP6rhmfwsBwahLaadZq2+4w236orfwedmitLB6c/E
         eElYQLwDhyL6X4jKcm452bh+nhKKw+LMGJNbhWGjk+vXasO7bklQr6p3Vks5l1kQNy3u
         /p30t2mc7vdVQVmlQBpJ101Lj9AL7Zz3crxq4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=YhqSvcJ2OqWo0xOOek8twpCO68UOQOXlEOnoXvL7nzUbmLY+0yPHcklepwEyzK+fNN
         r7rmc/4Y9fM9TdXxpScib1qVSUtAsATr6CTAYDCbqpBPLTtgmo58MIbgy3wt+6QefPBX
         KE7RcDWt1f9FqSStlTIXk2NfjyUK9AxrerN8s=
Received: by 10.239.196.130 with SMTP id v2mr1189269hbi.207.1263206576967; 
	Mon, 11 Jan 2010 02:42:56 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.1001080956270.7821@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136631>

[I messed up the Cc list when I sent the first mail in this thread, so
it didn't reach git@vger. This time it's fixed for real. Sorry for the
extra copy.]

On Fri, Jan 8, 2010 at 19:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>
> On Fri, 8 Jan 2010, Fredrik Kuivinen wrote:
>>
>> I only have access to a couple of boxes with more than one core so
>> some more testing would be greatly appreciated. On the boxes I have
>> tested this on the added parallelism roughly cut the time to grep th=
e
>> linux kernel in half (compared to the built-in grep). It also compar=
es
>> favourably to the external GNU grep (these are best of three runs):
>
> On my box (in all cases best-of-five):
>
> =A0- "NO_THREADS=3D1 git grep --no-ext-grep qwerty":
>
> =A0 =A0 =A0 =A0real =A0 =A00m0.945s
> =A0 =A0 =A0 =A0user =A0 =A00m0.808s
> =A0 =A0 =A0 =A0sys =A0 =A0 0m0.128s
>
> =A0- "git grep --no-ext-grep qwerty":
>
> =A0 =A0 =A0 =A0real =A0 =A00m0.402s
> =A0 =A0 =A0 =A0user =A0 =A00m1.116s
> =A0 =A0 =A0 =A0sys =A0 =A0 0m0.216s
>
> =A0- "git grep qwerty":
>
> =A0 =A0 =A0 =A0real =A0 =A00m0.408s
> =A0 =A0 =A0 =A0user =A0 =A00m0.176s
> =A0 =A0 =A0 =A0sys =A0 =A0 0m0.152s
>
> so it _just_ beat the external grep thanks to using 330% CPU time. An
> improvement, yes, but the CPU wastage is kind of sad. It really would=
 be
> nice to see if we could get rid of the stupid per-line overhead some =
way.

I agree. The per-line thing seems to be fixed with Junios recent patch.

> Btw, there does seem to be some unnecessary synchronization there, be=
cause
> if I pick a pattern that has no matches at all, my best parallel numb=
er
> goes down to 0.316. But the variation in times for the parallel one i=
s so
> big that I don't know how relevant that all is.
>
> I suspect you need more threads than CPU's due to the waiting (so tha=
t
> other threads can pick up the slack when one thread ends up waiting t=
o
> output). Or don't wait at all, and queue it up instead.

Yes, you are right, there is some unnecessary synchronization. I am
working on a new patch which queues the output instead.

- Fredrik
