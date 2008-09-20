From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 4/4] diff.c: convert builtin funcname patterns to
 non-GNU extended regex syntax
Date: Sat, 20 Sep 2008 00:02:58 -0700
Message-ID: <7vtzcb47vh.fsf@gitster.siamese.dyndns.org>
References: <7vskry1485.fsf@gitster.siamese.dyndns.org>
 <4i0Mu795rKpv37JoHytmE6kODBjwgwITn0-DuKdZiFs3ZnUlyJC-Fw@cipher.nrlssc.navy.mil> <7v7i97swv3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Andreas Ericsson <ae@op5.se>, Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Gustaf Hendeby <hendeby@isy.liu.se>,
	Jonathan del Strother <maillist@steelskies.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Sat Sep 20 09:05:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgwWZ-0000Vf-V7
	for gcvg-git-2@gmane.org; Sat, 20 Sep 2008 09:05:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbYITHDj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Sep 2008 03:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbYITHDj
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Sep 2008 03:03:39 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43215 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbYITHDi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Sep 2008 03:03:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 9DDB2630F4;
	Sat, 20 Sep 2008 03:03:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 4C6F9630E7; Sat, 20 Sep 2008 03:03:00 -0400 (EDT)
In-Reply-To: <7v7i97swv3.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri, 19 Sep 2008 13:29:20 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3F6E37FA-86E2-11DD-9540-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96335>

Junio C Hamano <gitster@pobox.com> writes:

> Neither has [4/4] on it.  I'd like two patches so that:
>
>  * [PATCH 1/2] applies to bc/maint-diff-hunk-header-fix, so that the
>    languages in 1.6.0.2 are fixed for non GNU platforms;
>
>  * After applying [1/2] to bc/maint-diff-hunk-header-fix, I'll merge the
>    branch to bc/master-diff-hunk-header-fix and then...
>
>  * [PATCH 2/2] applies on top of it to convert new languages that are
>    supported only on 'master' to use xfuncname.

If you apply the previous one on top of 45d9414 (diff.*.xfuncname which
uses "extended" regex's for hunk header selection, 2008-09-18), and then
merge the result to dde4af4 (Merge branch 'bc/maint-diff-hunk-header-fix'
into bc/master-diff-hunk-header-fix, 2008-09-18), you will get some
trivial conflicts.  This patch is [2/2] that applies on top of that merge,
and should result in this:

static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
	  REG_EXTENDED },
	{ "html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$", REG_EXTENDED },
	{ "java",
	  "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
	  "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
	  REG_EXTENDED },
	{ "pascal",
	  "^((procedure|function|constructor|destructor|interface|"
		"implementation|initialization|finalization)[ \t]*.*)$"
	  "|"
	  "^(.*=[ \t]*(class|record).*)$",
	  REG_EXTENDED },
	{ "php", "^[\t ]*((function|class).*)", REG_EXTENDED },
	{ "python", "^[ \t]*((class|def)[ \t].*)$", REG_EXTENDED },
	{ "ruby", "^[ \t]*((class|module|def)[ \t].*)$",
	  REG_EXTENDED },
	{ "tex",
	  "^(\\\\((sub)*section|chapter|part)\\*{0,1}\{.*)$",
	  REG_EXTENDED },
};

-- >8 --
Subject: [PATCH] diff: use extended regexp to find hunk headers

Using ERE elements such as "|" (alternation) by backquoting in BRE
is a GNU extension and should not be done in portable programs.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 5b9b074..a733010 100644
--- a/diff.c
+++ b/diff.c
@@ -1406,7 +1406,7 @@ static const struct funcname_pattern_entry *funcname_pattern(const char *ident)
 static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
 	{ "bibtex", "(@[a-zA-Z]{1,}[ \t]*\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
 	  REG_EXTENDED },
-	{ "html", "^\\s*\\(<[Hh][1-6]\\s.*>.*\\)$", 0 },
+	{ "html", "^[ \t]*(<[Hh][1-6][ \t].*>.*)$", REG_EXTENDED },
 	{ "java",
 	  "!^[ \t]*(catch|do|for|if|instanceof|new|return|switch|throw|while)\n"
 	  "^[ \t]*(([ \t]*[A-Za-z_][A-Za-z_0-9]*){2,}[ \t]*\\([^;]*)$",
@@ -1417,8 +1417,8 @@ static const struct funcname_pattern_entry builtin_funcname_pattern[] = {
 	  "|"
 	  "^(.*=[ \t]*(class|record).*)$",
 	  REG_EXTENDED },
-	{ "php", "^[\t ]*\\(\\(function\\|class\\).*\\)", 0 },
-	{ "python", "^\\s*\\(\\(class\\|def\\)\\s.*\\)$", 0 },
+	{ "php", "^[\t ]*((function|class).*)", REG_EXTENDED },
+	{ "python", "^[ \t]*((class|def)[ \t].*)$", REG_EXTENDED },
 	{ "ruby", "^[ \t]*((class|module|def)[ \t].*)$",
 	  REG_EXTENDED },
 	{ "tex",
-- 
1.6.0.2.414.g0bf11
