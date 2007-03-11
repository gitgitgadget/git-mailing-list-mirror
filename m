From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Make gc a builtin.
Date: Sun, 11 Mar 2007 23:48:45 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703112332550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
 <1173650820969-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Sun Mar 11 23:52:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQWuG-0002Te-I3
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 23:52:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933604AbXCKWwp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 18:52:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933610AbXCKWwp
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 18:52:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:57950 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933604AbXCKWwo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 18:52:44 -0400
Received: (qmail invoked by alias); 11 Mar 2007 22:48:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 11 Mar 2007 23:48:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/YLRIHutbYQd3d+2QShHT4Gm99VbVC4VsopUmAWb
	B/g4l0kuF6Ihvb
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <1173650820969-git-send-email-jbowes@dangerouslyinc.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42000>

Hi,

On Sun, 11 Mar 2007, James Bowes wrote:

> +	if (pack_refs)
> +		run_command_or_die("git-pack-refs", "--prune", NULL);
> +	run_command_or_die("git-reflog", "expire", "--all", NULL);
> +	run_command_or_die("git-repack", "-a", "-d", "-l", NULL);
> +	if (prune)
> +		run_command_or_die("git-prune", NULL);
> +	run_command_or_die("git-rerere", "gc", NULL);

Shawn recently sent a series which discourages the va_list versions of 
run_command. I think that makes sense. So, using 
run_command_v_opt(argv_pack_refs, RUN_GIT_CMD) would be better IMHO.

And instead of die()ing, I'd rather do something like

	return (pack_refs || run_command_v_opt(argv_pack_refs, RUN_GIT_CMD) &&
		run_command_v_opt(argv_reflog_expire, RUN_GIT_CMD) &&
		run_command_v_opt(argv_repack, RUN_GIT_CMD) &&
		(prune || run_command_v_opt(argv_prune, RUN_GIT_CMD) &&
		run_command_v_opt(argv_rerere, RUN_GIT_CMD);

Hmm?

Ciao,
Dscho
