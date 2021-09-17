Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC7D6C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 03:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFAC460F25
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 03:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbhIQD7L (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 23:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244169AbhIQD7G (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 23:59:06 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95EEC061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 20:57:44 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id a15so10548263iot.2
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 20:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ycAbu/0U3m35lMPEv2Gbksd5IT6fIXyhLMtvIn7H4NQ=;
        b=zLn8QglCqLGTrclBbJ2zVp8GFI9bnN8n4y/8U6IeNj4Yuct2WwcS5WJjZBG/0R24a6
         wdlgjmTHYgJ6QIEne94tEQGng1XOEw4QrSu3AlCLDpUdhLQRPtj7+Smh1knwcTB9ZQ8x
         +kAcJw8+0439kDQ+y7gnYc/emipAugZ9Jj0EBDhPQB2RJ5x4/hdc6bZkaS/b478yrNFu
         P4dkz3vNA8aXy4KMadSOH4nSDVkzgShCHNGN9X39J6NghvPK66FaXCvya+Uur9V/kJuT
         9wbF1grtv94o0AZ7U/4/1CjMxy+gkWn/N78EU58b7tki6qB1T+bRWrn5K0rKEVid8Lfm
         ixKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ycAbu/0U3m35lMPEv2Gbksd5IT6fIXyhLMtvIn7H4NQ=;
        b=7ws8NdR5ObQRKT2HJipi2Whp2uJTnrxYjb2PUmjPuc+yOKDN30WrjbLifvcFDqwo8t
         PealbLtjOyYioWae91dtKmeifZefgEzAtN329D1RZhrCj/cjKawVN80YMLxs343e/ABd
         l9Eod8A+l2U9GwR3M+7BPw6gxXfPFWnJZasbNNGxwKFQ6vcCL+4OsQ3z46gvlG/iP+9P
         gRBYHrnTmvFghe+hDHemvn47v3Wxh8NeLre2NhSAtZDjIRzHw0wHaM5iIHYkpfoGf/o5
         +pR2v9YRxTWjzx/d8pTVM+XSfdihvnBlcoAYhMol6eLvxEy4w2KzJkgjVOfZlOOs0LQg
         zx2w==
X-Gm-Message-State: AOAM5321gDWCl9Q7sox44H0RDXhbrWHL9Z630ixGzY0VuVK0Q6lhKkQt
        kWbMpQixZPoYI38UuhCi9LlFMQ==
X-Google-Smtp-Source: ABdhPJxr3q5HHRQ3XDLgvTRXR+nHdDuaMJnAS9OzJ8PsyN9MOBx7kxsbzMiF+TVVE42xG7jFNhDOjw==
X-Received: by 2002:a05:6638:2182:: with SMTP id s2mr7141447jaj.26.1631851064082;
        Thu, 16 Sep 2021 20:57:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e12sm2838603ile.14.2021.09.16.20.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 20:57:43 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:57:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 21/22] fsck: report invalid types recorded in objects
Message-ID: <YUQSNgC8yCw6ICY9@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-21.22-974f650cddf-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-21.22-974f650cddf-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:16PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Continue the work in the preceding commit and improve the error on:
>
>     $ git hash-object --stdin -w -t garbage --literally </dev/null
>     $ git fsck
>     error: hash mismatch for <OID_PATH> (expected <OID>)
>     error: <OID>: object corrupt or missing: <OID_PATH>
>     [ other fsck output ]
>
> To instead emit:
>
>     $ git fsck
>     error: <OID>: object is of unknown type 'garbage': <OID_PATH>
>     [ other fsck output ]
>
> The complaint about a "hash mismatch" was simply an emergent property
> of how we'd fall though from read_loose_object() into fsck_loose()
> when we didn't get the data we expected. Now we'll correctly note that
> the object type is invalid.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/fsck.c  | 22 ++++++++++++++++++----
>  object-file.c   | 13 +++++--------
>  object-store.h  |  4 ++--
>  t/t1450-fsck.sh | 24 +++++++++++++++++++++---
>  4 files changed, 46 insertions(+), 17 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index 082dadd5629..07af0434db6 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -600,12 +600,26 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
>  	unsigned long size;
>  	void *contents;
>  	int eaten;
> -
> -	if (read_loose_object(path, oid, &type, &size, &contents,
> -			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
> -		errors_found |= ERROR_OBJECT;
> +	struct strbuf sb = STRBUF_INIT;
> +	unsigned int oi_flags = OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
> +	struct object_info oi;
> +	int found = 0;
> +	oi.type_name = &sb;
> +	oi.sizep = &size;
> +	oi.typep = &type;
> +
> +	if (read_loose_object(path, oid, &contents, &oi, oi_flags) < 0) {

OK, now we pass a struct object_info instead of pointers to type and
size separately. Makes sense.

> +		found |= ERROR_OBJECT;

And found tracks the error we found when trying to read this loose
object, if any. Having a separate variable makes sense, since we only
want to avoid calling fsck_obj() if we found any errors for this object
while trying to call read_loose_object().

>  		error(_("%s: object corrupt or missing: %s"),
>  		      oid_to_hex(oid), path);
> +	}
> +	if (type < 0) {
> +		found |= ERROR_OBJECT;
> +		error(_("%s: object is of unknown type '%s': %s"),
> +		      oid_to_hex(oid), sb.buf, path);
> +	}
> +	if (found) {
> +		errors_found |= ERROR_OBJECT;

Perhaps errors_found |= found ?

>  		return 0; /* keep checking other objects */
>  	}
>
> diff --git a/object-file.c b/object-file.c
> index 0e6937fad73..f4850ba62b4 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2560,9 +2560,8 @@ static int check_stream_oid(git_zstream *stream,
>
>  int read_loose_object(const char *path,
>  		      const struct object_id *expected_oid,
> -		      enum object_type *type,
> -		      unsigned long *size,
>  		      void **contents,
> +		      struct object_info *oi,
>  		      unsigned int oi_flags)

All of the changes in this function make perfect sense, except...
>  {
>  	int ret = -1;
> @@ -2570,10 +2569,9 @@ int read_loose_object(const char *path,
>  	unsigned long mapsize;
>  	git_zstream stream;
>  	char hdr[MAX_HEADER_LEN];
> -	struct object_info oi = OBJECT_INFO_INIT;
>  	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
> -	oi.typep = type;
> -	oi.sizep = size;
> +	enum object_type *type = oi->typep;
> +	unsigned long *size = oi->sizep;

...I see that size is used in check_object_signature(), but I don't see
any uses for type. Am I missing it?

The tests look good to me.

Thanks,
Taylor
