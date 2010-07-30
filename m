From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH] Documentation/rev-parse: quoting is required with --parseopt
Date: Fri, 30 Jul 2010 17:01:50 +0200
Message-ID: <8ef69f9855ca0719c03d7dac320b3a3beb657bca.1280501949.git.trast@student.ethz.ch>
References: <201007301643.50730.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Giuseppe Scrivano <gscrivano@gnu.org>,
	<msysgit@googlegroups.com>, Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 30 17:04:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oer8o-0000yA-56
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 17:04:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758750Ab0G3PBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jul 2010 11:01:53 -0400
Received: from gwse.ethz.ch ([129.132.178.237]:11797 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758745Ab0G3PBw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jul 2010 11:01:52 -0400
Received: from CAS10.d.ethz.ch (172.31.38.210) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 30 Jul
 2010 17:01:51 +0200
Received: from localhost.localdomain (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 30 Jul
 2010 17:01:51 +0200
X-Mailer: git-send-email 1.7.2.1.342.g676a4
In-Reply-To: <201007301643.50730.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152246>

When calling rev-parse --parseopt, as in the (now fixed) documented
example

  eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"

the outermost quoting is required, as otherwise all runs of arbitrary
whitespace inside the resulting 'set -- ...' call would be collapsed
into a single space.

This was exposed as a result of our new use of cat <<\EOF since
47e9cd2 (parseopt: wrap rev-parse --parseopt usage for eval
consumption, 2010-06-12), but has always been a problem when handling
arguments containing e.g. newlines.

Point this out in the documentation, and in particular correct the
example that did not have the quotes.

Noticed-by: Joshua Jensen <jjensen@workspacewhiz.com>
Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 Documentation/git-rev-parse.txt |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 0727f43..be4c053 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -184,10 +184,13 @@ scripts the same facilities C builtins have. It works as an option normalizer
 (e.g. splits single switches aggregate values), a bit like `getopt(1)` does.
 
 It takes on the standard input the specification of the options to parse and
-understand, and echoes on the standard output a line suitable for `sh(1)` `eval`
+understand, and echoes on the standard output a string suitable for `sh(1)` `eval`
 to replace the arguments with normalized ones.  In case of error, it outputs
 usage on the standard error stream, and exits with code 129.
 
+Note: Make sure you quote the result when passing it to `eval`.  See
+below for an example.
+
 Input Format
 ~~~~~~~~~~~~
 
@@ -244,7 +247,7 @@ bar=      some cool option --bar with an argument
   An option group Header
 C?        option C with an optional argument"
 
-eval `echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?`
+eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
 ------------
 
 SQ-QUOTE
-- 
1.7.2.1.342.g676a4
