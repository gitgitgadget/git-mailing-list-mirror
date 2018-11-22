Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588B21F87F
	for <e@80x24.org>; Thu, 22 Nov 2018 01:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391542AbeKVMLJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Nov 2018 07:11:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55108 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727253AbeKVMLJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Nov 2018 07:11:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EB4753A4BA;
        Wed, 21 Nov 2018 20:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+Gow7fDoiHTA+t/ANYyWUZ138JA=; b=SjQQ8x
        aO4IWBM0Waoldp7FVwdaknsWU+gJ2SQ58Nhx2pFoEDrG+hgn9j/yCDwhBcRbF7R2
        5QHutAy85WC/k8Ldch9kLTTltxdMtuYQymG878ElqHJQuzh3m3HtR8Qxxb8Ug4ic
        vVc6F0zOtUqi1saz6XkPyPksQyn2bOmasAieM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BFkcmz9VJMmXeRBnfDErEl6x3TRF7cgk
        SI1JIxgwNe2CFpTRevy9EXGtQim1TvEqyxUVB1xEGWJ2o+wxBlQD43Eg9lALLUSX
        pEc2QWIXJaZQ/JJQOc64lSteTM+Jx/Em9e2Rk36CXHYxaYunCjge+NxcAXgTlM7W
        /cE5VhRdmxg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E51683A4B9;
        Wed, 21 Nov 2018 20:34:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0583C3A4B7;
        Wed, 21 Nov 2018 20:34:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v1 2/2] log -S: Add test which searches in binary files
References: <590f2ca6b5323c17365a1645b5d10e9ab30623c4.1542833244.git.thomas.braun@virtuell-zuhause.de>
        <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
Date:   Thu, 22 Nov 2018 10:34:03 +0900
In-Reply-To: <84cbbfbd213b358d1e2d7cce8b4685b09efac3de.1542833244.git.thomas.braun@virtuell-zuhause.de>
        (Thomas Braun's message of "Wed, 21 Nov 2018 21:52:28 +0100")
Message-ID: <xmqqzhu1520k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B348478E-EDF6-11E8-983C-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Braun <thomas.braun@virtuell-zuhause.de> writes:

> The -S <regex> option of log looks for differences that changes the
> number of occurrences of the specified string (i.e. addition/deletion)
> in a file.

s/-S <regex>/-S<block of text>/ and
s/the specified string/the specified block of text/ would make it
more in line with how Documentation/gitdiffcore.txt explains it.
The original discussion from early 2017 also explains with a pointer
why the primary mode of -S is not <regex> but is <block of text>.

> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 42cc8afd8b..d430f6f2f9 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -128,4 +128,15 @@ test_expect_success 'log -G looks into binary files with textconv filter' '
>  	test_cmp actual expected
>  '
>  
> +test_expect_success 'log -S looks into binary files' '
> +	rm -rf .git &&
> +	git init &&

Same comment as the one for 1/2 applies here.

> +	printf "a\0b" >data.bin &&
> +	git add data.bin &&
> +	git commit -m "message" &&
> +	git log -S a >actual &&
> +	git log >expected &&
> +	test_cmp actual expected
> +'
> +
>  test_done

Other than these, I think both patches look sensible.  Thanks for
resurrecting the old topic and reigniting it.
