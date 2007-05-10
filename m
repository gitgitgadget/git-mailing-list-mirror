From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-commit: Reformat log messages provided on commandline
Date: Wed, 09 May 2007 17:45:43 -0700
Message-ID: <7vsla5pkug.fsf@assigned-by-dhcp.cox.net>
References: <vpqwszm9bm9.fsf@bauges.imag.fr>
	<Pine.LNX.4.64.0705061851411.4015@racer.site>
	<vpqk5vlamav.fsf@bauges.imag.fr>
	<7vvef5c0fw.fsf@assigned-by-dhcp.cox.net>
	<20070509125225.GP4489@pasky.or.cz>
	<Pine.LNX.4.64.0705091513360.4167@racer.site>
	<20070509142426.GV4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 10 02:45:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hlwn0-00081g-Kq
	for gcvg-git@gmane.org; Thu, 10 May 2007 02:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751682AbXEJApp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 20:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757253AbXEJApp
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 20:45:45 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:39329 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682AbXEJApo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 20:45:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510004544.OAVE2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 9 May 2007 20:45:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xClj1W00E1kojtg0000000; Wed, 09 May 2007 20:45:43 -0400
In-Reply-To: <20070509142426.GV4489@pasky.or.cz> (Petr Baudis's message of
	"Wed, 9 May 2007 16:24:26 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46818>

Petr Baudis <pasky@suse.cz> writes:

> diff --git a/git-commit.sh b/git-commit.sh
> index f28fc24..28cbb55 100755
> --- a/git-commit.sh
> +++ b/git-commit.sh
> @@ -432,7 +432,7 @@ fi
>  
>  if test "$log_message" != ''
>  then
> -	echo "$log_message"
> +	echo "$log_message" | fmt
>  elif test "$logfile" != ""

Two points.

 * You would not want to wrap the first line;

 * 75-column is not ideal for every project, so this needs to be
   customizable;

 * If we were to munge the given message, we would probably also
   want to enforce "single-liner summary, empty line, and then
   the rest" convention.

Well, I have three there, but I suspect the first two somebody else
may have said already, so...

This is slightly related, but I have been wondering about the
interaction with "single-liner summary, empty line and then the
rest" convention and various commands in the log family.

Currently, --pretty=oneline and --pretty=email (hence format-patch)
take and use only the first line.  I think we could change it to:

 - take the first paragraph, where the definition of the first
   paragraph is "skip all blank lines from the beginning, and
   then grab everything up to the next empty line".

 - replace all line breaks with a whitespace.

This change would not affect well-behaved commit messages that
adhere to the convention, as their first paragraph always
consist of a single line.  On the other hand, people from
different culture can get frustrated by their commit message
chomped at the first linebreak in the middle of sentence right
now, which would be helped by this change.

Their Subject: and --pretty=oneline output would become very
long and unsightly, but their commit messages are already
ugly anyway, and such a change at least avoid the loss of
information.

If we were to do this, Subject: line would most likely use
RFC2822 line folding at the places where line breaks were in the
original, but that goes without saying.

What do people think?
