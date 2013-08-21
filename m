From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase --preserve-merges: ignore "merge.log" config
Date: Wed, 21 Aug 2013 15:44:40 -0700
Message-ID: <xmqqwqneslyf.fsf@gitster.dls.corp.google.com>
References: <1377110937-13439-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ralf Thielow <ralf.thielow@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 22 00:44:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCH8x-0000Va-G7
	for gcvg-git-2@plane.gmane.org; Thu, 22 Aug 2013 00:44:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752894Ab3HUWoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 18:44:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38713 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab3HUWon (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 18:44:43 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9B8CD3B5C9;
	Wed, 21 Aug 2013 22:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IvqQSpzCcBe83SZ7kgZ7Qkn2lXI=; b=hpyGq/
	DuF1JHcL7VGtqjURreikN5Q/edhC9K4kqwFjCWXTYXdIHkyhlAik1stIKrmsAwwR
	MpIsYGReeXQ2DBuLpaGObfpR6VRiozjbIh/i+ErB7nPqGXLZ2BwhyM9xOtDlhOCj
	B7RxapO2y1VYN6PJ1SbbrcUMZ4q5ozWhPp0Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oZ/7hzk/nuH5q+d7Gqn6MLvQGAzpxGfT
	Hg/zUJ4iFyqO3eF6CdK+PEVqOlu4iFnyH3qPemZKA3xlM86qhz5rm0P8m1bbmeWr
	AlT4gRpr0mXIVB+C7Ole6iG+HSzPY9Vw4FQBsMqv202ECDo+sMRuypV5+jkf2Gr5
	9kaMLGYeZ6U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9131B3B5C8;
	Wed, 21 Aug 2013 22:44:42 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EBBC23B5C2;
	Wed, 21 Aug 2013 22:44:41 +0000 (UTC)
In-Reply-To: <1377110937-13439-1-git-send-email-ralf.thielow@gmail.com> (Ralf
	Thielow's message of "Wed, 21 Aug 2013 20:48:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 44BBAE86-0AB3-11E3-AA18-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232746>

Ralf Thielow <ralf.thielow@gmail.com> writes:

> When "merge.log" config is set, "rebase --preserve-merges"
> will add the log lines to the message of the rebased merge
> commit.
>
> A rebase should not modify a commit message automatically.
>
> Teach "git-rebase" to ignore that configuration by passing "--no-log"
> to the git-merge call.
>
> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
> ---

Thanks; will queue with the following squashed-in.

 t/t3409-rebase-preserve-merges.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t3409-rebase-preserve-merges.sh b/t/t3409-rebase-preserve-merges.sh
index 2454811..8c251c5 100755
--- a/t/t3409-rebase-preserve-merges.sh
+++ b/t/t3409-rebase-preserve-merges.sh
@@ -113,10 +113,8 @@ test_expect_success 'rebase -p ignores merge.log config' '
 	cd clone4 &&
 	git fetch &&
 	git -c merge.log=1 rebase -p origin/topic &&
-	cat >expected <<-\EOF &&
-
-	EOF
-	git log --format="%b" -1 >current
+	echo >expected &&
+	git log --format="%b" -1 >current &&
 	test_cmp expected current
 	)
 '
