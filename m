From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH 0/4] Cygwin MSVC patches
Date: Tue, 27 Oct 2009 18:50:53 +0000
Message-ID: <4AE7410D.3030109@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>, mstormo@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 27 20:37:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N2rr9-0003oe-Lq
	for gcvg-git-2@lo.gmane.org; Tue, 27 Oct 2009 20:37:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688AbZJ0ThM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2009 15:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756681AbZJ0ThL
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Oct 2009 15:37:11 -0400
Received: from lon1-post-2.mail.demon.net ([195.173.77.149]:44182 "EHLO
	lon1-post-2.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756658AbZJ0ThK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Oct 2009 15:37:10 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-2.mail.demon.net with esmtp (Exim 4.69)
	id 1N2rr0-0004qk-az; Tue, 27 Oct 2009 19:37:15 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131373>

Hi Junio,

I've had these patches "hanging around" in my queue, for a few
weeks, with every intention of adding several more to fix up
some problems... Hmm, well I haven't got to those yet, so I
thought I may as well pass these on.

[PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on cygwin
[PATCH 2/4] Makefile: merge two Cygwin configuration sections into one
[PATCH 3/4] Makefile: keep MSVC and Cygwin configuration separate
[PATCH 4/4] win32: Improve the conditional inclusion of WIN32 API code

I think they are all pretty safe (famous last words), but it would be
a good idea for someone with an MSYS/MinGW installation to test them
(particularly patch #4; it's really the only one I'm slightly worried
about :D).

With these patches, the msvc build on cygwin seems to be working fine.

At first it looked bad; an ./git-status showed a shed-load of "Changed
but not updated" files along with many "Untracked files" which should
have been ignored (eg editor backup files).

In order to fix the ignored files problem, I had to make a change to
~/.gitconfig. The core.excludesfile was set to /home/ramsay/.gitignore,
which (being a cygwin path) the msvc build could not read.  However,
setting this to C:/cygwin/home/ramsay/.gitignore fixed the problem
since both the cygwin and msvc builds can read that path.

When ./git-diff showed that most of the "Changed" files differed only
in the mode, in particular only the execute bit, it was easy to fix
that also; set core.filemode to false.

This left only the symlink RelNotes, which was shown as deleted and an
RelNotes.lnk file as untracked. This is to be expected on a cygwin
git repo (and is an example of the "white-lies" that cygwin tells you
when it iterates over the filesystem).

ATB,
Ramsay Jones
