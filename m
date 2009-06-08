From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix handling of iconv configuration options
Date: Mon, 08 Jun 2009 14:50:13 -0700
Message-ID: <7vhbyqwg2y.fsf@alter.siamese.dyndns.org>
References: <3a3d9e520906071745k1fde4215xba310d945db37979@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Marco Nelissen <marcone@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon Jun 08 23:50:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDmjZ-0004xK-WA
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 23:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753857AbZFHVuQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 17:50:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753243AbZFHVuP
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 17:50:15 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:52400 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751013AbZFHVuP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 17:50:15 -0400
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090608215015.IWYT25927.fed1rmmtao106.cox.net@fed1rmimpo03.cox.net>;
          Mon, 8 Jun 2009 17:50:15 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 1ZqG1c0094aMwMQ04ZqGv9; Mon, 08 Jun 2009 17:50:16 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=Zkrp7XEca30A:10 a=fyr7q5YMh3YA:10
 a=bkO6awWE48XItVD-usQA:9 a=iQ6dBXb_b0bg8WsMeNy94ImKBxgA:4
X-CM-Score: 0.00
In-Reply-To: <3a3d9e520906071745k1fde4215xba310d945db37979@mail.gmail.com> (Marco Nelissen's message of "Sun\, 7 Jun 2009 17\:45\:48 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121116>

Marco Nelissen <marcone@xs4all.nl> writes:

> diff --git a/configure.ac b/configure.ac
> index 108a97f..3388036 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -385,6 +385,8 @@ AC_SUBST(NO_EXPAT)
>  # some Solaris installations).
>  # Define NO_ICONV if neither libc nor libiconv support iconv.
>
> +if test -z $NO_ICONV; then
> +
>  GIT_STASH_FLAGS($ICONVDIR)
>
>  AC_DEFUN([ICONVTEST_SRC], [
> @@ -431,6 +433,12 @@ GIT_UNSTASH_FLAGS($ICONVDIR)
>  AC_SUBST(NEEDS_LIBICONV)
>  AC_SUBST(NO_ICONV)
>
> +if test -n $NO_ICONV; then
> +    NEEDS_LIBICONV=
> +fi
> +
> +fi
> +

Hmm, have you tested this with both NO_ICONV defined and undefined?

Because ...

	$ test -z ; echo $?
        0
	$ test -n ; echo $?
        0

... I would feel better if you had dq around $NO_ICONV in both tests.
