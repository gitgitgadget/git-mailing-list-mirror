Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 943DC1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 19:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752138AbdHPTq2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 15:46:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65067 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751893AbdHPTq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2017 15:46:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9D5D6B0A72;
        Wed, 16 Aug 2017 15:46:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BMSgCwLBHP0CGOBWEZhJYmULH6E=; b=B6SbzR
        5an5Ny9CcqTaNwqVZ8j+5bnHCziW3oc6JxLLfGv4LmtZ9oTQ61Mh/2zt0WS3C5KH
        DuO4KQr860fEwyagbM1eNR4YOB5AJS8P8iDJPJaVxT12gOTGShefrDoruyrn+0BY
        CG8u/bC+QA+O3S2WCBw89AM4E3U4vh4SeVCMo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e5UxLug+KttF0ActW+IpvzGU02QXJAS/
        yuKxJdrzoVFu93NzwXK5L/vzl3tKsflag4WT4tLtE/scA+BYJ2XMx3jDYCekv3yP
        SHGYpvVL1zPpyy33ozlZ3u9RvtTyCqWI/6dQi2HRAXIurZjYuTUVqKw2rycvMhrp
        xW33tiSEEYQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 95D11B0A70;
        Wed, 16 Aug 2017 15:46:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCDE8B0A6D;
        Wed, 16 Aug 2017 15:46:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 1/4] sha1_file: fix hardcoded size in null_sha1
References: <cover.1502796628.git.patryk.obara@gmail.com>
        <cover.1502905085.git.patryk.obara@gmail.com>
        <cover.1502905085.git.patryk.obara@gmail.com>
        <bc6dc9fd13dfb6539af994c662eebf2474e731fb.1502905085.git.patryk.obara@gmail.com>
Date:   Wed, 16 Aug 2017 12:46:24 -0700
In-Reply-To: <bc6dc9fd13dfb6539af994c662eebf2474e731fb.1502905085.git.patryk.obara@gmail.com>
        (Patryk Obara's message of "Wed, 16 Aug 2017 19:58:22 +0200")
Message-ID: <xmqqinhnjnxr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96CCC8E8-82BB-11E7-AC0F-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patryk Obara <patryk.obara@gmail.com> writes:

> This prevents compilation error if GIT_MAX_RAWSZ is different than 20.

The above made me scratch my head wondering why because it does not
say what the root cause of the issue is.  It would have avoided a
few strand of lost hair if it were more like this, perhaps:

	The array is declared in cache.h as

	    extern const unsigned char null_sha1[GIT_MAX_RAWSZ];

	The definition of it we have in sha1_file.c must match.


>
> Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
> ---
>  sha1_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sha1_file.c b/sha1_file.c
> index b60ae15..f5b5bec 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -32,7 +32,7 @@
>  #define SZ_FMT PRIuMAX
>  static inline uintmax_t sz_fmt(size_t s) { return s; }
>  
> -const unsigned char null_sha1[20];
> +const unsigned char null_sha1[GIT_MAX_RAWSZ];
>  const struct object_id null_oid;
>  const struct object_id empty_tree_oid = {
>  	EMPTY_TREE_SHA1_BIN_LITERAL
