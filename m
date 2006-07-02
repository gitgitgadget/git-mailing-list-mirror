From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Git.pm: Avoid ppport.h
Date: Sun, 02 Jul 2006 12:05:33 -0700
Message-ID: <7v4pxz4yki.fsf@assigned-by-dhcp.cox.net>
References: <7vodwe5dr8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0606280928540.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0606280938420.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060701234832.GD29115@pasky.or.cz>
	<Pine.LNX.4.63.0607021141260.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sun Jul 02 21:05:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fx7GF-000765-5D
	for gcvg-git@gmane.org; Sun, 02 Jul 2006 21:05:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932717AbWGBTFf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Jul 2006 15:05:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932800AbWGBTFf
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Jul 2006 15:05:35 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:62175 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S932717AbWGBTFf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Jul 2006 15:05:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060702190534.XQYS12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 2 Jul 2006 15:05:34 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23114>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> This makes us not include ppport.h which seems not to give us anything real
>> anyway; it is useful for checking for portability warts but since Devel::PPPort
>> is a portability wart itself, we shouldn't require it for build.
>
> Why do people introduce a "portability enhancer" like that? This is soo 
> dumb.

I think that statement is a bit too harsh.

My understanding is that it's more for use by developers working
with later version to produce portability headers, so used that
way it is very sane.  From its manual page:

       How to use ppport.h

       Don't direct the users of your module to download "Devel::PPPort".
       They are most probably no XS writers. Also, don't make ppport.h
       optional. Rather, just take the most recent copy of ppport.h that you
       can find (e.g. by generating it with the latest "Devel::PPPort" release
       from CPAN), copy it into your project, adjust your project to use it,
       and distribute the header along with your module.

But in the case of source distribution, and if the source
distribution wants to be compatible with older versions, the
above advice does not apply.

> Error: 'const char *' not in typemap in Git.xs, line 69
> Error: 'const char *' not in typemap in Git.xs, line 79
> make: *** [Git.c] Error 1
>
> It seems like my typemap starts like this:
>...
> So, no "const char *". See next mail for a minimal patch.

An alternative would be to carry our own typemap but I think
your fix is less intrusive and fine.  Pasky?

> The warning 
> (IIRC that was mentioned already on the list) still persists:
>
> cc -c -I. -I.. -g -pipe -pipe -fno-common -no-cpp-precomp -flat_namespace 
> -DHAS_TELLDIR_PROTOTYPE -fno-strict-aliasing -Os     -DVERSION=\"0.01\" 
> -DXS_VERSION=\"0.01\"  -I/System/Library/Perl/darwin/CORE -I/sw/include 
> -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR -DNO_STRLCPY 
> -DGIT_VERSION='"1.4.1.g3b26"' Git.c
> In file included from /System/Library/Perl/darwin/CORE/perl.h:500,
>                  from Git.xs:15:
> /System/Library/Perl/darwin/CORE/embed.h:156:1: warning: "die" redefined
> Git.xs:11:1: warning: this is the location of the previous definition

I see the same here.
