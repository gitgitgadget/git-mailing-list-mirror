Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CB81C433DB
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E08446529C
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 21:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbhCHVAP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 16:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhCHVAD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 16:00:03 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E50C06174A
        for <git@vger.kernel.org>; Mon,  8 Mar 2021 13:00:00 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id z190so10823235qka.9
        for <git@vger.kernel.org>; Mon, 08 Mar 2021 13:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=V5PUu7toAIS0uV3fGIgqhJO8zDdKClGSwYwDwzI6es0=;
        b=bDE/vzu9APukTOiApIr5LK+XXQvDqzTtDZ7NkR6kzm/eOoe1GaFujIoKmWMKRnDFEc
         iirZwxBEDj0JXhp8+nEdjzfju9okn8PN7aGTUjoBRBMVDgPdk2L931iFu5KD/LeeFzVM
         ZCF+kLbFeUB1hMPcwqAxaFuu+vhCkla6/pi07qBo+lbCmp0XOBbiMeTbZKVF0BJzhbt6
         lLEH3IybXLQVkL9uvy4cDexD1px9nTLHKW4C8zuORJ2Pe+60U4n1OFEBaU0j5Lp4Omen
         t2NqJmvhhYqWzC0WyjJCjMVArPwD4YqWpDRXa8aTMsMVJbrSLdElqSpXrAppQb51Hlfy
         XM8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=V5PUu7toAIS0uV3fGIgqhJO8zDdKClGSwYwDwzI6es0=;
        b=RCxChPxguwKIIpBn6YJB1JyrFrYgmEwUnfj5zHB0c3CN1hDSGQ0dAghpLnXBkrBQzH
         7ucHGmlNTU9dYr7wBuE8sU3QETW4zpbWZV+ZiGNDoyugoPKyGqxtz30w+/YJyIKkUkuF
         WpX3k3AW3bP/DC6VLOvyIlWfmLFemi44EaxwEq5irJdxHC5cf4CY1ltQbW2S85kQtdIF
         rHKftUWY2j7F2uScmXLxSgn5VAUY/a5X33a6CSuMSm7pxq8US8DwD2v8gChmazD49pbU
         BS1cIVcYbSQuJpXXXN0ng9Jrn+v5QHU+FK0m/QkEX3mLR63qz6iLcycVNRGEfSVslZ3S
         DY2A==
X-Gm-Message-State: AOAM532+3vfOa7H0ahJ9DxWB94bNGVyHfEDwKzA9SSrpWU1yOt7GunNR
        K9ePokYZqOHC+EIEJLnAgCrHnw==
X-Google-Smtp-Source: ABdhPJwSPnVR5ejXGAZF7Qdqxyc87LhINCWnlpSu/Gfq6u412orXAxnxGrBmQ3G8Woj3fy9s5H+b6Q==
X-Received: by 2002:a37:6191:: with SMTP id v139mr22548668qkb.32.1615237199797;
        Mon, 08 Mar 2021 12:59:59 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d4a3:1166:858b:6d61])
        by smtp.gmail.com with ESMTPSA id q6sm7464182qtw.83.2021.03.08.12.59.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 12:59:59 -0800 (PST)
Date:   Mon, 8 Mar 2021 15:59:56 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 5/7] object.c: add a utility function for "expected type
 X, got Y"
Message-ID: <YEaQTK2BWrf1/cpY@nand.local>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-6-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308200426.21824-6-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:04:24PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Refactor various "Object X is not Y" error messages so that they use
> the same message as the long-standing object_as_type() error
> message. Now we'll consistently report e.g. that we got a commit when
> we expected a tag, not just that the object is not a tag.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/index-pack.c |  9 +++------
>  commit.c             | 10 ++++------
>  object.c             | 34 +++++++++++++++++++++++++++++++++-
>  object.h             |  5 +++++
>  tree.c               |  7 ++++---
>  5 files changed, 49 insertions(+), 16 deletions(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 253cfb07fbd..d9082831bb2 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -217,8 +217,8 @@ static int mark_link(struct object *obj, int type, void *data, struct fsck_optio
>  	if (!obj)
>  		return -1;
>
> -	if (type != OBJ_ANY && obj->type != type)
> -		die(_("object type mismatch at %s"), oid_to_hex(&obj->oid));
> +	if (type != OBJ_ANY)
> +		oid_is_type_or_die(&obj->oid, obj->type, &type);

Nice. This is definitely an improvement over the existing code.

> +static const char *oid_is_a_X_not_a_Y = N_("object %s is a %s, not a %s");
> +

This name is a little verbose. I'm nitpicking, of course, but would you
consider "object_type_mismatch_msg" instead?

>  const char *type_name(unsigned int type)
>  {
>  	if (type >= ARRAY_SIZE(object_type_strings))
> @@ -159,6 +161,36 @@ void *create_object(struct repository *r, const struct object_id *oid, void *o)
>  	return obj;
>  }
>
> +static int oid_is_type_or(const struct object_id *oid,
> +			  enum object_type want,
> +			  enum object_type type,
> +			  int err)
> +{
> +	if (want == type)
> +		return 0;
> +	if (err)
> +		return error(_(oid_is_a_X_not_a_Y),
> +			     oid_to_hex(oid), type_name(type),
> +			     type_name(want));
> +	else
> +		die(_(oid_is_a_X_not_a_Y), oid_to_hex(oid),
> +		    type_name(type), type_name(want));
> +}
> +
> +void oid_is_type_or_die(const struct object_id *oid,
> +			enum object_type want,
> +			enum object_type *type)
> +{
> +	oid_is_type_or(oid, want, *type, 0);
> +}
> +
> +int oid_is_type_or_error(const struct object_id *oid,
> +			 enum object_type want,
> +			 enum object_type *type)
> +{
> +	return oid_is_type_or(oid, want, *type, 1);
> +}
> +

I'm not sure that this oid_is_type_or() is really doing all that much.
It allows you to share the 'if (want == type)' conditional between the
other two functions, but the rest of the function is a conditional
itself that behaves differently depending on whether you called the
_die() or _error() variant.

Why not duplicate the 'if (want == type)' between the two functions, and
then remove 'oid_is_type_or()' altogether?

Thanks,
Taylor
