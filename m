From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/25] detecting &&-chain breakage
Date: Fri, 20 Mar 2015 11:00:05 -0700
Message-ID: <xmqq384zft22.fsf@gitster.dls.corp.google.com>
References: <20150320100429.GA17354@peff.net>
	<xmqqegojftsj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 20 19:00:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ1DU-0005pS-Ld
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 19:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbbCTSAL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 14:00:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63884 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751132AbbCTSAI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 14:00:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FF1740D32;
	Fri, 20 Mar 2015 14:00:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vOlaHIA6KjHQ0DkWOEF6cZ5trAE=; b=dodiOZ
	0umTDltnROCjVNjR+T81KoFo+Cq3eRaAHQII1gpwD+9oUevJ5zuKrkaxTB/rJ3w/
	KPtfE0y6XaNfBPYaxetTwdrG19EmN1wvDcHqOhoB6+hI19aI/HcL28l8sB8sg5aJ
	7gPoCxoLQZ9bDXQth3U3ehSCDsJZHy6Q5E2ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gh5p+tO7d1m887DQbDZrrYy8SXGYkYry
	bHgATIQ87/RuW8pgmQ3+s2PdIQV/P18GyxokeHmRm5oOJPknBJssoKWMD5kVCILA
	4OVjVaZkXS7YT+vQ9vH8nLh/Ms63yBl9yYo43ArgMaCXgsn17WlSXkYT9xJo0eKP
	phDTnMJ7A4A=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5965640D31;
	Fri, 20 Mar 2015 14:00:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A766440D2E;
	Fri, 20 Mar 2015 14:00:06 -0400 (EDT)
In-Reply-To: <xmqqegojftsj.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 20 Mar 2015 10:44:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F10201B2-CF2A-11E4-BF2B-FAE19E42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265924>

Junio C Hamano <gitster@pobox.com> writes:

> I found 2026 and 5312 to be broken (there may be others that are
> excluded in my usual test set) in 'pu'.  As to these topics in "git
> log --first-parent master..pu", my preference is to queue fixups on
> the broken-out topics (available at http://github.com/gitster/git)
> independently.
>
> For example, this will go on top of nd/multiple-work-trees.

... and this goes on top of jk/prune-with-corrupt-refs until it is
rerolled.

-- >8 --
Subject: [PATCH] SQUASH??? t5312: fix broken &&-chain

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5312-prune-corruption.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5312-prune-corruption.sh b/t/t5312-prune-corruption.sh
index 8b54d16..9633d97 100755
--- a/t/t5312-prune-corruption.sh
+++ b/t/t5312-prune-corruption.sh
@@ -80,7 +80,7 @@ test_expect_success 'pack-refs does not silently delete broken loose ref' '
 # skip processing a broken ref
 test_expect_success 'create packed-refs file with broken ref' '
 	rm -f .git/refs/heads/master &&
-	cat >.git/packed-refs <<-EOF
+	cat >.git/packed-refs <<-EOF &&
 	$missing refs/heads/master
 	$recoverable refs/heads/other
 	EOF
-- 
2.3.3-401-g402122f
