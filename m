Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1DC91F4F8
	for <e@80x24.org>; Thu, 22 Sep 2016 20:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030936AbcIVUZT (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Sep 2016 16:25:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62344 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1030459AbcIVUZR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Sep 2016 16:25:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A34B13F4F9;
        Thu, 22 Sep 2016 16:25:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fv2ZxMHwPHr8hi91xHfO2kHvS80=; b=rqkiZr
        HyhUehuR1y4jc45HI5hUrudOKQpCQzl7wEClTVnNNRHJHK92Qn99038xFfWqFJ9z
        8j/pkYqPAUzkgnd5IKyUDk7cNy4uObhdTZj9y454uJ+fTyWgJ4AWeAcVGb+xMC5B
        zB27rLK3uOTQnPX7W7JaCiFuiVHpC0MiQhZIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=e+omtZbnXjmsx+9D69tr17QEOeEvp648
        dRoScfH3qve5agKgrdlDvtXfPWo4Sztz1MzbhVojv49PpBKjSK24xEJuICSlIUgo
        ToIikbKFBr5GAT5MbsWBSQ/Wv5rM0PUrtAlhojIxH6KU+Hih5uHQaUte+79JrytT
        DqilyYtzQ7Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9B32B3F4F8;
        Thu, 22 Sep 2016 16:25:15 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 21F543F4F7;
        Thu, 22 Sep 2016 16:25:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     santiago@nyu.edu
Cc:     git@vger.kernel.org, peff@peff.net, sunshine@sunshineco.com,
        walters@verbum.org, Lukas P <luk.puehringer@gmail.com>,
        Lukas Puehringer <lukas.puehringer@nyu.edu>
Subject: Re: [PATCH 2/6] gpg-interface: add GPG_VERIFY_QUIET flag
References: <20160922185317.349-1-santiago@nyu.edu>
        <20160922185317.349-3-santiago@nyu.edu>
Date:   Thu, 22 Sep 2016 13:25:13 -0700
In-Reply-To: <20160922185317.349-3-santiago@nyu.edu> (santiago@nyu.edu's
        message of "Thu, 22 Sep 2016 14:53:13 -0400")
Message-ID: <xmqq7fa34r86.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ABB6B0EA-8102-11E6-8F04-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

santiago@nyu.edu writes:

> diff --git a/gpg-interface.c b/gpg-interface.c
> index 8672eda..b82bc50 100644
> --- a/gpg-interface.c
> +++ b/gpg-interface.c
> @@ -88,6 +88,9 @@ int check_signature(const char *payload, size_t plen, const char *signature,
>  
>  void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
>  {
> +	if (flags & GPG_VERIFY_QUIET)
> +		return;
> +
>  	const char *output = flags & GPG_VERIFY_RAW ?
>  		sigc->gpg_status : sigc->gpg_output;

This will not compile with -Werror=declaration-after-statement.
