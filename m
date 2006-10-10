From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: rpmbuild fails
Date: Wed, 11 Oct 2006 00:18:18 +0200
Message-ID: <200610110018.19035.Josef.Weidendorfer@gmx.de>
References: <pan.2006.10.10.20.31.48.692444@alarsen.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Oct 11 00:19:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXPwY-0007aR-F6
	for gcvg-git@gmane.org; Wed, 11 Oct 2006 00:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030592AbWJJWSc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Oct 2006 18:18:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030590AbWJJWSb
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Oct 2006 18:18:31 -0400
Received: from mail.gmx.de ([213.165.64.20]:53130 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030594AbWJJWSV (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Oct 2006 18:18:21 -0400
Received: (qmail invoked by alias); 10 Oct 2006 22:18:20 -0000
Received: from p5496AE33.dip0.t-ipconnect.de (EHLO noname) [84.150.174.51]
  by mail.gmx.net (mp027) with SMTP; 11 Oct 2006 00:18:20 +0200
X-Authenticated: #352111
To: Anders Larsen <al@alarsen.net>
User-Agent: KMail/1.9.3
In-Reply-To: <pan.2006.10.10.20.31.48.692444@alarsen.net>
Content-Disposition: inline
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28678>

On Tuesday 10 October 2006 22:31, Anders Larsen wrote:
> The current git fails when building rpms:
> 
> 	RPM build errors:
> 	    Installed (but unpackaged) file(s) found:
> 	   /usr/lib/perl5/vendor_perl/5.8.6/Git.pm

I got the same.
I'm no rpm guru, but changing %{perl_vendorarch} into
%{perl_vendorlib} in git.spec.in helped for me.

Obviously, the generated perl/Makefile installs Git.pm
into the perl vendor *library* directory, and not the arch
one.

I do not provide a real patch, as I have no idea if
this is really the correct fix (we have no arch-dependent
perl files anymore, yes?).

However, something like the above should go into git-1.4.3.

> Indeed git.spec.in does not specify any files for perl-Git, only
> 	%files -n perl-Git -f perl-files
> 	%defattr(-,root,root)
> nothing more.

Hmm... Obviously the "... -f perl-files" includes all files
mentioned in file "perl-files" into perl-Git. The problem was
that without the above change this file was empty.

Josef
