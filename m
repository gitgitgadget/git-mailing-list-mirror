From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/3] Git commit --patch (again)
Date: Mon, 09 May 2011 16:53:00 -0700
Message-ID: <7vwrhzmnxf.fsf@alter.siamese.dyndns.org>
References: <1304748001-17982-1-git-send-email-conrad.irwin@gmail.com>
 <20110509144451.GA11362@sigill.intra.peff.net>
 <7vei47q0i6.fsf@alter.siamese.dyndns.org>
 <20110509220806.GC3719@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: conrad.irwin@gmail.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 01:53:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJaGL-0005iL-2R
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 01:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755847Ab1EIXxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2011 19:53:12 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755765Ab1EIXxK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2011 19:53:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C2EE1521C;
	Mon,  9 May 2011 19:55:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iUzBQdl3pgQkej/brleJbercmWQ=; b=sVPdUq
	WNodY+5BDE4oPW1avQije9VriGgw67VJuhYJoVFVGD2WTViEHQwm9XuicXkv6JLb
	by7VpvzHgVlrpOQxYam6+BFGz8Kj4dE0MDwqpv65J3Y8wn08GDs/XpfT23p5/voF
	MMT28zX7LAmyWXMD6SpVkA5NtJJANQgA5+cew=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=uIQOOKlSobVEWX2bkXjqROrIQ7q1uyUR
	0S1iKm6Q6I6ckamwEbTD3+FCVMg7U09c4x6pu62grhxERNq5IPkxGirmWmvLtr/9
	oI9+4gp1KNeCFAu/oKlRm7lMhrKmx7FENZjatIWOFobRiewHYuQ8RCwRWFoFBIfW
	2fsJFgbjirs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8FEDD5217;
	Mon,  9 May 2011 19:55:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6EFEC520F; Mon,  9 May 2011
 19:55:08 -0400 (EDT)
In-Reply-To: <20110509220806.GC3719@sigill.intra.peff.net> (Jeff King's
 message of "Mon, 9 May 2011 18:08:06 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C7644932-7A97-11E0-BCC9-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173293>

Jeff King <peff@peff.net> writes:

> It's unfortunately not quite as simple as having that test succeed, as
> it changes state that breaks later tests. I didn't investigate deeply,
> though.

Yeah, that test that hardcodes the exact commit sequence is disgusting.
In the meantime...

-- >8 --
From: Jeff King <peff@peff.net>
Subject: [PATCH] t7501.8: feed a meaningful command

The command expects "git commit --interactive <path>" to fail because you
cannot (yet) limit "commit --interactive" with a pathspec, but even if the
command allowed to take <path>, the test would have failed as saying just
7:quit would leave the index the same as the current commit, leading to an
attempt to create an empty commit that would fail without --allow-empty.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t7501-commit.sh |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
index a76c474..3d2b14d 100755
--- a/t/t7501-commit.sh
+++ b/t/t7501-commit.sh
@@ -41,10 +41,12 @@ test_expect_success \
 	"echo King of the bongo >file &&
 	test_must_fail git commit -m foo -a file"
 
-test_expect_success PERL \
-	"using paths with --interactive" \
-	"echo bong-o-bong >file &&
-	! (echo 7 | git commit -m foo --interactive file)"
+test_expect_success PERL 'cannot use paths with --interactive' '
+	echo bong-o-bong >file &&
+	# 2: update, 1:st path, that is all, 7: quit
+	( echo 2; echo 1; echo; echo 7 ) |
+	test_must_fail git commit -m foo --interactive file
+'
 
 test_expect_success \
 	"using invalid commit with -C" \
-- 
1.7.5.1.290.g1b565
