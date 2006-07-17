From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git diff in subdirectories
Date: Mon, 17 Jul 2006 16:44:13 +0200
Message-ID: <E1G2UKT-0004ks-RW@moooo.ath.cx>
References: <7vhd1ghbwo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 17 16:44:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G2UKd-0004OO-2o
	for gcvg-git@gmane.org; Mon, 17 Jul 2006 16:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWGQOoS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 17 Jul 2006 10:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWGQOoS
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Jul 2006 10:44:18 -0400
Received: from moooo.ath.cx ([85.116.203.178]:61571 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1750809AbWGQOoS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Jul 2006 10:44:18 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vhd1ghbwo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23972>

Junio C Hamano <junkio@cox.net> wrote:
> I noticed that "git diff" from subdirectories does not seem to
> pick up the configuration from $GIT_DIR/config properly.  I
> suspect that fixing this breakage properly would help us later,
> as more and more commands learn to use the configuration
> mechanism to store user preferences, and the same fix would be
> applicable to them.  If somebody can fix this while we are away
> this week, that would be wonderful ;-).
I can think of these ways to fix this:
- Allow git_config() to work in subdirectories.
  - It can either change the working directory using
    setup_git_directory_gently() and go back to the subdirectory
    later.
  - Or we add a function to get the full path to the repository.  This
    could perhaps also be used in setup_git_env() to initialize
    git_dir?  Otherwise I would just add another function similar to
    git_path pointing to the full path instead of .git/.  (This is the
    way I'd prefer.)
- Fix the it in builtin-diff: change the directory before calling
  git_config().  Then we would either need to change the directory
  back or add a parameter to init_revisions to get the prefix without
  calling setup_git_directory itself.  (I think this will change the
  least code but wont help other commands.)

Any comments?
