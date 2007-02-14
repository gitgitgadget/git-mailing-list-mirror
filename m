From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] Have git-cvsserver call hooks/update before really altering the ref
Date: Tue, 13 Feb 2007 21:36:28 -0800
Message-ID: <7v4pppuwpv.fsf@assigned-by-dhcp.cox.net>
References: <200702131512.45412.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 06:37:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHCpD-0005g9-Ew
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 06:37:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750745AbXBNFhA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 00:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbXBNFhA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 00:37:00 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:59738 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750745AbXBNFg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 00:36:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214053659.LPXP1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 14 Feb 2007 00:36:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PHcU1W00J1kojtg0000000; Wed, 14 Feb 2007 00:36:58 -0500
In-Reply-To: <200702131512.45412.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 13 Feb 2007 15:12:45 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39619>

Andy Parkins <andyparkins@gmail.com> writes:

> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 9371788..b4ef6bc 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -1171,6 +1171,21 @@ sub req_ci
>          exit;
>      }
>  
> +	# Check that this is allowed, just as we would with a receive-pack
> +	my @cmd = ( $ENV{GIT_DIR}.'hooks/update', "refs/heads/$state->{module}",
> +			$parenthash, $commithash );
> +	if( -x $cmd[0] ) {
> +		unless( system( @cmd ) == 0 )
> +		{
> +			$log->warn("Commit failed (update hook declined to update ref)");
> +			print "error 2 Commit failed (update hook declined)\n";

Everybody else seems to say 'print "error 1 blah blah"'.  Are
you sure "error 2 message" is Kosher protocol-wise?
