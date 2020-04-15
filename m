Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A58CBC38A2B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:21:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F82D208E4
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 16:21:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="q3L+WvN2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1415571AbgDOQUq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 12:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1415556AbgDOQUj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 12:20:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA854C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 09:20:38 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d24so178173pll.8
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 09:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9JZsiP2wwb4yp7tXBbDl5TzSNqQZu4to9K8auSUXVY4=;
        b=q3L+WvN2N+xsEkkzUQdeT/Ajr1bSFUlu4lypRFvbr4MpI3JQ///f1rdiqaLo2BC6v0
         OceKRfVljEkxXVVtVIHHOwIeRI7H2xyq2APw4mcQAKu/Yw9ZmgOBoS5V8h7+kX1RxMLR
         InaQnr4epPTGQX+I+pldO1f2y5IyNihzjf8TjUwE0wBZB9J+ahAVcB57FQVg2eEmNRkC
         SSGV+RdHN9Ux7O22FVq1Pyd9SNAPgiQn10auq3tHWRk0I+7wKJTSUrPEQAI/F+CltXlW
         GlDasH2MJS1FRqjqKmgmpkcqnmsXQWBbh5dI3LUy12lOYWq2imy2ZypokWV+b/1Xvnp2
         P8vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9JZsiP2wwb4yp7tXBbDl5TzSNqQZu4to9K8auSUXVY4=;
        b=ktQdPntPcq7/y9mSgwiIJtcFXCwhs7/AjYB7+X7mSiCedVmk5MJkW2lUI/D84zZ4kY
         dkM4NRQl0MMti8VtoNozJ/nfFG9OEZjIezcI8rgxDBjdtpg5y+GxYsbKze+6PDC8Zc24
         RtE1QgtN+gByANIa96iQJTmtIB9d72ddzb6IAAybknT09OcwVSLc3JD07jkdUAcDv0HR
         st4/pAZdkOlXC+DfKhmdjsCnGgfx63PouzP5hourzzr7umQDnBEthAjTHdf+hsaOVP5x
         iD1reOpu0jWt98HPDIS4OGxbxv4u804DLpoFLWCD1QQ9mbBUbIqOiwQrCHKZtU13TENO
         bqAQ==
X-Gm-Message-State: AGi0PuZJ/zBY9aKFCHoZzC8hFHl6xUwo8GOnwzy8qPStqst24hHp01WG
        1oHBQdyYy1mQaz2566iABS0K4g==
X-Google-Smtp-Source: APiQypIJWxiW3JcZrug9GK47YQh7yawx/VlV/DYvhcfHwq3JpU0CNnBsKB5f2Zh2kkZQFZJAeT7OeQ==
X-Received: by 2002:a17:902:dc83:: with SMTP id n3mr5554372pld.133.1586967638074;
        Wed, 15 Apr 2020 09:20:38 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id jx1sm52697pjb.5.2020.04.15.09.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 09:20:37 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:20:35 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Vasil Dimov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Vasil Dimov <vd@freebsd.org>
Subject: Re: [PATCH 2/2] range-diff: avoid negative string precision
Message-ID: <20200415162035.GD22823@syl.local>
References: <pull.760.git.git.1586960921.gitgitgadget@gmail.com>
 <b3384880c7201d65adb7341ce23386d578e69193.1586960921.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3384880c7201d65adb7341ce23386d578e69193.1586960921.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 02:28:41PM +0000, Vasil Dimov via GitGitGadget wrote:
> From: Vasil Dimov <vd@FreeBSD.org>
>
> If the supplied integer for "precisoin" is negative in

s/precisoin/precision

> `"%.*s", len, line` then it is ignored. So the current code is
> equivalent to just `"%s", line` because it is executed only if
> `len` is negative.
>
> Fix this by saving the value of `len` before overwriting it with the
> return value of `parse_git_diff_header()`.
>
> Signed-off-by: Vasil Dimov <vd@FreeBSD.org>
> ---
>  range-diff.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index 5cc920be391..40af0862818 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -123,16 +123,19 @@ static int read_patches(const char *range, struct string_list *list,
>  			struct patch patch = { 0 };
>  			struct strbuf root = STRBUF_INIT;
>  			int linenr = 0;
> +			int orig_len;

Any reason to not assign this to 'len' up here?
>
>  			in_header = 0;
>  			strbuf_addch(&buf, '\n');
>  			if (!util->diff_offset)
>  				util->diff_offset = buf.len;
>  			line[len - 1] = '\n';
> +			orig_len = len;
>  			len = parse_git_diff_header(&root, &linenr, 0, line,
>  						    len, size, &patch);

OK, so we cut up the line by placing a NL at len, and then feed it to
'parse_git_diff_header' which will tell us the length of the thing that
it parsed, or give a negative value if it couldn't parse...

>  			if (len < 0)
> -				die(_("could not parse git header '%.*s'"), (int)len, line);
> +				die(_("could not parse git header '%.*s'"),
> +				    orig_len, line);

...and then you restore the original length and print it out here. It
seems like this error is now misleading though, because the line is
already modified at the point that the newline was inserted.

>  			strbuf_addstr(&buf, " ## ");
>  			if (patch.is_new > 0)
>  				strbuf_addf(&buf, "%s (new)", patch.new_name);
> --
> gitgitgadget

Thanks,
Taylor
