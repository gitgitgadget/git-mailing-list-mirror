From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Tue, 21 Mar 2006 00:42:02 -0800
Message-ID: <7v4q1sgpet.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
	<7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
	<200603201730.19373.Josef.Weidendorfer@gmx.de>
	<7voe00iupp.fsf@assigned-by-dhcp.cox.net>
	<20060320232101.GQ18185@pasky.or.cz>
	<7vfylcismx.fsf@assigned-by-dhcp.cox.net> <441FB715.1000500@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 21 09:42:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLcRO-00066v-OC
	for gcvg-git@gmane.org; Tue, 21 Mar 2006 09:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbWCUImI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 03:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbWCUImH
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 03:42:07 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:59640 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964968AbWCUImF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 03:42:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060321084209.THGG25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Mar 2006 03:42:09 -0500
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <441FB715.1000500@op5.se> (Andreas Ericsson's message of "Tue, 21
	Mar 2006 09:19:33 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17778>

Andreas Ericsson <ae@op5.se> writes:

> That way the only extra dwimery would be to add "remotes" after
> "heads" under .git/refs and accept directory in .git/remotes/ as ref
> and tack on '/master' at the end of it as the last option to
> search. For a specific branch on an imported remote, one would have to
> say "jc/next". This means we still only handle 'master' specially so
> we don't introduce any new protected or special names.

Two things that holding me back from doing what you suggested
are (1) "master" is just a convention and indeed non-negligible
number of kernel.org trees have "test" and "release" instead
without "master"; (2) I'd really really really want to avoid
teaching get_sha1_basic() C-level about .git/remotes/$origin
file, even though that function is more of a UI level than the
rest of the really core C-level routines.

But if I were forced to choose between the above 2, I would
probably pick defaulting to "master".

The reason I would like to avoid .git/remotes/$origin is because
it is designed to be Porcelainish thing.  The underlying C-level
git-fetch-pack never sees it; instead the information fed to
C-level is prepared by the upper layer using that file.  As far
as I understand, Cogito does not understand it either, except
that it ships with bash completion code that reads from
filenames there.
