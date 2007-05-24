From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 10/22] run-command: optionally clear git environment
Date: Thu, 24 May 2007 03:15:27 -0400
Message-ID: <20070524071527.GM28023@spearce.org>
References: <11799589913153-git-send-email-skimo@liacs.nl> <11799589923790-git-send-email-skimo@liacs.nl> <81b0412b0705232357i535be2adl6570847942ecb9c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "skimo@liacs.nl" <skimo@liacs.nl>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Martin Waitz <tali@admingilde.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 24 09:16:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hr7YG-0001sY-ED
	for gcvg-git@gmane.org; Thu, 24 May 2007 09:16:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbXEXHPk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 03:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756274AbXEXHPk
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 03:15:40 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57858 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755150AbXEXHPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 03:15:39 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hr7Xk-0003GB-0N; Thu, 24 May 2007 03:15:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5603220FBAE; Thu, 24 May 2007 03:15:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <81b0412b0705232357i535be2adl6570847942ecb9c0@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48228>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 5/24/07, skimo@liacs.nl <skimo@liacs.nl> wrote:
> >+               if (cmd->clear_git_env) {
> >+                       unsetenv(ALTERNATE_DB_ENVIRONMENT);
> >+                       unsetenv(DB_ENVIRONMENT);
> >+                       unsetenv(CONFIG_ENVIRONMENT);
> >+                       unsetenv(GIT_DIR_ENVIRONMENT);
> >+                       unsetenv(GRAFT_ENVIRONMENT);
> >+                       unsetenv(INDEX_ENVIRONMENT);
> >+               }
> 
> You might want to try the alternative approach from the recently
> proposed patches to do the same, but more generic. Would
> be less code, too.

Unfortunately Alex's approach means the caller must know the list of
"special Git envvars" that should be cleared when entering into a
subproject Git repository to execute a command.  That's horrible code
duplication in the callers of run_command, and is just asking for
trouble later when/if another magic environment variable is added.

As long as the above unsetenv list is, I'd really rather have a
specific clear_git_env bit in struct child_process, just so that the
callers don't have to be bothered with the precise list of names.
Of course declaring those names in a static const char** and
looping over it before doing Alex's env array thing would probably
be less code and let the two play along together rather nicely.

-- 
Shawn.
