From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] shell portability: Use sed instead of non-portable
 variable expansion
Date: Mon, 05 Sep 2011 01:22:04 -0700
Message-ID: <7vaaajcsb7.fsf@alter.siamese.dyndns.org>
References: <8762l73758.fsf@elisp.net>
 <7vbouzxy7g.fsf@alter.siamese.dyndns.org> <4E648031.6050607@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Naohiro Aota <naota@elisp.net>,
	git@vger.kernel.org, tarmigan+git@gmail.com,
	David Barr <davidbarr@google.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 10:22:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R0URb-0008Np-1E
	for gcvg-git-2@lo.gmane.org; Mon, 05 Sep 2011 10:22:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751482Ab1IEIWL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Sep 2011 04:22:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34270 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751139Ab1IEIWI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Sep 2011 04:22:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8456716A9;
	Mon,  5 Sep 2011 04:22:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=INkp4fSxg5sm+uNvOThW0F/g5IQ=; b=oW1aeV
	c+GNZ9bHY1154kvi/vd7DMsgiikZdh3LMsSEBk7B2Z3Rn/68w9D2GZ6wX3kzBaHF
	lp0m7IfwI3EyG8RRevLSQed2no0lS6icLx/1DWaL86MDMKvIqt1r0Ddk6PNHCMm/
	NiqcPrCAHo9ddbyg+OWaVhx8Vgc7EbWlTByGo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bcMpbmksr6YAXHbwF2FAhMGwieJlQXjb
	SpvjKt+UiblfuviFeGehLckCzMTfWzo08ozZUlMSB3pf8SlN6qWSLOn/lApjvT1v
	ye4djWkbR4zuV3ORasg8334S5C1VZrjO2RF+rntsiboM26YfHaApcAeBBOwNaKxK
	3GfjBqA8k4I=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6F94B16A8;
	Mon,  5 Sep 2011 04:22:06 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F00FC16A7; Mon,  5 Sep 2011
 04:22:05 -0400 (EDT)
In-Reply-To: <4E648031.6050607@viscovery.net> (Johannes Sixt's message of
 "Mon, 05 Sep 2011 09:54:25 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23FDEA7E-D798-11E0-80F5-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180729>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 9/5/2011 9:09, schrieb Junio C Hamano:
>> By the way, t9010 uses ${#parameter} (strlen) which is bashism we forbid,
>> and it needs to be rewritten (David CC'ed).
>
> Actually, no. It is perfectly valid POSIX. So we would need this patch.
>
> --- 8< ---
> From: Johannes Sixt <j6t@kdbg.org>
> Subject: [PATCH] CodingGuidelines: ${#parameter} is POSIX and should be allowed
>
> See http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#tag_18_06_02.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---

I would prefer to play it safe at least for now, especially before 1.7.7
ships.

 Documentation/CodingGuidelines |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index fe1c1e5..594fb76 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -52,7 +52,7 @@ For shell scripts specifically (not exhaustive):
 
    - No shell arrays.
 
-   - No strlen ${#parameter}.
+   - No strlen ${#parameter} (even though it is in POSIX).
 
    - No pattern replacement ${parameter/pattern/string}.
 
