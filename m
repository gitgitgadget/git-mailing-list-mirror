Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DB9C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:17:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA2FA610FC
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 20:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbhJ1UUS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 16:20:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59788 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhJ1UUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 16:20:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D64421552DC;
        Thu, 28 Oct 2021 16:17:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wvklmr70G3zVFiYbqNNb4i0KH8USuHSpoVbAHH
        dhzdQ=; b=hL7VaEOfTqQtOMaP+zIkpOIC3oJpzcCnMFpoKSrLeExfQ7o5ersMaf
        yjN215hmj2Hw9QcAUCBkV/+rXvsq95pmokvJdqsPPyBwoQ0trJU1iFez/exV/BVg
        3OyJ0T9nLahHNw3NRn6aUlOvQjVtN/obmYQAOw4ci8WVrxCg8Gg+k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BB13F1552DA;
        Thu, 28 Oct 2021 16:17:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B0E51552D5;
        Thu, 28 Oct 2021 16:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 1/6] t5516: add test case for pushing remote refspecs
References: <20211019224339.61881-1-chooglen@google.com>
        <20211028183101.41013-1-chooglen@google.com>
        <20211028183101.41013-2-chooglen@google.com>
Date:   Thu, 28 Oct 2021 13:17:45 -0700
In-Reply-To: <20211028183101.41013-2-chooglen@google.com> (Glen Choo's message
        of "Thu, 28 Oct 2021 11:30:56 -0700")
Message-ID: <xmqq1r44rjiu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1DC250D2-382C-11EC-AAA5-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> In detached HEAD, "git push remote-name" should push the refspecs in
> remote.remote-name.push. Since there is no test case that checks this
> behavior, add one.

Makes sense.

>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  t/t5516-fetch-push.sh | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index 8212ca56dc..d4c2f1b68f 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -541,6 +541,15 @@ do
>  
>  done
>  
> +test_expect_success "push to remote with detached HEAD and config remote.*.push = src:dest" '
> +	mk_test testrepo heads/main &&
> +	git checkout $the_first_commit &&
> +	test_config remote.there.url testrepo &&
> +	test_config remote.there.push refs/heads/main:refs/heads/main &&
> +	git push there &&
> +	check_push_result testrepo $the_commit heads/main
> +'
> +
>  test_expect_success 'push with remote.pushdefault' '
>  	mk_test up_repo heads/main &&
>  	mk_test down_repo heads/main &&
