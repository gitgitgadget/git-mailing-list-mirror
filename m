From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rebase -X: do not clobber strategy
Date: Thu, 11 Nov 2010 14:01:16 -0800
Message-ID: <7vpqubfrkj.fsf@alter.siamese.dyndns.org>
References: <1289373266-32593-1-git-send-email-martin.von.zweigbergk@gmail.com>
 <AANLkTimEvp2mQu1QWhx-FDEx37NLi8jose_p+A1y1iHK@mail.gmail.com>
 <AANLkTiks87caBYo78Xh1hwnEfDF9yKwBn5q3wa87hBo3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 23:01:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGfD2-0002E3-Qc
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 23:01:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756516Ab0KKWB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 17:01:28 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59927 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753732Ab0KKWB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 17:01:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6A0303736;
	Thu, 11 Nov 2010 17:01:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=kQIbegx+35QImtcCA3IKnn5FY/0=; b=ag2kM5
	X3ok73G865SUPCX+xOct9DziNWeX+ef8zngOQ8m0dCYrqlkFBagPkz+yc6kx9oe5
	mOfm8jlcXdOaQgiEJ6TJwCbPpa6mhlduwhMrtJy7iWsfL6EWFP24UsDElD7vS2e6
	aoCmqlx0pRy41ZPFr6/QmDPgY04Zcu6dK744o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sx6ylC+t+7iEauaGTu6/fykLXlH8KcrU
	XQDW5/j34wk2VtqJkxWztlY0sG8dGX+cGKT6t19wN3wjrz2LPW9PqSoWBRLzQrjo
	kmhG6rm8c0Eb+KAxleLHLEykwgCkS5dPMNaQXy049+7U11QJklmY7WAoqO0hQYiN
	IRWMIImvVGA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 38E4B3732;
	Thu, 11 Nov 2010 17:01:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 0F5D83730; Thu, 11 Nov 2010
 17:01:23 -0500 (EST)
In-Reply-To: <AANLkTiks87caBYo78Xh1hwnEfDF9yKwBn5q3wa87hBo3@mail.gmail.com>
 (Martin von Zweigbergk's message of "Wed\, 10 Nov 2010 20\:11\:04 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3BD861EA-EDDF-11DF-9D6A-B53272ABC92C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161303>

Martin von Zweigbergk <martin.von.zweigbergk@gmail.com> writes:

> I don't think there are any merge strategies other than recursive that
> accept options, so what I could add a test case for is that e.g.
> '-s ours -X foo' uses the 'ours' strategy, even though 'foo' will be
> ignored.

You would do something like this.

-- >8 --
Subject: [PATCH] t3402: test "rebase -s<strategy> -X<opt>"

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t3402-rebase-merge.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/t/t3402-rebase-merge.sh b/t/t3402-rebase-merge.sh
index 2bea656..be8c1d5 100755
--- a/t/t3402-rebase-merge.sh
+++ b/t/t3402-rebase-merge.sh
@@ -117,4 +117,25 @@ test_expect_success 'picking rebase' '
 	esac
 '
 
+test_expect_success 'rebase -s funny -Xopt' '
+	test_when_finished "rm -fr test-bin funny.was.run" &&
+	mkdir test-bin &&
+	cat >test-bin/git-merge-funny <<-EOF &&
+	#!$SHELL_PATH
+	case "\$1" in --opt) ;; *) exit 2 ;; esac
+	shift &&
+	>funny.was.run &&
+	exec git merge-recursive "\$@"
+	EOF
+	chmod +x test-bin/git-merge-funny &&
+	git reset --hard &&
+	git checkout -b test-funny master^ &&
+	test_commit funny &&
+	(
+		PATH=./test-bin:$PATH
+		git rebase -s funny -Xopt master
+	) &&
+	test -f funny.was.run
+'
+
 test_done
-- 
1.7.3.2.334.gd1031
