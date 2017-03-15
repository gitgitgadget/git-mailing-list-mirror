Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47D92202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 18:30:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbdCOS37 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 14:29:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64733 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751358AbdCOS3g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 14:29:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5441D782B3;
        Wed, 15 Mar 2017 14:29:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RWlG/SWQPA/iC5gx6k0c200U6pA=; b=eURDpc
        O2R9B7L4WhljQifkaKeMDFjAyuZ4FoGXuiRnZmy1iLbrDzvCkn1G59LU2MBjauKt
        oJlGwLvUSuxotiQ3WaTJhnF6nILjBRsSz0AV1NYs27UZD5p+QLAVvOK0KM/sOIZJ
        q40plLBmfZWxqWIpmTyWQ4IBRJKWSzVlUxXT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ZL0Z9pXOcewgvV968XE92imPNZhLPfyU
        I/LGzacwbZYdSWs5agLGWE1OUEjEMWt8pEN4/+ZinTEIVtS7tCJFxzyC4cwH29GZ
        X97cruVjNygvcKMj1rp9xknyj0sl2QmBFQ5voTednTkagINA3bq3hldi3KY+av1Y
        pqIEv5iWb04=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47D3A782B2;
        Wed, 15 Mar 2017 14:29:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3A84782B1;
        Wed, 15 Mar 2017 14:29:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule-config: correct error reporting for invalid ignore value
References: <20170314221440.18259-1-sbeller@google.com>
Date:   Wed, 15 Mar 2017 11:29:32 -0700
In-Reply-To: <20170314221440.18259-1-sbeller@google.com> (Stefan Beller's
        message of "Tue, 14 Mar 2017 15:14:40 -0700")
Message-ID: <xmqqefxyfl6b.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5626A4D0-09AD-11E7-809A-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> As 'var' contains the whole value we get error messages that repeat
> the section and key currently:
>
> warning: Invalid parameter 'true' for config option 'submodule.submodule.plugins/hooks.ignore.ignore'
>
> Fix this by only giving the section name in the warning.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  submodule-config.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/submodule-config.c b/submodule-config.c
> index 93453909cf..bb069bc097 100644
> --- a/submodule-config.c
> +++ b/submodule-config.c
> @@ -333,7 +333,7 @@ static int parse_config(const char *var, const char *value, void *data)
>  			 strcmp(value, "all") &&
>  			 strcmp(value, "none"))
>  			warning("Invalid parameter '%s' for config option "
> -					"'submodule.%s.ignore'", value, var);
> +					"'submodule.%s.ignore'", value, name.buf);

Obviously correct.  Nobody seems to have complained about this since
it was first written in 2.6 days, which is a bit sad, though.

Thanks.
