From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: [PATCH] blame.c: Properly initialize strbuf after calling textconv_object(),
 again
Date: Mon, 07 Nov 2011 16:53:10 +0100
Message-ID: <4EB7FEE6.9000609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 16:55:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNRXv-0003fx-8S
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 16:55:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651Ab1KGPzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 10:55:33 -0500
Received: from lo.gmane.org ([80.91.229.12]:41850 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932553Ab1KGPzc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 10:55:32 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1RNRXn-0003bs-KB
	for git@vger.kernel.org; Mon, 07 Nov 2011 16:55:31 +0100
Received: from jambul.zib.de ([130.73.68.203])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 16:55:31 +0100
Received: from sschuberth by jambul.zib.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 07 Nov 2011 16:55:31 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: jambul.zib.de
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12) Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184989>

2564aa4 started to initialize buf.alloc, but that should actually be one
more byte than the string length due to the trailing \0.
---
 builtin/blame.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 86c0537..45f0dcc 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2114,7 +2114,7 @@ static struct commit *fake_working_tree_commit(struct diff_options *opt,
 		case S_IFREG:
 			if (DIFF_OPT_TST(opt, ALLOW_TEXTCONV) &&
 			    textconv_object(read_from, mode, null_sha1, &buf.buf, &buf_len)) {
-				buf.alloc = buf_len;
+				buf.alloc = buf_len + 1;
 				buf.len = buf_len;
 			}
 			else if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
-- 
1.7.8.rc0.46.g5ae0f.dirty
