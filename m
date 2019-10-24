Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22F8D1F4C0
	for <e@80x24.org>; Thu, 24 Oct 2019 03:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437216AbfJXDhj (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 23:37:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63275 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392922AbfJXDhj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 23:37:39 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4632F1D4A5;
        Wed, 23 Oct 2019 23:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kzIdoNJxCX5Bf3/1kMP1bkn3s9E=; b=cyROgX
        /iiqBUtMBcVFtqVpASaenqBgqFEETjuIS47cVCOqlYp/RI+vn55TFqBviBOgVLER
        4LJw13U/IwxwnbkDidiOpXVavlBv91nxviFfqAWW1YIkC67e1XtbH+LsH7jIl1T+
        zfK8iXRqOnnC/2UXao/SqFhfhaASrUC4AHWG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=n81yzoOcb1Adr9BPI9KtuYlLwgIKBFQm
        JuQ8eMGbRrquVIsukFk47lPKHctxTtysgul7PvO7sWRnx+2eBMqSMTdmwVkbNm6y
        jsMKmePOo7sOrFGAOOto8LvtIFwSHszHnlM1fnnxmze2u4KQC5SdTlupSXIIPEfv
        CuCa7w87PVQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3E10D1D4A4;
        Wed, 23 Oct 2019 23:37:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D9451D4A3;
        Wed, 23 Oct 2019 23:37:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 01/23] parse_commit_buffer(): treat lookup_commit() failure as parse error
References: <20191018044103.GA17625@sigill.intra.peff.net>
        <20191018044212.GA17879@sigill.intra.peff.net>
Date:   Thu, 24 Oct 2019 12:37:32 +0900
In-Reply-To: <20191018044212.GA17879@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 18 Oct 2019 00:42:13 -0400")
Message-ID: <xmqq1rv2hkzn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9D5DA9E2-F60F-11E9-8FF5-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> The "seen" variant for this test mistakenly parsed another commit
> instead of the blob, meaning that we were actually just testing the
> "lone" case again. Changing that reveals the breakage (and shows that
> this fixes it).
> ...
> @@ -52,7 +52,7 @@ test_expect_success 'traverse unexpected non-commit parent (lone)' '
>  '
>  
>  test_expect_success 'traverse unexpected non-commit parent (seen)' '
> -	test_must_fail git rev-list --objects $commit $broken_commit \
> +	test_must_fail git rev-list --objects $blob $broken_commit \
>  		>output 2>&1 &&
>  	test_i18ngrep "not a commit" output
>  '

Yikes.  Thanks for spotting.

