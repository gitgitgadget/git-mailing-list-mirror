From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: [PATCH] Simplify strchrnul() compat code
Date: Mon, 12 Nov 2007 20:03:33 +1100
Message-ID: <ee77f5c20711120103s478e26cdib85f38293423d90c@mail.gmail.com>
References: <4733AEA0.1060602@lsrfire.ath.cx> <473434ED.50002@op5.se>
	 <47359C44.6090903@lsrfire.ath.cx> <4735BA79.5020102@op5.se>
	 <7v6409f4eh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Andreas Ericsson" <ae@op5.se>,
	"=?ISO-8859-1?Q?Ren=E9_Scharfe?=" <rene.scharfe@lsrfire.ath.cx>,
	"Pierre Habouzit" <madcoder@debian.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Jakub Narebski" <jnareb@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 12 10:03:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrVCy-0006uC-M8
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 10:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755454AbXKLJDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Nov 2007 04:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbXKLJDf
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 04:03:35 -0500
Received: from rv-out-0910.google.com ([209.85.198.187]:52751 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbXKLJDd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Nov 2007 04:03:33 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1117006rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 01:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=CVtm17TYNSXwTwNHGh/Noe/eupkSXzC9cMGwJCjERRA=;
        b=JHklaEeeWtgehnVv3BZ7bJjhTulfcxCcjwwscoJq7ZW0/2LSyqwz25m/LAxQYBwkQrLTYng5SdlcpSrhbQNDumgL5mXAOYUStmCpNtlEzUeNQ8Sbk8rVBc9c9SdgPGsguFTr28vTawEKeN6/DBfGZXiFHLj8sYYoA9O3b5LwtJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Xz6KqZeTklRLOmSOLNYtZgH3kUPLZGUTPtSuXoPadpkiK0fW2yiLbkr+oqLyvEBZcnFmUCKxOY2prnte4G0t6AKYhfxLsz8HyeELkh2oqtSktaDRdkd0EtB00vYr604z1qojRTT85SUFnsNc0+aPxLjCxqTpH23L/aMsA0lVNK8=
Received: by 10.140.136.6 with SMTP id j6mr2277884rvd.1194858213266;
        Mon, 12 Nov 2007 01:03:33 -0800 (PST)
Received: by 10.141.20.13 with HTTP; Mon, 12 Nov 2007 01:03:33 -0800 (PST)
In-Reply-To: <7v6409f4eh.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64578>

On Nov 11, 2007 9:44 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Andreas Ericsson <ae@op5.se> writes:
>
> > Ren=E9 Scharfe wrote:
> >>  -#ifdef NO_STRCHRNUL
> >> +#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
> >
> > This will break things for users of glibc-2.1.1 (the first release =
still
> > available from ftp://sources.redhat.com/pub/glibc/old-releases that
> > includes the strchrnul() function), since __GLIBC_PREREQ() was inve=
nted
> > after strchrnul() was introduced.
> >
> > Replacing __GLIBC__ with __GLIBC_PREREQ (as in the original patch) =
will
> > solve it nicely. Users of glibc-2.1.1 will be the odd minority wher=
e
> > strchrnul() is available in their libc but not used.
>
> Do you mean this on top of Ren=E9's patch?  Although I do not
> think I saw "the original patch" that did it this way, I think
> it makes sense.
>
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 11e6df6..dd96f7a 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -183,7 +183,7 @@ void *gitmemmem(const void *haystack, size_t hays=
tacklen,
>                  const void *needle, size_t needlelen);
>  #endif
>
> -#if !defined(__GLIBC__) && !__GLIBC_PREREQ(2, 1)
> +#if !defined(__GLIBC_PREREQ) && !__GLIBC_PREREQ(2, 1)
>  #define strchrnul gitstrchrnul
>  static inline char *gitstrchrnul(const char *s, int c)
>  {

I just tested it on my machine (OS X Tiger) now that it's in 'next',
and this breaks the build:

    CC git.o
In file included from builtin.h:4,
                 from git.c:1:
git-compat-util.h:187:48: error: missing binary operator before token "=
("
make: *** [git.o] Error 1


I don't think I have __GLIBC_PREREQ defined anywhere I can find.

Dave.
