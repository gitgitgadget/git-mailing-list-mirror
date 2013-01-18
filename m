From: John Keeping <john@keeping.me.uk>
Subject: [RFC/PATCH] CodingGuidelines: add Python code guidelines
Date: Fri, 18 Jan 2013 18:06:39 +0000
Message-ID: <20130118180639.GD31172@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Pete Wyckoff <pw@padd.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 18 19:07:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwGLS-0005hb-7J
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 19:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751849Ab3ARSGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jan 2013 13:06:53 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:46978 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507Ab3ARSGw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jan 2013 13:06:52 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3EE9E19808A;
	Fri, 18 Jan 2013 18:06:52 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4vvtUF8NULvw; Fri, 18 Jan 2013 18:06:51 +0000 (GMT)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by coyote.aluminati.org (Postfix) with ESMTP id 742D0198078;
	Fri, 18 Jan 2013 18:06:51 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 5F68A161E59E;
	Fri, 18 Jan 2013 18:06:51 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FzBhHeODHczY; Fri, 18 Jan 2013 18:06:51 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 25437161E3A8;
	Fri, 18 Jan 2013 18:06:41 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213920>

These are kept short by simply deferring to PEP-8.  Most of the Python
code in Git is already very close to this style (some things in contrib/
are not).

Rationale for version suggestions:

 - Amongst the noise in [2], there isn't any disagreement about using
   2.6 as a base (see also [3]).

 - The Git INSTALL document currently says:

      Python version 2.6 or later is needed to use the git-p4
      interface to Perforce.

 - Restricting ourselves to 2.6+ makes aiming for Python 3 compatibility
   significantly easier [4].

 - Following Pete's comment [5] I tested Python 2.6.0 and it does
   support bytes literals, as suggested by [4] but contradicted by [6].

 - Advocating Python 3 support in all scripts is currently unrealistic
   because:

     - 'p4 -G' provides output in a format that is very hard to use with
       Python 3 (and its documentation claims Python 3 is unsupported).

     - Mercurial does not support Python 3.

     - Bazaar does not support Python 3.

 - But we should try to make new scripts compatible with Python 3
   because all new Python development is happening on version 3 and the
   Python community will eventually stop supporting Python 2 [7].

I chose to recommend `from __future__ import unicode_literals` since it
provides the widest range of compatibility (2.6+ and 3.0+) while
allowing us to be explicit about bytes vs. Unicode.  The alternative
would be to advocate using the 'u' prefix on Unicode strings but this
isn't available in versions 3.0 - 3.2 (it is reintroduced in version 3.3
as a no-op in order to make it easier to write scripts targeting a wide
range of Python versions without needing to use 2to3 [1]).  In reality I
doubt we will ever need to worry about this since ASCII strings will
just work in both Python 2 and Python 3.

[1] http://www.python.org/dev/peps/pep-0414/
[2] http://thread.gmane.org/gmane.comp.version-control.git/210329
[3] http://article.gmane.org/gmane.comp.version-control.git/210429
[4] http://docs.python.org/3.3/howto/pyporting.html#try-to-support-python-2-6-and-newer-only
[5] http://article.gmane.org/gmane.comp.version-control.git/213830
[6] http://docs.python.org/2.6/reference/lexical_analysis.html#literals
[7] http://www.python.org/dev/peps/pep-0404/
---
 Documentation/CodingGuidelines | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 69f7e9b..baf3b41 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -179,6 +179,22 @@ For C programs:
  - Use Git's gettext wrappers to make the user interface
    translatable. See "Marking strings for translation" in po/README.
 
+For Python scripts:
+
+ - We follow PEP-8 (http://www.python.org/dev/peps/pep-0008/).
+
+ - As a minimum, we aim to be compatible with Python 2.6 and 2.7.
+
+ - Where required libraries do not restrict us to Python 2, we try to
+   also be compatible with Python 3.  In this case we use
+   `from __future__ import unicode_literals` if we need to differentiate
+   Unicode string literals, rather than prefixing Unicode strings with
+   'u' since the latter is not supported in Python versions 3.0 - 3.2.
+
+ - We use the 'b' prefix for bytes literals.  Note that even though
+   the Python documentation for version 2.6 does not mention this
+   prefix it is supported since version 2.6.0.
+
 Writing Documentation:
 
  Every user-visible change should be reflected in the documentation.
-- 
1.8.1
