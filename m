From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH RESEND] Git.pm: Set GIT_WORK_TREE if we set GIT_DIR
Date: Thu, 7 May 2009 21:40:47 +0200
Message-ID: <20090507194047.GA17989@machine.or.cz>
References: <1241703688-6892-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu May 07 21:41:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M29Sq-0000eK-L1
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 21:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752649AbZEGTkx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 15:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752591AbZEGTkx
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 15:40:53 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40443 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752404AbZEGTkx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 15:40:53 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id F055A862007; Thu,  7 May 2009 21:40:47 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1241703688-6892-1-git-send-email-frank@lichtenheld.de>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118509>

On Thu, May 07, 2009 at 03:41:27PM +0200, Frank Lichtenheld wrote:
> From: Frank Lichtenheld <flichtenheld@astaro.com>
> 
> Otherwise git will use the current directory as work tree which will
> lead to unexpected results if we operate in sub directory of the
> work tree.
> 
> Signed-off-by: Frank Lichtenheld <flichtenheld@astaro.com>
> ---
>  perl/Git.pm         |    2 ++
>  t/t9700-perl-git.sh |    4 ++++
>  t/t9700/test.pl     |   13 +++++++++++++
>  3 files changed, 19 insertions(+), 0 deletions(-)
> 
> No comments and doesn't seem to have been applied, so resent unchanged.
> 
> diff --git a/perl/Git.pm b/perl/Git.pm
> index 291ff5b..4313db7 100644
> --- a/perl/Git.pm
> +++ b/perl/Git.pm
> @@ -1280,6 +1280,8 @@ sub _cmd_exec {
>  	my ($self, @args) = @_;
>  	if ($self) {
>  		$self->repo_path() and $ENV{'GIT_DIR'} = $self->repo_path();
> +		$self->repo_path() and $self->wc_path()
> +			and $ENV{'GIT_WORK_TREE'} = $self->wc_path();
>  		$self->wc_path() and chdir($self->wc_path());
>  		$self->wc_subdir() and chdir($self->wc_subdir());
>  	}

This looks obviously correct?

You could even skip the first chdir and use $self->wc_path() .
$self->wc_subdir() in the second one to save a syscall, I guess. ;-)

I've really forgot most of the code already so it's not worth much, but

Acked-by: Petr Baudis <pasky@suse.cz>
