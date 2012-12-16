From: John Keeping <john@keeping.me.uk>
Subject: [PATCH v2] Documentation: don't link to example mail addresses
Date: Sun, 16 Dec 2012 14:00:29 +0000
Message-ID: <20121216140029.GE2725@river.lan>
References: <20121215150314.GC2725@river.lan>
 <20121215172018.GA18696@sigill.intra.peff.net>
 <20121215182408.GD2725@river.lan>
 <20121216120405.GA14320@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Dec 16 15:08:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkEt1-0001k5-Ol
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 15:08:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753072Ab2LPOFx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 09:05:53 -0500
Received: from anakin.london.02.net ([87.194.255.134]:39022 "EHLO
	anakin.london.02.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753029Ab2LPOFx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 09:05:53 -0500
X-Greylist: delayed 315 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Dec 2012 09:05:52 EST
Received: from river.lan (188.222.177.116) by anakin.london.02.net (8.5.140)
        id 4FED9D1503C523B5; Sun, 16 Dec 2012 14:00:29 +0000
Content-Disposition: inline
In-Reply-To: <20121216120405.GA14320@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211592>

Email addresses in documentation are converted into mailto: hyperlinks
in the HTML output and footnotes in man pages.  This isn't desirable for
cases where the address is used as an example and is not valid.

Particularly annoying is the example "jane@laptop.(none)" which appears
in git-shortlog(1) as "jane@laptop[1].(none)", with note 1 saying:

	1. jane@laptop
	   mailto:jane@laptop

Fix this by escaping these email addresses with a leading backslash, to
prevent Asciidoc expanding them as inline macros.

In the case of mailmap.txt, render the address monospaced so that it
matches the block examples surrounding that paragraph.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: John Keeping <john@keeping.me.uk>
---

On Sun, Dec 16, 2012 at 07:04:05AM -0500, Jeff King wrote:
> Furthermore, the right way to suppress
> expansion of macros is with a backslash escape.
[snipped an example]
> I think it's a little less ugly
> than the "$$" quoting, but not by much. No clue if one is accepted by
> more asciidoc versions or not.

>From a quick reading of the Asciidoc changelog, I think backslash
escaping should be supported just as well as "$$" quoting, which leaves
the minimal patch looking like this.

 Documentation/git-fast-import.txt | 2 +-
 Documentation/git-tag.txt         | 2 +-
 Documentation/mailmap.txt         | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index d1844ea..68bca1a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -427,7 +427,7 @@ they made it.
 
 Here `<name>` is the person's display name (for example
 ``Com M Itter'') and `<email>` is the person's email address
-(``cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
+(``\cm@example.com'').  `LT` and `GT` are the literal less-than (\x3c)
 and greater-than (\x3e) symbols.  These are required to delimit
 the email address from the other fields in the line.  Note that
 `<name>` and `<email>` are free-form and may contain any sequence
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 247534e..2f1c0c3 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -129,7 +129,7 @@ This option is only applicable when listing tags without annotation lines.
 CONFIGURATION
 -------------
 By default, 'git tag' in sign-with-default mode (-s) will use your
-committer identity (of the form "Your Name <your@email.address>") to
+committer identity (of the form "Your Name <\your@email.address>") to
 find a key.  If you want to use a different default key, you can specify
 it in the repository configuration as follows:
 
diff --git a/Documentation/mailmap.txt b/Documentation/mailmap.txt
index 288f04e..dd89fca 100644
--- a/Documentation/mailmap.txt
+++ b/Documentation/mailmap.txt
@@ -46,7 +46,7 @@ Jane Doe         <jane@desktop.(none)>
 Joe R. Developer <joe@example.com>
 ------------
 
-Note how there is no need for an entry for <jane@laptop.(none)>, because the
+Note how there is no need for an entry for `<jane@laptop.(none)>`, because the
 real name of that author is already correct.
 
 Example 2: Your repository contains commits from the following
-- 
1.8.0.2
