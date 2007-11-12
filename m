From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Mon, 12 Nov 2007 20:24:09 +1100
Message-ID: <ee77f5c20711120124m6281fddfs9403a46cf354b993@mail.gmail.com>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>
	 <47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se>
	 <7v6409f4eh.fsf@gitster.siamese.dyndns.org>
	 <ee77f5c20711120103s478e26cdib85f38293423d90c@mail.gmail.com>
	 <473818FA.1060400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Andreas Ericsson" <ae@op5.se>,
	"=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Johannes Sixt" <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:25:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVXR-0003i8-E8
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:25:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753209AbXKLJYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 04:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbXKLJYL
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:24:11 -0500
Received: from rv-out-0910.google.com ([209.85.198.189]:19058 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752813AbXKLJYK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 04:24:10 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1120905rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 01:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=LJxIP1eHL0P/feajHSSp2g99R9JIz89rWAFVsyCssYo=;
        b=lCV9Svb23gRsLP+iv+HagjEFykehsRn154loe/OnUWsDLam0cb4hAurSAqhcb4eUzBwKEP4Vi1i1tONqXzhPRRT9aM7FWvDlbjd0GM9bcFyqI4xmnOdHejaPQ4xJjVgQtyufDAHnF7sABqT3kRkrG9SfdP5ahSylhGJsOI3ivXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GcFDH5bRhvMU4mPCA1Df6xQtZXzpDXSlpl+CpKmY1X6MRr7ci4wctNmrX97+QeP20SSX15qCiCrZhi4jlGSxzVylQBOJU3ydOnjAubc6qwbqg1TzKB/hs0ftevFSt5ZYNBRo3VY2VvK1lcIzDt72halZjAdFwfkTnZXKAwFdu7M=
Received: by 10.141.180.5 with SMTP id h5mr2262024rvp.1194859449479;
        Mon, 12 Nov 2007 01:24:09 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Mon, 12 Nov 2007 01:24:09 -0800 (PST)
In-Reply-To: <473818FA.1060400@viscovery.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64581>

On Nov 12, 2007 8:12 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
> David Symonds schrieb:
> > On Nov 11, 2007 9:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> >> @@ -183,7 +183,7 @@ void *gitmemmem(const void *haystack, size_t haystacklen,
> >>                  const void *needle, size_t needlelen);
> >>  #endif
> >>
> >> -#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
> >> +#if !defined(__GLIBC_PREREQ) && !__GLIBC_PREREQ(2, 1)
> >>  #define strchrnul gitstrchrnul
> >>  static inline char *gitstrchrnul(const char *s, int c)
> >>  {
> >
> > I just tested it on my machine (OS X Tiger) now that it's in 'next',
> > and this breaks the build:
> >
> >     CC git.o
> > In file included from builtin.h:4,
> >                  from git.c:1:
> > git-compat-util.h:187:48: error: missing binary operator before token "("
> > make: *** [git.o] Error 1
> >
> >
> > I don't think I have __GLIBC_PREREQ defined anywhere I can find.
>
> Turn the && in that line into || and it should work.

Nope, no dice. Plus, that'd change the logic. I also tried turning the
(!X && !Y) into (X || Y) to no avail.


Dave.
