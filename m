From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn: Protect against "diff.color = true".
Date: Fri, 31 Aug 2007 14:58:21 -0700
Message-ID: <20070831215752.GA31033@untitled>
References: <46aeb24f0708310558t2defc547v483586f116d8b8ac@mail.gmail.com> <7vveav21uv.fsf@gitster.siamese.dyndns.org> <20070831152153.GA30745@muzzle> <7v4pifzawc.fsf@gitster.siamese.dyndns.org> <7v4pifxuia.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Newson <robert.newson@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:59:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IREW4-0002sH-Pb
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:59:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753500AbXHaV65 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753084AbXHaV65
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:58:57 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38523 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752532AbXHaV65 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:58:57 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 61B562DC08D;
	Fri, 31 Aug 2007 14:58:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v4pifxuia.fsf_-_@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57226>

Junio C Hamano <gitster@pobox.com> wrote:
> If the configuration of the user has "diff.color = true", the
> output from "log" we invoke internally added color codes, which
> broke the parser.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> 
>   Junio C Hamano <gitster@pobox.com> writes:
> 
>   > We probably should do two things to resolve this.
>   >
>   >  * Protect our scripts.  When parsing from "git log" and any
>   >    other Porcelain, explicitly give --no-color.
> 
>   Here is my attempt -- I do not have an easy access to SVN repo
>   to interoperate with, so a testing by real-world users and an
>   Ack is appreciated.  I think some fix for this issue (not
>   necessarily this patch) should be in 1.5.3 final.

Works for me here, although switching back to git-rev-list
(--pretty=raw) would make me more comfortable.

Acked-by: Eric Wong <normalperson@yhbt.net>

>  git-svn.perl |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/git-svn.perl b/git-svn.perl
> index 4e325b7..98218da 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -807,7 +807,7 @@ sub cmt_metadata {
>  
>  sub working_head_info {
>  	my ($head, $refs) = @_;
> -	my ($fh, $ctx) = command_output_pipe('log', $head);
> +	my ($fh, $ctx) = command_output_pipe('log', '--no-color', $head);
>  	my $hash;
>  	my %max;
>  	while (<$fh>) {
> @@ -2072,7 +2072,7 @@ sub rebuild {
>  		return;
>  	}
>  	print "Rebuilding $db_path ...\n";
> -	my ($log, $ctx) = command_output_pipe("log", $self->refname);
> +	my ($log, $ctx) = command_output_pipe("log", '--no-color', $self->refname);
>  	my $latest;
>  	my $full_url = $self->full_url;
>  	remove_username($full_url);

-- 
Eric Wong
