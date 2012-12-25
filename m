From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t9200: let "cvs init" create the test repository
Date: Mon, 24 Dec 2012 17:09:49 -0800
Message-ID: <7vr4mflyxu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 25 02:10:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TnJ27-0004ks-0H
	for gcvg-git-2@plane.gmane.org; Tue, 25 Dec 2012 02:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753403Ab2LYBJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Dec 2012 20:09:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46290 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab2LYBJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Dec 2012 20:09:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9C989AB19;
	Mon, 24 Dec 2012 20:09:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=A
	UbhkrqLHRRYs/793elaJhxzplo=; b=ubPdzQAeuNk6xNMnD/6dvUxm3Bh8uQig5
	fWd9KJmR+5fPAIjrA3co2tjdt8ASraKJJIAvLeYMVUWexPNhFzkLecLMAEQuOXXP
	D7fpepdcssG/ppjoECt+S6H0HzXN9dc+HBZKVivQWaz1bIwXOfKjzKinb53d+XMM
	LV1Bn+I1Cc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=ved
	4emmxA/0FkZY6ZcQvGAUI9x/0v36BfWw1r7JOQmZg1A0Placdzyq3hN/EVx3fTlm
	iyV6rQGglEeeDaKnU58UnHTIyRFQSAOf/NBpp+g2Grw5RvpkUmf1BsCEwRh6Tsrz
	Yt7T7Y3s2ih/9f5121bz7ikwWAQtUz8T/ewU+KJg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 899B3AB18;
	Mon, 24 Dec 2012 20:09:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E435CAB16; Mon, 24 Dec 2012
 20:09:50 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C8898972-4E2F-11E2-B54C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212120>

Some platforms (e.g. NetBSD 6.3) seem to configure their CVS to
allow "cvs init" in an existing directory only to members of
"cvsadmin".

Instead of preparing an empty directory and then running "cvs init"
on it, let's run "cvs init" and let it create the necessary
directory.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t9200-git-cvsexportcommit.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcommit.sh
index b59be9a..c5368a3 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -25,8 +25,9 @@ GIT_DIR=$PWD/.git
 export CVSROOT CVSWORK GIT_DIR
 
 rm -rf "$CVSROOT" "$CVSWORK"
-mkdir "$CVSROOT" &&
+
 cvs init &&
+test -d "$CVSROOT" &&
 cvs -Q co -d "$CVSWORK" . &&
 echo >empty &&
 git add empty &&
