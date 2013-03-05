From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] reflog: fix typo in "reflog expire" clean-up codepath
Date: Tue, 05 Mar 2013 13:39:06 -0800
Message-ID: <7vtxopsf0l.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 05 22:39:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UCzaH-00013t-Bq
	for gcvg-git-2@plane.gmane.org; Tue, 05 Mar 2013 22:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752593Ab3CEVjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Mar 2013 16:39:11 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59573 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752467Ab3CEVjJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Mar 2013 16:39:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE4EDBE62;
	Tue,  5 Mar 2013 16:39:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=F
	jL0NYqIFGfx0fyvh7rzTroc8rc=; b=eIQZkZD2vdxmaOOZUepi8ySzxmt3CnVHW
	9ZeIFnMDRKctYL/dsnFVBlVVFOzXWr7XE/EPNPpjnKknZAvXngygyxkkV/FqKGbo
	0dBHeGEOyB2YlGurJkWZgHR+sbzghvokQCEf4UFmhalQa1JqMOP0CY197/Kesoqe
	OYmq2Wct9Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=oYP
	XXsjab4l5jPBhAT4F9aGxAqf6XFNvw9pi4zQHzfXGjSLiSWUvrmE1XM8LJ0mwdxz
	Yly3JW+AGuqXABIkZVXE/8hHJfAuP+a0OoGaOLZiAuQi2c2YOnHPQTdmepPhiOI4
	149+OgGNkpFS9etoRNR4Bad0MmJxqstkiTekStzA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E32D3BE60;
	Tue,  5 Mar 2013 16:39:08 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4C4DDBE5E; Tue,  5 Mar 2013
 16:39:08 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1C4E761E-85DD-11E2-B87D-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217485>

In "reflog expire" we were not clearing the REACHABLE bit from
objects reachable from the tip of refs we marked earlier.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/reflog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index b3c9e27..ef56e7b 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -414,7 +414,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 		if (cb.unreachable_expire_kind == UE_HEAD) {
 			struct commit_list *elem;
 			for (elem = tips; elem; elem = elem->next)
-				clear_commit_marks(tip_commit, REACHABLE);
+				clear_commit_marks(elem->item, REACHABLE);
 			free_commit_list(tips);
 		} else {
 			clear_commit_marks(tip_commit, REACHABLE);
-- 
1.8.2-rc2-187-g1ea4a7c
