From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/5] git-rerere: detect unparsable conflicts
Date: Sun, 22 Jun 2008 02:47:46 -0700
Message-ID: <7viqw1ol6l.fsf@gitster.siamese.dyndns.org>
References: <20080616110113.GA22945@elte.hu>
 <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080616190911.GA7047@elte.hu>
 <7vskvd9kai.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Sun Jun 22 11:48:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAMBj-0006BW-5l
	for gcvg-git-2@gmane.org; Sun, 22 Jun 2008 11:48:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbYFVJry (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Jun 2008 05:47:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751491AbYFVJry
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jun 2008 05:47:54 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:37752 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306AbYFVJrx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jun 2008 05:47:53 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 5D9F3A358;
	Sun, 22 Jun 2008 05:47:52 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B13C7A357; Sun, 22 Jun 2008 05:47:49 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 48290E1C-4040-11DD-86A1-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85757>

rerere did not detect the case where <<< === >>> markers did not match.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-rerere.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 610b96a..addc5c7 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -144,6 +144,11 @@ static int handle_file(const char *path,
 		fclose(out);
 	if (sha1)
 		SHA1_Final(sha1, &ctx);
+	if (hunk) {
+		if (output)
+			unlink(output);
+		return error("Could not parse conflict hunks in %s", path);
+	}
 	return hunk_no;
 }
 
-- 
1.5.6.12.g73f03
