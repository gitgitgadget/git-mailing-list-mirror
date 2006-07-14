From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Documentation: Fix ssh:// URLs in generated documentation
Date: Fri, 14 Jul 2006 14:46:21 -0700
Message-ID: <7vk66foo5u.fsf@assigned-by-dhcp.cox.net>
References: <11528726881431-git-send-email-alp@atoker.com>
	<1152872688966-git-send-email-alp@atoker.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 14 23:46:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G1VUY-0001BJ-Kj
	for gcvg-git@gmane.org; Fri, 14 Jul 2006 23:46:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945898AbWGNVqY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Jul 2006 17:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161311AbWGNVqY
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Jul 2006 17:46:24 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:55444 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1161306AbWGNVqX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jul 2006 17:46:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060714214622.KIQJ22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 14 Jul 2006 17:46:22 -0400
To: Alp Toker <alp@atoker.com>
In-Reply-To: <1152872688966-git-send-email-alp@atoker.com> (Alp Toker's
	message of "Fri, 14 Jul 2006 11:24:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23911>

Alp Toker <alp@atoker.com> writes:

> Commit c3f17061be95de3498449a548e93883aebff23d6 was causing warnings
> during doc generation due to bad asciidoc markup.

It seems that the '+++' quoting does not seem to work with older asciidoc.

However, I just noticed that what the text talks about is wrong
to begin with (not your fault):

> +	rsync://host.xz/path/to/repo.git/
> +	http://host.xz/path/to/repo.git/
> +	https://host.xz/path/to/repo.git/
> +	git://host.xz/path/to/repo.git/
> +	git://host.xz/~user/path/to/repo.git/
> +	ssh://[user@]host.xz/path/to/repo.git/
> +	ssh://[user@]host.xz/~user/path/to/repo.git/
> +	ssh://[user@]host.xz/~/path/to/repo.git
>  
>  SSH Is the default transport protocol and also supports an
>  scp-like syntax.  Both syntaxes support username expansion,
>  as does the native git protocol. The following three are
>  identical to the last three above, respectively:
>  
> +	host.xz:/path/to/repo.git/
> +	host.xz:~user/path/to/repo.git/
> +	host.xz:path/to/repo.git

So how about something like this instead, until people have up
to date asciidoc?

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 93378d2..a5519e5 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -10,12 +10,12 @@ to name the remote repository:
 - https://host.xz/path/to/repo.git/
 - git://host.xz/path/to/repo.git/
 - git://host.xz/~user/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/~user/path/to/repo.git/
-- ssh://+++[user@+++]host.xz/~/path/to/repo.git
+- ssh://host.xz/path/to/repo.git/
+- ssh://host.xz/~user/path/to/repo.git/
+- ssh://host.xz/~/path/to/repo.git
 ===============================================================
 
-SSH Is the default transport protocol and also supports an
+SSH is the default transport protocol and also supports an
 scp-like syntax.  Both syntaxes support username expansion,
 as does the native git protocol. The following three are
 identical to the last three above, respectively:
@@ -26,6 +26,10 @@ identical to the last three above, respe
 - host.xz:path/to/repo.git
 ===============================================================
 
+In addition, you can specify the name of the user to log in as
+by saying `ssh://user@host.xz/\...` and `user@host.xz:\...` for
+the SSH protocol.
+
 To sync with a local directory, use:
 
 ===============================================================
