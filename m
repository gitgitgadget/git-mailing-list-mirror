From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] "git-tag -s" should create a signed annotated tag
Date: Sun, 25 Nov 2007 15:21:42 -0800
Message-ID: <7vprxxj4hl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos Rica <jasampler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 26 00:22:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwQni-0004vD-AO
	for gcvg-git-2@gmane.org; Mon, 26 Nov 2007 00:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756093AbXKYXVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Nov 2007 18:21:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755730AbXKYXVw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 18:21:52 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:41859 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755622AbXKYXVv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 18:21:51 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id EEA4C2F9;
	Sun, 25 Nov 2007 18:22:12 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 811E999BFB;
	Sun, 25 Nov 2007 18:22:10 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66026>

The earlier patch 396865859918e9c7bf8ce74aae137c57da134610 (Make
builtin-tag.c use parse_options.) broke "git-tag -s".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It's _very_ disturbing that the testsuite did not catch this
   breakage, even though I though we had a very detailed coverage for
   "git tag" when it was rewritten in C.

 builtin-tag.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 3a6467d..114c684 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -398,6 +398,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, options, git_tag_usage, 0);
 
+	if (sign)
+		annotate = 1;
+
 	if (list)
 		return list_tags(list == no_pattern ? NULL : list, lines);
 	if (delete)
