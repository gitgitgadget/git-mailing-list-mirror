Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46AE51F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 00:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391291AbfJRAie (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 20:38:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61952 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfJRAie (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 20:38:34 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9139193E83;
        Thu, 17 Oct 2019 20:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bHuvUU6j1FUE+XJWUazHzHJiVjw=; b=dsM+/s
        ADfVJZMh0f2G6wgNqwNm1AoTXPfs1gDkO3ewAg+W8Fl9JpHSKS17/GG583GilIRD
        H+egcaeAa8zTctWqYgyxH2U2DZDsYRxnkkjs5CTHBCtw0nRUoDU/bVo8FMYPf+dN
        89FyKdtIYygm+j/CM8BfgyEWpZbLpKekve564=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KML3pP8TxWFL35zp92RueWvWCNEu+Bje
        qDJpEtiWhEQ+1oekw9+lH/IAi1X+UnBs/4Z15gg9+ZuL4D0Ot84ICQeZd0b+fFY3
        iRQ3cAD7RB/oxdi5L/TjBG0IemXje23AWJcneThBzU+QVp3XYvlZ6WZO5AuaxrP1
        gPY9nG+UAug=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 89F1793E82;
        Thu, 17 Oct 2019 20:38:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B732593E80;
        Thu, 17 Oct 2019 20:38:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] t3301: test diagnose messages for too few/many paramters
References: <20191015163631.21808-1-congdanhqx@gmail.com>
        <20191016051841.19896-1-congdanhqx@gmail.com>
Date:   Fri, 18 Oct 2019 09:38:27 +0900
In-Reply-To: <20191016051841.19896-1-congdanhqx@gmail.com> (Doan Tran Cong
        Danh's message of "Wed, 16 Oct 2019 12:18:40 +0700")
Message-ID: <xmqqeeza7urg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B06E4BC-F13F-11E9-91D2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Doan Tran Cong Danh <congdanhqx@gmail.com> writes:

> If we accidentally lifted the check inside our code base, the test may
> still failed because the provided parameter is not a valid ref.

Makes sense.  Another option would be to use a valid ref to make
sure there are no other possible reason for the command to fail,
which would make the test robust against us accidentally switching
the order of the check to see if they are refs first and then
complain about too many or too few arguments ;-)  But I think what
we have here is fine as-is (I'll copy-edit the proposed log message
for grammos, though).

Thanks.

>
> Correct it.
>
> Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> ---
>  t/t3301-notes.sh | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
> index d3fa298c6a..d7767e4438 100755
> --- a/t/t3301-notes.sh
> +++ b/t/t3301-notes.sh
> @@ -1167,8 +1167,10 @@ test_expect_success 'GIT_NOTES_REWRITE_REF overrides config' '
>  '
>  
>  test_expect_success 'git notes copy diagnoses too many or too few parameters' '
> -	test_must_fail git notes copy &&
> -	test_must_fail git notes copy one two three
> +	test_must_fail git notes copy 2>error &&
> +	test_i18ngrep "too few parameters" error &&
> +	test_must_fail git notes copy one two three 2>error &&
> +	test_i18ngrep "too many parameters" error
>  '
>  
>  test_expect_success 'git notes get-ref expands refs/heads/master to refs/notes/refs/heads/master' '
