From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] t7501: test the right kind of breakage
Date: Fri, 30 Mar 2012 12:45:17 -0700
Message-ID: <1333136719-12657-2-git-send-email-gitster@pobox.com>
References: <7vaa2ylzrm.fsf@alter.siamese.dyndns.org>
 <1333136719-12657-1-git-send-email-gitster@pobox.com>
Cc: Adam Monsen <haircut@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 30 21:45:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SDhlQ-0002lI-OQ
	for gcvg-git-2@plane.gmane.org; Fri, 30 Mar 2012 21:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760583Ab2C3TpZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Mar 2012 15:45:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55941 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758382Ab2C3TpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2012 15:45:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E6C7342F;
	Fri, 30 Mar 2012 15:45:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=0yfY
	SRo1JjAxhp9WRXntCNjsmlw=; b=fUcbA3blEf2V3msirHsHp3U5dP4JptDo4cWT
	gx+w20d+mFS6bi9XmtA/gtbV17oGMJwfSFsjFAiNk+YK6s0DYYDrnl4KWzRrgjiD
	q2yfELkjz+Ykree10yyVFlUhgXYihvTOWZ4uEyN/ZTffsmVaV1EB+C0nG9ulwhCh
	Fy4mLRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	VXlS+RaqBZlAD+yO+ILOoialwH0+6RLRWjWKj0Y01kl8iRfFQxAEoHvx3sV1SnAS
	tJ2qmjiqkpYaAEjlYhVTjCs8sHIQxkORofZM/caGSsKf1DMolcwvSfSKXHnogH+l
	leGGqfBiRRjCScob+5NoVhUlYbz8cdruHGYHp1TFsac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8587C342E;
	Fri, 30 Mar 2012 15:45:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1CD07342D; Fri, 30 Mar 2012
 15:45:23 -0400 (EDT)
X-Mailer: git-send-email 1.7.10.rc3.55.g06e99
In-Reply-To: <1333136719-12657-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: E3B23DC4-7AA0-11E1-8815-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194390>

These tests try to run "git commit" with various "forbidden" combinations
of options and expect the command to fail, but they do so without having
any change added to the index.  We wouldn't be able to catch breakages
that would allow these combinations by mistake with them because the
command will fail with "nothing to commit" anyway.

Make sure we have something added to the index before running the command.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7501-commit.sh |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index 8bb3833..45446b1 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -30,10 +30,12 @@ test_expect_success 'setup: initial commit' '
 '
 
 test_expect_success '-m and -F do not mix' '
+	git checkout HEAD file && echo >>file && git add file &&
 	test_must_fail git commit -m foo -m bar -F file
 '
 
 test_expect_success '-m and -C do not mix' '
+	git checkout HEAD file && echo >>file && git add file &&
 	test_must_fail git commit -C HEAD -m illegal
 '
 
-- 
1.7.10.rc3.55.g06e99
