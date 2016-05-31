From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t4014: shell portability fix
Date: Tue, 31 May 2016 15:53:15 -0700
Message-ID: <xmqqbn3l3kmc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 01 00:53:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7sXR-0007di-Em
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 00:53:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756630AbcEaWxV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 May 2016 18:53:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64797 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756572AbcEaWxT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2016 18:53:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C2C8203E2;
	Tue, 31 May 2016 18:53:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=RAj0bLn3pHqdYuf6CqBQdXmPW
	II=; b=Kvv4bN1W4IPOC24MbrOdoF4EMKvLTVUVp288lCKZhh+lISC4be5hDW7sR
	xxN21N+w/J9IzddHnAwDVfXEc9Q4/ewg+4cJkX7GuRh9ZbMlrHMJ/9FEHaFalMOl
	9H98JTJhTw05a92WlnPfcGVRTAnTM6ivyf97NOMV9ebvZVfHUE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=NB1dIngKYnGMPWl6Ve/
	h42P5+pRJuZd1gdLRwo9GdQG0euyDy8YnmXzsKfwg6eeySScTzP/2WTYxcdcsSVN
	b2/Nx6SDP1Ws3q2RR6+GYc+deDVUOOaX5mRR6r3AJjyucTkDcv9gCRnAFmSl5jW7
	VrYrfcb5b/AD8HLLgRAFXGwA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 25CEA203E1;
	Tue, 31 May 2016 18:53:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A3DD2203DF;
	Tue, 31 May 2016 18:53:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 76FB69EC-2782-11E6-B31B-89D312518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296028>

One-shot assignment to an environment variable, i.e.

	VAR=3DVAL cmd

does not work as expected for "cmd" that is a shell function on
certain shells.  test_commit _is_ a helper function and cannot be
driven that way portably.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t4014-format-patch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 8049cad..c3aa543 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1072,7 +1072,7 @@ test_expect_success '--from omits redundant in-bo=
dy header' '
 '
=20
 test_expect_success 'in-body headers trigger content encoding' '
-	GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc" test_commit exotic &&
+	(export GIT_AUTHOR_NAME=3D"=C3=A9x=C3=B6t=C3=ACc"; test_commit exotic=
) &&
 	test_when_finished "git reset --hard HEAD^" &&
 	git format-patch -1 --stdout --from >patch &&
 	cat >expect <<-\EOF &&
