From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .gitattributes: CR at the end of the line is an error
Date: Sun, 21 Jun 2009 02:31:21 -0700
Message-ID: <7vvdmqrl06.fsf@alter.siamese.dyndns.org>
References: <20090619194253.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Jun 21 11:32:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MIJPn-0003XE-Oy
	for gcvg-git-2@gmane.org; Sun, 21 Jun 2009 11:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752492AbZFUJb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2009 05:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbZFUJb1
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Jun 2009 05:31:27 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35695 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZFUJb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2009 05:31:26 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090621093125.IURJ2915.fed1rmmtao103.cox.net@fed1rmimpo02.cox.net>;
          Sun, 21 Jun 2009 05:31:25 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6ZXQ1c0024aMwMQ04ZXQr8; Sun, 21 Jun 2009 05:31:25 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=9iTIXA1uRrgA:10 a=UQnXkbzPAAAA:8
 a=WxnEEQXvtg9fcQzu8eAA:9 a=Je74_75V21mXMSXep0lEbnmOpU4A:4 a=Q21-j9j7q-gA:10
X-CM-Score: 0.00
In-Reply-To: <20090619194253.6117@nanako3.lavabit.com> (Nanako Shiraishi's message of "Fri\, 19 Jun 2009 19\:42\:53 +0900")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121976>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> When a CR is accidentally added at the end of a C source file in the git
> project tree, "git diff --check" doesn't detect it as an error.
>
>     $ echo abQ | tr Q '\015' >>fast-import.c
>     $ git diff --check
>
> I think this is because the "whitespace" attribute is set to *.[ch] files
> without specifying what kind of errors are caught. It makes git "notice
> all types of errors" (as described in the documentation), but I think it
> is incorrectly setting cr-at-eol, too, and hides this error.
>
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---
>
> diff --git a/.gitattributes b/.gitattributes
> index 6b9c715..bb03350 100644
> --- a/.gitattributes
> +++ b/.gitattributes
> @@ -1,2 +1,2 @@
>  * whitespace=!indent,trail,space
> -*.[ch] whitespace
> +*.[ch] whitespace=indent,trail,space
>

I like the result of applying this patch to my tree.

A "whitespace" attribute that is Set, which is what the original has, is
defined to "notice all types of errors known to git", it is a poor way to
define the project policy, which was what 14f9e12 (Define the project
whitespace policy, 2008-02-10) tried to do.  It means the policy will
silently change when newer git learns to detect more types of whitespace
errors.

And it never meant to allow trailing carriage-returns.  I think the
implementation of whitespace attribute handling is broken.
