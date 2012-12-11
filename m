From: Marc Branchaud <marcnarc@xiplink.com>
Subject: (bug?) Inconsistent workdir file timestamps after initial clone.
Date: Tue, 11 Dec 2012 15:52:47 -0500
Message-ID: <50C79D1F.1080709@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:52:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiWoj-0002Xs-Gx
	for gcvg-git-2@plane.gmane.org; Tue, 11 Dec 2012 21:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753978Ab2LKUwZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2012 15:52:25 -0500
Received: from smtp138.ord.emailsrvr.com ([173.203.6.138]:58870 "EHLO
	smtp138.ord.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753389Ab2LKUwY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2012 15:52:24 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp18.relay.ord1a.emailsrvr.com (SMTP Server) with ESMTP id D2A2B30182;
	Tue, 11 Dec 2012 15:52:23 -0500 (EST)
X-Virus-Scanned: OK
Received: by smtp18.relay.ord1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A49A530187;
	Tue, 11 Dec 2012 15:52:23 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211299>

Hi all,

Occasionally when doing a fresh clone of a repo, if the clock ticks at just
the wrong time the checked-out files end up with different timestamps.

The effect of this can be that, when "make" is run in the workdir it'll
decide that some files are out of date and try to rebuild them.

(In our particular case, our automated build-bot cloned a submodule of some
third-party (i.e. not our) code, where a Makefile.in got an earlier timestamp
than its dependent Makefile.am, so "configure && make" then tried to rebuild
Makefile.in and the build failed because our build environment has the wrong
version of automake.)

I'm completely unfamiliar with the clone-and-checkout parts of git's code, so
my first question really is if someone more familiar with the code could look
at it (or at least point me to it) to verify whether or not such inconsistent
timestamps are possible.

If someone can please confirm that timestamps will always be consistent on
the initial checkout of a clone, then I'll have to hunt for a different cause
of our build failure.

However, if inconsistent timestamps are possible, I'd like to suggest that
this should be fixed.  (I'd learn the code and write a patch myself, but as
some of you may know I haven't had very much time for git hacking lately.)

Thanks!

		M.
