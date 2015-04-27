From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Cleaning projects with submodules
Date: Mon, 27 Apr 2015 14:47:29 +0200
Message-ID: <20150427124729.GA5399@sandbox-ub1410>
References: <553C08D9.9000907@hogyros.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Simon Richter <Simon.Richter@hogyros.de>
X-From: git-owner@vger.kernel.org Mon Apr 27 14:54:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmiYU-0006cw-3B
	for gcvg-git-2@plane.gmane.org; Mon, 27 Apr 2015 14:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932777AbbD0My1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2015 08:54:27 -0400
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:43584 "EHLO
	smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932658AbbD0My0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2015 08:54:26 -0400
X-Greylist: delayed 406 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2015 08:54:26 EDT
Received: from [80.135.111.219] (helo=sandbox-ub1410)
	by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:AES128-GCM-SHA256:128)
	(Exim 4.84)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1YmiRl-0006I9-An; Mon, 27 Apr 2015 14:47:37 +0200
Content-Disposition: inline
In-Reply-To: <553C08D9.9000907@hogyros.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267853>

Hi,

On Sat, Apr 25, 2015 at 11:36:25PM +0200, Simon Richter wrote:
> I'm trying to set up a continuous integration build for Boost, which
> uses massive amounts of submodules, and keep running into problems when
> running "git clean" in the toplevel project.
> 
> When I switch to a version where a submodule has been removed (e.g. an
> earlier version), "git clean -dx" will not remove the submodule's
> directory, because it has its own .git directory. Using a single -f
> flag, the process fails (because directories containing .git directories
> are no longer skipped), and using -ff removes all submodules (which is
> overkill).
> 
> Is there a good way to clean a project, leaving valid submodules in
> place (these are then switched to the new tip and cleaned in separate
> commands) while removing submodules that are no longer referenced?

Unfortunately there is no really nice way for that yet. Safely removing
submodule ist still under development.

Here is a snippet that I used on a CI server for this purpose:

   git status --porcelain | grep "^?? " | sed -e 's/^?? //' | \
   while read i; do
        rm -rf "$i"
   done

It does a little more, since it unconditionally removes all untracked files
that are not ignored.

Cheers Heiko
