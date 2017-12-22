Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 503061F406
	for <e@80x24.org>; Fri, 22 Dec 2017 18:16:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756756AbdLVSQF (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 13:16:05 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50437 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756762AbdLVSQD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 13:16:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6526BBCCE3;
        Fri, 22 Dec 2017 13:16:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=oPHQlNI7nl+1
        4G92DJsStoxs634=; b=nBYx2o4jucWJwUPXcCcKyV7FJyS6KouRdCcWwc5VFH55
        Lfr9JLLyQz8FiNwmuTODfXMab9mUHXpjG/NxoukO2yzFbY5Wla4ZDT5H2geVjXPQ
        l1/BF7/YjmuEMUoKRsiXXblpgHMcd/sBlTlF0WOCFD8vapsH7HHyI1cJvT+UgvI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=vBdzhQ
        pVUVOhWtvGjBiP1IDzo9hN25FJgwvntv8DSNJ+hJmWGFk6USkD+/asNB5BunTyJX
        +trcRw27UKfJRRZ9d4F38eq9BC0WaU1ICRrz/WCoptMYJxKV162xQI+c1b96MM1A
        bXLldzuATMQdL6hq6TYT4/ZmvL/yhb3k+OxrE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0075ABCCE1;
        Fri, 22 Dec 2017 13:16:01 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AE147BCCDF;
        Fri, 22 Dec 2017 13:16:00 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@jeffhostetler.com, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] t/helper/test-lazy-name-hash: fix compilation
References: <39238da4-c2b8-050d-51e3-675f5515776e@jeffhostetler.com>
        <20171220222416.130872-1-sbeller@google.com>
Date:   Fri, 22 Dec 2017 10:15:59 -0800
In-Reply-To: <20171220222416.130872-1-sbeller@google.com> (Stefan Beller's
        message of "Wed, 20 Dec 2017 14:24:16 -0800")
Message-ID: <xmqq7etetyqo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2A0C29C2-E744-11E7-A515-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I was compiling origin/master today with the DEVELOPER compiler flags
> today and was greeted by
>
> t/helper/test-lazy-init-name-hash.c: In function =E2=80=98cmd_main=E2=80=
=99:
> t/helper/test-lazy-init-name-hash.c:172:5: error: =E2=80=98nr_threads_u=
sed=E2=80=99 may be used uninitialized in this function [-Werror=3Dmaybe-=
uninitialized]
>      printf("avg [size %8d] [single %f] %c [multi %f %d]\n",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          nr,
>          ~~~
>          (double)avg_single/1000000000,
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          (avg_single < avg_multi ? '<' : '>'),
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          (double)avg_multi/1000000000,
>          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>          nr_threads_used);
>          ~~~~~~~~~~~~~~~~
> t/helper/test-lazy-init-name-hash.c:115:6: note: =E2=80=98nr_threads_us=
ed=E2=80=99 was declared here
>   int nr_threads_used;
>       ^~~~~~~~~~~~~~~
>
> Fix this issue by assigning 0 to 'nr_threads_used'.
>
> Acked-by: Jonathan Tan <jonathantanmy@google.com>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>
> Slightly reworded the commit message. I'd really like this patch to be =
included
> such that I can compile git with the DEVELOPER_CFLAGS flags.

Heh; I do not think there particularly is much difference between
stricter flags and DEVELOPER flags, but I would rather not lose the
removal of duplicated 'today' I did while I queued the previous one
;-)

>
>  t/helper/test-lazy-init-name-hash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-i=
nit-name-hash.c
> index 6368a89345..297fb01d61 100644
> --- a/t/helper/test-lazy-init-name-hash.c
> +++ b/t/helper/test-lazy-init-name-hash.c
> @@ -112,7 +112,7 @@ static void analyze_run(void)
>  {
>  	uint64_t t1s, t1m, t2s, t2m;
>  	int cache_nr_limit;
> -	int nr_threads_used;
> +	int nr_threads_used =3D 0;
>  	int i;
>  	int nr;
