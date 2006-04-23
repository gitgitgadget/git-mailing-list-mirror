From: Junio C Hamano <junkio@cox.net>
Subject: Re: make update-index --chmod work with multiple files and --stdin
Date: Sat, 22 Apr 2006 17:54:51 -0700
Message-ID: <7v1wvpi010.fsf@assigned-by-dhcp.cox.net>
References: <20060422204642.GA7676@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 23 02:55:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FXSsR-0007Hn-C7
	for gcvg-git@gmane.org; Sun, 23 Apr 2006 02:55:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751279AbWDWAyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 22 Apr 2006 20:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWDWAyy
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Apr 2006 20:54:54 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:49365 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751279AbWDWAyy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Apr 2006 20:54:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060423005453.FZCH8241.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 22 Apr 2006 20:54:53 -0400
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <20060422204642.GA7676@steel.home> (Alex Riesen's message of
	"Sat, 22 Apr 2006 22:46:42 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19063>

Alex Riesen <raa.lkml@gmail.com> writes:

> I had a project where lots of files were "accidentally" marked +x, and
> doing plain "git-update-index --chmod=-x" for each file was too slow.
> Besides, it's somewhat inconsistent, that --chmod does work only for
> one subsequent file.

If you are doing that on the command line, people may want to
have a way to mean "from here on do not do chmod, just do normal
update-index and nothing else" by resetting the chmod_mode thing
back to zero.  Nothing major, and we do not do that to allow_add
and allow_remove either, but just a thought.

> +	char chmod_mode = 0;

Perhaps "set_executable_bit"?

> +		if ( chmod_mode ) {

Please lose ( extra ) whitespaces around parentheses.

> +			if ( chmod_mode ) {

Likewise.

> +				if (chmod_path(chmod_mode, p))
> +					die("git-update-index: cannot chmod %cx %s",
> +					    chmod_mode, p);
> +			}

Might make sense to die inside chmod_path() instead of repeating
the if () { die() } sequence twice?  I dunno.
