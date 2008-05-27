From: Nikolaus Schulz <microschulz@web.de>
Subject: Re: [PATCH] git-svn fails in prop_walk if $self->{path} is not empty
Date: Wed, 28 May 2008 00:54:02 +0200
Message-ID: <20080527225402.GA25550@penelope.zusammrottung.local>
References: <20080527162002.GA21855@penelope.zusammrottung.local> <20080527084655.20379.qmail@5bba46d46c095e.315fe32.mid.smarden.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 00:55:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K184W-0001B6-N5
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 00:55:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758880AbYE0WyO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 May 2008 18:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758732AbYE0WyN
	(ORCPT <rfc822;git-outgoing>); Tue, 27 May 2008 18:54:13 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:54840 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758349AbYE0WyM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 May 2008 18:54:12 -0400
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate01.web.de (Postfix) with ESMTP id C3DE1E132FA9
	for <git@vger.kernel.org>; Wed, 28 May 2008 00:54:05 +0200 (CEST)
Received: from [83.125.40.75] (helo=tunichtgut.zusammrottung.local)
	by smtp07.web.de with asmtp (TLSv1:AES256-SHA:256)
	(WEB.DE 4.109 #226)
	id 1K183R-0007Aw-00
	for git@vger.kernel.org; Wed, 28 May 2008 00:54:05 +0200
Received: from penelope.zusammrottung.local ([192.168.178.202])
	by tunichtgut.zusammrottung.local with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1K183Q-00087C-0P
	for git@vger.kernel.org; Wed, 28 May 2008 00:54:04 +0200
Received: from nikolaus by penelope.zusammrottung.local with local (Exim 4.63)
	(envelope-from <nikolaus@penelope.zusammrottung.local>)
	id 1K183O-0006eJ-R4
	for git@vger.kernel.org; Wed, 28 May 2008 00:54:02 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080527084655.20379.qmail@5bba46d46c095e.315fe32.mid.smarden.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Sender: microschulz@web.de
X-Provags-ID: V01U2FsdGVkX1/KgiEJQq4rEcCNwp0oOkr2j3WvIq9jDj4r4WMt
	x9HRDI0hbNRUnhStn8tRZP8WQyecdupf+V33J2gMnmipYwKn4C
	2cDNvBoyc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83057>

Happy coincidence!

This patch happens to fix my problem posted in "git-svn
{show,create}-ignore chokes upon subdirs" today. 

Nikolaus

On Tue, May 27, 2008 at 08:46:55AM +0000, Gerrit Pape wrote:
> From: Christian Engwer <christi@uni-hd.de>
> 
> The problem now is that prop_walk strips trunk from the path and then
> calls itself recursively. But now trunk is missing in the path and
> get_dir fails, because it is called for a non existing path.
> 
> The attached patch fixed the problem, by adding the priviously stipped
> $self->{path} in the recursive call. 
> git-svn repository for the commands show-ignore and show-external.
> 
> Patch was submitted through
>  http://bugs.debian.org/477393
> 
> Signed-off-by: Gerrit Pape <pape@smarden.org>
> ---
> 
> I'm not that much a git-svn user, and didn't test this thoroughly.  I'd
> be happy if anyone could crossread/test this, and maybe add a Acked-By.
> 
> Thanks, Gerrit.
> 
> 
>  git-svn.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 37976f2..72fef16 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1918,7 +1918,7 @@ sub prop_walk {
>  
>  	foreach (sort keys %$dirent) {
>  		next if $dirent->{$_}->{kind} != $SVN::Node::dir;
> -		$self->prop_walk($p . $_, $rev, $sub);
> +		$self->prop_walk($self->{path} . $p . $_, $rev, $sub);
>  	}
>  }
