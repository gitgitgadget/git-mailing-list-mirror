From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-submodule has bash-ism?
Date: Wed, 01 Jun 2016 13:56:08 -0700
Message-ID: <xmqq37owy6fr.fsf@gitster.mtv.corp.google.com>
References: <xmqq1t4h3jxo.fsf@gitster.mtv.corp.google.com>
	<xmqqoa7kzy3u.fsf@gitster.mtv.corp.google.com>
	<xmqqk2i8zxtx.fsf@gitster.mtv.corp.google.com>
	<20160601163747.GA10721@sigill.intra.peff.net>
	<20160601183100.GN1355@john.keeping.me.uk>
	<20160601190759.GB12496@sigill.intra.peff.net>
	<20160601191621.GO1355@john.keeping.me.uk>
	<xmqqinxsy9q0.fsf@gitster.mtv.corp.google.com>
	<20160601202852.GP1355@john.keeping.me.uk>
	<xmqq8tyoy6se.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:56:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8DBY-0004dH-PM
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 22:56:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbcFAU4N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 16:56:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60549 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750720AbcFAU4M (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 16:56:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F3BEF204F4;
	Wed,  1 Jun 2016 16:56:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=r4OHoXW9qKIOO8NkXByLx8ZZJhI=; b=qjcvOb
	yKogOje/znUrhY/d1o/E15hSgGKe8MejyjtHRUrKK6TlscV7t1ttYyDNhReU1ofk
	gEa1BEfsnxjZDcYaTKqVzTeDZGbnr2mlSzKDfbP80IKzL1l6Jh8+Oqw2qex2MX7H
	ksI3juJ1eyg/8vnY7bnwUdznx7ZgqUtX9lyKQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=a8J0+q5LKpO1nB5Xkls26cmZBXEfWuDm
	QH1FAXM2qcJqL9SXLizuDvAeVBBTwaRoNeFIViWKI2HUyQfmUVuVxdHKT8T13Bfi
	kWRHksiDJkiXJ++XcsfG4hXssHOSqRPMxCsFW74kPtxwEcKasg3FYB4qWY3NcG4T
	79Pwnb84fks=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ECB0F204F3;
	Wed,  1 Jun 2016 16:56:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6FB65204F2;
	Wed,  1 Jun 2016 16:56:10 -0400 (EDT)
In-Reply-To: <xmqq8tyoy6se.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Wed, 01 Jun 2016 13:48:33 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44DA5086-283B-11E6-A46E-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296161>

Junio C Hamano <gitster@pobox.com> writes:

> John Keeping <john@keeping.me.uk> writes:
>
>> Absolutely, my original point should have been prefixed with: I wonder
>> if the reason we haven't had any problems reported is because ...
>>
>> And we've got lucky because the clobbering of global variables happens
>> not to matter in these particular cases.
>
> Ah, I did misunderstand why you were making that statement, and now
> I fully agree with your conclusion (which is what Jeff spelled out
> in the latest message) that the fact that we saw no breakage report
> is not a datapoint that everybody's shell supports "local" at all.
>
> Thanks for clarification.

So here is the final version with a log message.

-- >8 --
Subject: [PATCH] t5500 & t7403: lose bash-ism "local"

In t5500::check_prot_host_port_path(), diagport is not a variable
used elsewhere and the function is not recursively called so this
can simply lose the "local", which may not be supported by shell
(besides, the function liberally clobbers other variables without
making them "local").

t7403::reset_submodule_urls() overrides the "root" variable used
in the test framework for no good reason; its use is not about
temporarily relocating where the test repositories are created.
This assignment can be made not to clobber the varible by moving
them into the subshells it already uses.  Its value is always
$TRASH_DIRECTORY, so we could use it instead there, and this
function that is called only once and its two subshells may not be
necessary (instead, the caller can use "git -C $there config" and
set a value that is derived from $TRASH_DIRECTORY), but this is a
minimum fix that is needed to lose "local".

Helped-by: John Keeping <john@keeping.me.uk>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5500-fetch-pack.sh     | 1 -
 t/t7403-submodule-sync.sh | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 9b9bec4..dc305d6 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -556,7 +556,6 @@ check_prot_path () {
 }
 
 check_prot_host_port_path () {
-	local diagport
 	case "$2" in
 		*ssh*)
 		pp=ssh
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 79bc135..5503ec0 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -62,13 +62,13 @@ test_expect_success 'change submodule' '
 '
 
 reset_submodule_urls () {
-	local root
-	root=$(pwd) &&
 	(
+		root=$(pwd) &&
 		cd super-clone/submodule &&
 		git config remote.origin.url "$root/submodule"
 	) &&
 	(
+		root=$(pwd) &&
 		cd super-clone/submodule/sub-submodule &&
 		git config remote.origin.url "$root/submodule"
 	)
-- 
2.9.0-rc1-223-gb1e1500
