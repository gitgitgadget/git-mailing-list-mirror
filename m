From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t2202: make sure "git add" (no args) stays a no-op
Date: Fri, 19 Jul 2013 21:35:23 -0700
Message-ID: <7vvc45svas.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 06:35:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0OtJ-0004Xa-Li
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 06:35:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952Ab3GTEf1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jul 2013 00:35:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50463 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750796Ab3GTEf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jul 2013 00:35:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCDB52BE4A;
	Sat, 20 Jul 2013 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=r
	0m7VnEPb9QdEusuGfnOVsOnVss=; b=Gao+kuyp0e7BMdeJkkeRhGlumSiYWjCg5
	8ETtlVGV79cHS/NCvqJS00SJYtI31BOlKohfm3WmYASRbWyrlHZYcIbpAPN1NaOJ
	ibHI5sB4ENw5a5t6EZB6eOKopjFERbxFT+3KidKej01GgIwYnOx5rUzHEC0veG44
	j7rmGNjvb4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=pyA
	Mkdbt/3+/jxPSRcD7cXzEQSJgKY8zceizlpnjVrWKJ/ARd5sAi0Q45Cuzc71SJJm
	0k4QelVXQKWXJVzy8grW5LKStGDcC7X1jcFDLp2NuXU//UwmX4yDQ5+cQEnRP7An
	Qo22ydjzKphx5BqscO/aYhtW3kYhahRX3Knknsy4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D2FAE2BE42;
	Sat, 20 Jul 2013 04:35:25 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 43F3C2BE3E;
	Sat, 20 Jul 2013 04:35:25 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CBE35288-F0F5-11E2-8550-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230872>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t2202-add-addremove.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t2202-add-addremove.sh b/t/t2202-add-addremove.sh
index 6a81510..fc8b59e 100755
--- a/t/t2202-add-addremove.sh
+++ b/t/t2202-add-addremove.sh
@@ -41,4 +41,14 @@ test_expect_success 'git add --all' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Just "git add" is a no-op' '
+	git reset --hard &&
+	echo >will-remove &&
+	>will-not-be-added &&
+	git add &&
+	git diff-index --name-status --cached HEAD >actual &&
+	>expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
1.8.3.3-1028-g038de5b
