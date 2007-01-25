From: Junio C Hamano <junkio@cox.net>
Subject: Re: grafts+repack+prune = history at danger
Date: Thu, 25 Jan 2007 15:07:47 -0800
Message-ID: <7vireu7lj0.fsf@assigned-by-dhcp.cox.net>
References: <45B8E61E.C9C5E6C6@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 00:08:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HADhC-0005Av-9i
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 00:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030481AbXAYXHt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 18:07:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030484AbXAYXHt
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 18:07:49 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:45635 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030481AbXAYXHs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 18:07:48 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125230747.KMRN25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 18:07:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fb6q1W00S1kojtg0000000; Thu, 25 Jan 2007 18:06:50 -0500
In-Reply-To: <45B8E61E.C9C5E6C6@eudaptics.com> (Johannes Sixt's message of
	"Thu, 25 Jan 2007 18:17:18 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37776>

Johannes Sixt <J.Sixt@eudaptics.com> writes:

> Isn't there a major hole in the logic how repack works when grafts are
> in effect?
>
> I did this (details follow):
>
> 1. specify grafts
> 2. repack
> 3. prune
> 4. clone
>
> Result: Broken history in the clone; info/grafts was not copied.

That is expected.

If you had problem in the original repository (i.e. the one with
grafts) that lost objects after step 3., that would be serious
and needs to be fixed, but otherwise the rule of thumb has
always been not to expose repositories with grafts without
telling unsuspecting downstream people for cloning or fetching.
It will give objects they did not even ask for.

grafts are local matter for archaeologist's convenience to glue
two independent histories together, and not much more.  For
example, the history that starts at v2.6.12-rc2 can be grafted
on top of old bkcvs history, but people who clone from you may
not expect to get anything beyond the true origin of the history
at v2.6.12-rc2 (after all that commit object records it as a
parentless commit).

I suspect you could extend fetch-pack protocol to give existing
grafts from upload-pack to trivially fix 'clone', but I do not
know offhand what the ramifications of it are for normal
'fetch'.  You would need to merge potentially conflicting graft
information you obtained from where you fetched from and what
you already had before starting to fetch.
