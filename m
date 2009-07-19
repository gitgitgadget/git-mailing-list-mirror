From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: [PATCH] Re: configure: use AC_SEARCH_LIBS instead of AC_CHECK_LIB
Date: Sun, 19 Jul 2009 15:14:04 +0200
Message-ID: <20090719131404.GA11546@vidovic>
References: <m34ot9c67t.fsf_-_@localhost.localdomain> <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	David Syzdek <david@syzdek.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Sun Jul 19 15:14:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSWDb-0006pV-Fr
	for gcvg-git-2@gmane.org; Sun, 19 Jul 2009 15:14:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754282AbZGSNON (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jul 2009 09:14:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753603AbZGSNOM
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jul 2009 09:14:12 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:49382 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417AbZGSNOL (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jul 2009 09:14:11 -0400
Received: by ewy26 with SMTP id 26so1770980ewy.37
        for <git@vger.kernel.org>; Sun, 19 Jul 2009 06:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=OJ0gixNkoYyFt222TtOg5JUEzKCD6nnbK1djokZwuLc=;
        b=pfMuU+DCrgwV28D+nt8E78hacfMsR425Tkj8I2EBgE0tQlgn9AzLimcAcu1v+Nu47C
         EuNpj2Ph0LU+lhiltO5IqFsBAJ4xdTZ3EPZ0yiErTR7WpCilGvw+3998NBLqMm9R+/Bc
         upaISGIUadWUpg7Cf7wStGLs8oL1hBD0NtWpM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=KQPlKqgSjDscwg6PC07j6dkmDpAxvVP9zOp/4T/MuNBCljoxReRufG7FGwAmsoWs7D
         IGPIs4TP+arY5MDf6JDpfh+xfKrQquFffI0TMpKXuaIjGYue2fWdt6P+9b4f1Xzhx8PQ
         9/0b+grK/SVKNMr/U1LwIu3Jlu+u2P4MV5IMU=
Received: by 10.210.131.6 with SMTP id e6mr2311460ebd.29.1248009249223;
        Sun, 19 Jul 2009 06:14:09 -0700 (PDT)
Received: from @ (91-165-140-71.rev.libertysurf.net [91.165.140.71])
        by mx.google.com with ESMTPS id 24sm8232867eyx.23.2009.07.19.06.14.06
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 19 Jul 2009 06:14:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <a52be8ba36206abc5ff5c91a759036a931e2658c.1248007036.git.nicolas.s.dev@gmx.fr>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123552>

The 19/07/09, Nicolas Sebrecht wrote:
> 
> > and when I did "rm configure ; make configure ; ./configure"
> > it gave me
> > 
> >   NO_LIBGEN_H=
> >   NEEDS_RESOLV=
> > 
> >   SNPRINTF_RETURNS_BOGUS=UnfortunatelyYes
> > 
> > I have tried to find which commit introduced this regression.
> > 
> >  $ git bisect start origin v1.6.3 v1.6.3.2 -- configure.ac config.mak.in
> >  $ git bisect run ~/git/test.sh
> > 
> > finds ecc395c (Makefile: add NEEDS_LIBGEN to optionally add -lgen to
> > compile arguments, 2009-07-10) as a first bad commit.  But I don't see
> > how it could have changed it... Strange...

The wrong check of lib gen added a flag ' -lgen' to $LIBS (in configure).
This wrong flag then gave:

 [...]/bin/ld: cannot find -lgen collect2: ld returned 1 exit status

which made wrongly fail the next compilation test (using $LIBS).

> > CC-ed Brandon Casey, author of blamed changeset, and David Syzdek who
> > offered at some time help with maintaining autoconf.
> 
> Thank you, I did the same investigation here. :-)

I wonder if we could have some feedbacks on this patch. The change on
the whole file may make more bad than good. Works as expected here on
Linux (glibc 2.9).

Otherwise, the following lines are sufficient to correct the original
error:

>  test -n "$NEEDS_RESOLV" && LIBS="$LIBS -lresolv"
>  
> -AC_CHECK_LIB([gen], [basename],
> +AC_SEARCH_LIBS([basename], [gen],
>  [NEEDS_LIBGEN=],
>  [NEEDS_LIBGEN=YesPlease])
>  AC_SUBST(NEEDS_LIBGEN)

-- 
Nicolas Sebrecht
