From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/14] t5520: test pulling an octopus into an unborn branch
Date: Sat, 25 Apr 2015 22:25:56 -0700
Message-ID: <1430025967-24479-4-git-send-email-gitster@pobox.com>
References: <xmqqiocqli1c.fsf@gitster.dls.corp.google.com>
 <1430025967-24479-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 26 07:26:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YmF5J-0002kU-8a
	for gcvg-git-2@plane.gmane.org; Sun, 26 Apr 2015 07:26:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751144AbbDZF0R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2015 01:26:17 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51177 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751102AbbDZF0N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2015 01:26:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EE915466E8;
	Sun, 26 Apr 2015 01:26:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=79t3
	OS3NL8Tb4Q4N+P66tJy5mWU=; b=EqOi5ExEjmWq9KAW2CzYGLWXJ8GaB9i7xjMT
	1wHmjxT49mPzfvhrZvZ94DD/bK2+vb3ylmIu2mIcDre37Atb43F0GHA4Cfz5Z+yW
	8JMjLl5xvL1hAq4Ha7WSiB6BhQOHUwxXjdekftACM8E1yMH4Z83+lUxXmsGshEF7
	fmWmY0Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=Fih8ya
	UiDEjhqkQWc7n9zIt4AoNxfm3Uhi1d1FE+4nEPL1SHLI7vkbj1rdVTN8z95VMW/1
	uqaXVWjzO4sJ20oExymtkIE0VlkEovnyZcETn+rwzb5W4ZVxt76i64YAhM9RZ0KS
	tJU3ntkIAx198JELP8G8CirCfZHC0RidbEe7c=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E77B0466E7;
	Sun, 26 Apr 2015 01:26:12 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A79B466E6;
	Sun, 26 Apr 2015 01:26:12 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-rc3-238-g36f5934
In-Reply-To: <1430025967-24479-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C093E5C4-EBD4-11E4-A9FB-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267811>

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
2.4.0-rc3-238-g36f5934
