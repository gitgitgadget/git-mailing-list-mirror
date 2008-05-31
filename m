From: Junio C Hamano <gitster@pobox.com>
Subject: [Nikolaus Schulz] Re: [PATCH] git-svn fails in prop_walk if
 $self->{path} is not empty
Date: Sat, 31 May 2008 14:24:27 -0700
Message-ID: <7v3anyf9pw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>,
	Benoit Sigoure <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Sat May 31 23:26:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Yaa-0001x1-VV
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 23:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753912AbYEaVYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 May 2008 17:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753894AbYEaVYs
	(ORCPT <rfc822;git-outgoing>); Sat, 31 May 2008 17:24:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:59548 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753867AbYEaVYs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 May 2008 17:24:48 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 728D238C9;
	Sat, 31 May 2008 17:24:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 84ABF38C4; Sat, 31 May 2008 17:24:35 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FBD31182-2F57-11DD-9D0B-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83405>

Ping?

Date:	Wed, 28 May 2008 00:54:02 +0200
To:	git@vger.kernel.org
Subject: Re: [PATCH] git-svn fails in prop_walk if $self->{path} is not empty
Message-ID: <20080527225402.GA25550@penelope.zusammrottung.local>
From:	Nikolaus Schulz <microschulz@web.de>

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
