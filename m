Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 734DE2021E
	for <e@80x24.org>; Mon, 31 Oct 2016 21:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S946979AbcJaVLE (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Oct 2016 17:11:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59026 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935253AbcJaVLB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2016 17:11:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5EFF94B112;
        Mon, 31 Oct 2016 17:11:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SyGPhpSThwBCQd3/wqYQ2CoTOAQ=; b=aBcnkN
        3sWJbTmk8Vfo9Tt1yP0dlYi0jxAiACQbu+Y0SQX6xqWklHpZakjh2Xr+XbA+cE3+
        6mXFjDtlGfQ+0QU98ViEVC9bhV0ROEX09D9ZnRHZAHRZ/vTskyarfeBX2OlGRJfp
        8kS7677tCfIlwEVPJWutIWoyDqolbJeMSOywg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=o8/bBAS7mwWr7VloGIAzkUWUuTiiCBwr
        cJf7Kcc2PR7L7FxqQwAFFriLZFCUG9nd4K/OMARCxoCDahu8SWvST/tF/pTedpqU
        FbqY2ezxAX1kiVxHY4DDdK/9WfLy2zC8mt72kMI4a4DaouBApCvn974NHckN7uk3
        hiB+vuRVHys=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54F724B111;
        Mon, 31 Oct 2016 17:11:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C790F4B110;
        Mon, 31 Oct 2016 17:10:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
Cc:     git@vger.kernel.org, Kannan Goundan <kannan@cakoose.com>
Subject: Re: [PATCH] push: do not use potentially ambiguous default refspec
References: <xmqqvawcz36d.fsf@gitster.mtv.corp.google.com>
        <20161031203834.dfavyjzkob2goa5n@hurricane>
Date:   Mon, 31 Oct 2016 14:10:58 -0700
In-Reply-To: <20161031203834.dfavyjzkob2goa5n@hurricane> (Dennis Kaarsemaker's
        message of "Mon, 31 Oct 2016 21:38:35 +0100")
Message-ID: <xmqqk2corzq5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85BEC6C8-9FAE-11E6-9355-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dennis Kaarsemaker <dennis@kaarsemaker.net> writes:

> On Fri, Oct 28, 2016 at 12:25:30PM -0700, Junio C Hamano wrote:
>
>>  * It is appreciated if somebody with spare cycles can add a test or
>>    two for this in t/t5523-push-upstream.sh or somewhere nearby.
>
> 5523 is for push --set-upstream-to, 5528 seemed more appropriate. Here's
> something squashable that fails before your patch and succeeds after.

Thanks.

>
>>8----
> Subject: [PATCH] push: test pushing ambiguously named branches
>
> Signed-off-by: Dennis Kaarsemaker <dennis@kaarsemaker.net>
> ---
>  t/t5528-push-default.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t5528-push-default.sh b/t/t5528-push-default.sh
> index 73f4bb6..ac103ce 100755
> --- a/t/t5528-push-default.sh
> +++ b/t/t5528-push-default.sh
> @@ -98,6 +98,16 @@ test_expect_success 'push from/to new branch with upstream, matching and simple'
>  	test_push_failure upstream
>  '
>  
> +test_expect_success 'push ambiguously named branch with upstream, matching and simple' '
> +	git checkout -b ambiguous &&
> +	test_config branch.ambiguous.remote parent1 &&
> +	test_config branch.ambiguous.merge refs/heads/ambiguous &&
> +	git tag ambiguous &&
> +	test_push_success simple ambiguous &&
> +	test_push_success matching ambiguous &&
> +	test_push_success upstream ambiguous
> +'
> +
>  test_expect_success 'push from/to new branch with current creates remote branch' '
>  	test_config branch.new-branch.remote repo1 &&
>  	git checkout new-branch &&
