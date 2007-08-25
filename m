From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/2] blame: check return value from read_sha1_file()
Date: Sat, 25 Aug 2007 01:30:04 -0700
Message-ID: <7v7ink6mpf.fsf@gitster.siamese.dyndns.org>
References: <20070825072604.GA20155@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 10:30:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOr2Z-0003jA-DE
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 10:30:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761312AbXHYIa0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 04:30:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933607AbXHYIaZ
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 04:30:25 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933585AbXHYIaJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 04:30:09 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CD51F127FB3;
	Sat, 25 Aug 2007 04:30:28 -0400 (EDT)
In-Reply-To: <20070825072604.GA20155@spearce.org> (Shawn O. Pearce's message
	of "Sat, 25 Aug 2007 03:26:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56629>

(Trivial #1).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-blame.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 0519339..dc88a95 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -98,6 +98,10 @@ static char *fill_origin_blob(struct origin *o, mmfile_t *file)
 		num_read_blob++;
 		file->ptr = read_sha1_file(o->blob_sha1, &type,
 					   (unsigned long *)(&(file->size)));
+		if (!file->ptr)
+			die("Cannot read blob %s for path %s",
+			    sha1_to_hex(o->blob_sha1),
+			    o->path);
 		o->file = *file;
 	}
 	else
@@ -1384,6 +1388,9 @@ static void get_commit_info(struct commit *commit,
 		unsigned long size;
 		commit->buffer =
 			read_sha1_file(commit->object.sha1, &type, &size);
+		if (!commit->buffer)
+			die("Cannot read commit %s",
+			    sha1_to_hex(commit->object.sha1));
 	}
 	ret->author = author_buf;
 	get_ac_line(commit->buffer, "\nauthor ",
@@ -2382,6 +2389,10 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 		sb.final_buf = read_sha1_file(o->blob_sha1, &type,
 					      &sb.final_buf_size);
+		if (!sb.final_buf)
+			die("Cannot read blob %s for path %s",
+			    sha1_to_hex(o->blob_sha1),
+			    path);
 	}
 	num_read_blob++;
 	lno = prepare_lines(&sb);
-- 
1.5.3.rc6.23.g0058
