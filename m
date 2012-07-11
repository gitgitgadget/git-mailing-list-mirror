From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Mini bug report origin/pu: t1512 failed on Mac OS X (commit 
 957d74062c1f0e ?)
Date: Wed, 11 Jul 2012 16:30:28 -0700
Message-ID: <7va9z5dgff.fsf@alter.siamese.dyndns.org>
References: <4FFDDD5E.3080309@web.de>
 <7vipdtdhla.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Jul 12 01:30:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sp6Me-00071V-C5
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jul 2012 01:30:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933123Ab2GKXab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jul 2012 19:30:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35735 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab2GKXaa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2012 19:30:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 17E6D65BB;
	Wed, 11 Jul 2012 19:30:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lG5aAv72QYwbd0JQF7BezRnNkd0=; b=G/2fJy
	rJ7lIz+/9GgBRZ1OGAto+LsBpH3sgRtKD/9XDpNkxiOlf14pRLZE3hLQOZdvQf2/
	PnonP5BpmmxNheENAJE4KpJ28e9nQeczphN0ryVLFVt9OtwrPPEeLnQ8mnft198E
	UknzWEGPjM9tgJdKgSmW2Lg0ikttWetBbTG78=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l+HDe+QDfwqEDb0NkqWcuu1Ee1bi/Yea
	BEi35mYb9uLyU7NCmV8+/PToiTR2aYMG4RGjjg6IDNY45HhaY9EiMQCepFdd9ix8
	K9qzejljDtp+ZXljhAsPqqGpBA6FnzWaAEqXLYfwZ/4JEv1MCATyu5+RMBhAfMVv
	STgtDgHbeL0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EE6EA65BA;
	Wed, 11 Jul 2012 19:30:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7DE1D65B9; Wed, 11 Jul 2012
 19:30:29 -0400 (EDT)
In-Reply-To: <7vipdtdhla.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 11 Jul 2012 16:05:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 66AF3E24-CBB0-11E1-A6B0-C3672E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201346>

Junio C Hamano <gitster@pobox.com> writes:

> I think the other tests in t/ prefer to unquote it so that we would
> ignore spaces around "wc -l" output, i.e.
>
> 	test $(wc -l <actual) = 16
>
> Thanks for a report.

-- >8 --
Subject: [PATCH] t1512: ignore whitespaces in wc -l output

Some implementations of sed (e.g. MacOS X) have whitespaces in the
output of "wc -l" that reads from the standard input.  Ignore these
whitespaces by not quoting the command substitution to be compared
with the constant "16".

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t1512-rev-parse-disambiguation.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 3ed7558..1eb3514 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -257,7 +257,7 @@ test_expect_success 'rev-parse --disambiguate' '
 	# commits created by commit-tree in earlier tests do not share
 	# the prefix.
 	git rev-parse --disambiguate=000000000 >actual &&
-	test "$(wc -l <actual)" = 16 &&
+	test $(wc -l <actual) = 16 &&
 	test "$(sed -e "s/^\(.........\).*/\1/" actual | sort -u)" = 000000000
 '
 
-- 
1.7.11.2.270.gc2d3e4b
