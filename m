Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 79DCB1FC96
	for <e@80x24.org>; Tue, 29 Nov 2016 18:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756319AbcK2SmY (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Nov 2016 13:42:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55744 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754936AbcK2SmV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Nov 2016 13:42:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4016252BA0;
        Tue, 29 Nov 2016 13:42:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=YUauNg1lZhWv
        XJ5yKsHoZsFENrM=; b=fOumJ7LPopYb9wOhKvmwkKi71Wji7bC/k4qygXanYAmE
        Zfwj88reWLeSfKzkd7ECqHbNNx/JI/7VfZau4j2bilhW8lfBkR0W/X7ph8cZTmAU
        kChwT4MQcX6KZ9qh7KuOsPx6smT4zg9Ru3cw/NZAhTBvVfhh19nR2SpaBTDasO4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GUsIOo
        Kktne32scnAn5w8vireUrgjzpmoOePhDbr3R8uTTymqKYlCqgviby9LzUuFPo6tJ
        0uJvpFs1cU1y1W/87HbtCzRPWcWQpgQmHEKilv3qBGVhWlXF/zodVDFi4EccExzW
        UBZKuVRarOWkAqnLhhDv8Vqq++ScrQIF+Zazc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 372B952B9F;
        Tue, 29 Nov 2016 13:42:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A1A7952B9E;
        Tue, 29 Nov 2016 13:42:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, eevee.reply@veekun.com
Subject: Re: [PATCH v1 1/1] convert:  git cherry-pick -Xrenormalize did not work
References: <6a7e155-f399-c9f8-c69e-8164e0735dfb@veekun.com>
        <20161129163023.23403-1-tboegi@web.de>
Date:   Tue, 29 Nov 2016 10:42:18 -0800
In-Reply-To: <20161129163023.23403-1-tboegi@web.de> (tboegi@web.de's message
        of "Tue, 29 Nov 2016 17:30:23 +0100")
Message-ID: <xmqq7f7mgmb9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8EE4DA46-B663-11E6-908A-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> Working with a repo that used to be all CRLF. At some point it
> was changed to all LF, with `text=3Dauto` in .gitattributes.
> Trying to cherry-pick a commit from before the switchover fails:
>
> $ git cherry-pick -Xrenormalize <commit>
>     fatal: CRLF would be replaced by LF in [path]

OK.  That's a very clear description of the symptom that can be
observed from the surface.

> Whenever crlf_action is CRLF_TEXT_XXX and not CRLF_AUTO_XXX,
> SAFE_CRLF_RENORMALIZE must be turned into CRLF_SAFE_FALSE.

Aside from needing s/CRLF_SAFE/SAFE_CRLF/, this however lacks
"Otherwise, because of X and Y, Z ends up doing W" to explain
the "must be" part.  Care to explain it a bit more?

Thanks.

> Reported-by: Eevee (Lexy Munroe) <eevee@veekun.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>
> Thanks for reporting.
> Here is a less invasive patch.
> Please let me know, if the patch is OK for you
> (email address, does it work..)
>
>  convert.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/convert.c b/convert.c
> index be91358..526ec1d 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -286,7 +286,9 @@ static int crlf_to_git(const char *path, const char=
 *src, size_t len,
>  			checksafe =3D SAFE_CRLF_FALSE;
>  		else if (has_cr_in_index(path))
>  			convert_crlf_into_lf =3D 0;
> -	}
> +	} else if (checksafe =3D=3D SAFE_CRLF_RENORMALIZE)
> +		checksafe =3D SAFE_CRLF_FALSE;
> +
>  	if (checksafe && len) {
>  		struct text_stat new_stats;
>  		memcpy(&new_stats, &stats, sizeof(new_stats));
