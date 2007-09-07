From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String   Library.
Date: Fri, 07 Sep 2007 21:31:11 +0200
Message-ID: <85wsv22ry8.fsf@lola.goethe.zz>
References: <46DDC500.5000606@etek.chalmers.se>
	<1189004090.20311.12.camel@hinata.boston.redhat.com>
	<vpq642pkoln.fsf@bauges.imag.fr>
	<4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
	<alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
	<a1bbc6950709061721r537b153eu1b0bb3c27fb7bd51@mail.gmail.com>
	<alpine.LFD.0.999.0709070135361.5626@evo.linux-foundation.org>
	<alpine.LFD.0.999.0709070203200.5626@evo.linux-foundation.org>
	<fbqmdu$udg$1@sea.gmane.org> <20070907094120.GA27754@artemis.corp>
	<fbs79k$tac$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Walter Bright <boost@digitalmars.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 21:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITjY3-0002D9-Nz
	for gcvg-git@gmane.org; Fri, 07 Sep 2007 21:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932750AbXIGTbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Sep 2007 15:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752110AbXIGTbS
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Sep 2007 15:31:18 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:50459 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751996AbXIGTbS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Sep 2007 15:31:18 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id C1AFD31ED8E;
	Fri,  7 Sep 2007 21:31:16 +0200 (CEST)
Received: from mail-in-07.arcor-online.net (mail-in-07.arcor-online.net [151.189.21.47])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id B133A4B5;
	Fri,  7 Sep 2007 21:31:16 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-039-212.pools.arcor-ip.net [84.61.39.212])
	by mail-in-07.arcor-online.net (Postfix) with ESMTP id 8CD8E292B61;
	Fri,  7 Sep 2007 21:31:12 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 2295D1CAD71D; Fri,  7 Sep 2007 21:31:12 +0200 (CEST)
In-Reply-To: <fbs79k$tac$1@sea.gmane.org> (Walter Bright's message of "Fri\, 07 Sep 2007 12\:03\:24 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.2/4179/Fri Sep  7 18:47:56 2007 on mail-in-07.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58060>

Walter Bright <boost@digitalmars.com> writes:

> There are a lot of people hard at work on D to make it more stable
> and increase the breadth and depth of tools available. I am fully
> aware that there may be non-technical issues to using D in a project
> like git, like availability of other D programmers, tradition, etc.,
> but in this thread I'm concerned mainly with technical issues.
>
> P.S. I'm also NOT suggesting that git be converted to D. Translating
> a working, debugged, 80,000 line codebase from one language to
> another is usually a fool's errand.

In my opinion there is basically one area which C has botched up
seriously in order to be useful as a general purpose language, and
that is conflating pointers and arrays, and allowing pointer
arithmetic.  The consequences are absolutely awful with regard to
compilers being able to optimize, and it is pretty much the primary
reason that Fortran is still quite in use for numerical work.

C has no usable two-dimensional (never mind higher dimensions) array
concept that would allow passing multidimensional arrays of
runtime-determined size into functions.  Period.

Add to that the pointer aliasing problems affecting compilers, and C
is useless for serious portable readable numerical work.

Fortran libraries like blas and lapack are ubiquitous after decades
because the language can deal with multiple-dimension arrays sensibly,
and could do so in the sixties already.

C99 helps a bit.  But messing around with restrict pointers and
similar means that to wring equal performance out of some trivial code
piece (or permitting the compiler to do so without having to take
aliasing into account) is a lot of work and leads to ugly and
inscrutable code.

That's the one thing that has seriously hampered C: the lack of a true
array type on its own, decoupled from pointers.  It does not need to
carry its dimensions with it or other
hide-the-implementation-from-the-programmer niceties: C is, after all,
a low-level language, and Fortran did not suffer from not having array
dimensions packed into the arrays as well.

But that's water down the drawbridge.  This single major deficiency is
not anything that would hamper git development.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
