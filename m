From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] test-lib.sh: support -x option for shell-tracing
Date: Mon, 13 Oct 2014 15:31:49 -0700
Message-ID: <xmqqd29v1u0a.fsf@gitster.dls.corp.google.com>
References: <20141010062722.GB17481@peff.net>
	<20141010064727.GC17481@peff.net>
	<xmqqh9z71uf9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>, Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 14 00:32:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdo9v-0004om-Co
	for gcvg-git-2@plane.gmane.org; Tue, 14 Oct 2014 00:32:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600AbaJMWbx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 18:31:53 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52230 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751546AbaJMWbw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 18:31:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A3EB15480;
	Mon, 13 Oct 2014 18:31:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HxbXA7pqYeuP8rLcto+/Tz/TG7s=; b=H5FpkY
	XrFtBzgYB8vU/r9V6TIu7Felm9vfRGWsQySP4BTfJwCiNP2lXz03fn4ueJR1nJCZ
	TrNddDNoBfPLYEWrTI9GcwSYvZmqXQ16h3AdVhw8HJPAUrHfogXZkrSvOcJK44BY
	u9uRtXDaVlqawEpmqoC5sBnGzfQ76OOOgT9xo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pJC+3aJlNAl5rij+Pic0vYcLgYE4z4LT
	EzLmx/Qd6HbBFwh/jXl6KqWegHn1a/NxmWA7tcXU5DiVR+3QSX2YPuMuk9plLMmH
	vCaEg5/dd2sMnGP1KojEr9JwKmdD4rjA+sV0IJ3yplOKUL54STZx750RvM7egf3x
	eMFe6BFbQV0=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5B4B91547F;
	Mon, 13 Oct 2014 18:31:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D55C91547E;
	Mon, 13 Oct 2014 18:31:50 -0400 (EDT)
In-Reply-To: <xmqqh9z71uf9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 13 Oct 2014 15:22:50 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B9CAF524-5328-11E4-8ADE-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Does 1308 pass with this patch for you (running it without "-x")?
>
> The original that expects a hardcoded line number (not relative to
> the original or something) is a bad taste, and also the test setup
> procedure is broken (see below for a fix of that breakage, which
> does not fix the breakage this patch seems to bring in anyway).
>
> But still it is disturbing to see that there is a blank line
> difference with and without this change in the file created by the
> test (i.e. the client of the code this patch touches).

This is even more disturbing.  With this fix (which is correct as
far as I can tell) queued on top of ta/config-set, the shell-tracing
patch does not fail any more.

I suspect that the broken test in the original ended the .git/config
file with an incomplete line or something, and with the attached fix
we no longer do so and that is why shell-tracing patch no longer
breaks it, it seems.  So if there is a test that does want to create
a file that ends with an incomplete line, we may see the real
breakage again with the shell-tracing patch in.



-- >8 --
Subject: [PATCH] t1308: fix broken here document in test script

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1308-config-set.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index 7fdf840..243d612 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -23,7 +23,7 @@ check_config () {
 }
 
 test_expect_success 'setup default config' '
-	cat >.git/config <<\EOF
+	cat >.git/config <<-\EOF
 	[case]
 		penguin = very blue
 		Movie = BadPhysics
@@ -185,7 +185,7 @@ test_expect_success 'proper error on error in default config files' '
 	cp .git/config .git/config.old &&
 	test_when_finished "mv .git/config.old .git/config" &&
 	echo "[" >>.git/config &&
-	echo "fatal: bad config file line 35 in .git/config" >expect &&
+	echo "fatal: bad config file line 34 in .git/config" >expect &&
 	test_expect_code 128 test-config get_value foo.bar 2>actual &&
 	test_cmp expect actual
 '
-- 
2.1.2-468-g1a77c5b
