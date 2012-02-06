From: Nicholas Harteau <nrh@ikami.com>
Subject: Re: [PATCH] perl/Makefile: use 'installsitelib' even with NO_PERL_MAKEMAKER
Date: Mon, 6 Feb 2012 14:38:20 -0500
Message-ID: <7328033C-8A11-452D-A927-E81E2DC4ABD6@spotify.com>
References: <24482D02-B773-4FE3-8FC7-92B8B4D8C0FA@spotify.com>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 06 20:38:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuUOS-0007it-HB
	for gcvg-git-2@plane.gmane.org; Mon, 06 Feb 2012 20:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752906Ab2BFTiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 14:38:23 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:53814 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751337Ab2BFTiW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Feb 2012 14:38:22 -0500
Received: by qcqw6 with SMTP id w6so3597003qcq.19
        for <git@vger.kernel.org>; Mon, 06 Feb 2012 11:38:22 -0800 (PST)
Received: by 10.229.136.144 with SMTP id r16mr7190991qct.62.1328557101876;
        Mon, 06 Feb 2012 11:38:21 -0800 (PST)
Received: from [10.40.0.191] ([152.179.155.2])
        by mx.google.com with ESMTPS id m20sm35572282qaj.14.2012.02.06.11.38.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 06 Feb 2012 11:38:21 -0800 (PST)
In-Reply-To: <24482D02-B773-4FE3-8FC7-92B8B4D8C0FA@spotify.com>
X-Mailer: Apple Mail (2.1257)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190089>

This is a boring patch, I know, but it affects anyone doing a vanilla git installation on an os that bundles perl but not ExtUtils::MakeMaker, which is quite common.  Git's own utilities in perl can use Git.pm, but any other perl programs will fail to 'use Git;'

Any takers?

On Jan 30, 2012, at 11:51 AM, Nicholas Harteau wrote:

> perl/Makefile installs Git.pm into $prefix/lib when ExtUtils::MakeMaker
> is not present.  perl can't "use Git;" in that scenario, as $prefix/lib
> isn't in perl's include path.
> 
> This patch installs Git.pm into perl's 'installsitelib', generally
> $prefix/lib/perl5/site_perl, so that even when ExtUtils::MakeMaker isn't
> present, Git.pm gets installed in a location where 'use Git;' just
> works.
> 
> for some additional discussion, see:
> https://github.com/mxcl/homebrew/pull/8643
> https://github.com/mxcl/homebrew/issues/8620
> ---
> perl/Makefile |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/perl/Makefile b/perl/Makefile
> index b2977cd..2199eb1 100644
> --- a/perl/Makefile
> +++ b/perl/Makefile
> @@ -21,7 +21,7 @@ clean:
> 	$(RM) $(makfile).old
> 
> ifdef NO_PERL_MAKEMAKER
> -instdir_SQ = $(subst ','\'',$(prefix)/lib)
> +instdir_SQ = $(subst ','\'',$(subst installsitelib=,'',$(shell $(PERL_PATH_SQ) -V:installsitelib)))
> $(makfile): ../GIT-CFLAGS Makefile
> 	echo all: private-Error.pm Git.pm > $@
> 	echo '	mkdir -p blib/lib' >> $@
> -- 
> 1.7.8.3
> 
> --
> nicholas harteau
> nrh@spotify.com
> 
> 
> 
> 

--
nicholas harteau
nrh@spotify.com
