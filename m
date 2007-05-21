From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 1/2] Update the bash prompt from 'applied' instead of the obsolete 'current'
Date: Mon, 21 May 2007 16:17:22 +0100
Message-ID: <b0943d9e0705210817n35e50a6bgb519b693984b3a4b@mail.gmail.com>
References: <20070520204627.GR19253@nan92-1-81-57-214-146.fbx.proxad.net>
	 <20070520211103.17468.21373.stgit@lathund.dewire.com>
	 <20070521074838.GA32510@diana.vm.bytemark.co.uk>
	 <b0943d9e0705210231j75ef2e57o922f7899f4b5814b@mail.gmail.com>
	 <20070521101540.GB32510@diana.vm.bytemark.co.uk>
	 <20070521113915.GA3090@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Robin Rosenberg" <robin.rosenberg@dewire.com>, ydirson@altern.org,
	git@vger.kernel.org
To: "=?ISO-8859-1?Q?Karl_Hasselstr=F6m?=" <kha@treskal.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:17:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hq9dh-0001in-MJ
	for gcvg-git@gmane.org; Mon, 21 May 2007 17:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757380AbXEUPR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 21 May 2007 11:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757946AbXEUPR3
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 11:17:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:51982 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757380AbXEUPR2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2007 11:17:28 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1233544uga
        for <git@vger.kernel.org>; Mon, 21 May 2007 08:17:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lIRfNTsy2T9i3CVb+rKYKCt5T9C7gD2gcqnKuldt+HpQ+1Can1+1NTtZcs7AhqtPJMJc/rYyIB+p770kk3YkWkxUgAa7R2Qoeoeh1te/mTK2y3PNDLT4Y+sV4s6cBQHWBgoSdB2+Yn3kP+ycwmqYpmS1rvhxZXAnKE/bOkiVp9w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pCUF3m/wRUCM90eGbEB2vwTqbABqh9HERjK3QoGJowvVDyLlAuX5qvutJxD/CcCyr5JlkvMxHalaJ9eyJh2U0ST5ilY4VoNAHw9R4XA9CsM+LTHDI+wA12hmUfWphx72bqNJyR/4F12lJ6NjCuU8ch6Gx/Draek5SHhudvX4ltg=
Received: by 10.67.15.15 with SMTP id s15mr3481239ugi.1179760642798;
        Mon, 21 May 2007 08:17:22 -0700 (PDT)
Received: by 10.66.255.6 with HTTP; Mon, 21 May 2007 08:17:22 -0700 (PDT)
In-Reply-To: <20070521113915.GA3090@diana.vm.bytemark.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48022>

On 21/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
> On 2007-05-21 12:15:40 +0200, Karl Hasselstr=F6m wrote:
>
> > We might consider having plumbing written in C or something, and
> > make sure that the plumbing can be called directly if there's need,
> > but it's going to complicate things greatly compared to pure Python=
=2E

Yes, it will complicate things. I think StGIT would have progressed at
a much slower pace if written in C :-).

> What I'm (foggily) envisioning here is to rewrite parts of StGIT (as
> little as possible) as a C library (libstgit.so?), and call the
> library both from the Python code, and from a "plumbing" C program
> (stgit-helper?). We should not try to make the library API stable,
> just like the current git library.

Apart from the start-up time, I don't see other major slowdowns caused
by Python. It would be useful to use a git library directly without
invoking external applications (I'm not sure what's the state of a
"libgit.a" or what improvement we would get).

As for the start-up time, unless you write most of the commands in C,
we would still have to load Python modules. If you run stg-prof
instead of stg for a simple command like 'top', you can see that the
main function takes about 60-70ms, the rest to 150ms reported by the
external 'time' is Python start-up and module loading.

I had a quick try at using "freeze.py" to generate a binary (well, it
includes python bytecodes but it might save time on module look-up)
but it got confused by my optimisation to only load module commands
based on the stg arguments. Maybe we should try this first.

> There are two kinds of things we'd want to have in the library: (1)
> things that are too slow to do in Python, and (2) things that need to
> be available from stgit-helper in order to avoid Python's startup
> cost, such as top/applied/unapplied for the bash completion and bash
> prompt.

As you probably guessed, I'm not really in favour of re-writing parts
of StGIT in C, at least not in the near future, though anyone can fork
and re-implement it :-).

--=20
Catalin
