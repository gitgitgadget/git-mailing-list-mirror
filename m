From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] diff.c: respect diff.renames config option
Date: Fri, 07 Jul 2006 04:18:42 -0700
Message-ID: <7vpsghzmr1.fsf@assigned-by-dhcp.cox.net>
References: <11522670452824-git-send-email-normalperson@yhbt.net>
	<11522670473116-git-send-email-normalperson@yhbt.net>
	<7v7j2p3eac.fsf@assigned-by-dhcp.cox.net>
	<20060707110123.GA23400@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 07 13:19:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyoMB-00066h-5f
	for gcvg-git@gmane.org; Fri, 07 Jul 2006 13:18:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751044AbWGGLSo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 7 Jul 2006 07:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbWGGLSo
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Jul 2006 07:18:44 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:48019 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751039AbWGGLSn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jul 2006 07:18:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060707111843.WZKX27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 7 Jul 2006 07:18:43 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <20060707110123.GA23400@soma> (Eric Wong's message of "Fri, 7 Jul
	2006 04:01:23 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23428>

Eric Wong <normalperson@yhbt.net> writes:

> Nevertheless, it's still opt -in via repo-config, and most people will
> find renames useful unless they need to export to non-git
> systems.

I am more worried about somebody who opts-in finds breakage of
commands that happen to internally use low-level diff machinery
and expect the diff machinery does not automagically do funny
rename detection without being told.

For example, revision walking with path pruning uses diff
machinery without renames.  I do not know what happens if I
override it with diff.renames to allow rename detection but I
fear something might horribly break.

That is why I said I do not want this at _that_ low level.  I do
not have objections to have the configuration at a layer closer
to the UI, e.g. things in builtin-log.c and builtin-diff.c.
