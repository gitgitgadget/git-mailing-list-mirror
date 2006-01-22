From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Mention install-doc in INSTALL
Date: Sat, 21 Jan 2006 19:29:02 -0800
Message-ID: <7vr771gcu9.fsf@assigned-by-dhcp.cox.net>
References: <E1F0SYe-0005ix-WB@puzzle.fieldses.org>
	<20060122001255.GR28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 22 04:29:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0Vuq-0002NA-Ej
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 04:29:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbWAVD3G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 22:29:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbWAVD3F
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 22:29:05 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:910 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S932147AbWAVD3E (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 22:29:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060122032702.FQIL17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 21 Jan 2006 22:27:02 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060122001255.GR28365@pasky.or.cz> (Petr Baudis's message of
	"Sun, 22 Jan 2006 01:12:55 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15042>

Petr Baudis <pasky@suse.cz> writes:

> But you really do not want to build the documentation as root.

True.

> Cogito's "solution" is:
>
> + - By default, separate documentation (manpages, text, HTML) is not built
> +   since it requires asciidoc and xmlto, and those tools are not so common.

That's cheating ;-), but I cannot blame you.

I'll push out this hopefully tonight.

---
From: J. Bruce Fields <bfields@fieldses.org>
Date: Sat Jan 21 18:54:12 2006 -0500
[PATCH] Mention install-doc in INSTALL

I think most people will want to install the man pages as well.

[jc: incorporated Pasky's comment on not building them as root.
Some people may not want to install asciidoc/xmlto toolchain, so
redirect them to the man and html branches of the git.git
repository as well.]

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 INSTALL |   28 ++++++++++++++++++++++++++--
 1 files changed, 26 insertions(+), 2 deletions(-)

eff351c957975055643f2e1359652ab3aac30256
diff --git a/INSTALL b/INSTALL
index 916ddd4..433449f 100644
--- a/INSTALL
+++ b/INSTALL
@@ -5,8 +5,8 @@ Normally you can just do "make" followed
 will install the git programs in your own ~/bin/ directory.  If you want
 to do a global install, you can do
 
-	$ make prefix=/usr ;# as yourself
-	# make prefix=/usr install ;# as root
+	$ make prefix=/usr all doc ;# as yourself
+	# make prefix=/usr install install-doc ;# as root
 
 (or prefix=/usr/local, of course).  Just like any program suite
 that uses $prefix, the built results have some paths encoded,
@@ -90,3 +90,27 @@ Issues of note:
    You can place local settings in config.mak and the Makefile
    will include them.  Note that config.mak is not distributed;
    the name is reserved for local settings.
+
+ - To build and install documentation suite, you need to have the
+   asciidoc/xmlto toolchain.  Alternatively, pre-formatted
+   documentation are available in "html" and "man" branches of the git
+   repository itself.  For example, you could:
+
+	$ mkdir manual && cd manual
+	$ git init-db
+	$ git clone-pack git://git.kernel.org/pub/scm/git/git.git man html |
+	  while read a b
+	  do
+	    echo $a >.git/$b
+	  done
+	$ cp .git/refs/heads/man .git/refs/heads/master
+	$ git checkout
+
+   to checkout the pre-built man pages.  Also in this repository:
+
+	$ git checkout html
+
+   would instead give you a copy of what you see at:
+
+	http://www.kernel.org/pub/software/scm/git/docs/
+
-- 
1.1.4.g73f3
