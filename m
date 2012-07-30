From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH 6/7] Switch path canonicalization to use the SVN API.
Date: Mon, 30 Jul 2012 20:04:44 +0000
Message-ID: <20120730200444.GB20137@dcvr.yhbt.net>
References: <1343468312-72024-1-git-send-email-schwern@pobox.com>
 <1343468312-72024-7-git-send-email-schwern@pobox.com>
 <20120728135502.GC9715@burratino>
 <5014387C.50903@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, robbat2@gentoo.org, bwalton@artsci.utoronto.ca
To: Michael G Schwern <schwern@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 22:04:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvwCx-0000uW-D0
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 22:04:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754709Ab2G3UEp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 16:04:45 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:56405 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754284Ab2G3UEp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 16:04:45 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76B441F449;
	Mon, 30 Jul 2012 20:04:44 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <5014387C.50903@pobox.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202608>

Michael G Schwern <schwern@pobox.com> wrote:
> On 2012.7.28 6:55 AM, Jonathan Nieder wrote:
> > Michael G. Schwern wrote:
> >> --- a/perl/Git/SVN/Utils.pm
> >> +++ b/perl/Git/SVN/Utils.pm
> >> @@ -86,6 +86,27 @@ sub _collapse_dotdot {
> >>  
> >>  
> >>  sub canonicalize_path {
> >> +	my $path = shift;
> >> +
> >> +	# The 1.7 way to do it
> >> +	if ( defined &SVN::_Core::svn_dirent_canonicalize ) {
> >> +		$path = _collapse_dotdot($path);
> >> +		return SVN::_Core::svn_dirent_canonicalize($path);
> >> +	}
> >> +	# The 1.6 way to do it
> >> +	elsif ( defined &SVN::_Core::svn_path_canonicalize ) {
> >> +		$path = _collapse_dotdot($path);
> >> +		return SVN::_Core::svn_path_canonicalize($path);
> >> +	}
> >> +	# No SVN API canonicalization is available, do it ourselves
> >> +	else {
> > 
> > When would this "else" case trip?
> 
> When svn_path_canonicalize() does not exist in the SVN API, presumably because
> their SVN is too old.
> 
> 
> > Would it be safe to make it
> > return an error message, or even to do something like the following?
> 
> I don't know what your SVN backwards compat requirements are, or when
> svn_path_canonicalize() appears in the API, so I left it as is.  git-svn's
> home rolled path canonicalization worked and its no work to leave it working.
>  No reason to break it IMO.

I agree there's no reason to break something on older SVN.

git-svn should work with whatever SVN is in CentOS 5.x and similar
distros (SVN 1.4.2).  As long as an active "long-term" distro supports
a version of SVN, I think we should support that if it's not too
difficult.
