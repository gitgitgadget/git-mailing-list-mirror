From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git --trace: trace command execution
Date: Sun, 25 Jun 2006 04:50:48 -0700
Message-ID: <7v3bdtv4h3.fsf@assigned-by-dhcp.cox.net>
References: <E1FuSIf-0004jK-Tp@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 25 13:50:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuT8e-0000XW-Ru
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 13:50:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932403AbWFYLuu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Jun 2006 07:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbWFYLuu
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Jun 2006 07:50:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59364 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932403AbWFYLut (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Jun 2006 07:50:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625115048.ZKRA19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 25 Jun 2006 07:50:48 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FuSIf-0004jK-Tp@moooo.ath.cx> (Matthias Lederhofer's message
	of "Sun, 25 Jun 2006 12:57:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22617>

Matthias Lederhofer <matled@gmx.net> writes:

> Show parameters to execve/builtin-cmds before executing them. This
> version does not yet have a parameter --trace to git to enable this I
> just want to get feedback first :)
>
> I think this is quite useful to debug what is going on since a command
> may be another program (shell/python/perl/.. script etc) or just an
> alias for a internal command. Before that many commands became
> built-ins this was quite easy to do with strace.

Interesting.  Debugging one's alias entries would be helped with
this I would imagine, and for that you would want something like
this:

> Example:
> % git showtag v1.4.1-rc1 > /dev/null
> trace: exec: /home/matled/local/stow/git/bin/git-showtag v1.4.1-rc1
> trace: exec failed: No such file or directory
* trace: expanded alias "showtag" => "cat-file tag"
> trace: built-in command: git cat-file tag v1.4.1-rc1

By the way "git cat-file -p" or "git verify-tag -v" might be
more pleasant to view a tag since they make the tagger timestamp
human readable.

> print_shell_escape will escape the arguments to be used as strings in
> the shell to prevent ambiguity with spaces and other special
> characters and make them copy-and-pastable.

Might be worth reusing quote.c::sq_quote(), perhaps?
