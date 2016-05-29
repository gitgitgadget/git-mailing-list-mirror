From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/8] t4051: rewrite, add more tests
Date: Sun, 29 May 2016 16:55:56 -0700
Message-ID: <xmqqinxwpgfn.fsf@gitster.mtv.corp.google.com>
References: <xmqqh9e5mvjs.fsf@gitster.mtv.corp.google.com>
	<xmqq4ma5msrd.fsf@gitster.mtv.corp.google.com>
	<5740AC28.6010202@web.de> <5749AF59.2070704@web.de>
	<5749B1EA.10707@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ramsay Jones <ramsay@ramsayjones.plus.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon May 30 01:56:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b7AZ2-00046a-4Q
	for gcvg-git-2@plane.gmane.org; Mon, 30 May 2016 01:56:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753238AbcE2X4A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 29 May 2016 19:56:00 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54914 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753195AbcE2Xz7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 May 2016 19:55:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7F4941FE22;
	Sun, 29 May 2016 19:55:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=TBuFM40DoZMp
	N1hnMYO4TqqVpyI=; b=r7B9TGteSBY/8+9Rm4xBL493c0wF/ucpWe/wzq7QTK0E
	X+ZGius4/NAcmHMFGBMbZXwQvjSoduQRl+CtdLbOj5kiH4H8Jh98SzUolBBRV/b0
	gn0ChptblGfVXMBc2mqqAIamia7Sym7y1PLOiiy9IyG5mIywkrYXTm1pcrNhoHI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=CqTpCz
	xVsSOrisnH0oLBj+DqKxqpO0hDGa8X3czeZZSjhp53iGeaK5/WtMWQo5IzyJ+kJc
	+YVib06GeQqp8OphEd4KzoqB4KF0GjEnRBqGuOOZjw4FkB6dES6h6mTPejaLEEl+
	UuhTim5GTXI9JXp2FkT4FWRVKns8leT5y0JX8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 77DCC1FE21;
	Sun, 29 May 2016 19:55:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0133B1FE20;
	Sun, 29 May 2016 19:55:57 -0400 (EDT)
In-Reply-To: <5749B1EA.10707@web.de> (=?utf-8?Q?=22Ren=C3=A9?= Scharfe"'s
 message of "Sat, 28 May
	2016 16:57:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E37DCEBA-25F8-11E6-A05B-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295846>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> +commit_and_tag () {
> +	message=3D$1 &&
> +	shift &&
> +	git add $@ &&

Lack of dq around $@ makes me wonder if there is something funny
going on (looking at the callers, there isn't, so we'd better quote
it to avoid wasting time, I think).

> +	test_tick &&
> +	git commit -m $message &&
> +	git tag $message
>  }

The use of $message as the sole argument to "git tag" makes the
readers guess that it must be a single token without any funny
character, so the readers would probably do not waste too much time
wondreing if the lack of dq around $message in the last two is
problematic.

> +last_context_line () {
> +	sed -n '$ p'
>  }

I have a vague recollection that some implementations of sed are
unhappy to see that space between the address and the operation; I'd
feel safer without it.

> +check_diff () {
> +	name=3D$1
> +	desc=3D$2
> +	options=3D"-W $3"
> +
> +	test_expect_success "$desc" '
> +		git diff $options "$name^" "$name" >"$name.diff"
> +	'
> +
> +	test_expect_success ' diff applies' '
> +		test_when_finished "git reset --hard" &&
> +		git checkout --detach "$name^" &&

With the presence of ^ there, --detach is unnecessary; it would not
hurt, though.

> +		git apply "$name.diff" &&
> +		git diff --exit-code "$name"

Even though we may know that $name.diff" will never have a creation
of new paths, I'd feel safer if "apply" is run with "--index".


Thanks.
