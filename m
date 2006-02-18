From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-cvs-import retries
Date: Fri, 17 Feb 2006 23:27:48 -0800
Message-ID: <7v1wy1t9cb.fsf@assigned-by-dhcp.cox.net>
References: <mj+md-20060217.193146.10308.albireo@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 08:28:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FAMVt-0004ZP-Iy
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 08:28:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750965AbWBRH1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 02:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750967AbWBRH1u
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 02:27:50 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37345 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750965AbWBRH1u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Feb 2006 02:27:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060218072447.RNPR17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 18 Feb 2006 02:24:47 -0500
To: Martin Mares <mj@ucw.cz>
In-Reply-To: <mj+md-20060217.193146.10308.albireo@ucw.cz> (Martin Mares's
	message of "Fri, 17 Feb 2006 20:38:05 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16396>

Martin Mares <mj@ucw.cz> writes:

> Hello!
>...
> This patch extends the retry check and makes the symptoms go away.
> However, take it with a grain of salt as I don't understand yet why the
> connection is aborted.
>
> 				Have a nice fortnight
> -- 
> Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
> Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
> A jury consists of 12 persons chosen to decide who has the better lawyer.
>
>
> Signed-Off-By: Martin Mares <mj@ucw.cz>
>
> --- old/git-cvsimport	2006-02-17 13:02:24.000000000 +0100

First, one technicality.  You can see what's wrong with the
above, right?  Remember, the top part of your message goes into
the commit log, so we do not want "Hello!" nor signature.

> +++ new/git-cvsimport	2006-02-17 18:13:06.000000000 +0100
> @@ -371,7 +371,7 @@
>  
>  	$self->_file($fn,$rev) and $res = $self->_line($fh);
>  
> -	if (!defined $res) {
> +	if (!defined $res || $res eq '') {
>  	    # retry
>  	    $self->conn();
>  	    $self->_file($fn,$rev)

I read _line() three times but its return value is the lexical
variable $res which is initialized to 0 and then either reset to
0 by assignment or updated with $res += somethingelse.  So I do
not see how you can get a defined but empty string in there.
Even when _file() returns false, the $res variable in file()
(the function you are modifying) is not initialized, so it would
stay undefined.

Maybe I am missing something very obvious, but I cannot see how
this can make any difference.  Please enlighten.
