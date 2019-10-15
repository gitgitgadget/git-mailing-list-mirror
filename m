Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 535B41F4C0
	for <e@80x24.org>; Tue, 15 Oct 2019 02:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfJOCZq (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 22:25:46 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54370 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbfJOCZq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 22:25:46 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8ED2295BB0;
        Mon, 14 Oct 2019 22:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S/hE0kMK9lstD12zrLNomi3uJYw=; b=AYe/17
        6hffth4tu+VjCUOrucN6d8JpzxEesTWVHtGheJU2Cd15WYLmzMiTb0jGMyqeWsvH
        Xt7P6oRcL5qnlCTQe9vEAwExSiOizkvRll8i2WbPhmuSb4AugRLtU5MD3STgyYuy
        nGwoE4s9sQrKaZmOeEckMwXvI8qDkjY4Oj3DU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WcyYL+d5R3z1ac23/uolCbhhY/hDMfNl
        1p33JWe/GUcD9Cx0i97y5caDN6fkOGzur2JUYF6oUHPhfKFKjj/ISF6fXecBSFRy
        cNISJ9UfSFvCLdAHb7PlwGgFgkWJ4ocEdk38qlYE3wG6wyf2/gTvu846FhvGKGDR
        7L1HAIPqcsc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86D0B95BAF;
        Mon, 14 Oct 2019 22:25:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFC5B95BAC;
        Mon, 14 Oct 2019 22:25:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v5 3/3] format-patch: teach --cover-from-description option
References: <cover.1570821015.git.liu.denton@gmail.com>
        <cover.1571085952.git.liu.denton@gmail.com>
        <315c308950270968293c92c94fdadd3be3340c33.1571085952.git.liu.denton@gmail.com>
Date:   Tue, 15 Oct 2019 11:25:37 +0900
In-Reply-To: <315c308950270968293c92c94fdadd3be3340c33.1571085952.git.liu.denton@gmail.com>
        (Denton Liu's message of "Mon, 14 Oct 2019 13:47:04 -0700")
Message-ID: <xmqqa7a2d9su.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 14595830-EEF3-11E9-9ED2-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> diff --git a/builtin/log.c b/builtin/log.c
> index d212a8305d..af33fe9ffb 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -1057,6 +1072,44 @@ static void show_diffstat(struct rev_info *rev,
>  	fprintf(rev->diffopt.file, "\n");
>  }
>  
> +static void pp_from_desc(struct pretty_print_context *pp,
> +			 const char *branch_name,
> +			 struct strbuf *sb,
> +			 const char *encoding,
> +			 int need_8bit_cte)
> +{
> +	const char *subject = "*** SUBJECT HERE ***";
> +	const char *body = "*** BLURB HERE ***";
> +	struct strbuf description_sb = STRBUF_INIT;
> +	struct strbuf subject_sb = STRBUF_INIT;
> +
> +	if (cover_from_description_mode == COVER_FROM_NONE)
> +		goto do_pp;
> +
> +	if (branch_name && *branch_name)
> +		read_branch_desc(&description_sb, branch_name);
> +	if (!description_sb.len)
> +		goto do_pp;
> +
> +	if (cover_from_description_mode == COVER_FROM_SUBJECT ||
> +			cover_from_description_mode == COVER_FROM_AUTO)
> +		body = format_subject(&subject_sb, description_sb.buf, " ");
> +
> +	if (cover_from_description_mode == COVER_FROM_MESSAGE ||
> +			(cover_from_description_mode == COVER_FROM_AUTO &&
> +			 subject_sb.len > COVER_FROM_AUTO_MAX_SUBJECT_LEN))
> +		body = description_sb.buf;
> +	else
> +		subject = subject_sb.buf;
> +
> +do_pp:
> +	pp_title_line(pp, &subject, sb, encoding, need_8bit_cte);
> +	pp_remainder(pp, &body, sb, 0);
> +
> +	strbuf_release(&description_sb);
> +	strbuf_release(&subject_sb);
> +}
> +

This implementation is very clear and easy to follow, and ...

> @@ -1064,8 +1117,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  			      int quiet)
>  {
>  	const char *committer;
>  	struct shortlog log;
>  	struct strbuf sb = STRBUF_INIT;
>  	int i;
> @@ -1095,15 +1146,12 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
>  	if (!branch_name)
>  		branch_name = find_branch_name(rev);
>  
>  	pp.fmt = CMIT_FMT_EMAIL;
>  	pp.date_mode.type = DATE_RFC2822;
>  	pp.rev = rev;
>  	pp.print_email_subject = 1;
>  	pp_user_info(&pp, NULL, &sb, committer, encoding);
> +	pp_from_desc(&pp, branch_name, &sb, encoding, need_8bit_cte);
>  	fprintf(rev->diffopt.file, "%s\n", sb.buf);
>  
>  	strbuf_release(&sb);

... made the caller much simpler.

One large nit is that pp_user_info() is about "pretty printing the
user info", pp_title_line() is about "pretty printing the title
line", but pp_from_desc() is not about "pretty printing the from
desc".  Naming matters.

How about calling it with more emphasis on what it does (i.e. the
helper is about preparing the subject and body of the cover letter
e-mail) and less emphasis on how it does or what it bases its
decision on?  prepare_cover_text() or soemthing, perhaps?

Other than that, this version is very much more preferrable than the
previous one.  Quite nicely done.

Thanks.
