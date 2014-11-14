From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] Allow TTY tests to run under recent Mac OS
Date: Fri, 14 Nov 2014 12:20:46 -0800
Message-ID: <xmqqbno9355t.fsf@gitster.dls.corp.google.com>
References: <1415995993-70879-1-git-send-email-blume.mike@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 14 21:20:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpNMT-0003Re-NV
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 21:20:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755134AbaKNUUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2014 15:20:49 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:59194 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754474AbaKNUUt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2014 15:20:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0E2801E33C;
	Fri, 14 Nov 2014 15:20:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sGQPb+K0KL82D+o4vhnxwb/TtQQ=; b=w+HYcU
	KfrPnOGhPielCBwhDGbNR4UakUvg/az5OLY20q4F3fMlyZ/p4OsbrefPhZfoNuRS
	Az9SvgQn/LwuMLtrv4ZhjlEq1D/7NiJxbnOyvY6w68gUE/LaLEtmFhubklyV8rpO
	0YxCoC1xm/t/Z3al7ryY8X9iohwf2hr9cj8X4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LL/rKOW3A4YZLgKHh3DhuxMdI9CuuTSb
	926Qh2lhZqj4vKEMGJPWu2j/yEzJaPDYRXL2bVbxjHiuFT40/fFc289O56VOxLc5
	YcgPsaDxzXEIVbNqKqsMZkGwxJKQ05C4KaGc2NsNaNGUpWX4bvSkvxP0J94yZwXA
	9+5bkDPc3+w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id F01681E33B;
	Fri, 14 Nov 2014 15:20:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 57F191E33A;
	Fri, 14 Nov 2014 15:20:47 -0500 (EST)
In-Reply-To: <1415995993-70879-1-git-send-email-blume.mike@gmail.com> (Mike
	Blume's message of "Fri, 14 Nov 2014 12:13:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B7FDE982-6C3B-11E4-8A19-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mike Blume <blume.mike@gmail.com> writes:

> TTY tests were previously skipped on all Mac OS systems because of a
> bug where reading from pty master occasionally hung. This bug has since
> been found not to be reproducible under Mac OS 10.9 and 10.10.1.
>
> Therefore, run TTY tests under Mac OS 10.9 (Mavericks) and higher.
>
> Signed-off-by: Mike Blume <blume.mike@gmail.com>
> Improved-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Improved-by: John Szakmeister <john@szakmeister.net>
> Improved-by: Johannes Sixt <j6t@kdbg.org>
> Improved-by: Jeff King <peff@peff.net>
> ---

The patch in this round looks good.  Will queue.

Thanks all who helped.

>  t/lib-terminal.sh | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/t/lib-terminal.sh b/t/lib-terminal.sh
> index 5184549..275fb09 100644
> --- a/t/lib-terminal.sh
> +++ b/t/lib-terminal.sh
> @@ -29,7 +29,12 @@ test_lazy_prereq TTY '
>  	# After 2000 iterations or so it hangs.
>  	# https://rt.cpan.org/Ticket/Display.html?id=65692
>  	#
> -	test "$(uname -s)" != Darwin &&
> +	# Under Mac OS X 10.9, this problem appears to be gone.
> +	#
> +	{
> +		test "$(uname -s)" != Darwin ||
> +		test "$(uname -r | cut -d. -f1)" -ge 13
> +	} &&
>  
>  	perl "$TEST_DIRECTORY"/test-terminal.perl \
>  		sh -c "test -t 1 && test -t 2"
