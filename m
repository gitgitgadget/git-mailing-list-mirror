From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Tweak asciidoc output to work with broken docbook-xsl
Date: Sun, 05 Mar 2006 16:53:11 -0800
Message-ID: <7vr75gcs20.fsf@assigned-by-dhcp.cox.net>
References: <20060305231336.GA21797@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 06 01:54:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FG3yU-0001To-KT
	for gcvg-git@gmane.org; Mon, 06 Mar 2006 01:53:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750959AbWCFAxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Mar 2006 19:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWCFAxO
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Mar 2006 19:53:14 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:56522 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1750959AbWCFAxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Mar 2006 19:53:13 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060306004931.SWGI17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 5 Mar 2006 19:49:31 -0500
To: Francis Daly <francis@daoine.org>
In-Reply-To: <20060305231336.GA21797@craic.sysops.org> (Francis Daly's message
	of "Sun, 5 Mar 2006 23:13:36 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17255>

Francis Daly <francis@daoine.org> writes:

> docbook-xsl v1.68 incorrectly converts "<screen>" from docbook to
> manpage by not rendering it verbatim. v1.69 handles it correctly, but
> not many current popular distributions ship with it.
>
> asciidoc by default converts "listingblock" to "<screen>". This change
> causes asciidoc in git to convert "listingblock" to "<literallayout>", which
> both old and new docbook-xsl handle correctly.

Have you tested html generation side?  With 1.68 I seem to be
getting an disaster.

How about this instead?

---
diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index fa0877d..7ce7151 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -18,6 +18,16 @@ ifdef::backend-docbook[]
 {0#</citerefentry>}
 endif::backend-docbook[]
 
+ifdef::backend-docbook[]
+# "unbreak" docbook-xsl v1.68 for manpages. v1.69 works with or without this.
+[listingblock]
+<example><title>{title}</title>
+<literallayout>
+|
+</literallayout>
+{title#}</example>
+endif::backend-docbook[]
+
 ifdef::backend-xhtml11[]
 [gitlink-inlinemacro]
 <a href="{target}.html">{target}{0?({0})}</a>
