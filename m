From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/5] t9001: check send-email behavior with implicit
 sender
Date: Wed, 28 Nov 2012 10:55:02 -0800
Message-ID: <7vk3t5v9q1.fsf@alter.siamese.dyndns.org>
References: <20121128182534.GA21020@sigill.intra.peff.net>
 <20121128184229.GA3993@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 28 19:55:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tdmn6-0007WO-DV
	for gcvg-git-2@plane.gmane.org; Wed, 28 Nov 2012 19:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755779Ab2K1SzG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Nov 2012 13:55:06 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55945 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755513Ab2K1SzF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Nov 2012 13:55:05 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E459C8C94;
	Wed, 28 Nov 2012 13:55:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+y5y/xyzSk+YzkX5HRKHwZImjRk=; b=U4vqLy
	CCJ9Hn91Pk7GVED15edmaqjBET5tsos2RHmt0y1fmVFiJwaxXov821u5yj66mkw2
	Hr/F1sSdgnn39SMxunDQ7X+0Hqc3wocMmnr3iAMcErvSVVCSpJqQdT0qloOYsct9
	kuW0tQ9X7CH9fEfqz9k+/kwHvlq+HtNqHBvM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M1yYrjxAYAXzhxBCfZ5kIu335f51CiUC
	Jz/Ca7zFLRPJ2MhRe5jc2Rj7oSQp4VtUW7sz0pOgqcClVnzKDjaD3ECKH18B8NB4
	DA90dFMYmGK/n8MCkq323T3i74LyTcxd+lTxa57QHrGsbf7oRH0gNYoWyMFmNgVZ
	tdl4G16qgGQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D16B08C93;
	Wed, 28 Nov 2012 13:55:04 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1FAA48C91; Wed, 28 Nov 2012
 13:55:04 -0500 (EST)
In-Reply-To: <20121128184229.GA3993@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 28 Nov 2012 13:42:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1E9DF99A-398D-11E2-8F75-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210758>

Jeff King <peff@peff.net> writes:

> On Wed, Nov 28, 2012 at 01:25:35PM -0500, Jeff King wrote:
>
>> Here are the cleanups and refactorings split out from my
>> jk/send-email-sender-prompt series. They can go right on master and are
>> independent of Felipe's fc/send-email-no-sender-prompt topic.
>> [...]
>> Dropped were:
>> [...]
>>   - send-email prompting change; obsoleted by Felipe's patch
>
> Here is one more patch pulling out the extra tests from my final commit.
> It needs to go on top of the merge of Felipe's series and the one I just
> sent. The former because of the new prompting behavior, and the latter
> because of the AUTOIDENT prerequisites.
>
> If it's simpler, my whole series can just go on top of Felipe's patch
> (or vice versa).
>
> -- >8 --
> Subject: [PATCH] t9001: check send-email behavior with implicit sender
>
> We allow send-email to use an implicitly-defined identity
> for the sender (because there is still a confirmation step),
> but we abort when we cannot generate such an identity. Let's
> make sure that we test this.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t9001-send-email.sh | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>
> diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
> index c5d66cf..27edfa8 100755
> --- a/t/t9001-send-email.sh
> +++ b/t/t9001-send-email.sh
> @@ -201,6 +201,34 @@ test_expect_success $PREREQ 'Prompting works' '
>  		grep "^To: to@example.com\$" msgtxt1
>  '
>  
> +test_expect_success $PREREQ,AUTOIDENT 'implicit ident is allowed' '
> +       clean_fake_sendmail &&
> +       (sane_unset GIT_AUTHOR_NAME &&
> +	sane_unset GIT_AUTHOR_EMAIL &&
> +	sane_unset GIT_COMMITTER_NAME &&
> +	sane_unset GIT_COMMITTER_EMAIL &&
> +	GIT_SEND_EMAIL_NOTTY=1 git send-email \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		--to=to@example.com \
> +		$patches \
> +		</dev/null 2>errors
> +       )
> +'
> +
> +test_expect_success $PREREQ,!AUTOIDENT 'broken implicit ident aborts send-email' '
> +       clean_fake_sendmail &&
> +       (sane_unset GIT_AUTHOR_NAME &&
> +	sane_unset GIT_AUTHOR_EMAIL &&
> +	sane_unset GIT_COMMITTER_NAME &&
> +	sane_unset GIT_COMMITTER_EMAIL &&
> +	GIT_SEND_EMAIL_NOTTY=1 && export GIT_SEND_EMAIL_NOTTY &&
> +	test_must_fail git send-email \
> +		--smtp-server="$(pwd)/fake.sendmail" \
> +		$patches </dev/null 2>errors &&
> +	test_i18ngrep "tell me who you are" errors
> +       )
> +'

The difference between these two tests should solely come from
AUTOIDENT and nothing else, so it would be better to see their
command line arguments to match; the former is with --to and the
latter is without in this patch but I do not think you meant them to
differ that way.



>  test_expect_success $PREREQ 'tocmd works' '
>  	clean_fake_sendmail &&
>  	cp $patches tocmd.patch &&
