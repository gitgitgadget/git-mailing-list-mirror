Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D3DC91F454
	for <e@80x24.org>; Fri,  8 Nov 2019 04:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfKHE5K (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 23:57:10 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57099 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfKHE5K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 23:57:10 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70D19219E2;
        Thu,  7 Nov 2019 23:57:02 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=hS52CoE9cfsz
        N+geZYf8GLIeTLc=; b=eK1ADz4vU76pLKhahZ+eJvtDIPzgfD3WovLANCiBA5PU
        FlTlqGSrBlKhGbFJUvwRS/FynxyFCnPiPF+FE9vfVvwNS222diUQkNRVeh9ayBO9
        QRoXJ9djUta/aOabux8shJSBLAlhcvTK33qS23u+tobfIfIU4u59kCVwg/3hySc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ie8VKI
        VlAjDwIiu5o+HecwqRXmrl7UmgiwQBVdz9TC7Vdzw+DZhW6NDwvwcT63BpXm8rM0
        0Yy60DmSEoxoLd3y2wiDGTIBkFsWjl6vvznJ2qDzgfmXNYk8Yg/OL+ValVOMRcw/
        FVMyzxEGh1TrU5t/KThzuqIrLaEykwOItupm0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 62417219E1;
        Thu,  7 Nov 2019 23:57:02 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A80C8219DF;
        Thu,  7 Nov 2019 23:57:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Daniel Ferreira <bnmvco@gmail.com>
Subject: Re: [PATCH v5 2/9] diff: export diffstat interface
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <2fc8cc354690841cd8496d9a7660faf572580aef.1572869730.git.gitgitgadget@gmail.com>
Date:   Fri, 08 Nov 2019 13:56:59 +0900
In-Reply-To: <2fc8cc354690841cd8496d9a7660faf572580aef.1572869730.git.gitgitgadget@gmail.com>
        (Daniel Ferreira via GitGitGadget's message of "Mon, 04 Nov 2019
        12:15:22 +0000")
Message-ID: <xmqqd0e3nexw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 32F1B63A-01E4-11EA-B75B-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Daniel Ferreira via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Daniel Ferreira <bnmvco@gmail.com>
>
> Make the diffstat interface (namely, the diffstat_t struct and
> compute_diffstat) no longer be internal to diff.c and allow it to be us=
ed
> by other parts of git.
>
> This is helpful for code that may want to easily extract information
> from files using the diff machinery, while flushing it differently from
> how the show_* functions used by diff_flush() do it. One example is the
> builtin implementation of git-add--interactive's status.
>
> Signed-off-by: Daniel Ferreira <bnmvco@gmail.com>
> Signed-off-by: Slavica =C4=90uki=C4=87 <slawica92@hotmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c | 39 ++++++++++++++++-----------------------
>  diff.h | 20 ++++++++++++++++++++
>  2 files changed, 36 insertions(+), 23 deletions(-)

Looks good.  The diffstat API seems to be quite well isolated to
allow this with minimum (eh, rather no) changes.

Thanks.

>
> diff --git a/diff.c b/diff.c
> index afe4400a60..5703a9b78f 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2495,22 +2495,6 @@ static void pprint_rename(struct strbuf *name, c=
onst char *a, const char *b)
>  	}
>  }
> =20
> -struct diffstat_t {
> -	int nr;
> -	int alloc;
> -	struct diffstat_file {
> -		char *from_name;
> -		char *name;
> -		char *print_name;
> -		const char *comments;
> -		unsigned is_unmerged:1;
> -		unsigned is_binary:1;
> -		unsigned is_renamed:1;
> -		unsigned is_interesting:1;
> -		uintmax_t added, deleted;
> -	} **files;
> -};
> -
>  static struct diffstat_file *diffstat_add(struct diffstat_t *diffstat,
>  					  const char *name_a,
>  					  const char *name_b)
> @@ -3157,7 +3141,7 @@ static void show_dirstat_by_line(struct diffstat_=
t *data, struct diff_options *o
>  	gather_dirstat(options, &dir, changed, "", 0);
>  }
> =20
> -static void free_diffstat_info(struct diffstat_t *diffstat)
> +void free_diffstat_info(struct diffstat_t *diffstat)
>  {
>  	int i;
>  	for (i =3D 0; i < diffstat->nr; i++) {
> @@ -6283,12 +6267,7 @@ void diff_flush(struct diff_options *options)
>  	    dirstat_by_line) {
>  		struct diffstat_t diffstat;
> =20
> -		memset(&diffstat, 0, sizeof(struct diffstat_t));
> -		for (i =3D 0; i < q->nr; i++) {
> -			struct diff_filepair *p =3D q->queue[i];
> -			if (check_pair_status(p))
> -				diff_flush_stat(p, options, &diffstat);
> -		}
> +		compute_diffstat(options, &diffstat, q);
>  		if (output_format & DIFF_FORMAT_NUMSTAT)
>  			show_numstat(&diffstat, options);
>  		if (output_format & DIFF_FORMAT_DIFFSTAT)
> @@ -6621,6 +6600,20 @@ static int is_submodule_ignored(const char *path=
, struct diff_options *options)
>  	return ignored;
>  }
> =20
> +void compute_diffstat(struct diff_options *options,
> +		      struct diffstat_t *diffstat,
> +		      struct diff_queue_struct *q)
> +{
> +	int i;
> +
> +	memset(diffstat, 0, sizeof(struct diffstat_t));
> +	for (i =3D 0; i < q->nr; i++) {
> +		struct diff_filepair *p =3D q->queue[i];
> +		if (check_pair_status(p))
> +			diff_flush_stat(p, options, diffstat);
> +	}
> +}
> +
>  void diff_addremove(struct diff_options *options,
>  		    int addremove, unsigned mode,
>  		    const struct object_id *oid,
> diff --git a/diff.h b/diff.h
> index 7f8f024feb..d986ddc3b5 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -245,6 +245,22 @@ void diff_emit_submodule_error(struct diff_options=
 *o, const char *err);
>  void diff_emit_submodule_pipethrough(struct diff_options *o,
>  				     const char *line, int len);
> =20
> +struct diffstat_t {
> +	int nr;
> +	int alloc;
> +	struct diffstat_file {
> +		char *from_name;
> +		char *name;
> +		char *print_name;
> +		const char *comments;
> +		unsigned is_unmerged:1;
> +		unsigned is_binary:1;
> +		unsigned is_renamed:1;
> +		unsigned is_interesting:1;
> +		uintmax_t added, deleted;
> +	} **files;
> +};
> +
>  enum color_diff {
>  	DIFF_RESET =3D 0,
>  	DIFF_CONTEXT =3D 1,
> @@ -334,6 +350,10 @@ void diff_change(struct diff_options *,
> =20
>  struct diff_filepair *diff_unmerge(struct diff_options *, const char *=
path);
> =20
> +void compute_diffstat(struct diff_options *options, struct diffstat_t =
*diffstat,
> +		      struct diff_queue_struct *q);
> +void free_diffstat_info(struct diffstat_t *diffstat);
> +
>  #define DIFF_SETUP_REVERSE      	1
>  #define DIFF_SETUP_USE_SIZE_CACHE	4
