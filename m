Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DE2CD6115
	for <git@archiver.kernel.org>; Mon,  9 Oct 2023 17:37:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377427AbjJIRhz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Oct 2023 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjJIRhx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Oct 2023 13:37:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7CF91
        for <git@vger.kernel.org>; Mon,  9 Oct 2023 10:37:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-27758c8f579so2783026a91.0
        for <git@vger.kernel.org>; Mon, 09 Oct 2023 10:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696873071; x=1697477871; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WV4EtaWkQNn79AiqxoCxl7bJDEMulSgyJcDPL+p9+N4=;
        b=sFMdirBXDGUWfCwPe2QoAQ0C9E3jvX0D1qzsl5pu9tO6DMYtFzbP6uYtQaAZ+vgWOZ
         xF8i666USC+Ku14dpciWXqCszQA5xGK3qpGzsZoZL5z14xjWw3bfTPZbB0ISwhO2+H+0
         x76tUuoDwtYz+FrrOMeLUocdtXQ/tx1bn/I9oOZ+7Rd/CkDkFY+nmQFVhtoJo2YtIRT1
         yA478+EeWAhS+lu7jk7PGpU1XAbhKtHfZj1OqPHdOQw3gHWyHaMsCvgASVROl7gviSo3
         wQKs/YYXQwJfdtKll2e6BpwLqH94EBxVraFYN4VcTpq19cIoyoZRY5djYVl4rcKVSf2Y
         2jvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696873071; x=1697477871;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WV4EtaWkQNn79AiqxoCxl7bJDEMulSgyJcDPL+p9+N4=;
        b=qXWcNbyPBQ/iAuFut6EpWCtr8Kht7+vt9O3WfLsg8/kbdzB4f5YD7MhxBwvBcNB16v
         ZOaLONqJK0PDEN5tLi2myeMyWq6ZyPNIhXaQHmlP3o+2hLWzdiG66Bg8XaCu9hkhd26d
         ojeVYrrXmeBsp/aAtewsHiDeJUcfNSFdO04EazUJXMYwNc0zlyi/gY9MgMog3+8HCzAg
         6wdkQ74Qas/8deUYVtlnbVGHlv77cUpKdXU4u1/TzimTN2kP9qvIUHfWIxEPkMMrc2oY
         5umHxYRbnWNrq/6S6RWzkLrONyUr5eXuC5C/0W6bJM6cJ2lTiU0nkamGk50I0JE/60SO
         C8mQ==
X-Gm-Message-State: AOJu0Yxn6iQJAtFn439sM18lESYFaFbM5JXGJL8bsxdbnpTB6LUjvutB
        UKbm0pqfAJVtcnX0uEPxXLvy4g==
X-Google-Smtp-Source: AGHT+IHBYdCaaGiWKKmNmp8mHztjcE0VrtSD/iSfxsPAw4F/bb2cwirty7IRMGzaG5CnuRllzYCePA==
X-Received: by 2002:a17:90b:1c0b:b0:268:3f6d:9751 with SMTP id oc11-20020a17090b1c0b00b002683f6d9751mr14087988pjb.23.1696873071233;
        Mon, 09 Oct 2023 10:37:51 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:bbb3:af9c:b456:cb2a])
        by smtp.gmail.com with ESMTPSA id 14-20020a17090a19ce00b00277371fd346sm11466314pjj.30.2023.10.09.10.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 10:37:49 -0700 (PDT)
Date:   Mon, 9 Oct 2023 10:37:43 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     phillip.wood123@gmail.com, git@vger.kernel.org, linusa@google.com,
        calvinwan@google.com, rsbecker@nexbridge.com
Subject: Re: [PATCH v7 2/3] unit tests: add TAP unit test framework
Message-ID: <ZSQ6ZwoZDYtS5hmz@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, phillip.wood123@gmail.com,
        git@vger.kernel.org, linusa@google.com, calvinwan@google.com,
        rsbecker@nexbridge.com
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
 <cover.1692297001.git.steadmon@google.com>
 <3cc98d4045eeda6e8cc24914802edc16d367fba0.1692297001.git.steadmon@google.com>
 <xmqq350hw6n7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq350hw6n7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.08.17 17:12, Junio C Hamano wrote:
> 
> What I am going to utter from here on are not complaints but purely
> meant as questions.  
> 
> Would the resulting output and maintainability of the tests change
> (improve, or worsen) if we introduce
> 
> 	static void assert_empty_strbuf(struct strbuf *buf)
> 	{
> 		check_uint(buf->len, ==, 0);
>                 check_uint(buf->alloc, ==, 0);
> 		check(buf.buf == strbuf_slopbuf);
> 		check_char(buf.buf[0], ==, '\0');
> 	}
> 
> and call it from the setup() function to ensure that
> strbuf_release(&buf) it calls after running customer test f() brings
> the buffer in a reasonably initialized state?  The t_static_init()
> test should be able to say
> 
> 	static void t_static_init(void)
> 	{
> 		struct strbuf buf = STRBUF_INIT;
> 		assert_empty_strbuf(&buf);
> 	}
> 
> if we did so, but is that a good thing or a bad thing (e.g. it may
> make it harder to figure out where the real error came from, because
> of the "line number" thing will not easily capture the caller of the
> caller, perhaps)?  

I am unsure whether or not this is an improvement. While it would
certainly help readability and reduce duplication if this were
production code, in test code it can often be more valuable to be
verbose and explicit, so that individual broken test cases can be
quickly understood without having to do a lot of cross referencing.

I'll hold off on adding any more utility functions in t-strbuf for V8,
but if you or other folks feel strongly about it we can address it in
V9.


> > +	check_char(buf.buf[0], ==, '\0');
> > +}
> 
> > +static void t_dynamic_init(void)
> > +{
> > +	struct strbuf buf;
> > +
> > +	strbuf_init(&buf, 1024);
> > +	check_uint(buf.len, ==, 0);
> > +	check_uint(buf.alloc, >=, 1024);
> > +	check_char(buf.buf[0], ==, '\0');
> 
> Is it sensible to check buf.buf is not slopbuf at this point, or
> does it make the test TOO intimate with the current implementation
> detail?

Yes, I think this is too much of an internal detail. None of the users
of strbuf ever reference it directly. Presumably for library-ish code,
we should stick to testing just the user-observable parts, not the
implementation.


> > +	check_char(buf->buf[0], ==, ch);
> > +	check_char(buf->buf[1], ==, '\0');
> > +}
> 
> In any case, this t_addch() REQUIRES that incoming buf is empty,
> doesn't it?  I do not think it is sensible.  I would have expected
> that it would be more like
> 
> 	t_addch(struct strbuf *buf, void *data)
> 	{
> 		char ch = *(char *)data;
> 		size_t orig_alloc = buf->alloc;
> 		size_t orig_len = buf->len;
> 
> 		if (!assert_sane_strbuf(buf))
> 			return;
>                 strbuf_addch(buf, ch);
> 		if (!assert_sane_strbuf(buf))
> 			return;
> 		check_uint(buf->len, ==, orig_len + 1);
> 		check_uint(buf->alloc, >=, orig_alloc);
>                 check_char(buf->buf[buf->len - 1], ==, ch);
>                 check_char(buf->buf[buf->len], ==, '\0');
> 	}
> 
> to ensure that we can add a ch to a strbuf with any existing
> contents and get a one-byte longer contents than before, with the
> last byte of the buffer becoming 'ch' and still NUL terminated.
> 
> And we protect ourselves with a helper that checks if the given
> strbuf looks *sane*.

Yeah, in general I think this is a good improvement, but again I'm not
sure if it's worth adding additional helpers. I'll try to rework this a
bit in V8.


> 	static int assert_sane_strbuf(struct strbuf *buf)
> 	{
>         	/* can use slopbuf only when the length is 0 */
> 		if (buf->buf == strbuf_slopbuf)
>                 	return (buf->len == 0);
> 		/* everybody else must have non-NULL buffer */
> 		if (buf->buf == NULL)
> 			return 0;
>                 /* 
> 		 * alloc must be at least 1 byte larger than len
> 		 * for the terminating NUL at the end.
> 		 */
> 		return ((buf->len + 1 <= buf->alloc) &&
> 		    	(buf->buf[buf->len] == '\0'));
> 	}
> 
> You can obviously use your check_foo() for the individual checks
> done in this function to get a more detailed diagnosis, but because
> I have confused myself enough by thinking about their polarity, I
> wrote this in barebones comparison instead.
> 
