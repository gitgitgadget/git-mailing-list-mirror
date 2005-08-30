From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments in read-tree about #nALT
Date: Mon, 29 Aug 2005 17:42:43 -0700
Message-ID: <7vr7cc6yrg.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
	<7vwtm726xq.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0508271709530.23242@iabervon.org>
	<Pine.LNX.4.63.0508271855100.23242@iabervon.org>
	<Pine.LNX.4.58.0508271621210.3317@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 02:43:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9uDA-0006bU-1l
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 02:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbVH3Amp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 20:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbVH3Amp
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 20:42:45 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:14746 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750885AbVH3Amo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 20:42:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050830004242.RMRA1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 Aug 2005 20:42:42 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508271621210.3317@g5.osdl.org> (Linus Torvalds's
	message of "Sat, 27 Aug 2005 16:35:15 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7932>

Linus Torvalds <torvalds@osdl.org> writes:

> Daniel, 
> I'm not 100% sure what you're trying to do, but one thing that might work 
> out is to just having multiple "stage 3" entries with the same pathname.

My understanding is that he is enhancing the current three-way
merge 'read-tree -m O A B' "we are at A and have come from O; we
would like to apply changes made by somebody who went from O to
A" to 'read-tree -m O1,O2,O3,... A B' to mean "any of the O_n
are merge-base candidates".  I think having multiple "stage 1"
is useful for what Daniel is doing.

> But if we allowed duplicate entries per stage, I think we could easily 
> just fold stage 2/3 into one stage, and just have <n> entries in stage 2. 
> That would immediately mean that a three-way merge could be <n> way.

I suspect you are solving a different problem here --- an
Octopus.

But I agree that the current way of doing things in stage 2 and
stage 3 is special casing two head merges from an Octopus, and
there might not be a fundamental reason for doing so.  Folding
the current stage 2 and 3 into a single "merge target stage",
treating current stage 1 as "merge base stage", and allowing
duplicate entries in both stages might turn out to make more
sense.  I suspect this would break a lot of tools initially, but
that is part of the process of making progress.

> The only rule would be that when you add a entry to stage 2, you must 
> always add it after any previous entry that is already in stage 2. That 
> should be easy.

The same rule should apply to multiple stage 1 entries to
represent multiple candidate merge bases.
