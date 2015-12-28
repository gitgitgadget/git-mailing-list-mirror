From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 07/10] t5100-mailinfo.sh: use the $( ... ) construct for command substitution
Date: Sun, 27 Dec 2015 17:59:16 -0800
Message-ID: <xmqq37unbaff.fsf@gitster.mtv.corp.google.com>
References: <1450798073-22811-1-git-send-email-gitter.spiros@gmail.com>
	<1450798073-22811-8-git-send-email-gitter.spiros@gmail.com>
	<567997E4.1000700@kdbg.org> <5679B3E2.7090406@kdbg.org>
	<xmqq7fjzbgkr.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 02:59:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aDN5q-0002Vp-F4
	for gcvg-git-2@plane.gmane.org; Mon, 28 Dec 2015 02:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbbL1B7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2015 20:59:21 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750990AbbL1B7U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2015 20:59:20 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 303F337639;
	Sun, 27 Dec 2015 20:59:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zai6cVafcpuw/Ht/+4p7eRxjQSY=; b=JekPkY
	4r8N+dBu/pURZN0iosoqWl6WolJ8GaS+MdTvURpnLlBV/4Ou/8Xhoq3N8ULh23iP
	Y/z1KptOtv+Gl++mLL297LoYTQbuV9XRKMoDcA36AzpVzG7Ba7jDZPJJ7/7yerKz
	fMRsNmW3NRbByKxwACMBPMv8QFtyt31B3Dias=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CmqcxMkl0S6QesT+5B7bniE11gqYz0Vb
	XEaAMcTQKb7FwZxHClp8AV45BHwF4juATjEt2ie/LiWeiFrwAcv416i+bXGY69WH
	b37bmejhmZX5ekEQzok21tFuIu9Ib+xXpMWTlS5yl2YuLfhDLrmt7jw6QM5nTA9y
	0lfABd6+fQY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26D3B37638;
	Sun, 27 Dec 2015 20:59:19 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D45B37636;
	Sun, 27 Dec 2015 20:59:18 -0500 (EST)
In-Reply-To: <xmqq7fjzbgkr.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Sun, 27 Dec 2015 15:46:28 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9B0079B4-AD06-11E5-A5FC-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283024>

Junio C Hamano <gitster@pobox.com> writes:

> Very true.  Let's leave that kind of things as separate clean-ups
> after these patches settle, as mixing manual and mechanical changes
> in a single patch makes it harder to review.
>
> Thanks.

So that I won't forget (I'll need to amend with your sign-off even
if this one is satisfactory to you).

-- >8 --
From: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 22 Dec 2015 19:35:16 +0100
Subject: [PATCH] t5100: no need to use 'echo' command substitutions for globbing

Instead of making the shell expand 00* and invoke 'echo' with it,
and then capturing its output as command substitution, just use
the result of expanding 00* directly.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5100-mailinfo.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5100-mailinfo.sh b/t/t5100-mailinfo.sh
index 4e52b3b..85b3df5 100755
--- a/t/t5100-mailinfo.sh
+++ b/t/t5100-mailinfo.sh
@@ -23,7 +23,7 @@ check_mailinfo () {
 }
 
 
-for mail in $(echo 00*)
+for mail in 00*
 do
 	test_expect_success "mailinfo $mail" '
 		check_mailinfo $mail "" &&
@@ -51,7 +51,7 @@ test_expect_success 'split box with rfc2047 samples' \
 	echo total is $last &&
 	test $(cat rfc2047/last) = 11'
 
-for mail in $(echo rfc2047/00*)
+for mail in rfc2047/00*
 do
 	test_expect_success "mailinfo $mail" '
 		git mailinfo -u $mail-msg $mail-patch <$mail >$mail-info &&
-- 
2.7.0-rc2-145-g5695473
