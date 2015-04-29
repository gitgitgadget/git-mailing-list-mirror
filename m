From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/15] t5520: test pulling an octopus into an unborn branch
Date: Wed, 29 Apr 2015 14:29:22 -0700
Message-ID: <1430342973-30344-5-git-send-email-gitster@pobox.com>
References: <1430025967-24479-1-git-send-email-gitster@pobox.com>
 <1430342973-30344-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 29 23:29:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnZYJ-0006RW-0U
	for gcvg-git-2@plane.gmane.org; Wed, 29 Apr 2015 23:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbbD2V3o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2015 17:29:44 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57099 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750940AbbD2V3m (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2015 17:29:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A04DF4DAA3;
	Wed, 29 Apr 2015 17:29:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=aVuF
	QWdhBEPdgB3KR1wFdqIq/uk=; b=K2e+CJGLFyTiWXMzRApT9oP+3SIf0aRT+Xnk
	fzH3snh32BaxpdbDvgYeRjLviaB4qt+xACDQDznnbWVbxo5k9IVfnUUOqLjbVloj
	nzeGSxW6EdEtZ+1XknPtfHG1AaC51pCpk0T6i9X+D6MlEGDif6uZvSEv3d5FHqQF
	nGvWH1c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=eL2A0y
	2YWyQ7A43xe6TUuj1J9HmpIHehgvOrtxtze4nlTMZ2T7qTCfwEFmNboIfeIu3q6f
	c0QTXzovwSxq13hQTe0PlmUjSCeHkCAZuQNf6I+o5a7uSnDAqozsgY5pYZRZKKZY
	SGL4+TC3vMVWz9HzFsvadKqoOlcloLbFxX9K4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 97CF64DAA0;
	Wed, 29 Apr 2015 17:29:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1B91C4DA9F;
	Wed, 29 Apr 2015 17:29:41 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-300-g052d062
In-Reply-To: <1430342973-30344-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D879B6F2-EEB6-11E4-8CAA-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268016>

The code comment for "git merge" in builtin/merge.c, we say

    If the merged head is a valid one there is no reason
    to forbid "git merge" into a branch yet to be born.
    We do the same for "git pull".

and t5520 does have an existing test for that behaviour.  However,
there was no test to make sure that 'git pull' to pull multiple
branches into an unborn branch must fail.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5520-pull.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 5195a21..7efd45b 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -76,6 +76,15 @@ test_expect_success 'pulling into void does not remove new staged files' '
 	)
 '
 
+test_expect_success 'pulling into void must not create an octopus' '
+	git init cloned-octopus &&
+	(
+		cd cloned-octopus &&
+		test_must_fail git pull .. master master &&
+		! test -f file
+	)
+'
+
 test_expect_success 'test . as a remote' '
 
 	git branch copy master &&
-- 
2.4.0-rc3-300-g052d062
