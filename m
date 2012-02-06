From: Nicholas Harteau <nrh@ikami.com>
Subject: Re: [PATCH] perl/Makefile: use 'installsitelib' even with NO_PERL_MAKEMAKER
Date: Mon, 6 Feb 2012 15:30:54 -0500
Message-ID: <9D199309-85A6-42EE-9417-8C4E61534670@spotify.com>
References: <24482D02-B773-4FE3-8FC7-92B8B4D8C0FA@spotify.com> <7328033C-8A11-452D-A927-E81E2DC4ABD6@spotify.com> <20120206202610.GC30776@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 06 21:31:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuVDK-0001K9-RY
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 21:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755542Ab2BFUa6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 15:30:58 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:54675 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753620Ab2BFUa6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 15:30:58 -0500
Received: by qafk1 with SMTP id k1so3860951qaf.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 12:30:57 -0800 (PST)
Received: by 10.229.76.9 with SMTP id a9mr7197247qck.76.1328560257308;
        Mon, 06 Feb 2012 12:30:57 -0800 (PST)
Received: from [10.40.0.191] ([152.179.155.2])
        by mx.google.com with ESMTPS id el3sm35874422qab.8.2012.02.06.12.30.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 12:30:56 -0800 (PST)
In-Reply-To: <20120206202610.GC30776@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190098>

On Feb 6, 2012, at 3:26 PM, Jeff King wrote:

> On Mon, Feb 06, 2012 at 02:38:20PM -0500, Nicholas Harteau wrote:
> 
>>> perl/Makefile installs Git.pm into $prefix/lib when ExtUtils::MakeMaker
>>> is not present.  perl can't "use Git;" in that scenario, as $prefix/lib
>>> isn't in perl's include path.
>>> 
>>> This patch installs Git.pm into perl's 'installsitelib', generally
>>> $prefix/lib/perl5/site_perl, so that even when ExtUtils::MakeMaker isn't
>>> present, Git.pm gets installed in a location where 'use Git;' just
>>> works.
>> [...]
>>> ifdef NO_PERL_MAKEMAKER
>>> -instdir_SQ = $(subst ','\'',$(prefix)/lib)
>>> +instdir_SQ = $(subst ','\'',$(subst installsitelib=,'',$(shell $(PERL_PATH_SQ) -V:installsitelib)))
> 
> Isn't this a regression if I am a non-root user installing into
> $HOME/local or similar? With MakeMaker, I end up with this in my
> perl.mak:
> 
>  PREFIX = /home/peff/local
>  ...
>  SITEPREFIX = $(PREFIX)
>  ...
>  INSTALLSITELIB = $(SITEPREFIX)/share/perl/5.14.2
> 
> which works great.  Before your patch, without MakeMaker, git would
> install into /home/peff/local/lib, which is also OK. But with your
> patch, it will try:
> 
>  $ perl -V:installsitelib
>  installsitelib='/usr/local/share/perl/5.14.2';
> 
> which is not writable by me, and the install will fail.
> 
> I know it's more convenient for some uses, because we know that
> installsitelib will be in perl's @INC. But git has always installed out
> of the box for non-root users, and I don't think we want to change that.


Totally correct - let me re-think the non-root case.  Thanks.



--
Nicholas Harteau
nrh@spotify.com
