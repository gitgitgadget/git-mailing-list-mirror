From: Gerrit Pape <pape@smarden.org>
Subject: Re: [PATCH/rfc] git-svn.perl: workaround assertions in svn library
	1.5.0
Date: Thu, 17 Jul 2008 14:08:56 +0000
Message-ID: <20080717140856.10213.qmail@c0f13986110104.315fe32.mid.smarden.org>
References: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Thu Jul 17 16:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJUAd-0006VB-7e
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 16:09:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754795AbYGQOIZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 10:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755298AbYGQOIY
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 10:08:24 -0400
Received: from a.ns.smarden.org ([212.42.242.37]:52803 "HELO a.mx.smarden.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754401AbYGQOIY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 10:08:24 -0400
Received: (qmail 10214 invoked by uid 1000); 17 Jul 2008 14:08:56 -0000
Content-Disposition: inline
In-Reply-To: <20080706192850.32547.qmail@4480698c45f1ed.315fe32.mid.smarden.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88855>

On Sun, Jul 06, 2008 at 07:28:50PM +0000, Gerrit Pape wrote:
> With subversion 1.5.0 (C and perl libraries) the git-svn selftest
> t9101-git-svn-props.sh fails at test 25 and 26.  The following commands

> The breakage was reported by Lucas Nussbaum through
>  http://bugs.debian.org/489108

> ---
>  git-svn.perl |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> I ran into this on Debian/unstable.  With svn 1.5.0 the selftest fails
> without the patch, with svn 1.4.6 it succeeds with and without the
> patch.  I'm not familar with the svn interfaces, not sure whether this
> is a regression in subversion, or a bug in git-svn.

Hi, while this commit fixed the selftests, it unfortunately is a
regression

 http://thread.gmane.org/gmane.comp.version-control.git/87822/
 http://bugs.debian.org/490400

I'm still not sure whether this is a git-svn problem, or actually a
problem in subversion 1.5.0

 $ perl -MSVN::Client -e \
 'sub print_names { print "<$_[0]>\n"; } $ctx=new SVN::Client;
 $ctx->status(".", "BASE", \&print_names, 1, 1, 0, 1);' | head -5
 perl:
 /build/buildd/subversion-1.5.0dfsg1/subversion/libsvn_subr/path.c:119: svn_path_join: Assertion `is_canonical(base, blen)' failed.
 $ 
 [0]

Regards, Gerrit.

[0] http://bugs.debian.org/359679
