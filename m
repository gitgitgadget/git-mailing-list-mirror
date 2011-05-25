From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t0021: test application of both crlf and ident
Date: Tue, 24 May 2011 19:18:28 -0700
Message-ID: <7vlixv5xqj.fsf_-_@alter.siamese.dyndns.org>
References: <1305961127-26540-1-git-send-email-gitster@pobox.com>
 <1305961127-26540-5-git-send-email-gitster@pobox.com>
 <4DD82931.6000101@lsrfire.ath.cx> <4DD82DB2.8000101@lsrfire.ath.cx>
 <7vy61v612b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 25 04:18:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QP3gI-0002fO-E3
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 04:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753111Ab1EYCSh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 May 2011 22:18:37 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:58165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751648Ab1EYCSg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2011 22:18:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12C525D78;
	Tue, 24 May 2011 22:20:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RGZ7LXApqd8N
	pt9oVv1LqkaCXao=; b=wtx8N7AyxT3pwiyi7Hh06t5h9eNN38Ts+ci2DdkoNh/M
	M1DNqo4udyYlelH56D79/31B5atc4NZberILbZ4ybXAvaDy6TWMU6nbD5kO5Bnor
	ryfOw8S0k3aX7GI/O3mGjqVgi32GaeqLjZccCB/o3GwOCPVlrkAxC+oto9kz3JY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OtIuYE
	YSCRfbLW8Sxjxjle5B1RQk4o5LyQF0g5H8YB5tPSNt4hbBmPbTH52KikMI/tDYYI
	iotmoE/S0+STsIV3+uOL2dnMHWSXfGOKo5l/qkr1Oo3aLIoK1IY+jvJ/KoBCe/eN
	DSirex3ww8KI53N00ryBDZ1ZRlHrJMo+Uh1v0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id E42AE5D77;
	Tue, 24 May 2011 22:20:40 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B302D5D76; Tue, 24 May 2011
 22:20:37 -0400 (EDT)
In-Reply-To: <7vy61v612b.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 24 May 2011 18:06:36 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9617128A-8675-11E0-836E-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174367>


Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This comes on top of Ren=C3=A9's updates to the test.=20

 t/t0021-conversion.sh |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 275421e..f19e651 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -66,10 +66,14 @@ test_expect_success expanded_in_repo '
 		echo "\$Id:NoSpaceAtEitherEnd\$"
 		echo "\$Id: NoTerminatingSymbol"
 		echo "\$Id: Foreign Commit With Spaces \$"
-		printf "\$Id: NoTerminatingSymbolAtEOF"
-	} > expanded-keywords &&
+	} >expanded-keywords.0 &&
=20
-	git add expanded-keywords &&
+	{
+		cat expanded-keywords.0 &&
+		printf "\$Id: NoTerminatingSymbolAtEOF"
+	} >expanded-keywords &&
+	cat expanded-keywords >expanded-keywords-crlf &&
+	git add expanded-keywords expanded-keywords-crlf &&
 	git commit -m "File with keywords expanded" &&
 	id=3D$(git rev-parse --verify :expanded-keywords) &&
=20
@@ -83,15 +87,27 @@ test_expect_success expanded_in_repo '
 		echo "\$Id: $id \$"
 		echo "\$Id: NoTerminatingSymbol"
 		echo "\$Id: Foreign Commit With Spaces \$"
+	} >expected-output.0 &&
+	{
+		cat expected-output.0 &&
 		printf "\$Id: NoTerminatingSymbolAtEOF"
-	} > expected-output &&
+	} >expected-output &&
+	{
+		append_cr <expected-output.0 &&
+		printf "\$Id: NoTerminatingSymbolAtEOF"
+	} >expected-output-crlf &&
+	{
+		echo "expanded-keywords ident"
+		echo "expanded-keywords-crlf ident text eol=3Dcrlf"
+	} >>.gitattributes &&
=20
-	echo "expanded-keywords ident" >> .gitattributes &&
+	rm -f expanded-keywords expanded-keywords-crlf &&
=20
-	rm -f expanded-keywords &&
 	git checkout -- expanded-keywords &&
-	cat expanded-keywords &&
-	cmp expanded-keywords expected-output
+	test_cmp expanded-keywords expected-output &&
+
+	git checkout -- expanded-keywords-crlf &&
+	test_cmp expanded-keywords-crlf expected-output-crlf
 '
=20
 # The use of %f in a filter definition is expanded to the path to
--=20
1.7.5.2.483.gc61ca
