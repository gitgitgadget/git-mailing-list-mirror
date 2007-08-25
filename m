From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/2] pack-objects: check return value from read_sha1_file()
Date: Sat, 25 Aug 2007 01:30:27 -0700
Message-ID: <7v3ay86mos.fsf@gitster.siamese.dyndns.org>
References: <20070825072604.GA20155@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 25 10:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOr2Z-0003jA-Tw
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 10:30:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933570AbXHYIae (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 04:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765602AbXHYIad
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 04:30:33 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:38942 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933355AbXHYIab (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 04:30:31 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 73ECB127FB3;
	Sat, 25 Aug 2007 04:30:51 -0400 (EDT)
In-Reply-To: <20070825072604.GA20155@spearce.org> (Shawn O. Pearce's message
	of "Sat, 25 Aug 2007 03:26:04 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56628>

(Trivial #2).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-pack-objects.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 77481df..9b3ef94 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1356,6 +1356,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	/* Load data if not already done */
 	if (!trg->data) {
 		trg->data = read_sha1_file(trg_entry->idx.sha1, &type, &sz);
+		if (!trg->data)
+			die("object %s cannot be read",
+			    sha1_to_hex(trg_entry->idx.sha1));
 		if (sz != trg_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(trg_entry->idx.sha1), sz, trg_size);
@@ -1363,6 +1366,9 @@ static int try_delta(struct unpacked *trg, struct unpacked *src,
 	}
 	if (!src->data) {
 		src->data = read_sha1_file(src_entry->idx.sha1, &type, &sz);
+		if (!src->data)
+			die("object %s cannot be read",
+			    sha1_to_hex(src_entry->idx.sha1));
 		if (sz != src_size)
 			die("object %s inconsistent object length (%lu vs %lu)",
 			    sha1_to_hex(src_entry->idx.sha1), sz, src_size);
-- 
1.5.3.rc6.23.g0058
