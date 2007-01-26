From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Document check option to git diff.
Date: Fri, 26 Jan 2007 15:46:02 -0800
Message-ID: <7vodoltkqt.fsf@assigned-by-dhcp.cox.net>
References: <1169833372823-git-send-email-rael@zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Jan 27 00:46:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAalv-0007i0-1E
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 00:46:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751784AbXAZXqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 18:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752182AbXAZXqH
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 18:46:07 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63375 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbXAZXqD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 18:46:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070126234603.KEIH25875.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Fri, 26 Jan 2007 18:46:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Fzl51W00D1kojtg0000000; Fri, 26 Jan 2007 18:45:05 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37902>

rael@zopyra.com writes:

> From: Bill Lear <rael@zopyra.com>
>
> Signed-off-by: Bill Lear <rael@zopyra.com>
> ---
>  Documentation/SubmittingPatches |    3 ++-
>  Documentation/diff-options.txt  |    5 +++++
>  Documentation/git-diff.txt      |    6 ++++++
>  3 files changed, 13 insertions(+), 1 deletions(-)

Thanks.  It's nice to see somebody new getting more and more
comfortable with git.

> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index da1cc60..501e0df 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -58,6 +58,11 @@
>  	Turn off rename detection, even when the configuration
>  	file gives the default to do so.
>  
> +--check::
> +	Check whether differences form a valid patch.  Warns if
> +	differences include a space before a tab or a space at the end
> +	of a line.
> +

It is supposed to be only about new lines; correcting an
existing line that had trailing whitespaces should not trigger
the check.  "SP before a TAB" check is supposed to apply only in
the indent part (if the code does not work that way, you have
spotted bugs).

Also I fear that 'valid' is a bit too strong a word here.  A
patch that introduces new lines that have trailing whitespaces
is still a valid patch in the sense that 'patch' and 'git apply'
would accept it as input.  How about rewording it like this?

	Look for and warn about changes that introduce trailing
        whitespaces at the end of the line or an indent that
        uses a whitespace before a tab.

> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 6a098df..5054fb7 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -70,6 +70,7 @@ Various ways to check your working tree::
>  $ git diff            <1>
>  $ git diff --cached   <2>
>  $ git diff HEAD       <3>
> +$ git diff --check    <4>
>  ------------
>  +
>  <1> changes in the working tree not yet staged for the next commit.
> @@ -77,6 +78,11 @@ $ git diff HEAD       <3>
>  would be committing if you run "git commit" without "-a" option.
>  <3> changes in the working tree since your last commit; what you
>  would be committing if you run "git commit -a"
> +<4> display whether what you are about to commit is a valid patch,
> +including whether you have spaces at the end of lines, or spaces
> +before tabs.  Violations are displayed in this form:
> +
> +<file name>:<line number>:<violation>:<offending line>
>  
>  Comparing with arbitrary commits::
>  +

        ... what you are about to commit introduces funny whitespaces,
        such as traling whitespaces at the end of the line or an indent
        that uses a whitespace before a tab.  Violations are...
