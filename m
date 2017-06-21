Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A33320401
	for <e@80x24.org>; Wed, 21 Jun 2017 17:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751152AbdFUR6Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 13:58:25 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33363 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbdFUR6Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 13:58:24 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so32105930pfk.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 10:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=B+koMolvxiC0jqFFecyQuDafzKwatiruMEs+RFfzT6M=;
        b=Fdnu06WhUohl2g3YlY/3636bpiJMx1flHt/ytDu90Q/2m2eRLqTi73O2SVI2qJWQgu
         8o+X8TMm1f1nLB7H5BKBtYT/wVmVipD2m0KNOLF6qezFeU7uhowIudNO5ytYUhePZFs5
         KkD66At2rex2VLr5WW2Oa7soto3bjOzBrN6XzFZRx7AiGbgofSMR5bLf1CKlEGlqdmXS
         AWzMcH9gIkr9/S6CylAZPcd/k4iGwBLWaa3sGNR/XlfnybE2DOSXcnWyzscMlgL3ZM1b
         cpd/yrEMJR6SqGyap62hgGaO2ALg8zo91Fj6FLUBzJwpGlhITqjV4h1jK54plzHNtGOK
         B/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=B+koMolvxiC0jqFFecyQuDafzKwatiruMEs+RFfzT6M=;
        b=qYEZfseaUqSbYapSPpjp4bjLFJcT1TTDDt2IOY0kjx8txkViD9A8W4bvZfInPE+lpE
         MDmTtwDhwhvD/w6hOow62e0U2YmGjUndtha19h8wdaF8He8Od+9b35u/WJmL9DnoLn6D
         XqSyni0D4m5IRyssppL54iWUIX5JEvYg1do1dlSO18r574ek4aG/xoQ8aqMOKTGKnaXd
         Vp1Gs07BcYwSi1JqNDkWHtQZmLEK76qLXIpSEzpTN/SuTqDKgzoBgcJUw1fRPn+BCXWn
         SNFjvrLeC+x6v4HgLatjXT5yEr+U0iZNkqrAv8czzeA3lfsqlCn34ecxqUZ+E/vqoVC0
         mwfQ==
X-Gm-Message-State: AKS2vOxiCsHxa8nlc2wigFl/msL0aH4GK+rX4w0wRmZMYGZZCbUQ1rJn
        rVAHG0ysmElwrA==
X-Received: by 10.84.174.1 with SMTP id q1mr42938518plb.8.1498067902264;
        Wed, 21 Jun 2017 10:58:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id s88sm35814707pfk.16.2017.06.21.10.58.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 10:58:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 5/8] sha1_file: refactor read_object
References: <cover.1497920092.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
        <73d085b6fad9316c5a500341db2dd6451700656e.1497920092.git.jonathantanmy@google.com>
Date:   Wed, 21 Jun 2017 10:58:20 -0700
In-Reply-To: <73d085b6fad9316c5a500341db2dd6451700656e.1497920092.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 19 Jun 2017 18:03:12 -0700")
Message-ID: <xmqqefudql37.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> @@ -2914,6 +2912,7 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  	git_zstream stream;
>  	char hdr[32];
>  	struct strbuf hdrbuf = STRBUF_INIT;
> +	unsigned long size_scratch;
>  
>  	if (oi->delta_base_sha1)
>  		hashclr(oi->delta_base_sha1);
> @@ -2939,6 +2938,10 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  	map = map_sha1_file(sha1, &mapsize);
>  	if (!map)
>  		return -1;
> +
> +	if (!oi->sizep)
> +		oi->sizep = &size_scratch;
> +
>  	if (oi->disk_sizep)
>  		*oi->disk_sizep = mapsize;
>  	if ((flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE)) {
>  	if (status && oi->typep)
>  		*oi->typep = status;
> +	if (oi->sizep == &size_scratch)
> +		oi->sizep = NULL;

This looked somewhat unusual but nevertheless is correct.  Because
of the way parse_sha1_header_extended() interacts with its callers,
the usual fn(oi->sizep ? oi->sizep : &dummy) pattern does not apply
to this codepath.

> @@ -3077,28 +3090,15 @@ int pretend_sha1_file(void *buf, unsigned long len, enum object_type type,
>  static void *read_object(const unsigned char *sha1, enum object_type *type,
>  			 unsigned long *size)
>  {
> -	unsigned long mapsize;
> -	void *map, *buf;
> -	struct cached_object *co;
> -
> -	co = find_cached_object(sha1);
> -	if (co) {
> -		*type = co->type;
> -		*size = co->size;
> -		return xmemdupz(co->buf, co->size);
> -	}
> +	struct object_info oi = OBJECT_INFO_INIT;
> +	void *content;
> +	oi.typep = type;
> +	oi.sizep = size;
> +	oi.contentp = &content;
>  
> -	buf = read_packed_sha1(sha1, type, size);
> -	if (buf)
> -		return buf;
> -	map = map_sha1_file(sha1, &mapsize);
> -	if (map) {
> -		buf = unpack_sha1_file(map, mapsize, type, size, sha1);
> -		munmap(map, mapsize);
> -		return buf;
> -	}
> -	reprepare_packed_git();
> -	return read_packed_sha1(sha1, type, size);
> +	if (sha1_object_info_extended(sha1, &oi, 0))
> +		return NULL;
> +	return content;
>  }

Nice code reduction; it is somewhat funny to think that a function
meant to gather 'object info' does so much, but we can always say
the contents is part of the information about the object ;-).

Same comment as the other one applies here; the definition of how an
error is reported by sha1_object_info_extended() should be kept
consistent with existing callers.

Thanks.

