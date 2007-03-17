From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: [PATCH] git-init: set core.workdir when GIT_WORK_DIR is specified
Date: Sat, 17 Mar 2007 15:34:52 +0100
Message-ID: <20070317143452.GA21140@moooo.ath.cx>
References: <20070317015855.GB19305@moooo.ath.cx> <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Mar 17 15:35:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HSZzo-0001vV-ET
	for gcvg-git@gmane.org; Sat, 17 Mar 2007 15:35:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965618AbXCQOe5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Mar 2007 10:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965625AbXCQOe5
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Mar 2007 10:34:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:55779 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965618AbXCQOez (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2007 10:34:55 -0400
Received: (qmail invoked by alias); 17 Mar 2007 14:34:54 -0000
X-Provags-ID: V01U2FsdGVkX1/8ABBxRQD8gLdLURfPgqziKRUa+iH9iXEGI/zn7f
	aA8Cn+/gOznUZL
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vbqiss4yw.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42436>

Here is a new patch series replacing ml/workdir.

Changes:
 * rename GIT_WORK_DIR to GIT_WORK_TREE, --work-dir to --work-tree and
   core.workdir to core.worktree
 * use getcwd and prefixcmp instead of stat to check if cwd is below
   GIT_DIR or GIT_WORK_TREE
 * rename 'has_working_directory' to 'inside_working_tree'

The first two patches have not changed except for their order in the
series but I repost them anyway for easier review.

Things I'm not sure about how/if to change (see my last mail too)
 * is_bare_repository() uses the old check
       /* definitely bare */
       if (is_bare_repository_cfg == 1)
               return 1;
       /* GIT_WORK_TREE is set, bare if cwd is outside */
       if (inside_working_tree >= 0)
               return !inside_working_tree;
       /* configuration says it is not bare */
       if (is_bare_repository_cfg == 0)
               return 0;
 * is_bare_repository() in general
 * git init does not show the expansion of GIT_WORK_TREE to an
   absolute path, this might confuse the user
