Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FE5C433E4
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39614204EC
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 19:29:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GrZ27Mw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732252AbgHQT31 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:29:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50387 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729978AbgHQT3X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 15:29:23 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6A57184F16;
        Mon, 17 Aug 2020 15:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GEJSwVNnZD3U/l/V8FEdUJD9yB8=; b=GrZ27M
        w9cUXZuXmHmbEGIkZk7U5W2v7H54Hzoj9REqsAziHirGNKaDIlWjnlp1aPGbJRYx
        RXUuDgDd0IUI6wsuKG2UUH8acXXleyRdT/jd7vosBCoEv6KYaSD/8vN1ziK04bL8
        0uvd9IMXNqt/v5lbKZ4ccz/6Yidq/bXAyCGVc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JAbqfOuXA/7KrTRH1Bq7gHfcP63AfNlq
        +7vgbMI+kW7eYKOU/M76p+Swu8InBolSFNu6sggDSh2qpDOb3vkZMFfSMEc3x49M
        yp1q/BgsDdDX7+dQKWgbXZZfddOWppgbQZLkmNo6Mzy7vcyxu/mHcOd2ufexsgHw
        UDM8pliaKYY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 627BD84F15;
        Mon, 17 Aug 2020 15:29:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.190.152.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E12A584F14;
        Mon, 17 Aug 2020 15:29:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3 7/9] pretty: refactor `format_sanitized_subject()`
References: <pull.684.v2.git.1596664305.gitgitgadget@gmail.com>
        <pull.684.v3.git.1597687822.gitgitgadget@gmail.com>
        <0ad22c7cdd3c692aa5b46444e64a3b76f1e87b4c.1597687822.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 12:29:20 -0700
In-Reply-To: <0ad22c7cdd3c692aa5b46444e64a3b76f1e87b4c.1597687822.git.gitgitgadget@gmail.com>
        (Hariom Verma via GitGitGadget's message of "Mon, 17 Aug 2020 18:10:20
        +0000")
Message-ID: <xmqqpn7p1373.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F30DE7DA-E0BF-11EA-9D40-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -static void format_sanitized_subject(struct strbuf *sb, const char *msg)
> +static void format_sanitized_subject(struct strbuf *sb, const char *msg, size_t len)
>  {
> +	char *r = xmemdupz(msg, len);
>  	size_t trimlen;
>  	size_t start_len = sb->len;
>  	int space = 2;
> +	int i;
>  
> -	for (; *msg && *msg != '\n'; msg++) {
> -		if (istitlechar(*msg)) {
> +	for (i = 0; i < len; i++) {
> +		if (r[i] == '\n')
> +			r[i] = ' ';

Copying the whole string only for this one looks very wasteful.
Can't you do

	for (i = 0; i < len; i++) {
		char r = msg[i];
		if (isspace(r))
			r = ' ';
		if (istitlechar(r)) {
			...
	}

or something like that instead?  

> +		if (istitlechar(r[i])) {
>  			if (space == 1)
>  				strbuf_addch(sb, '-');
>  			space = 0;
> -			strbuf_addch(sb, *msg);
> -			if (*msg == '.')
> -				while (*(msg+1) == '.')
> -					msg++;
> +			strbuf_addch(sb, r[i]);
> +			if (r[i] == '.')
> +				while (r[i+1] == '.')
> +					i++;
>  		} else
>  			space |= 1;
>  	}
> +	free(r);

Also, because neither LF or SP is a titlechar(), wouldn't the "if
r[i] is LF, replace it with SP" a no-op wrt what will be in sb at
the end?


>  	case 'f':	/* sanitized subject */
> -		format_sanitized_subject(sb, msg + c->subject_off);
> +		eol = strchrnul(msg + c->subject_off, '\n');
> +		format_sanitized_subject(sb, msg + c->subject_off, eol - (msg + c->subject_off));

This original caller expected the helper to stop reading at the end
of the first line, but the updated helper needs to be told where to
stop, so we do so with some extra computation.  Makes sense.

