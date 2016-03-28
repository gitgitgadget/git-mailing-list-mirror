From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] worktree: add: introduce --checkout option
Date: Mon, 28 Mar 2016 10:40:52 -0700
Message-ID: <xmqq8u12zejf.fsf@gitster.mtv.corp.google.com>
References: <01020153ad85c135-8ca8cff0-9e6f-48ea-89f3-4036814feeca-000000@eu-west-1.amazonses.com>
	<01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Ray Zhang <zhanglei002@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 19:48:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1akb9y-0000PW-8p
	for gcvg-git-2@plane.gmane.org; Mon, 28 Mar 2016 19:41:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753405AbcC1Rk5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2016 13:40:57 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53140 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751212AbcC1Rk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2016 13:40:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AF08D4D129;
	Mon, 28 Mar 2016 13:40:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TriSTxFQdUdCsRHMdNLQv/0FgVc=; b=pIWyr6
	b7EwYxoq8NFhKZueoaBYXB5zUqRZigOfEIoXiT79+4bHiBc4O8oOgLBCe74khA5e
	y55m0b3ENb3SbI7RGsyqbkaVWj+MoI3dtXPlFPoT1xexTlzHjAddKTckCCZ/UaWQ
	KAO4FeBLIfUhFs6qKktocV5v/DhbXzSWo2SE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PLEfeknhuVqUpW3cdqEdvU5azY8hSDQI
	MTJOh3VfWKrKgblfQTzGMEVxQtwYXFKhCzXozUiRblCixIcvK7AhnroMvnUUZC8B
	/dnH3izYXbeAZjpNm71UCQgdgUPcEAqTEoRskOEL9MmASc1s87I5mjGIM9KGxWFp
	/jssHyZ/T40=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A5A0F4D126;
	Mon, 28 Mar 2016 13:40:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 209E94D125;
	Mon, 28 Mar 2016 13:40:54 -0400 (EDT)
In-Reply-To: <01020153bcda5e6c-2bae9b68-6669-4f29-a512-136c42722001-000000@eu-west-1.amazonses.com>
	(Ray Zhang's message of "Mon, 28 Mar 2016 10:52:21 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3887296A-F50C-11E5-80AD-E95C6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290050>

Ray Zhang <zhanglei002@gmail.com> writes:

> By adding this option which defaults to true, we can use the
> corresponding --no-checkout to make some customizations before
> the checkout, like sparse checkout, etc.
>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Ray Zhang <zhanglei002@gmail.com>
> ---

Thanks.  Will queue.

> diff --git a/t/t2025-worktree-add.sh b/t/t2025-worktree-add.sh
> index cbfa41e..472b811 100755
> --- a/t/t2025-worktree-add.sh
> +++ b/t/t2025-worktree-add.sh
> @@ -213,4 +213,17 @@ test_expect_success 'local clone from linked checkout' '
>  	( cd here-clone && git fsck )
>  '
>  
> +test_expect_success '"add" worktree with --no-checkout' '
> +	git worktree add --no-checkout -b swamp swamp &&
> +	ls swamp >actual &&
> +	test_line_count = 0 actual &&

The remainder of the test (both existing and added parts)
seems to only care about init.t; running "ls swamp" feels
somewhat inconsistent.  We could replace the two lines with

	! test -e swamp/init.t

to address this, but I do not think it is worth a patch churn.

> +	git -C swamp reset --hard &&
> +	test_cmp init.t swamp/init.t
> +'
> +test_expect_success '"add" worktree with --checkout' '
> +	git worktree add --checkout -b swmap2 swamp2 &&
> +	test_cmp init.t swamp2/init.t
> +'
> +
>  test_done
