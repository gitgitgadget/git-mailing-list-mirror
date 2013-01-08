From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 08/10] test: add test for --use-mailmap option
Date: Mon,  7 Jan 2013 16:10:19 -0800
Message-ID: <1357603821-8647-9-git-send-email-gitster@pobox.com>
References: <1357603821-8647-1-git-send-email-gitster@pobox.com>
Cc: Antoine Pelisse <apelisse@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 08 01:11:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsMms-0006ta-9A
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 01:11:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756175Ab3AHALE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 19:11:04 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50378 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756166Ab3AHAKl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 19:10:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86ED6B7C4;
	Mon,  7 Jan 2013 19:10:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=J3BV
	v+Oj1oL6TlHi1mKXWlqPMT8=; b=a+dycONfB1Tee1PJpYGRsX7FQ4gWVEkHbTWS
	Rgg8s/NmSaS+xJCPOXDSp0qYWX+APcDwE8eXDGfk4FPTw4pjjHVEJTKR2kRjF3Tg
	LJOTWk5V/Zi+DcEyCgMvDTlSh28dNyo2cay0Gk9VuYd/7ySi0zl+sQqqOoOzWauB
	HUHCvug=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	DQpy518cmvSSLTMxckhOfaMtzIHaQP5MxpcDvhPDmcwEnykxHzmMuUhMLZ0xZNBV
	uQ9oy8qXvUM7UOQFgWM0X0P4uspIBxjDkzK6DKhepQ5iasFH4iJmXH7QIS0nhXw9
	qb7aZwm9Q1U+o7oX+0gw4Wo3sk4NwODTs42fPnOvz7Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 79726B7C3;
	Mon,  7 Jan 2013 19:10:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2ED6B7C0; Mon,  7 Jan 2013
 19:10:40 -0500 (EST)
X-Mailer: git-send-email 1.8.1.304.gf036638
In-Reply-To: <1357603821-8647-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: D650211C-5927-11E2-8C02-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212931>

From: Antoine Pelisse <apelisse@gmail.com>

The new option '--use-mailmap' can be used to make sure that mailmap
file is used to convert name when running log commands.

The test is simple and checks that the Author line
is correctly replaced when running log.

Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4203-mailmap.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 1f182f6..db043dc 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -239,6 +239,20 @@ test_expect_success 'Log output (complex mapping)' '
 	test_cmp expect actual
 '
 
+cat >expect <<\EOF
+Author: CTO <cto@company.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Santa Claus <santa.claus@northpole.xx>
+Author: Other Author <other@author.xx>
+Author: Other Author <other@author.xx>
+Author: Some Dude <some@dude.xx>
+Author: A U Thor <author@example.com>
+EOF
+test_expect_success 'Log output with --use-mailmap' '
+	git log --use-mailmap | grep Author >actual &&
+	test_cmp expect actual
+'
+
 # git blame
 cat >expect <<\EOF
 ^OBJI (A U Thor     DATE 1) one
-- 
1.8.1.304.gf036638
