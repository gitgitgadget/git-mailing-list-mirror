From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Make gc a builtin.
Date: Sun, 11 Mar 2007 19:11:02 -0700
Message-ID: <7vtzwrtdmx.fsf@assigned-by-dhcp.cox.net>
References: <11736508181273-git-send-email-jbowes@dangerouslyinc.com>
	<1173650820969-git-send-email-jbowes@dangerouslyinc.com>
	<Pine.LNX.4.63.0703112332550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Bowes <jbowes@dangerouslyinc.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 12 03:11:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQa0S-0007QJ-Gn
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 03:11:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751913AbXCLCLI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 22:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752013AbXCLCLI
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 22:11:08 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:63556 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980AbXCLCLE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 22:11:04 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070312021102.QEHA28911.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 22:11:02 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZeB21W00D1kojtg0000000; Sun, 11 Mar 2007 22:11:02 -0400
In-Reply-To: <Pine.LNX.4.63.0703112332550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 11 Mar 2007 23:48:45 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42004>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> And instead of die()ing, I'd rather do something like
>
> 	return (pack_refs || run_command_v_opt(argv_pack_refs, RUN_GIT_CMD) &&
> 		run_command_v_opt(argv_reflog_expire, RUN_GIT_CMD) &&
> 		run_command_v_opt(argv_repack, RUN_GIT_CMD) &&
> 		(prune || run_command_v_opt(argv_prune, RUN_GIT_CMD) &&
> 		run_command_v_opt(argv_rerere, RUN_GIT_CMD);

Gaaaaaaaah.

That may be valid C, but please do that as a sequence of
separate statements.

	if (we are told to pack-refs)
        	if (try to pack refs and find error)
			goto failure;

	if (try to reflog expire and find error)
		goto failure;

        ...

	return Ok;

	failure:

	return Error;
