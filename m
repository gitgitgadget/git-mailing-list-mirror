From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/7] builtin/log.c: stop using global patch_suffix
Date: Sat, 22 Dec 2012 00:33:28 -0800
Message-ID: <1356165212-5611-4-git-send-email-gitster@pobox.com>
References: <1356165212-5611-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 22 09:34:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TmKX0-0007tg-8C
	for gcvg-git-2@plane.gmane.org; Sat, 22 Dec 2012 09:34:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751212Ab2LVIdm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2012 03:33:42 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751060Ab2LVIdk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2012 03:33:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3BFA8284
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=hot6
	baY4RD/pn4Kbs48fwdTnG6Q=; b=LL/oIoitQxH8L/PK5Sg2D9lyfnlkrZUfbT6Y
	7jYNO1IMhDHTWfapXD+FL5encLEbHPanfbeYaIl2Op+hOvYJZOlwxSDCuggkMsno
	MJQSfvR4XhKO51GV5S3KeFAmOsrRD0qy0ITbXTHMCDmwXHG1RCADiG2qHXbasgEI
	FBx0WCQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=wT05VB
	1OLK+He4TtktuBjAKT+zWdae5RjvhpF1sVzmblamuEbHdozUy5bSj3ObopwglLsU
	2dNf3wHcF9EP1WEGBzn9nuOhok2n9cqlthZeHIEjIjd4FOw7ttO72+d/wknRFRIc
	mQNxIf/XuE6Pxy7EBuLfxdkBSIvbVf3w/peG0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E28628283
	for <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:39 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 695268282 for
 <git@vger.kernel.org>; Sat, 22 Dec 2012 03:33:39 -0500 (EST)
X-Mailer: git-send-email 1.8.1.rc2.227.g7335c9f
In-Reply-To: <1356165212-5611-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 491E3FE4-4C12-11E2-80C9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212042>

The suffix for the output filename is found in rev->patch_suffix; do
not keep using the global that is only used to parse the command
line and configuration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index f1d086e..7cf157e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -673,7 +673,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 			 struct rev_info *rev, int quiet)
 {
 	struct strbuf filename = STRBUF_INIT;
-	int suffix_len = strlen(fmt_patch_suffix) + 1;
+	int suffix_len = strlen(rev->patch_suffix) + 1;
 
 	if (output_directory) {
 		strbuf_addstr(&filename, output_directory);
@@ -684,7 +684,7 @@ static int reopen_stdout(struct commit *commit, const char *subject,
 			strbuf_addch(&filename, '/');
 	}
 
-	get_patch_filename(commit, subject, rev->nr, fmt_patch_suffix, &filename);
+	get_patch_filename(commit, subject, rev->nr, rev->patch_suffix, &filename);
 
 	if (!quiet)
 		fprintf(realstdout, "%s\n", filename.buf + outdir_offset);
-- 
1.8.0.6.gd28b5d4.dirty
