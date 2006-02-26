From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use setenv(), fix warnings
Date: Sun, 26 Feb 2006 10:06:41 -0800
Message-ID: <7vmzge570u.fsf@assigned-by-dhcp.cox.net>
References: <20060226171346.33ad3e47.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 19:07:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDQII-00037p-So
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 19:06:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbWBZSGp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 13:06:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751377AbWBZSGp
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 13:06:45 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:37844 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751362AbWBZSGp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 13:06:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060226180328.CQYZ17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 13:03:28 -0500
To: Timo Hirvonen <tihirvon@gmail.com>
In-Reply-To: <20060226171346.33ad3e47.tihirvon@gmail.com> (Timo Hirvonen's
	message of "Sun, 26 Feb 2006 17:13:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16785>

Timo Hirvonen <tihirvon@gmail.com> writes:

>   - Use setenv() instead of putenv()
>   - Fix -Wundef -Wold-style-definition warnings
>   - Make pll_free() static

I think the last one makes sense, and I can see why some people
may prefer -Wundef but I am not sure about the first one.  Care
to defend why we should prefer setenv()?  IIRC, initially we did
not use setenv() anywhere because certain platforms only had
putenv().

> diff --git a/fsck-objects.c b/fsck-objects.c
> @@ -483,7 +483,7 @@ int main(int argc, char **argv)
>  	if (standalone && check_full)
>  		die("Only one of --standalone or --full can be used.");
>  	if (standalone)
> -		putenv("GIT_ALTERNATE_OBJECT_DIRECTORIES=");
> +		setenv("GIT_ALTERNATE_OBJECT_DIRECTORIES", "", 1);

For platforms with only putenv we did this; here, what we really
wanted to do was unsetenv.
