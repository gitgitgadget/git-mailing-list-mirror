Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD52B2070D
	for <e@80x24.org>; Fri,  8 Jul 2016 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755348AbcGHPyO (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 11:54:14 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755164AbcGHPyL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 11:54:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id BD7D82B9F7;
	Fri,  8 Jul 2016 11:53:41 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RWJuvqaEwAiy7x7gghYFTmi9tZE=; b=kFcrVQ
	TwLnAYM7hYeMCdjGPjHaPz2goPVdUyuCRv2yn2EM0Q3hqPcymOcvoDY3T5f4xMR2
	dGl/cEFZppyb/wOrcPRfZG5X8rpvCdv+DAdRMxktNFGoK8jKcZV+SPoQjKEze71F
	23935lcD41zrHgSYocjZNajAueuwwoPMpSnEc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=bRxkboB5AUEzVV6ga62+KOqdkQg47foi
	RZGwij4UNze3NVCmR95BKs+UFFxQ8W5nXrNLsPQHjsE07wvFabby4rnz07zEJSWe
	8xopeDpejlDI3+Of8qOVe9/LndeSyhV4wnvqNkvlbgV0espl8UBk6oAp53WweV80
	MdnV5jwKgHM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B5B6A2B9F6;
	Fri,  8 Jul 2016 11:53:41 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3FE452B9F5;
	Fri,  8 Jul 2016 11:53:41 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	git@vger.kernel.org, yuri.kanivetsky@gmail.com
Subject: Re: [PATCH v2 2/2] cache-tree: do not generate empty trees as a result of all i-t-a subentries
References: <20160704174807.6578-1-pclouds@gmail.com>
	<20160706184829.31825-1-pclouds@gmail.com>
	<20160706184829.31825-3-pclouds@gmail.com>
	<xmqqeg76sh44.fsf@gitster.mtv.corp.google.com>
	<20160707171237.GA31445@duynguyen>
	<xmqqmvltp9f9.fsf@gitster.mtv.corp.google.com>
	<20160708153930.GA19448@duynguyen>
Date:	Fri, 08 Jul 2016 08:53:39 -0700
In-Reply-To: <20160708153930.GA19448@duynguyen> (Duy Nguyen's message of "Fri,
	8 Jul 2016 17:39:30 +0200")
Message-ID: <xmqqwpkwm8ho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 245F0FBC-4524-11E6-9E0D-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Yeah that's better. So the squash patch is something like this

Rather...

> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index a19f06b..80880b7 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -107,7 +107,9 @@ test_expect_success 'cache-tree does skip dir that becomes empty' '
>  		mkdir -p 1/2/3 &&
>  		echo 4 >1/2/3/4 &&
>  		git add -N 1/2/3/4 &&
> -		test_must_fail git commit -m committed
> +		git write-tree >actual &&
> +		echo 4b825dc642cb6eb9a060e54bf8d69288fbee4904 >empty-tree &&
> +		test_cmp empty-tree actual

	written=$(git write-tree) &&
        git ls-tree "$written" >actual &&
        ! grep 1 actual

That way, we have one less thing to worry about when the hash
function changes in the future.  You may want to rename 1/2/3
to something more readable (e.g. dir/2/3) and grep for "dir"
instead, though.

