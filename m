Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D004C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A8B207DA
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 15:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="v5ad9w/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHMPTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMPS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 11:18:59 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6CCC061757
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:18:59 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id dd12so2801996qvb.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2020 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Xn/V4TnUWk86XPSq560qTLKw+x6Z/k/jOt8DjB1c7gs=;
        b=v5ad9w/G6VFqtByhLGckUAiQzHnqp1Bc2t3cAD/3iGrHQZP1XWRnbyD/GQ1hBqdEdR
         MrTn9lkVe8ihsQppZpZgWee+oQ3Zb2tP+LRoETk/CAr/t2GF6w0/6+a+ASY9CVlN6KVm
         a3dsV3MX2x1bJ8m1aT64/nTH6YtDVTAccIU1wujyux5yXvYIs1QKp3ZYl9rJ1SBj84AR
         TI0zp34s8xg1nCzHtIB52KYkbJeclu1sVD2BGb2EZgB6+96qZE5lNGaVH4JMwVNQFmp9
         vFWtP/GkBctJ6sfB9R7Vy/JNzi9cyb+uI9STTSIe/a76gXd5Peb2NndvpkacttE1ZFWB
         a99Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Xn/V4TnUWk86XPSq560qTLKw+x6Z/k/jOt8DjB1c7gs=;
        b=r6Lm46RKuR6mpXLon3Xj5pfO2wiCfxQEK9FVJBUlH64rLf6cbwDMa+yLow4W/pV2F8
         DfVnyN2l2JgurLpiQNhHHaiNtC78O7u6wuakzdHCwKNIykLZQ55oOPEFPwbpWKyqw1OA
         /HZ1FFjveQLW5i20jR8Pgthssercv0qiFsqLAvyOyCsE/1cB/MvCUhHp3QOPEaYKUfsM
         z2rjs58AfokrwL4z9xxVF3vJjJOc5LNGq4tSsBjJ637cLf9xtyf0dI3+y1Aqnz2IHVuk
         dv9SGGZNG26XG8qsuwsxKitg7katTsR9h0paAqpOeMPXf8r0iP8epIjVU9gB2vIcA3SQ
         PJZA==
X-Gm-Message-State: AOAM532t+QgQQgLHCPDfNmhgwq6GVSp0K9D2QU9CxnpJqTy/PgJi6Qqk
        0sI556xk/DK0OmPDcKNqLh6Rnw==
X-Google-Smtp-Source: ABdhPJyOajsEWGKft5FcRJlXFKHV3MJCEielqtrQk/vsBVlA+W48odWXHywVWXPn9VN5bZt1FEIHdA==
X-Received: by 2002:ad4:56ee:: with SMTP id cr14mr5123272qvb.119.1597331938449;
        Thu, 13 Aug 2020 08:18:58 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:cdcd:c658:5bb1:ebc9])
        by smtp.gmail.com with ESMTPSA id g55sm7730046qta.94.2020.08.13.08.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2020 08:18:57 -0700 (PDT)
Date:   Thu, 13 Aug 2020 11:18:56 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: factor out print_oid()
Message-ID: <20200813151856.GE2244@syl.lan>
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 13, 2020 at 01:11:18PM +0200, René Scharfe wrote:
> Simplify the output code by splitting it up and reducing duplication.
> Reuse the logic for printing object IDs -- anonymized if needed -- by
> moving it to its own function, print_oid().
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  builtin/fast-export.c | 26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
> index 9f37895d4cf..49bb50634ab 100644
> --- a/builtin/fast-export.c
> +++ b/builtin/fast-export.c
> @@ -420,6 +420,14 @@ static const char *anonymize_oid(const char *oid_hex)
>  	return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
>  }
>
> +static void print_oid(const struct object_id *oid, int anonymize)
> +{
> +	const char *oid_hex = oid_to_hex(oid);
> +	if (anonymize)
> +		oid_hex = anonymize_oid(oid_hex);
> +	fputs(oid_hex, stdout);
> +}
> +

The fact that this calls fputs makes this patch (in my own opinion)
noisier than it needs to be. This is because of all of the factoring out
of the other printfs. I'd expect that this looks something more like:

  -				       anonymize ?
  -				       anonymize_oid(oid_to_hex(&spec->oid)) :
  -				       oid_to_hex(&spec->oid));
  +				       anonymize_oid(anonymize, &spec->oid));

without moving around all of the other printf code.

>  static void show_filemodify(struct diff_queue_struct *q,
>  			    struct diff_options *options, void *data)
>  {
> @@ -470,21 +478,19 @@ static void show_filemodify(struct diff_queue_struct *q,
>  		case DIFF_STATUS_TYPE_CHANGED:
>  		case DIFF_STATUS_MODIFIED:
>  		case DIFF_STATUS_ADDED:
> +			printf("M %06o ", spec->mode);
>  			/*
>  			 * Links refer to objects in another repositories;
>  			 * output the SHA-1 verbatim.
>  			 */
>  			if (no_data || S_ISGITLINK(spec->mode))
> -				printf("M %06o %s ", spec->mode,
> -				       anonymize ?
> -				       anonymize_oid(oid_to_hex(&spec->oid)) :
> -				       oid_to_hex(&spec->oid));
> +				print_oid(&spec->oid, anonymize);
>  			else {
>  				struct object *object = lookup_object(the_repository,
>  								      &spec->oid);
> -				printf("M %06o :%d ", spec->mode,
> -				       get_object_mark(object));
> +				printf(":%d", get_object_mark(object));
>  			}
> +			putchar(' ');

... That said, this transformation looks correct from a quick glance.

>  			print_path(spec->path);
>  			string_list_insert(changed, spec->path);
>  			putchar('\n');
> @@ -724,12 +730,10 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
>  		else
>  			printf("merge ");
>  		if (mark)
> -			printf(":%d\n", mark);
> +			printf(":%d", mark);
>  		else
> -			printf("%s\n",
> -			       anonymize ?
> -			       anonymize_oid(oid_to_hex(&obj->oid)) :
> -			       oid_to_hex(&obj->oid));
> +			print_oid(&obj->oid, anonymize);
> +		putchar('\n');

As does this one.

>  		i++;
>  	}
>
> --
> 2.28.0

So, I guess what I'm trying to say is that this patch doesn't look
wrong, other than that it seems more invasive than I would have expected
it to be.

Thanks,
Taylor
