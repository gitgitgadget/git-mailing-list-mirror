From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 24/25] rev-parse: A and B in "rev-parse A..B" refer to
 committish
Date: Tue,  3 Jul 2012 14:37:14 -0700
Message-ID: <1341351435-31011-25-git-send-email-gitster@pobox.com>
References: <1341351435-31011-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 03 23:39:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SmAp5-0007vc-MH
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 23:39:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932999Ab2GCVjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 17:39:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755850Ab2GCViE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 17:38:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 305AE86A5
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=/lMD
	zcZWI8u7vsOovXhzZxB4Qjc=; b=haSuoFaMhN6BH9w4/g/lOQPfIMULznMXawty
	0dPtH6AE4q/AVQEUvrlpT44ts2GrbFgubPOiOhuf2oimgysukekEeeWjO09ASTvU
	OtRHG3e8+OUZVqvgI+CjSW9U5WVe/GRIyW0YVw2xTpl0AZ97lQ6KX7M1Wp2s3Fhu
	q4qn6bY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=r8Uk1W
	Fe9ShBiTA8DvpMNSMTg3S69IMjJGAxVVRQTxuZuTpGiSTsEVsnzyMp9/7h47N3EI
	ftnmx6ZnPtVoH/XNFVqekjl681nLscbi653facVSCU9YDxz9ZkbwL28s372Ub4DQ
	93zEztH77s5JWHCyRcYUM+Ck0RCS/NY49Rq70=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 280C386A4
	for <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:04 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B36C486A3 for
 <git@vger.kernel.org>; Tue,  3 Jul 2012 17:38:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.1.229.g706c98f
In-Reply-To: <1341351435-31011-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5E94A01C-C557-11E1-9E30-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200970>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/rev-parse.c                 | 4 ++--
 t/t1512-rev-parse-disambiguation.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 98d1cbe..16b98b5 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -238,7 +238,7 @@ static int try_difference(const char *arg)
 		next = "HEAD";
 	if (dotdot == arg)
 		this = "HEAD";
-	if (!get_sha1(this, sha1) && !get_sha1(next, end)) {
+	if (!get_sha1_committish(this, sha1) && !get_sha1_committish(next, end)) {
 		show_rev(NORMAL, end, next);
 		show_rev(symmetric ? NORMAL : REVERSED, sha1, this);
 		if (symmetric) {
@@ -278,7 +278,7 @@ static int try_parent_shorthands(const char *arg)
 		return 0;
 
 	*dotdot = 0;
-	if (get_sha1(arg, sha1))
+	if (get_sha1_committish(arg, sha1))
 		return 0;
 
 	if (!parents_only)
diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index c3b78b9..9acaf1d 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -111,7 +111,7 @@ test_expect_success 'log name1..name2 takes only commit-ishes on both ends' '
 	git log 11021982...
 '
 
-test_expect_failure 'rev-parse name1..name2 takes only commit-ishes on both ends' '
+test_expect_success 'rev-parse name1..name2 takes only commit-ishes on both ends' '
 	git rev-parse 11021982..11021982 &&
 	git rev-parse ..11021982 &&
 	git rev-parse 11021982..
-- 
1.7.11.1.229.g706c98f
