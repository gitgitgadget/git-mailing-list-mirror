Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1782CC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4EFF61425
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 13:27:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbhGBNa0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 09:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbhGBNa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 09:30:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD7C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 06:27:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l24so16104387ejq.11
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 06:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ry31w3laCU8sTyyp9PPiPbzh6nYfFNQRMD+HlcQ8FQE=;
        b=poNz5yS1gfjnJjM5qmSKX3E67yq4fS8hjZANXvwmiNafUaSZNQOify1jH27tgobHrj
         gZD8If4yHG4KmRhudcuz8S7purzXVD8YCPD3+FhnmULikxmtINq92yR7qDuMF76saVzk
         l9Q3OEmZ0Ei6gUmK/Fr96aAE6+YFeYx5dwT3Skb/A78yIeXIiYl2rdVn5os7BzxLXK/x
         5x61QHtuuB0kR919Rj95OHa0EvlPYX4+wEzv7MKu9ssQsgs2V5Uai5BYkrpg/zMCz40o
         RJwlGq84ihtJDVE8GoJ0HT0MmG5J4KrpTltn2QNKSErLHnOyOWYjho8sgVIAYX6mvnjP
         BShg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ry31w3laCU8sTyyp9PPiPbzh6nYfFNQRMD+HlcQ8FQE=;
        b=LwMnlrQ1RbEBK7Jn1Y18fdOjQRdnXoeg8ieAZiLwyr5YAWfI7mNYFmvPDBiOifir28
         lEcv5A95TcVnLJ5KAlCk7OmnXM/wUt7/kwksiztFDs8Z5IPwAVXnl8m5ZWE2pT6qIxKV
         0hqgs7w1dVpaVbDwD1w6oJfW09GSLZ6BCUNa9vYZVcnrW9NAFW48cuMVZvZeijeENcHd
         wK8c7/0uyT4nW8Aj5z5DkB99MJ3qDC+ig7R1dDmawNIt7A7YH4ybkR0KsvT7U38dn2qf
         L2VjnSwvrvDj4Mm47Lq4SRVxCpbZvhoKHb13+2O7oNC0/0d/BGIHiss72o7fE/rbEGsD
         SyJw==
X-Gm-Message-State: AOAM532717wtFvceKsS2i8uL3ug6qZTsl39VENCT3Y6yuZaiOs6N5xC3
        J7DubaV1vzWbFp0heVnDJiGRdyl0DT1K3Q==
X-Google-Smtp-Source: ABdhPJzQb23RsVxeK73ZFwl+LE33w995ot2hfnBxPUklMhEwmUgQbN84UtUUI8FD07HGL0m1nxHOpw==
X-Received: by 2002:a17:906:7946:: with SMTP id l6mr5221902ejo.230.1625232471241;
        Fri, 02 Jul 2021 06:27:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id og26sm1082964ejc.52.2021.07.02.06.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:27:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 02/15] [GSOC] ref-filter: add %(raw) atom
Date:   Fri, 02 Jul 2021 15:22:29 +0200
References: <pull.989.git.1625155693.gitgitgadget@gmail.com>
 <ad71510feda0a100920a99de41db0ab137787796.1625155693.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <ad71510feda0a100920a99de41db0ab137787796.1625155693.git.gitgitgadget@gmail.com>
Message-ID: <87im1salrd.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 01 2021, ZheNing Hu via GitGitGadget wrote:

> @@ -1362,17 +1398,29 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct exp
>  	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
>  	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
>  	void *buf = data->content;
> +	unsigned long buf_size = data->size;

Let's declare this.

>  	for (i = 0; i < used_atom_cnt; i++) {
>  		struct used_atom *atom = &used_atom[i];
>  		const char *name = atom->name;
>  		struct atom_value *v = &val[i];
> +		enum atom_type atom_type = atom->atom_type;
>  
>  		if (!!deref != (*name == '*'))
>  			continue;
>  		if (deref)
>  			name++;
>  
> +		if (atom_type == ATOM_RAW) {

Here, where it's going to be used.

> +static int memcasecmp(const void *vs1, const void *vs2, size_t n)
> +{
> +	const char *s1 = vs1, *s2 = vs2;
> +	const char *end = s1 + n;
> +
> +	for (; s1 < end; s1++, s2++) {
> +		int diff = tolower(*s1) - tolower(*s2);
> +		if (diff)
> +			return diff;
> +	}
> +	return 0;
> +}

I thought we had such a thing already, but clearly not...

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 9e0214076b4..18554f62d94 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -130,6 +130,8 @@ test_atom head parent:short=10 ''
>  test_atom head numparent 0
>  test_atom head object ''
>  test_atom head type ''
> +test_atom head raw "$(git cat-file commit refs/heads/main)
> +"

Extra stay line here, is the \n intentional?
