Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C9C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81A4D206B7
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 21:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l7klSf20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgFNVfM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 17:35:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58079 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNVfM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 17:35:12 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEEFD61372;
        Sun, 14 Jun 2020 17:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VKJz6XtUZByJTRBsdvdnq3dejSs=; b=l7klSf
        20hvCpa1MSs5VPHaa8OdgN3t9JIg3vPDr7sPMFsGHuFfIe1ue0qCh9D5twjynDer
        riZUyjszcIrq3sFtzwUBGCSoivy/lBReyIY8vTdEZHf0H/jJA1YiaG9jBj5gosqH
        PBHX7UIQZtQIIah57JXR+xfNsHR6mvSW9N5Ds=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oM4CsNCnk/kR1GV+YVO529w5hrF8r+KU
        F0YULZYFLH92p10nA9vxhM0+m14CO8rj7LLAK1ZByj6rnjKyvQcwNTJrhNZ+6Ab5
        6jtyrOg1D5w98WkOIGqDfVyBq6nF2EszAiw/DEvRdHhWllgE5KsfuMTCFbqDsdVq
        SwMNDab0A7U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9047A6136B;
        Sun, 14 Jun 2020 17:35:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6BB36136A;
        Sun, 14 Jun 2020 17:35:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v2] pkt-line: use string versions of functions
References: <20200614083131.GD3405@danh.dev>
        <da9ba5fb2d0fb9481f81ce525cbabaedd722858d.1592125442.git.liu.denton@gmail.com>
Date:   Sun, 14 Jun 2020 14:35:06 -0700
In-Reply-To: <da9ba5fb2d0fb9481f81ce525cbabaedd722858d.1592125442.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sun, 14 Jun 2020 05:07:54 -0400")
Message-ID: <xmqqeeqhxred.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA425FC0-AE86-11EA-B65C-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> +#define control_packet_write(fd, s, errstr) \
> +	do { \
> +		(void)s"is a string constant"; \
> +		packet_trace_str((s), 1); \
> +		if (write_str_in_full((fd), (s)) < 0) \
> +			die_errno((errstr)); \
> +	} while (0)
> +

Oh, that's much better.  If you go this route, drop your use of
write_str_in_full(), but count the length of s with strlen() here
to give the chance to the compilers to count the constant strings
at compile time.

>  /*
>   * If we buffered things up above (we don't, but we should),
>   * we'd flush it here
>   */
>  void packet_flush(int fd)
>  {
> -	packet_trace("0000", 4, 1);
> -	if (write_in_full(fd, "0000", 4) < 0)
> -		die_errno(_("unable to write flush packet"));
> +	control_packet_write(fd, "0000", _("unable to write flush packet"));

> +#define control_packet_buf_write(buf, s) \
> +	do { \
> +		(void)s"is a string constant"; \
> +		packet_trace_str((s), 1); \
> +		strbuf_addstr((buf), (s)); \
> +	} while (0)
> +

Likewise for strbuf_addstr().

>  void packet_buf_flush(struct strbuf *buf)
>  {
> -	packet_trace("0000", 4, 1);
> -	strbuf_add(buf, "0000", 4);
> +	control_packet_buf_write(buf, "0000");
>  }
