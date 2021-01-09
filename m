Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3EBEC433DB
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 02:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CF8E23A3C
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 02:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbhAICTU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 21:19:20 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59984 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbhAICTU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 21:19:20 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4192A10DCD6;
        Fri,  8 Jan 2021 21:18:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=O3AucHlPHdIqV5tg0/wQGrpncZE=; b=Mr0U5O
        jm0Qng2hKEoB9FJ24JVRhiZvaP4YFMcKe5mkSeNkGDN1BZ9OM2q0tlLYu4z2DUTD
        LmZSlw6a/cXVSL7kXgxYZv7Jd38nr7LSqS8a+WQWb98zHXTasW3vgxRr9ZPyj9r1
        Eaz6lsotulScnsZlyWMxpdCNXXyN7shFDaNWo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qKTGOd+VIxOeSPfYpofgNqebHVc5y3c6
        u3uDtYY9XgtOCY0A7ERARJ0foIuxvLz8FVWM81WRaSJnnSJ+lhEKjfSV0z5YSEI7
        QELmc+nCtKkQkKmRTt2VRdYZXpRZHLMNxSW13PajTvOPPUBS1jGiKNZzGoztvFtW
        cxASqhFDAgg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2D86010DCD5;
        Fri,  8 Jan 2021 21:18:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 67EA910DCD3;
        Fri,  8 Jan 2021 21:18:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Joey Hess <id@joeyh.name>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v4 2/2] bundle: arguments can be read from stdin
References: <X/cqrTgilKAW9P9G@danh.dev>
        <20210108144514.24805-3-worldhello.net@gmail.com>
Date:   Fri, 08 Jan 2021 18:18:33 -0800
In-Reply-To: <20210108144514.24805-3-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 8 Jan 2021 09:45:14 -0500")
Message-ID: <xmqqo8hyg8ee.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FA299B5E-5220-11EB-8BCE-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/t/t5607-clone-bundle.sh b/t/t5607-clone-bundle.sh
> index 26985f4b44..425258767d 100755
> --- a/t/t5607-clone-bundle.sh
> +++ b/t/t5607-clone-bundle.sh
> @@ -38,13 +38,13 @@ test_expect_success 'die if bundle file cannot be created' '
>  	test_must_fail git bundle create adir --all
>  '
>  
> -test_expect_failure 'bundle --stdin' '
> +test_expect_success 'bundle --stdin' '
>  	echo master | git bundle create stdin-bundle.bdl --stdin &&
>  	git ls-remote stdin-bundle.bdl >output &&
>  	grep master output
>  '
>  
> -test_expect_failure 'bundle --stdin <rev-list options>' '
> +test_expect_success 'bundle --stdin <rev-list options>' '
>  	echo master | git bundle create hybrid-bundle.bdl --stdin tag &&
>  	git ls-remote hybrid-bundle.bdl >output &&
>  	grep master output

I think these tests that documented the known limitation came from
f62e0a39 (t5704 (bundle): add tests for bundle --stdin, 2010-04-19).

The author(s) of the original test deserves to be notified ;-)

