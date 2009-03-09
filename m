From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 5/4] parseopt: document KEEP_ARGV0, KEEP_UNKNOWN, NO_INTERNAL_HELP
Date: Mon, 09 Mar 2009 21:26:56 +0100
Message-ID: <49B57B90.4060409@lsrfire.ath.cx>
References: <7vfxhs2shk.fsf@gitster.siamese.dyndns.org> <49B2C784.90800@lsrfire.ath.cx> <49B40A9F.7050408@lsrfire.ath.cx> <7vvdqjkbka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, carlos.duclos@nokia.com,
	Pierre Habouzit <madcoder@madism.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 09 21:28:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lgm5P-0005mP-OZ
	for gcvg-git-2@gmane.org; Mon, 09 Mar 2009 21:28:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbZCIU1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Mar 2009 16:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752386AbZCIU1B
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Mar 2009 16:27:01 -0400
Received: from india601.server4you.de ([85.25.151.105]:36361 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZCIU1A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Mar 2009 16:27:00 -0400
Received: from [10.0.1.101] (p57B7F24E.dip.t-dialin.net [87.183.242.78])
	by india601.server4you.de (Postfix) with ESMTPSA id 6C9FC2F8063;
	Mon,  9 Mar 2009 21:26:58 +0100 (CET)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
In-Reply-To: <7vvdqjkbka.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112737>

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Documentation/technical/api-parse-options.txt |   27 +++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/Documentation/technical/api-parse-options.txt b/Documentation/technical/api-parse-options.txt
index 539863b..dc72987 100644
--- a/Documentation/technical/api-parse-options.txt
+++ b/Documentation/technical/api-parse-options.txt
@@ -66,6 +66,12 @@ Steps to parse options
 non-option arguments in `argv[]`.
 `argc` is updated appropriately because of the assignment.
 +
+You can also pass NULL instead of a usage array as fourth parameter of
+parse_options(), to avoid displaying a help screen with usage info and
+option list.  This should only be done if necessary, e.g. to implement
+a limited parser for only a subset of the options that needs to be run
+before the full parser, which in turn shows the full help message.
++
 Flags are the bitwise-or of:
 
 `PARSE_OPT_KEEP_DASHDASH`::
@@ -77,6 +83,27 @@ Flags are the bitwise-or of:
 	Using this flag, processing is stopped at the first non-option
 	argument.
 
+`PARSE_OPT_KEEP_ARGV0`::
+	Keep the first argument, which contains the program name.  It's
+	removed from argv[] by default.
+
+`PARSE_OPT_KEEP_UNKNOWN`::
+	Keep unknown arguments instead of erroring out.  This doesn't
+	work for all combinations of arguments as users might expect
+	it to do.  E.g. if the first argument in `--unknown --known`
+	takes a value (which we can't know), the second one is
+	mistakenly interpreted as a known option.  Similarly, if
+	`PARSE_OPT_STOP_AT_NON_OPTION` is set, the second argument in
+	`--unknown value` will be mistakenly interpreted as a
+	non-option, not as a value belonging to the unknown option,
+	stopping the parser early.
+
+`PARSE_OPT_NO_INTERNAL_HELP`::
+	By default, parse_options() handles `-h`, `--help` and
+	`--help-all` internally, by showing a help screen.  This option
+	turns it off and allows one to add custom handlers for these
+	options, or to just leave them unknown.
+
 Data Structure
 --------------
 
-- 
1.6.2
