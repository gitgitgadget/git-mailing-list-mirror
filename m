From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tree with leading '0' modes in 1.7.0.3
Date: Sat, 27 Mar 2010 12:14:05 -0700
Message-ID: <20100327191405.GF10910@spearce.org>
References: <20100326230537.GC10910@spearce.org> <7v7hoyabiv.fsf@alter.siamese.dyndns.org> <32541b131003261656h430d77a8q753c6141297e8f86@mail.gmail.com> <4BAD4A82.5070703@gmail.com> <20100327012211.GD10910@spearce.org> <alpine.LFD.2.00.1003262125120.694@xanadu.home> <20100327013443.GE10910@spearce.org> <alpine.LFD.2.00.1003262142121.694@xanadu.home> <d411cc4a1003270544l43f2f93dq5006efb737aa7bbc@mail.gmail.com> <alpine.LFD.2.00.1003270959110.694@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Scott Chacon <schacon@gmail.com>,
	"Mike.lifeguard" <mike.lifeguard@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Sat Mar 27 20:14:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvbSg-0007Op-Qq
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 20:14:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753835Ab0C0TOL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 15:14:11 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:44548 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753829Ab0C0TOK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 15:14:10 -0400
Received: by gwaa18 with SMTP id a18so3269815gwa.19
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 12:14:09 -0700 (PDT)
Received: by 10.100.235.26 with SMTP id i26mr4614401anh.65.1269717249807;
        Sat, 27 Mar 2010 12:14:09 -0700 (PDT)
Received: from localhost (george.spearce.org [209.20.77.23])
        by mx.google.com with ESMTPS id 21sm2083944iwn.11.2010.03.27.12.14.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 12:14:07 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1003270959110.694@xanadu.home>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143343>

Nicolas Pitre <nico@fluxnic.net> wrote:
> On Sat, 27 Mar 2010, Scott Chacon wrote:
> > > My stance has always been that the C Git is authoritative with regards to
> > > formats and protocols. ??It's up to Github to fix their screw-up.
> > 
> > It is fixed and will be deployed soon, but really, there is no reason
> > to be snippy.  It is a simple and minor mistake effecting very few
> > repositories (maybe 100 out of 730k)

What is the C Git stance on these 100 repositories then?  Are they
now considered corrupt?  Or is 100 enough in the wild that we have
to accept the problem, just like we accept the 10664 mode issue from
"ancient" Linux?

I would love to say "those are corrupt, sorry, fix your repository".

But we have traditionally tried to help our users, and not cause
them pain.  Forcing a rewrite on these 100 projects to fix up the
corruption is going to be painful for them.  

> > , and the only reason it's an
> > issue at all is that JGit is not following the authoritative CGit
> > implementation of basically ignoring it.
> 
> But again CGit's fsck is not ignoring this discrepancy.  And if the CGit 
> core is otherwise silently accepting it then it is a mistake.

Right.  I tend to agree.  CGit was too lax here, fsck shouldn't
be issuing a warning, it should be a fatal error.  Both CGit and
JGit are too lax by not failing when reading that tree during
normal processing.
 
> > Also, if we're all concerned about "Git reimplementation du jour"
> > deviations, then we need to focus on libifying Git so there isn't a
> > need for such re-implementations.  I'm hoping to help with a possible
> > GSoC project on libgit2, but the lack of a linkable library will
> > ensure that re-implementations in nearly every useful language will
> > continue.
> 
> Don't get me wrong.  I'm not against Git reimplementations per se, as 
> long as they rigorously implement the exact format and protocol from 
> CGit.  In that sense it is important that the CGit fsck and verify-pack 
> tools be exploited on objects/packs produced by alternate Git 
> implementation systematically to find such issues.

When JGit had the tree sort order wrong, JGit was in the wrong,
and any repository which contained those corrupt trees had to be
fixed by rewriting them.  IIRC it was only the JGit repository
itself that had this problem in the wild.  But we fixed our code.

IMHO, this leading '0' thing is a similar breakage.  We shouldn't
relax CGit or JGit to accept it just because the Ruby implementation
of Git got the tree encoding wrong.  If anything, we should teach
these implementations to catch these sorts of problems earlier.

-- 
Shawn.
