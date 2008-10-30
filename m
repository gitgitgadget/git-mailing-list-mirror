From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] asciidoc: add minor workaround to add an empty line after
	code blocks
Date: Thu, 30 Oct 2008 11:45:03 +0100
Message-ID: <20081030104503.GA17131@diku.dk>
References: <87skqfus7v.fsf@iki.fi> <2c6b72b30810291235j554cc21dw4e3da4fdbfe633ee@mail.gmail.com> <87od13ujm4.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Oct 30 11:46:33 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvV2n-0002eG-Ka
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 11:46:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbYJ3KpJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 06:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753915AbYJ3KpI
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 06:45:08 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:59099 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753638AbYJ3KpH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 06:45:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 6C4B419BCB6;
	Thu, 30 Oct 2008 11:45:05 +0100 (CET)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12815-13; Thu, 30 Oct 2008 11:45:04 +0100 (CET)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 15A6019BC4A;
	Thu, 30 Oct 2008 11:45:04 +0100 (CET)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id A99896DF8B3; Thu, 30 Oct 2008 11:43:36 +0100 (CET)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id F231F1A4001; Thu, 30 Oct 2008 11:45:03 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <87od13ujm4.fsf@iki.fi>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99455>

Insert an empty <simpara> in manpages after code blocks to force and
empty line.

The problem can be seen on the manpage for the git tutorial, where an
example command and the following paragraph is printed with no empty
line between them:

     First, note that you can get documentation for a command such as git
     log --graph with:
 
         $ man git-log             
     It is a good idea to introduce yourself to git [...]

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/asciidoc.conf |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

 Teemu Likonen <tlikonen@iki.fi> wrote Thu, Oct 30, 2008:
 > In case someone is interested there is still a minor flaw that an
 > example command and the following paragraph is printed with no empty
 > line between them. Like in the beginning of "git help tutorial", for
 > example:
 > 
 >     First, note that you can get documentation for a command such as git
 >     log --graph with:
 > 
 >         $ man git-log             
 >     It is a good idea to introduce yourself to git [...]
 > 
 > It would be nicer if there was empty line after "$ man git-log". I can't
 > remember if this is new issue or not. This applies only to man pages; in
 > html pages there are nice boxes around example commands and equal
 > spacing before and after them.

 This is an old issue reported by Theodore Ts'o and fixed partially in
 commit 63c97ce228f2d2697a8ed954a9592dfb5f286338 for the URL section of
 the fetch/pull/push manpages. I have fixed this in tig using an
 approach similar to the attached. Simple and clean, but only tested
 with docbook-xsl version 1.72 so I have made it conditional.

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 40d43b7..2da867d 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -40,6 +40,26 @@ endif::doctype-manpage[]
 </literallayout>
 {title#}</example>
 endif::docbook-xsl-172[]
+
+ifdef::docbook-xsl-172[]
+ifdef::doctype-manpage[]
+# The following two small workarounds insert a simple paragraph after screen
+[listingblock]
+<example><title>{title}</title>
+<screen>
+|
+</screen><simpara></simpara>
+{title#}</example>
+
+[verseblock]
+<formalpara{id? id="{id}"}><title>{title}</title><para>
+{title%}<literallayout{id? id="{id}"}>
+{title#}<literallayout>
+|
+</literallayout><simpara></simpara>
+{title#}</para></formalpara>
+endif::doctype-manpage[]
+endif::docbook-xsl-172[]
 endif::backend-docbook[]
 
 ifdef::doctype-manpage[]
-- 
1.6.0.3.756.gb776d.dirty

-- 
Jonas Fonseca
