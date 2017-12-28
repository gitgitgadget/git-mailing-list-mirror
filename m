Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 231631F406
	for <e@80x24.org>; Thu, 28 Dec 2017 19:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753976AbdL1TFf (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 14:05:35 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56413 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751074AbdL1TFe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 14:05:34 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AAC21C4AFF;
        Thu, 28 Dec 2017 14:05:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=mEdnQJ4YIGie
        9LeMRWe+20JVe3M=; b=If9tcq3pUf6/S9Ptf/XfpkjWADcfugDjWSW/DCGqOVL4
        4yrStGAZBWADpExF3/FsdncJ2KLxFGQgYyFHqmtKZs6FbeO/npib5bpn+vYorLpS
        pNK797ahXkcz/PGkXG++8ke8GGbJoheQaaidAuBIrCXc3DqV/x9eS2d3ke0rau8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=CUmZZD
        4PfxQjVr0jPemDk8z5+t6aJeGZ7k2TW2yXFmfRGkH11OPkbeB+ygzH56zB9XgFmo
        FO71mhFoiqMQUiYPt4ZAYtNAk09ZYPjfiovpHO4ZA25ibTQ5zl3aoq9jBhVahQ24
        qmi10naCxGM9eoqX5yHAU+4xCFNIiTiI4uawo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A42FCC4AFE;
        Thu, 28 Dec 2017 14:05:33 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1ACBFC4AFD;
        Thu, 28 Dec 2017 14:05:33 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] dir.c: avoid stat() in valid_cached_dir()
References: <20171228002807.22388-1-pclouds@gmail.com>
Date:   Thu, 28 Dec 2017 11:05:32 -0800
In-Reply-To: <20171228002807.22388-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 28 Dec 2017 07:28:07 +0700")
Message-ID: <xmqqd12yllkz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1435E3C8-EC02-11E7-80DE-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> stat() may follow a symlink and return stat data of the link's target
> instead of the link itself. We are concerned about the link itself.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
.com>
> ---
>  I noticed this while looking at the untracked cache bug [1] but
>  because it's not directly related to that bug, I'm submitting it
>  separately here.

Thanks; it totally makes sense.

>
>  [1] https://public-inbox.org/git/CACsJy8AmbKSp0mDLRaDCWn45veeNc03B-Gq8=
r8PQPrDt9bM_EA@mail.gmail.com/
>
>  dir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/dir.c b/dir.c
> index 7c4b45e30e..edcb7bb462 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -1809,7 +1809,7 @@ static int valid_cached_dir(struct dir_struct *di=
r,
>  	 */
>  	refresh_fsmonitor(istate);
>  	if (!(dir->untracked->use_fsmonitor && untracked->valid)) {
> -		if (stat(path->len ? path->buf : ".", &st)) {
> +		if (lstat(path->len ? path->buf : ".", &st)) {
>  			invalidate_directory(dir->untracked, untracked);
>  			memset(&untracked->stat_data, 0, sizeof(untracked->stat_data));
>  			return 0;
