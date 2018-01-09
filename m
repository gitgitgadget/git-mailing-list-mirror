Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7C01F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755041AbeAISZj (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:25:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55186 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752476AbeAISZi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:25:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 13614C7D64;
        Tue,  9 Jan 2018 13:25:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ibEA8CLMOcRSnVm+1TZXBbNOmaw=; b=qLrD0f
        8+jxS48cfVO84z9yRPrNutsqgx9jn0+kPo5c8hu4LZuQdDQKdYDhQlGqp6W1du0W
        HzzkB0XY4UB2KZDRCz/IX51Nb21MZHVsTvx0jCw7eSMjZcWjU3Piomu2WTGf2oKp
        M+Thb4V3nq3KqnQcHP0bR2zsk2RZGgBW8G9d4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bdXQEscLyUWJ1ULf2Rp9LVIudDtBiFPG
        veE0bEIU0XFcc4+d2l8Z6K8jU+j3C5Cb+tjQ3G+VGKGDHde0xumrScoE8KDSP5dN
        5h5KbKmcfI3Z36gk4+WzcGjISFHdMBzYNYTm5whPeANAD6vkVu8IYIYJFk22PHda
        BupyAMK7Joo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C116C7D63;
        Tue,  9 Jan 2018 13:25:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 78A87C7D62;
        Tue,  9 Jan 2018 13:25:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, a.krey@gmx.de
Subject: Re: [PATCH] merge-recursive: do not look at the index during recursive merge
References: <CABPp-BGy3_RyVQfCm+9O_AAfKA0_CZ5ajJE7NuLbToERWyWmqQ@mail.gmail.com>
        <20171221191907.4251-1-newren@gmail.com>
        <20171221191907.4251-3-newren@gmail.com>
        <xmqqbmi484tw.fsf@gitster.mtv.corp.google.com>
        <xmqq7esq7v4j.fsf_-_@gitster.mtv.corp.google.com>
Date:   Tue, 09 Jan 2018 10:25:36 -0800
In-Reply-To: <xmqq7esq7v4j.fsf_-_@gitster.mtv.corp.google.com> (Junio
        C. Hamano's message of "Tue, 09 Jan 2018 10:19:24 -0800")
Message-ID: <xmqq373e7uu7.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7D450DB4-F56A-11E7-9522-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> + ...
> +	test_tick &&
> +	git commit --allow-empty -m "O2" &&
> +	O1=$(git rev-parse HEAD) &&
> +
> +	git reset --hard $O0 &&
> +	test_tick &&
> +	git commit --allow-empty -m "O2" &&
> +	O2=$(git rev-parse HEAD) &&

Does not affect the validity of the test at all, but the log message
of the $O1 should be made with -m "O1", not with -m "O2".  That fix
will be in the version I'll be queuing.

> +
> +	test_tick &&
> +	git merge -s ours $O1 &&
> +	B=$(git rev-parse HEAD) &&
> +
> +	git reset --hard $O1 &&
> +	test_tick &&
> +	git merge -s ours $O2 &&
> +	A=$(git rev-parse HEAD) &&
> +
> +	git merge $B
> +'
> +
>  test_done
