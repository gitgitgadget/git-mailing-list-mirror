From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] escape tilde in Documentation/git-rev-parse.txt
Date: Mon, 02 Oct 2006 22:52:57 -0700
Message-ID: <7vhcymt07a.fsf@assigned-by-dhcp.cox.net>
References: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 03 07:53:08 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUdDC-0005mj-HT
	for gcvg-git@gmane.org; Tue, 03 Oct 2006 07:53:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965268AbWJCFw7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 01:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965269AbWJCFw7
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 01:52:59 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:8412 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S965268AbWJCFw6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 01:52:58 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003055258.BMK26416.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 3 Oct 2006 01:52:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Vht01V0071kojtg0000000
	Tue, 03 Oct 2006 01:53:00 -0400
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
In-Reply-To: <tkrat.4532d38d43e16a62@s5r6.in-berlin.de> (Stefan Richter's
	message of "Mon, 2 Oct 2006 20:55:05 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28246>

Stefan Richter <stefanr@s5r6.in-berlin.de> writes:

> fixes a failure to build the git-rev-parse manpage,
> seen with asciidoc 8.0.0
>
> Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
> ---
> diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
> index b761b4b..671b4e3 100644
> --- a/Documentation/git-rev-parse.txt
> +++ b/Documentation/git-rev-parse.txt
> @@ -138,7 +138,7 @@ syntax.
>    'rev{caret}0' means the commit itself and is used when 'rev' is the
>    object name of a tag object that refers to a commit object.
>  
> -* A suffix '~<n>' to a revision parameter means the commit
> +* A suffix '$$~$$<n>' to a revision parameter means the commit
>    object that is the <n>th generation grand-parent of the named
>    commit object, following only the first parent.  I.e. rev~3 is
>    equivalent to rev{caret}{caret}{caret} which is equivalent to\

But this makes it asciidoc 7.1 barf, so we need an alternative
compatible to both.

This works for me on 7.1; is your 8.0 happy with it?

-- >8 --

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 8196d78..44b1ce4 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -11,6 +11,7 @@ # the command.
 caret=^
 startsb=&#91;
 endsb=&#93;
+tilde=&#126;
 
 ifdef::backend-docbook[]
 [gitlink-inlinemacro]
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index b761b4b..2f1306c 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -138,7 +138,7 @@ syntax.
   'rev{caret}0' means the commit itself and is used when 'rev' is the
   object name of a tag object that refers to a commit object.
 
-* A suffix '~<n>' to a revision parameter means the commit
+* A suffix '{tilde}<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
   commit object, following only the first parent.  I.e. rev~3 is
   equivalent to rev{caret}{caret}{caret} which is equivalent to\
