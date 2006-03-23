From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question about possible git races
Date: Wed, 22 Mar 2006 17:46:48 -0800
Message-ID: <7vmzfi53w7.fsf@assigned-by-dhcp.cox.net>
References: <200603201724.12442.astralstorm@o2.pl>
	<7vacbi6m91.fsf@assigned-by-dhcp.cox.net>
	<200603230222.38978.astralstorm@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 23 02:47:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMEun-0001nd-7e
	for gcvg-git@gmane.org; Thu, 23 Mar 2006 02:47:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750705AbWCWBq6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Mar 2006 20:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751118AbWCWBq6
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Mar 2006 20:46:58 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:15059 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750705AbWCWBq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Mar 2006 20:46:57 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060323014650.RENP26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 22 Mar 2006 20:46:50 -0500
To: Radoslaw Szkodzinski <astralstorm@o2.pl>
In-Reply-To: <200603230222.38978.astralstorm@o2.pl> (Radoslaw Szkodzinski's
	message of "Thu, 23 Mar 2006 02:22:34 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17844>

Radoslaw Szkodzinski <astralstorm@o2.pl> writes:

> For me fetch = git-*-fetch. Which in turn calls git-receive-pack.

Does anything other than git-send-pack call git-receive-pack?

For fetch, git-fetch-pack is called from the core level, but it
does not update refs itself.  It writes out enough information
to its standard output so that the script calling it can update
the refs.  So at the core level there cannot be any race, but
that does not necessarily mean existing scripts are race free.

Our barebone Porcelainish scripts _do_ use update-ref to do the
same lock - re-read - rename-to-update cycle when updating the
refs using that information, but that is something you
explicitly said you are not interested in ;-).
