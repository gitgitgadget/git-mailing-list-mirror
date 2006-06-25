From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH 7/7] Convert git-annotate to use Git.pm
Date: Sun, 25 Jun 2006 02:27:23 -0700
Message-ID: <20060625092719.GH3154@h4x0r5.com>
References: <20060625015421.29906.50002.stgit@machine.or.cz> <20060625015434.29906.23422.stgit@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 11:27:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuQu1-0007vb-24
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 11:27:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWFYJ1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 05:27:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWFYJ1d
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 05:27:33 -0400
Received: from h4x0r5.com ([70.85.31.202]:12301 "EHLO h4x0r5.com")
	by vger.kernel.org with ESMTP id S932166AbWFYJ1c (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Jun 2006 05:27:32 -0400
Received: from ryan by h4x0r5.com with local (Exim 4.50)
	id 1FuQtn-0000cg-SD; Sun, 25 Jun 2006 02:27:24 -0700
To: Petr Baudis <pasky@suse.cz>
Content-Disposition: inline
In-Reply-To: <20060625015434.29906.23422.stgit@machine.or.cz>
User-Agent: Mutt/1.5.9i
X-michonline.com-MailScanner: Found to be clean
X-michonline.com-MailScanner-From: ryan@h4x0r5.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22596>

On Sun, Jun 25, 2006 at 03:54:34AM +0200, Petr Baudis wrote:
> -sub open_pipe {
> -	if ($^O eq '##INSERT_ACTIVESTATE_STRING_HERE##') {
> -		return open_pipe_activestate(@_);
> -	} else {
> -		return open_pipe_normal(@_);
> -	}
> -}
> -
> -sub open_pipe_activestate {
> -	tie *fh, "Git::ActiveStatePipe", @_;
> -	return *fh;
> -}
> -
> -sub open_pipe_normal {
> -	my (@execlist) = @_;
> -
> -	my $pid = open my $kid, "-|";
> -	defined $pid or die "Cannot fork: $!";
> -
> -	unless ($pid) {
> -		exec @execlist;
> -		die "Cannot exec @execlist: $!";
> -	}
> -
> -	return $kid;
> -}

I don't see that Git.pm provides the compatibility functionality we have
stubbed out, here.

(It clearly has never been used, because there hasn't been a patch to
set the actual ActiveState string there.. 'MSWin32', btw.)

I suspect that the other scripts, that have more users, will see
regression complaints when the qx() calls get replaced by calls to
open(my $fh, "-|"), indirectly, in Git.pm

-- 

Ryan Anderson
  sometimes Pug Majere
