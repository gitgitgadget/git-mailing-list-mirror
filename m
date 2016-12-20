Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 689D21FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 20:10:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934124AbcLTUKE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 15:10:04 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65173 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752856AbcLTUKD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 15:10:03 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BA3A5788C;
        Tue, 20 Dec 2016 15:10:01 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=vCz8sOADYO0r
        6qiX82dMhMmqxkI=; b=PCvIMwGvZKcWmlwVp24uN/eAD8/yLk1QE3VgwdMYT79k
        yB4KhvDVyKM/JWMq+KYsItUkumsyM4ynfvL2a89hdmqyJNjflq09paX6PHuZcOzY
        d0cRI7QFBAHuc/zrawH2aX5cg7xB0peQMIFSnizJii1ocmyjulnqxPdE4qbsVvc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iWkvN6
        sBATykbMZPu5MeHgCy2UXRR5iakMcPpRghtuWq2eoMYUZfCw9YXsOOYRskwG/8wU
        R4sfWN7QXxPJHgQRXXFwcilcwof9g3qUrU/1B7PGCD6bdrpkKehfcy7h7Y98uhyl
        EtibgLQiXT1xxne2gylxwfKPuloaHEVkYiudg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 998CA5788A;
        Tue, 20 Dec 2016 15:10:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DFEB657887;
        Tue, 20 Dec 2016 15:09:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, josharian@gmail.com
Subject: Re: [PATCH 2/2] config.c: handle lock file in error case in git_config_rename_...
References: <20161220094746.GA3917@ash>
        <20161220094836.4131-1-pclouds@gmail.com>
        <20161220094836.4131-2-pclouds@gmail.com>
Date:   Tue, 20 Dec 2016 12:09:58 -0800
In-Reply-To: <20161220094836.4131-2-pclouds@gmail.com> (=?utf-8?B?Ik5ndXk=?=
 =?utf-8?B?4buFbiBUaMOhaSBOZ+G7jWM=?=
        Duy"'s message of "Tue, 20 Dec 2016 16:48:36 +0700")
Message-ID: <xmqqfulijrah.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48ED49B8-C6F0-11E6-82B9-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> We could rely on atexit() to clean up everything, but let's be
> explicit when we can. And it's good anyway because the function is
> called the second time in the same process, we're in trouble.
>
> This function should not affect the successful case because after
> commit_lock_file() is called, rollback_lock_file() becomes no-op.

Not really.  At the point of the first "goto out" in this function,
lock is merely an uninitialized pointer.

>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---


>  config.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.c b/config.c
> index 505e0d0..e02def4 100644
> --- a/config.c
> +++ b/config.c
> @@ -2483,6 +2483,7 @@ int git_config_rename_section_in_file(const char =
*config_filename,
>  		ret =3D error_errno("could not write config file %s",
>  				  config_filename);
>  out:
> +	rollback_lock_file(lock);
>  	free(filename_buf);
>  	return ret;
>  }
