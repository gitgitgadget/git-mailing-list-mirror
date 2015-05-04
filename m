From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] t1007: add hash-object --literally tests
Date: Mon,  4 May 2015 14:37:30 -0700
Message-ID: <1430775451-31130-4-git-send-email-gitster@pobox.com>
References: <1430724315-524-1-git-send-email-sunshine@sunshineco.com>
 <1430775451-31130-1-git-send-email-gitster@pobox.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 23:38:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpO3v-0001S7-An
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:38:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752331AbbEDVhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 17:37:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:62813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752128AbbEDVhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 17:37:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9148E4FA21;
	Mon,  4 May 2015 17:37:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=6/Cx
	9FI9dC2ol3shNxE43q+ghcA=; b=WLU39TMg2Nibj2nsdc2FhzBk70U878z5k/I+
	5ZLJaTugas5+4cykBmAPa8APT+aEqejTgQwoeI854rUfHXHM+T77AEsjWlsIPHLk
	tDzKSnlqKCxFK6zLvX0+0vHkM4Axf1H25Osuf0vMdANi5VgsMpufKWEMMQfQvn0l
	3/PAvkw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	e2gAWdFsZAjkQM2jlnvw8CfJ2iqIXIhL/OH/jUNuqDLFwd+fc52OPjhGwDJhH2AY
	vdVV6/5XmjLD88epilZ1s+isiEdxanTye0v0lT2EFVWiom2HCSLnhdB/X1cjosyL
	6s8gL3Op4he6TB51Xh3qp8qPnF9Fa6qHxpq1MknqN24=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A9F84FA20;
	Mon,  4 May 2015 17:37:37 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 150444FA1F;
	Mon,  4 May 2015 17:37:37 -0400 (EDT)
X-Mailer: git-send-email 2.4.0-307-g8f38e3e
In-Reply-To: <1430775451-31130-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: C83DE7B6-F2A5-11E4-85E9-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268362>

From: Eric Sunshine <sunshine@sunshineco.com>

git-hash-object learned a --literally option in 5ba9a93
(hash-object: add --literally option, 2014-09-11). Check that
--literally allows object creation with a bogus type, with two
type strings whose length is reasonably short and very long.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Almost as posted by Eric, but the fix happens earlier in the
   series so both tests expect to succeed.

 t/t1007-hash-object.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index f83df8e..7c3dcfb 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -201,4 +201,15 @@ test_expect_success 'corrupt tag' '
 	test_must_fail git hash-object -t tag --stdin </dev/null
 '
 
+test_expect_success '--literally' '
+	t=1234567890 &&
+	echo example | git hash-object -t $t --literally --stdin
+'
+
+test_expect_success '--literally with extra-long type' '
+	t=12345678901234567890123456789012345678901234567890 &&
+	t="$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t$t" &&
+	echo example | git hash-object -t $t --literally --stdin
+'
+
 test_done
-- 
2.4.0-302-g6743426
