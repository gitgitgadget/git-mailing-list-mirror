Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7539BC433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 22:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50AE32068E
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 22:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n0YhbvOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgFNW2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 18:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgFNW2b (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 18:28:31 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0EBC05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 15:28:31 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v79so14027888qkb.10
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fFy06Ma3jvuGZwQdXV2MYtfaMw29pcx9XdgM53hu1TU=;
        b=n0YhbvOnQvqCoYC4AyxlsR9SMDkuyTBWjK9gV4cQm6O6XkfBguHwEi9bIh9xRVSTug
         /VPh4EXTK8u1FPMqAtBHjtZ2SvF5MIRhWVgAhwM516wurfuN1LT4dm+rDYpNL49rP5j0
         QxBlxHvQ1xLGpSs3Uty0/5Prw060koKZthG25+KJNU5J0fB8XQ7JIZhq/ZChjib+Sc9H
         mqDqI7BbmE01WHRMVFmnH+xZnSR0zbD9XxazBd0GviEqnOFqXhnBtr8ceG8/XAtVMTZg
         PofF7O0H9yIRwC3NVQwn/5l6Fj+1abvUBXGBXdYBPgXAxM4RXDlNOxvGRksRRIl11eAo
         pxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fFy06Ma3jvuGZwQdXV2MYtfaMw29pcx9XdgM53hu1TU=;
        b=s4WPRKDkiO3UlwJlLJUYavcmewxn+wIsbxjHySf4Yic7nd+s5wShSDrs14MYkWY7xH
         +vD26NzqJPAeT/KQJDNH6HXRIJNhqqL+q56A2mLHxZPgnUqkt88mnOfLWoPRchxkpRlt
         QPqu3kIwvzW3AmsfMWSwzki2fxOc+z8GZz+sHhgyeqsZowX0t0EfY0xun5+5JDSLh8pC
         /7Xj26KiBTFFKmYQOBSRFqox2DZM6xLH/E2O6dFWNIy/l9LQFkDYG5KQFUdcULwwV2Z7
         5jMtjGYOojtXhnZ6bm0r8wzaUE4KL26pvhGHUVYi3wi2ZbBN6J/VnlhAWdzPNFE3Ga6E
         UcIw==
X-Gm-Message-State: AOAM533+pGeMc9FgEUdfBQI2NrpGBnQEsnrOZ6/uTMuQyVsQvixgjRxh
        fHgeH03Jg3AK6dYA6VNYNUw=
X-Google-Smtp-Source: ABdhPJzcsZ8R5BdeNfZgdw3tzbBjmkwQPgFxtsQ/qxrvMRT3v+d6+kvDmP3uQr+HAWuKcHABQpKQeA==
X-Received: by 2002:a37:a292:: with SMTP id l140mr12594449qke.171.1592173710570;
        Sun, 14 Jun 2020 15:28:30 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d193sm9924773qke.124.2020.06.14.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 15:28:29 -0700 (PDT)
Date:   Sun, 14 Jun 2020 18:28:28 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v2] pkt-line: use string versions of functions
Message-ID: <20200614222828.GA4846@generichostname>
References: <20200614083131.GD3405@danh.dev>
 <da9ba5fb2d0fb9481f81ce525cbabaedd722858d.1592125442.git.liu.denton@gmail.com>
 <xmqqeeqhxred.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeeqhxred.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 14, 2020 at 02:35:06PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > +#define control_packet_write(fd, s, errstr) \
> > +	do { \
> > +		(void)s"is a string constant"; \
> > +		packet_trace_str((s), 1); \
> > +		if (write_str_in_full((fd), (s)) < 0) \
> > +			die_errno((errstr)); \
> > +	} while (0)
> > +
> 
> Oh, that's much better.  If you go this route, drop your use of
> write_str_in_full(), but count the length of s with strlen() here
> to give the chance to the compilers to count the constant strings
> at compile time.
> 
> >  /*
> >   * If we buffered things up above (we don't, but we should),
> >   * we'd flush it here
> >   */
> >  void packet_flush(int fd)
> >  {
> > -	packet_trace("0000", 4, 1);
> > -	if (write_in_full(fd, "0000", 4) < 0)
> > -		die_errno(_("unable to write flush packet"));
> > +	control_packet_write(fd, "0000", _("unable to write flush packet"));
> 
> > +#define control_packet_buf_write(buf, s) \
> > +	do { \
> > +		(void)s"is a string constant"; \
> > +		packet_trace_str((s), 1); \
> > +		strbuf_addstr((buf), (s)); \
> > +	} while (0)
> > +
> 
> Likewise for strbuf_addstr().
> 
> >  void packet_buf_flush(struct strbuf *buf)
> >  {
> > -	packet_trace("0000", 4, 1);
> > -	strbuf_add(buf, "0000", 4);
> > +	control_packet_buf_write(buf, "0000");
> >  }

Checking the code, it seems like write_str_in_full() and strbuf_addstr()
are both inline defined. I was under the impression that the compiler
will optimise out these strlen()s to be compile-time constants. In fact,
strbuf_addstr() has this comment

	NOTE: This function will *always* be implemented as an inline or a macro
	using strlen, meaning that this is efficient to write things like:

so if my assumption isn't true, I suspect that we'd need to change the
comment.
