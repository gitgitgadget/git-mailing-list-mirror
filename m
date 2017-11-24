Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05DC20A40
	for <e@80x24.org>; Fri, 24 Nov 2017 05:49:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751241AbdKXFtR (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 00:49:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55839 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750853AbdKXFtR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 00:49:17 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2012FB6B28;
        Fri, 24 Nov 2017 00:49:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FKzDjqWI122nv108jr7Kls1RbsY=; b=GhZYSB
        JJTikQYSliVxUSw1jA2pp+h5Rx+c2r9UThYLFk4ersQlogrv0wrLTH3umKu8GcAq
        uFouQ7a8N9SqzFv+Q7P0JPYvWQ1WqVQqlj49sRpV25Kr7W0YE7nQMkUw8v6N6dt9
        tY+rPpkcKGg4A1GOL5xyGre4cYFe1oIGzhlPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=h/lOVorO+lnPgvkYA7QcGev216Nikyue
        OpbkRtHBFe+XcQLz4d+PSEaj7tVOO8wMluomJNILXHr3U9DNrsKgEoWbjr3W14LF
        wl/L8dNtJYsRP9RSxyQWISJo6rR1Gj8hVcfQ+wv6njEk8LV3zc5wehlMr5tYkpGb
        ZG89kHLZcz8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 171A8B6B27;
        Fri, 24 Nov 2017 00:49:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8F4CBB6B26;
        Fri, 24 Nov 2017 00:49:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phil Hord <phil.hord@gmail.com>
Cc:     Git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 2/2] stash-store: add failing test for same-ref
References: <20171122212802.7068-1-phil.hord@gmail.com>
Date:   Fri, 24 Nov 2017 14:49:14 +0900
In-Reply-To: <20171122212802.7068-1-phil.hord@gmail.com> (Phil Hord's message
        of "Wed, 22 Nov 2017 13:28:02 -0800")
Message-ID: <xmqqzi7cns4l.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 348A9AA2-D0DB-11E7-9AAF-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phil Hord <phil.hord@gmail.com> writes:

> stash-store cannot create a new stash with the same ref as stash@{0}. No
> error is returned even though no new stash log is created. Add a failing
> test to track.
>
> Signed-off-by: Phil Hord <phil.hord@gmail.com>
> ---

Sorry, I lost track.  Where is v1 of this series and 1/2 of v2?
IOW, where does this patch fit in in the larger picture?

>  t/t3903-stash.sh | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> index 279e31717..7d511afd3 100755
> --- a/t/t3903-stash.sh
> +++ b/t/t3903-stash.sh
> @@ -813,6 +813,17 @@ test_expect_success 'push -m also works without space' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_failure 'store same ref twice' '
> +	>foo &&
> +	git add foo &&
> +	STASH_ID=$(git stash create) &&
> +	git stash store -m "original message" $STASH_ID &&
> +	git stash store -m "custom message" $STASH_ID &&
> +	echo "stash@{0}: custom message" >expect &&
> +	git stash list -1 >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'store -m foo shows right message' '
>  	>foo &&
>  	git add foo &&
