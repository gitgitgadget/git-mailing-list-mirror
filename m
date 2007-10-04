From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH/RFT] cvsserver: only allow checkout of branches
Date: Thu, 4 Oct 2007 23:15:57 +0200
Message-ID: <20071004211555.GG31659@planck.djpig.de>
References: <200710031348.50800.wielemak@science.uva.nl> <46823.146.50.26.20.1191496739.squirrel@webmail.science.uva.nl> <Pine.LNX.4.64.0710041352480.4174@racer.site> <200710041506.13154.wielemak@science.uva.nl> <Pine.LNX.4.64.0710041622070.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Oct 04 23:17:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdY3q-0003VD-6X
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756464AbXJDVQd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757598AbXJDVQc
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:16:32 -0400
Received: from planck.djpig.de ([85.10.192.180]:1463 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756464AbXJDVQc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:16:32 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 6004188231;
	Thu,  4 Oct 2007 23:16:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OZvmnCb61j7m; Thu,  4 Oct 2007 23:16:21 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 600AE88232; Thu,  4 Oct 2007 23:15:57 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710041622070.4174@racer.site>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60009>

On Thu, Oct 04, 2007 at 04:29:04PM +0100, Johannes Schindelin wrote:
> diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> index 13dbd27..869690c 100755
> --- a/git-cvsserver.perl
> +++ b/git-cvsserver.perl
> @@ -770,6 +770,14 @@ sub req_co
>  
>      $log->debug("req_co : " . ( defined($data) ? $data : "[NULL]" ) );
>  
> +    if( system("git", "rev-parse", "--verify", "refs/heads/$module" ) != 0 )
> +    {
> +	$log->warn("Checkout failed: $module is not a branch");
> +	print "error 1 Checkout failed: $module is not a branch\n";
> +	chdir "/";
> +	exit;
> +    }
> +
>      $log->info("Checking out module '$module' ($state->{CVSROOT}) to '$checkout_path'");
>  
>      $ENV{GIT_DIR} = $state->{CVSROOT} . "/";

I've found a problem with the patch. Since git-rev-parse will produce
output (which will end up at the client and confuse it), we will have to use a fork/exec
combination instead of system to be able to close STDOUT and STDERR of the child.

Should I sent a patch on top of this one or as a replacement?

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
