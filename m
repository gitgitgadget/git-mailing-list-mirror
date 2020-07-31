Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 795C7C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D5322B42
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 18:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jorzHgFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbgGaS2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:28:31 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53703 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387695AbgGaS2b (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 14:28:31 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1A4BDEDB03;
        Fri, 31 Jul 2020 14:28:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lGcqVaMOO0dvU4XveeebgxjRAuk=; b=jorzHg
        FAfyLbXaY5GM62pWNy/4GsRkxAnlDsg3IDHhKGeq8qRBynumCdJcGjhISi2j8FB4
        E0byoiqSUVsFTuvjGW4Mk7+uWYH+gTdzZ50KFp0z3FAxKDXKxhSpfcb7agOJpFnI
        YxmJKbYkcAnkpUxpdvs23sT2O7BaeVYbqF9bA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=O/374DmIry7L0G/6t3NHBsTNwkWssCWq
        Ya6Vkgp67qvYAj34CxTXYdcDh1CTydJVqDnR2mv0l8ZTSc7YknCoZ5xm98Hbq10X
        y+FaM6aCnnbEFoCKQU6RVLVUQrrzHMKjI61hDuTRr9rvMqK+mAbd2VHR1gG37PiY
        nWf0tixDzDI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 10F2FEDB01;
        Fri, 31 Jul 2020 14:28:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5A593EDB00;
        Fri, 31 Jul 2020 14:28:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alban Gruin <alban.gruin@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH v3 1/6] stash: mark `i_tree' in reset_tree() const
References: <20200630151558.20975-1-alban.gruin@gmail.com>
        <20200731165140.29197-1-alban.gruin@gmail.com>
        <20200731165140.29197-2-alban.gruin@gmail.com>
Date:   Fri, 31 Jul 2020 11:28:24 -0700
In-Reply-To: <20200731165140.29197-2-alban.gruin@gmail.com> (Alban Gruin's
        message of "Fri, 31 Jul 2020 18:51:35 +0200")
Message-ID: <xmqqtuxn35fb.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9FBF8DC0-D35B-11EA-A865-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alban Gruin <alban.gruin@gmail.com> writes:

> In reset_tree(), the value pointed by `i_tree' is not modified.  In a

This helper function is about "reset the working tree and the index
to match this given tree object" and it is clear that it is an
input-only parameter, so that alone is a good justification for code
hygiene.  Good.

> latter commit, it will be provided with `the_hash_algo->empty_tree',
> which is a constant.  Hence, this changes `i_tree' to be a constant.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/stash.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/stash.c b/builtin/stash.c
> index 0c52a3b849..9baa8b379e 100644
> --- a/builtin/stash.c
> +++ b/builtin/stash.c
> @@ -228,7 +228,7 @@ static int clear_stash(int argc, const char **argv, const char *prefix)
>  	return do_clear_stash();
>  }
>  
> -static int reset_tree(struct object_id *i_tree, int update, int reset)
> +static int reset_tree(const struct object_id *i_tree, int update, int reset)
>  {
>  	int nr_trees = 1;
>  	struct unpack_trees_options opts;
