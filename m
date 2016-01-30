From: Moritz Neeb <lists@moritzneeb.de>
Subject: [PATCH 2/5] clean: read user input with strbuf_getline()
Date: Sat, 30 Jan 2016 19:04:45 +0100
Message-ID: <56ACFB3D.6010309@moritzneeb.de>
References: <56ACF82B.2030005@moritzneeb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jan 30 19:06:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPZui-0007JI-Th
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 19:06:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933245AbcA3SGJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 13:06:09 -0500
Received: from moritzneeb.de ([78.47.1.106]:48377 "EHLO moritzneeb.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932981AbcA3SGE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 13:06:04 -0500
Received: from [192.168.1.11] (x4db33e5e.dyn.telefonica.de [77.179.62.94])
	by moritzneeb.de (Postfix) with ESMTPSA id 9E6781C04E
	for <git@vger.kernel.org>; Sat, 30 Jan 2016 19:06:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=moritzneeb.de;
	s=mail; t=1454177163;
	bh=ClFR6u3s3pMMVtomp05kVeDtdwlUSYWVTXBWvXtwagg=;
	h=From:Subject:References:To:Date:In-Reply-To:From;
	b=bAP/UFWdHjDdgsA/0gR4R8m5POTvRWXgKXR+zoc15zoSyZC5xxRsyTuWE+dCmB9HK
	 7Uu81KqW/nIdpBrH25aIIq+Ubf0hiA7YPx5UFxlBGqeiodtdsFnDREDH6sljculrsv
	 i3Lx+vb/fCicWCbDWhxcsIWgn3elc668Dk8icavM=
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
In-Reply-To: <56ACF82B.2030005@moritzneeb.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285122>

    The input that is read is trimmed with strbuf_trim() immediately.
    There is thus no logic expecting CR, so strbuf_getline_lf() can be
    replaced by its CRLF counterpart.

Signed-off-by: Moritz Neeb <lists@moritzneeb.de>
---
 builtin/clean.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 7b08237..956283d 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -570,7 +570,7 @@ static int *list_and_choose(struct menu_opts *opts, struct menu_stuff *stuff)
 			       clean_get_color(CLEAN_COLOR_RESET));
 		}
 -		if (strbuf_getline_lf(&choice, stdin) != EOF) {
+		if (strbuf_getline(&choice, stdin) != EOF) {
 			strbuf_trim(&choice);
 		} else {
 			eof = 1;
@@ -652,7 +652,7 @@ static int filter_by_patterns_cmd(void)
 		clean_print_color(CLEAN_COLOR_PROMPT);
 		printf(_("Input ignore patterns>> "));
 		clean_print_color(CLEAN_COLOR_RESET);
-		if (strbuf_getline_lf(&confirm, stdin) != EOF)
+		if (strbuf_getline(&confirm, stdin) != EOF)
 			strbuf_trim(&confirm);
 		else
 			putchar('\n');
@@ -750,7 +750,7 @@ static int ask_each_cmd(void)
 			qname = quote_path_relative(item->string, NULL, &buf);
 			/* TRANSLATORS: Make sure to keep [y/N] as is */
 			printf(_("Remove %s [y/N]? "), qname);
-			if (strbuf_getline_lf(&confirm, stdin) != EOF) {
+			if (strbuf_getline(&confirm, stdin) != EOF) {
 				strbuf_trim(&confirm);
 			} else {
 				putchar('\n');
-- 
2.4.3
