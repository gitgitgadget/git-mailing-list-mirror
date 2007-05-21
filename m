From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add ability to specify environment extension to run_command
Date: Mon, 21 May 2007 16:02:42 -0700
Message-ID: <7v7ir1dbl9.fsf@assigned-by-dhcp.cox.net>
References: <20070520153908.GF5412@admingilde.org>
	<20070520181433.GA19668@steel.home>
	<20070521090339.GH942MdfPADPa@greensroom.kotnet.org>
	<20070521224828.GA10890@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Sven Verdoolaege <skimo@kotnet.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 22 01:02:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HqGtv-0008CV-SN
	for gcvg-git@gmane.org; Tue, 22 May 2007 01:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbXEUXCo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 May 2007 19:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756545AbXEUXCo
	(ORCPT <rfc822;git-outgoing>); Mon, 21 May 2007 19:02:44 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:51164 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbXEUXCo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2007 19:02:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070521230244.IVPF22040.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 21 May 2007 19:02:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1z2i1X00S1kojtg0000000; Mon, 21 May 2007 19:02:43 -0400
In-Reply-To: <20070521224828.GA10890@steel.home> (Alex Riesen's message of
	"Tue, 22 May 2007 00:48:28 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48058>

Alex Riesen <raa.lkml@gmail.com> writes:

> There is no way to specify and override for the environment: there is
> no visible user for it (yet, something in git-daemon could need it).
>
> Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
> ---
>
> Sven Verdoolaege, Mon, May 21, 2007 11:03:39 +0200:
>> Could you sign-off on this for me so I can use it my patch set?
>> 
>
> So here it is. On top of the previos patch regarding chdir before
> exec. Junio, if needed, I can resend that first patch about chdir.

Both of them in a row would be good, so yes, resend is
appreciated.

> @@ -76,6 +76,10 @@ int start_command(struct child_process *cmd)
>  		if (cmd->dir && chdir(cmd->dir))
>  			die("exec %s: cd to %s failed (%s)", cmd->argv[0],
>  			    cmd->dir, strerror(errno));
> +		if (cmd->env) {
> +			for (; *cmd->env; cmd->env++)
> +				putenv((char*)*cmd->env);
> +		}
>  		if (cmd->git_cmd) {
>  			execv_git_cmd(cmd->argv);
>  		} else {

I had a feeling that some callers needed to be able to unsetenv
some.  How would this patch help them, or are they outside of
the scope?
