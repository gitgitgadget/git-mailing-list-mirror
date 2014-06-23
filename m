From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 5/5] t7510: test verify-commit
Date: Mon, 23 Jun 2014 16:02:30 -0700
Message-ID: <xmqq1tufb56h.fsf@gitster.dls.corp.google.com>
References: <cover.1402655838.git.git@drmicha.warpmail.net>
	<340919e5e17a582acaa57faefb362141e64d32a1.1403506792.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jun 24 01:02:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzDG6-000637-HU
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 01:02:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbaFWXCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 19:02:38 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61574 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750931AbaFWXCi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 19:02:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D092522FE9;
	Mon, 23 Jun 2014 19:02:32 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ppU5JA1xPvQKt3Kcjz1F8m2Pifc=; b=Yr8YV2
	OiPlUKy5RnakK3m8GFE0Sj3MNPBkNzona7vkrVeo1PTxWpumL3xNQQOiVMTkTv26
	GgnqG4Y98zlG2rsvBbXUxNQR83+sDiJmThboeYzArFT8bqtHPmFUhqdYGvQoJy9u
	Jvanovkq3SokTvmvOcCvXeDEiCRj/KBFLC2RM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IHMoPb6VRxA0UWnZpUDIn5As6GhThywz
	0Vo2toziWeZXqxavBRZghtYW45A4U90irwxZPRKd2cFqkMZ7wRehk/W6Q9/pbo56
	6XJRHG4sKnVlpeaQhlo9D9NeZNU2+g3Mp9fUw1AySlnK7ODZcoE/P7WzCkgx0bCh
	M3Fr3BKy0vA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C6D8122FE7;
	Mon, 23 Jun 2014 19:02:32 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B6A1622FE4;
	Mon, 23 Jun 2014 19:02:27 -0400 (EDT)
In-Reply-To: <340919e5e17a582acaa57faefb362141e64d32a1.1403506792.git.git@drmicha.warpmail.net>
	(Michael J. Gruber's message of "Mon, 23 Jun 2014 09:05:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7263EF3E-FB2A-11E3-99EB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252375>

Michael J Gruber <git@drmicha.warpmail.net> writes:

>  test_expect_success GPG 'detect fudged signature' '
>  	git cat-file commit master >raw &&
>  
>  	sed -e "s/seventh/7th forged/" raw >forged1 &&
>  	git hash-object -w -t commit forged1 >forged1.commit &&
> +	! git verify-commit $(cat forged1.commit) &&

This should be "test_must_fail git verify-commit ...", I think.
Otherwise you would end up declaring a segfaulting implementation a
good one.

> +	! git verify-commit $(cat forged2.commit) &&

Likewise.
