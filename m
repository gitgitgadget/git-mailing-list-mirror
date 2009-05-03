From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug in git diff --unified=0 ?
Date: Sat, 02 May 2009 17:17:36 -0700
Message-ID: <7vocub59b3.fsf@alter.siamese.dyndns.org>
References: <20090502234701.GL23604@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun May 03 02:17:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M0POo-0001AA-IV
	for gcvg-git-2@gmane.org; Sun, 03 May 2009 02:17:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbZECARg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 May 2009 20:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752833AbZECARf
	(ORCPT <rfc822;git-outgoing>); Sat, 2 May 2009 20:17:35 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:60436 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752301AbZECARf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 May 2009 20:17:35 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090503001734.UBZF25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Sat, 2 May 2009 20:17:34 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id moHa1b0094aMwMQ04oHaAE; Sat, 02 May 2009 20:17:34 -0400
X-Authority-Analysis: v=1.0 c=1 a=4fBY6cwzPQcA:10 a=oAYF_C9AAAAA:8
 a=uZvujYp8AAAA:8 a=SguRkLujtVg9GKqfeIkA:9 a=1bouTXG3VQXRG5llD3IfOOJ4K9UA:4
 a=R0wQ3QzoQ0IA:10 a=ZzzmQ2vsvfXHKPPg:21 a=xcViucIrp9oLZyTS:21
X-CM-Score: 0.00
In-Reply-To: <20090502234701.GL23604@spearce.org> (Shawn O. Pearce's message of "Sat\, 2 May 2009 16\:47\:01 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118153>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I can't decide if this is a bug in JGit, or a bug in CGit, or just
> an area where the patch format is very unclear.
>
> The following 2 patches are identical, but use different context:
>
> git diff --unified=1:
>
>     diff --git a/X b/X
>     index a3648a1..2d44096 100644
>     --- a/X
>     +++ b/X
>     @@ -2,2 +2,3 @@
>      b
>     +c
>      d
>     @@ -16,4 +17,2 @@
>      q
>     -r
>     -s
>      t
>
> git diff --unified=0:
>
>     diff --git a/X b/X
>     index a3648a1..2d44096 100644
>     --- a/X
>     +++ b/X
>     @@ -2,0 +3 @@
>     +c
>     @@ -17,2 +17,0 @@
>     -r
>     -s
>     
> Now lets look at JGit's output of that last patch, unified=0:
>
>     diff --git a/X b/X
>     index a3648a1..2d44096 100644
>     --- a/X
>     +++ b/X
>     @@ -3,0 +3,1 @@
>     +c
>     @@ -17,2 +18,0 @@
>     -r
>     -s

I do not know what the current status of the POSIX draft for spliting
"context diff" format into "copied context" and "unified context", but
see http://www.opengroup.org/austin/aardvark/latest/xcubug2.txt for the
definition that was on track the last time I checked.

    First the range of lines in each file shall be written in the
    following format:

    "@@^-%s^+%s^@@", <file1 range>, <file2 range>

    Each <range> field shall be of the form:

   "%1d", <beginning line number>

    if the range contains exactly one line, and:

   "%1d,%1d", <beginning line number>, <number of lines>

    otherwise.  If a range is empty, its beginning line number shall be
    the number of the line just before the range, or 0 if the empty
    range starts the file.

So, JGit is wrong.
