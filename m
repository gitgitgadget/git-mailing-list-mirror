Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B69E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 10:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729324AbeKLUp7 (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 15:45:59 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63307 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729217AbeKLUp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 15:45:58 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2BFC104C3E;
        Mon, 12 Nov 2018 05:53:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SavAGgZEKczd
        f0zlJyKwnxZJAs8=; b=bHtHksv7GiwZc2MRQ7id96sIYgu+aCh/9FsuYr8W1Jqz
        FT/MmfF4RcedzeCrYDWzjHspzWRpCvSvs8eAWrf/naolwJLR/Cu24lFq9XpvQCxa
        yipOcMF3e21lOlknu3xec+LQuPnovZQ84Nm9z4qPMMlUQ+3ZCdlBn76tYorEE4k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ZB69IZ
        IwvPXX8W3X0ymPjpYGPvgNJcbADBtyWh3qg9YcE92kLCYSrYDU2BbDrHm95BxYx9
        5jhqSo5dbacERoNNyP9kEyL3LKSBjbaLRJC9Cy5gvIl81CAAEdTvvH2wa3+PG/1j
        Gp0zIzz7Tx97P/ZPy8oEW7uS/a+HcHBvQTq84=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAEDB104C3B;
        Mon, 12 Nov 2018 05:53:13 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 137D1104C39;
        Mon, 12 Nov 2018 05:53:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        johannes.schindelin@gmx.de, peff@peff.net
Subject: Re: [PATCH 2/2] read-cache: use time_t instead of unsigned long
References: <20181112084031.11769-1-carenas@gmail.com>
        <20181112084031.11769-3-carenas@gmail.com>
Date:   Mon, 12 Nov 2018 19:53:11 +0900
In-Reply-To: <20181112084031.11769-3-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Mon, 12 Nov 2018 00:40:31 -0800")
Message-ID: <xmqqftw61sa0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 26C11938-E669-11E8-8A58-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> b968372279 ("read-cache: unlink old sharedindex files", 2017-03-06)
> introduced get_shared_index_expire_date using unsigned long to track
> the modification times of a shared index.
>
> dddbad728c ("timestamp_t: a new data type for timestamps", 2017-04-26)
> shows why that might problematic so move to time_t instead.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  read-cache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/read-cache.c b/read-cache.c
> index 7b1354d759..5525d8e679 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2625,9 +2625,9 @@ static int write_split_index(struct index_state *=
istate,
> =20
>  static const char *shared_index_expire =3D "2.weeks.ago";
> =20
> -static unsigned long get_shared_index_expire_date(void)
> +static time_t get_shared_index_expire_date(void)
>  {
> -	static unsigned long shared_index_expire_date;
> +	static time_t shared_index_expire_date;
>  	static int shared_index_expire_date_prepared;
> =20
>  	if (!shared_index_expire_date_prepared) {

After this line, the post-context reads like this:

		git_config_get_expiry("splitindex.sharedindexexpire",
				      &shared_index_expire);
		shared_index_expire_date =3D approxidate(shared_index_expire);
		shared_index_expire_date_prepared =3D 1;
	}

	return shared_index_expire_date;

Given that the function returns the value obtained from
approxidate(), which is approxidate_careful() in disguise, time_t is
not as appropriate as timestamp_t, no?

IOW, what if time_t were narrower than timestamp_t?


> @@ -2643,7 +2643,7 @@ static unsigned long get_shared_index_expire_date=
(void)
>  static int should_delete_shared_index(const char *shared_index_path)
>  {
>  	struct stat st;
> -	unsigned long expiration;
> +	time_t expiration;
> =20
>  	/* Check timestamp */
>  	expiration =3D get_shared_index_expire_date();
