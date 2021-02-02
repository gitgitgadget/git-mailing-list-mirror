Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555DBC433E0
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1507B64F68
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 21:47:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233556AbhBBVrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 16:47:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59035 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233212AbhBBVrH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 16:47:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C6BD095FAF;
        Tue,  2 Feb 2021 16:46:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=lGDYrvd8pLniqguRyKpdg/D19cU=; b=X5/zPy
        sX59Ui5gdwjmhLGOuEEovk7WWA4IrPyYXt94Nsexf0psYNaqxLllCt/Th3tTpBi3
        en8KY+jB0NdO7kv8M+GlpbuQxj9yX8f7+o4tEE2HmV6jprMKJtDJULxWiUYFbP0P
        TTYtlBozI02GcW1futZFcAsMIAlbWjD/VksRU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AMyk63KG4SQpKFqEFomxk6svVnJOlYlc
        eqjQLIx1dBvzPgXwF7ohhFTl38yXpzaOTM//QU1cKvnkzXg7lvASWi537Hlo45GM
        kmxEp6iwin7SV8D3vfr+7xoK4NGt+N9vRDyzkoCxst/qS5VjAayu/eZhw3uh9Pvn
        WsXW2tBOxMU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE0E695FAE;
        Tue,  2 Feb 2021 16:46:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4734495FAD;
        Tue,  2 Feb 2021 16:46:24 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 7/9] stash: declare ref_stash as an array
In-Reply-To: <b5f22de3fc320d23ba2c5342776b56770266ca5f.1612258145.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 2 Feb 2021 01:33:24 -0800")
References: <cover.1612258145.git.liu.denton@gmail.com>
        <b5f22de3fc320d23ba2c5342776b56770266ca5f.1612258145.git.liu.denton@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
Date:   Tue, 02 Feb 2021 13:46:23 -0800
Message-ID: <xmqqa6smf8i8.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 18614896-65A0-11EB-BF40-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Save sizeof(const char *) bytes by declaring ref_stash as an array
> instead of having a redundant pointer to an array.

One important prerequisite for this rewrite to work is that nobody
in the code repoints ref_stash pointer to point at a different
string, which has been the case for the past number of years and
will continue to be so.

Looks good.

> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  builtin/stash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 9bc85f91cd..6f2b58f6ab 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -87,7 +87,7 @@ static const char * const git_stash_save_usage[] = {
>  	NULL
>  };
>  
> -static const char *ref_stash = "refs/stash";
> +static const char ref_stash[] = "refs/stash";
>  static struct strbuf stash_index_path = STRBUF_INIT;
>  
>  /*
