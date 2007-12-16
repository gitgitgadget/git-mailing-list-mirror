From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] builtin-commit: make summary output consistent with status
Date: Sun, 16 Dec 2007 15:12:25 -0800
Message-ID: <7vwsregrom.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712151507420.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 00:13:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J42fO-0006i7-9Z
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 00:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757881AbXLPXMh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 18:12:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757806AbXLPXMh
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 18:12:37 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33436 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757644AbXLPXMg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 18:12:36 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3659F43D4;
	Sun, 16 Dec 2007 18:12:32 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id B87F643D3;
	Sun, 16 Dec 2007 18:12:29 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712151507420.5349@iabervon.org> (Daniel
	Barkalow's message of "Sat, 15 Dec 2007 15:29:18 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68502>

This enables -B -M to the summary output after a commit is made so that
it is in line with what is shown in git-status and commit log template.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * And this fixes the "7 files" because print_summary() does not pass -B
   -M which makes it inconsistent with the status output.  After this
   you should see "6 files".

 builtin-commit.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 61770ef..0a91013 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -662,6 +662,9 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	rev.show_root_diff = 1;
 	rev.commit_format = get_commit_format("format:%h: %s");
 	rev.always_show_header = 0;
+	rev.diffopt.detect_rename = 1;
+	rev.diffopt.rename_limit = 100;
+	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
 	printf("Created %scommit ", initial_commit ? "initial " : "");
-- 
1.5.4.rc0.52.gb90ce
