Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F5611F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 01:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391530AbeKVMGg (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 07:06:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53138 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389067AbeKVMGg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 07:06:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 75E4E113D72;
        Wed, 21 Nov 2018 20:29:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aRDYLY1m0ysb31JwY6lMv0PKIcI=; b=TNDjOu
        fwuHnlM59ifrvDcv0YsPUuLPqSmVGut9MVTJOyx3StByAN8XJMWRfffrMB4zzxA7
        07WeJ391e9oEOc+u6ZtvytcTqPe1txyPfjTScAX3HD0Qn73yrE8c0lArfjWLrIiQ
        p+iAXqjQyFTnVj9y9D/XXf7jzDoYxrAmW37DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q1Pv0j4kOTAGwckt2/JmO3lzX+KtQYla
        3/enWwTxnn258kITcxnmdfoIcSUpKaM9q5y3qDAZpSclljt/dCTJo2AtM4JWi8Ea
        kMYg7zHYYp5Ab6Cx6uEFoB0bTiQQuzFgu253Ki5bIWSD03eRNzgNxAqgCBDPlHz9
        V9JvGWBiol4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6E32D113D71;
        Wed, 21 Nov 2018 20:29:37 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C413E113D6D;
        Wed, 21 Nov 2018 20:29:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v1 1/2] log -G: Ignore binary files
References: <cover.1542831544.git.thomas.braun@virtuell-zuhause.de>
        <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
Date:   Thu, 22 Nov 2018 10:29:35 +0900
In-Reply-To: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
        (Thomas Braun's message of "Wed, 21 Nov 2018 21:52:27 +0100")
Message-ID: <xmqq4lc96gsg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 12CFFDE2-EDF6-11E8-B89B-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> The -G <regex> option of log looks for the differences whose patch text
> contains added/removed lines that match regex.
>
> The concept of differences only makes sense for text files, therefore
> we need to ignore binary files when searching with -G <regex> as well.
>
> Signed-off-by: Thomas Braun <thomas.braun@virtuell-zuhause.de>
> ---
>  Documentation/gitdiffcore.txt |  2 +-
>  diffcore-pickaxe.c            |  5 +++++
>  t/t4209-log-pickaxe.sh        | 22 ++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 1 deletion(-)

OK.

> diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
> index c0a60f3158..059ddd3431 100644
> --- a/Documentation/gitdiffcore.txt
> +++ b/Documentation/gitdiffcore.txt
> @@ -242,7 +242,7 @@ textual diff has an added or a deleted line that matches the given
>  regular expression.  This means that it will detect in-file (or what
>  rename-detection considers the same file) moves, which is noise.  The
>  implementation runs diff twice and greps, and this can be quite
> -expensive.
> +expensive.  Binary files without textconv filter are ignored.

OK.

> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
> index 69fc55ea1e..8c2558b07d 100644
> --- a/diffcore-pickaxe.c
> +++ b/diffcore-pickaxe.c
> @@ -144,6 +144,11 @@ static int pickaxe_match(struct diff_filepair *p, struct diff_options *o,
>  		textconv_two = get_textconv(o->repo->index, p->two);
>  	}
>  
> +	if ((o->pickaxe_opts & DIFF_PICKAXE_KIND_G) &&
> +	    ((!textconv_one && diff_filespec_is_binary(o->repo, p->one)) ||
> +	     (!textconv_two && diff_filespec_is_binary(o->repo, p->two))))
> +		return 0;
> +
>  	/*
>  	 * If we have an unmodified pair, we know that the count will be the
>  	 * same and don't even have to load the blobs. Unless textconv is in

Shouldn't this new test come after the existing optimization, which
allows us to leave without loading the blob contents (which is
needed once you call diff_filespec_is_binary())?

> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 844df760f7..42cc8afd8b 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -106,4 +106,26 @@ test_expect_success 'log -S --no-textconv (missing textconv tool)' '
>  	rm .gitattributes
>  '
>  
> +test_expect_success 'log -G ignores binary files' '
> +	rm -rf .git &&
> +	git init &&

Please never never ever do the above two unless you are writing a
test that checks low-level repository details.

If you want a clean history that has specific lineage of commits
without getting affected by commits that have been made by the
previous test pieces, it is OK to "checkout --orphan" to create an
empty history to work with.

> +	printf "a\0b" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -G a >result &&
> +	test_must_be_empty result
> +'
> +
> +test_expect_success 'log -G looks into binary files with textconv filter' '
> +	rm -rf .git &&
> +	git init &&
> +	echo "* diff=bin" > .gitattributes &&
> +	printf "a\0b" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git -c diff.bin.textconv=cat log -G a >actual &&
> +	git log >expected &&
> +	test_cmp actual expected
> +'
> +
>  test_done
