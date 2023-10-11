Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DDECDB475
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 18:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346995AbjJKSb5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 14:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjJKSb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 14:31:56 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4A993
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:31:52 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id 6a1803df08f44-664bd97692dso913426d6.0
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 11:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1697049111; x=1697653911; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1hZcdgxA/yYXzZyOcjMic9gsBNLIC9MyPYtwj2AhGkk=;
        b=RajCy5cvOT+FRA909gwv3jdGK6+L5N6CusuYk6QzWzHnGkj+1h82rvN12bnbkThiH9
         r28DYH+EP8heKcMWCga1TagR7OBuJEfFxFE/nJLc890CVY7nkjdcns2UcmWUfVePJRYL
         +AaV24YzpNFmFHRTE36hbRvSxWmbNQHf6/+r8c0jw9cdMf5EuPnLwXBZpBOFoMN8e7Oq
         5sCm8cI+5PtOJu8OXmWdtjHIYpme8WbUBTifevNKoVueZG+SFUL0JFYM9Xg2IWObOZC5
         JHmM+Ea/1AqjDqMF1DUgZD2M0fL5sPJuXElD62qBwDZc0PZext4rXlTmTo/fXN9KjdwL
         vKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697049111; x=1697653911;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hZcdgxA/yYXzZyOcjMic9gsBNLIC9MyPYtwj2AhGkk=;
        b=Ne7MlXJ/qDTAkscPgXHF17KJ67l7wxFC/sqbcxu4g2LNJ6UmkJtWAYT1c/s00QkSVB
         emewJIkk8H95gJi8h9kOKk7wYq6gN5Jt36MYxlaEebGN/WkeqDz1XoJXsoJLvzM9dnEb
         psMSxSuA15w0PKGMY7lWWlPNmreZc2eMG7x2zIi5WP3ZU9e7bUNw/z9I+VQL3hJHWx6E
         +dIc30WYL00G1NRbgSJqCCvHKfVjmfJs5HfaCwsxbNiXm914omH9gtxF+3cznjwkIeJO
         QiYkYqy9p1OS9Q1BnqX/EKfrVioZ3C8zS9QHlPN6NQJnd0IpfcmnaWFMMydgH1V2h0kP
         aXsA==
X-Gm-Message-State: AOJu0YyHvo3uM2/ZsAa2Rcn8h/ZsfM4tB0sCcTlSY5/yiLW8OEWliJ/q
        LRzIbHyQdpzbDkbKp7ITYKG74iUsoplaSzLbgDUnqQ==
X-Google-Smtp-Source: AGHT+IHjWwWJiIVYVOj/R9p5n99z3sSQwPeD9Pp+j1eUVlrkLoL8O07Qv7j7+rOYwYepcF39QyT2YQ==
X-Received: by 2002:a0c:cb0b:0:b0:66a:f5ef:d7e7 with SMTP id o11-20020a0ccb0b000000b0066af5efd7e7mr15550955qvk.27.1697049111229;
        Wed, 11 Oct 2023 11:31:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a21-20020a0ca995000000b006582f94af3asm5964168qvb.44.2023.10.11.11.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 11:31:50 -0700 (PDT)
Date:   Wed, 11 Oct 2023 14:31:49 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 09/20] midx: check size of object offset chunk
Message-ID: <ZSbqFcoxUJUqC6qz@nand.local>
References: <20231009205544.GA3281950@coredump.intra.peff.net>
 <20231009210527.GI3282181@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231009210527.GI3282181@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 09, 2023 at 05:05:27PM -0400, Jeff King wrote:
> @@ -88,6 +88,19 @@ static int midx_read_oid_lookup(const unsigned char *chunk_start,
>  	return 0;
>  }
>
> +static int midx_read_object_offsets(const unsigned char *chunk_start,
> +				    size_t chunk_size, void *data)
> +{
> +	struct multi_pack_index *m = data;
> +	m->chunk_object_offsets = chunk_start;
> +
> +	if (chunk_size != st_mult(m->num_objects, MIDX_CHUNK_OFFSET_WIDTH)) {
> +		error(_("multi-pack-index object offset chunk is the wrong size"));
> +		return 1;
> +	}
> +	return 0;
> +}

Makes sense, and the (elided) test below looks good, too. I think that
this is another case that would benefit from having the chunk-format API
take in an "expected size" and validate that the requested chunk is
actually that size before assigning its address to some pointer.

Thanks,
Taylor
