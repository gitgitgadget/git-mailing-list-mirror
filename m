From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t0040: remove unused test helpers
Date: Fri, 06 May 2016 11:00:42 -0700
Message-ID: <xmqqeg9f3w39.fsf_-_@gitster.mtv.corp.google.com>
References: <xmqq7ff8b99q.fsf@gitster.mtv.corp.google.com>
	<20160505215056.28224-1-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 06 20:00:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayk3W-0000X1-7L
	for gcvg-git-2@plane.gmane.org; Fri, 06 May 2016 20:00:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758208AbcEFSAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 May 2016 14:00:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755867AbcEFSAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 May 2016 14:00:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 813BD179A8;
	Fri,  6 May 2016 14:00:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TU9T1AelDqi5T8KYg0mDOjM0xe4=; b=vnU7XL
	UNocqh2fiaaKbRmqt71pl7JNfUpra/jvgsSp5qj4+FcYEkl2iWkYhsgbe7jIF9Nd
	lC/amVZRTQ8VdmNN4vXeWSLZSI7kie4hqoXD3vra+bC8vGVOsKvsMcPipSZSMa3R
	cASev9Wf8IrgidRZn8ihK5Gu78auiqfZtXVJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gc5zlQ0fyFu1MzfYAcfXmxWcdIJs9A0p
	+yjD4+0uhx28lnDydHH4/+tx06cic3lgtQirGd/0YU0I/+r2uzzKRxE10qdoDgFS
	qq9KE4ZvPa6pdFLmIQTX7N5ua4WUqF7LfWjutiPbMtMGbVzrLNPEFisFDPL3+TR6
	RA9BX/SSUn8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7A97B179A7;
	Fri,  6 May 2016 14:00:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 02610179A6;
	Fri,  6 May 2016 14:00:43 -0400 (EDT)
In-Reply-To: <20160505215056.28224-1-gitster@pobox.com> (Junio C. Hamano's
	message of "Thu, 5 May 2016 14:50:53 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 73DC7AE4-13B4-11E6-8DB7-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293841>

9a001381 (Fix tests under GETTEXT_POISON on parseopt, 2012-08-27)
introduced check_i18n, but the helper was never used from the
beginning.

The same commit also introduced check_unknown_i18n to replace the
helper check_unknown and changed all users of the latter to use the
former, but failed to remove check_unknown itself.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0040-parse-options.sh | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index d678fbf..5c8c72a 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -81,30 +81,6 @@ check() {
 	test_cmp expect output
 }
 
-check_i18n() {
-	what="$1" &&
-	shift &&
-	expect="$1" &&
-	shift &&
-	sed "s/^$what .*/$what $expect/" <expect.template >expect &&
-	test-parse-options $* >output 2>output.err &&
-	test_must_be_empty output.err &&
-	test_i18ncmp expect output
-}
-
-check_unknown() {
-	case "$1" in
-	--*)
-		echo error: unknown option \`${1#--}\' >expect ;;
-	-*)
-		echo error: unknown switch \`${1#-}\' >expect ;;
-	esac &&
-	cat expect.err >>expect &&
-	test_must_fail test-parse-options $* >output 2>output.err &&
-	test_must_be_empty output &&
-	test_cmp expect output.err
-}
-
 check_unknown_i18n() {
 	case "$1" in
 	--*)
-- 
2.8.2-507-g43e827d
