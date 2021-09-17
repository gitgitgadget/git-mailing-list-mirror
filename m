Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A878AC433EF
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 03:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E84560F92
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 03:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244033AbhIQDit (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 23:38:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbhIQDis (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 23:38:48 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29452C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 20:37:27 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id a20so8835271ilq.7
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 20:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sBz/ch2b2R70Jrm/PcM7Awml8SJXTEMc0v2BIOayIx4=;
        b=y/8c7BrcGnIM/h59NIYZXv8JFD02/zmzhSlFhIz3p+C9UGecHnmhsF7VLDsIbXKsH/
         dHNH1Ft18/kv3u3htWwYNe0QlKTyUbE4TTB/JWhpw0ygLCjPy2vb9RNl50xcZY0OCqpN
         +jAKYjtwlGrwQcJIAhKkLrm1b/+WswqtyNtzbgtx1sQsAjSWoHsO4bPapOxulxLqIISH
         /nuIWyzHDHXYgFDrf88RJ9dKOu5slI1jEyNItsSeX7XBKu3/fBUKHHdQFYPiG4pieof0
         Ws133rR3VReXWKmWHAyqxLKUF2XWlQswNiZjQgMBRT0QuDv6zvwaVF03NMD2AHDU9kpo
         8FxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sBz/ch2b2R70Jrm/PcM7Awml8SJXTEMc0v2BIOayIx4=;
        b=r2tzP72sDxh/HGSvDyC1qp3H0RoI+sMzUB2vuab4km5rFJcgV3vCaoax7dRxS8r1vb
         8L8qV6dB/mWmL2j1YwchjH89S/T2NQ1fLjC62KKQrROukIqMMwRLpRNgT0zsf5VIf/CO
         ECsKuUo5WMMxI/PslRS34YOx/4mtfK22CoIRsnaoL4B8E19ePmfuAM8ZR1mhOGnUdPr8
         RACapg97O/LyiwLIp0vd+tLu8D6EGebbwbHTu7MDPktXBjV2gUKdRcUBSxSAg3UKwmBS
         T7OcY5A599rPUKybbRL7XPlo2R8zyQebU/FYlcOy+s+oyA3dv2HoNsmZuNwxh5CKimxc
         KqqQ==
X-Gm-Message-State: AOAM532mDUJIce58QznRE7ebJG/lTO/ouBgDLA0ByDeyKg87v+RNAfXx
        IorHzSZwZvUA6tfw1my07uFeZw==
X-Google-Smtp-Source: ABdhPJzarNiRuaUCl9YC4bxx5MxPSn2L9pXa636trJQsoKuAD7YtStlZEnSTkSXhGBwWTgyvGA5IDg==
X-Received: by 2002:a05:6e02:f13:: with SMTP id x19mr6515939ilj.216.1631849846533;
        Thu, 16 Sep 2021 20:37:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s10sm2798703iom.40.2021.09.16.20.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 20:37:26 -0700 (PDT)
Date:   Thu, 16 Sep 2021 23:37:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v6 19/22] fsck: don't hard die on invalid object types
Message-ID: <YUQNcPAs35WhJHKo@nand.local>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
 <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
 <patch-v6-19.22-ad1614dbb8d-20210907T104559Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v6-19.22-ad1614dbb8d-20210907T104559Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 07, 2021 at 12:58:14PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Change the error fsck emits on invalid object types, such as:
>
>     $ git hash-object --stdin -w -t garbage --literally </dev/null
>     <OID>
>
> >From the very ungraceful error of:
>
>     $ git fsck
>     fatal: invalid object type
>     $
>
> To:
>
>     $ git fsck
>     error: hash mismatch for <OID_PATH> (expected <OID>)
>     error: <OID>: object corrupt or missing: <OID_PATH>
>     [ the rest of the fsck output here, i.e. it didn't hard die ]

Great. I don't love the second error (since it doesn't really give the
user any new information when read after the first) but that's fsck's
fault, and not your patch's.

> To do this we need to pass down the "OBJECT_INFO_ALLOW_UNKNOWN_TYPE"
> flag from read_loose_object() through to parse_loose_header(). Since
> the read_loose_object() function is only used in builtin/fsck.c we can
> simply change it. See f6371f92104 (sha1_file: add read_loose_object()
> function, 2017-01-13) for the introduction of read_loose_object().
>
> Why are we complaining about a "hash mismatch" for an object of a type
> we don't know about? We shouldn't. This is the bare minimal change
> needed to not make fsck hard die on a repository that's been corrupted
> in this manner. In subsequent commits we'll teach fsck to recognize
> this particular type of corruption and emit a better error message.
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  builtin/fsck.c  |  3 ++-
>  object-file.c   | 11 ++++++++---
>  object-store.h  |  3 ++-
>  t/t1450-fsck.sh | 14 +++++++-------
>  4 files changed, 19 insertions(+), 12 deletions(-)
>
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index b42b6fe21f7..082dadd5629 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -601,7 +601,8 @@ static int fsck_loose(const struct object_id *oid, const char *path, void *data)
>  	void *contents;
>  	int eaten;
>
> -	if (read_loose_object(path, oid, &type, &size, &contents) < 0) {
> +	if (read_loose_object(path, oid, &type, &size, &contents,
> +			      OBJECT_INFO_ALLOW_UNKNOWN_TYPE) < 0) {
>  		errors_found |= ERROR_OBJECT;
>  		error(_("%s: object corrupt or missing: %s"),
>  		      oid_to_hex(oid), path);
> diff --git a/object-file.c b/object-file.c
> index 9484c7ce2be..0e6937fad73 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -2562,7 +2562,8 @@ int read_loose_object(const char *path,
>  		      const struct object_id *expected_oid,
>  		      enum object_type *type,
>  		      unsigned long *size,
> -		      void **contents)
> +		      void **contents,
> +		      unsigned int oi_flags)
>  {
>  	int ret = -1;
>  	void *map = NULL;
> @@ -2570,6 +2571,7 @@ int read_loose_object(const char *path,
>  	git_zstream stream;
>  	char hdr[MAX_HEADER_LEN];
>  	struct object_info oi = OBJECT_INFO_INIT;
> +	int allow_unknown = oi_flags & OBJECT_INFO_ALLOW_UNKNOWN_TYPE;
>  	oi.typep = type;
>  	oi.sizep = size;
>
> @@ -2592,8 +2594,11 @@ int read_loose_object(const char *path,
>  		git_inflate_end(&stream);
>  		goto out;
>  	}
> -	if (*type < 0)
> -		die(_("invalid object type"));
> +	if (!allow_unknown && *type < 0) {
> +		error(_("header for %s declares an unknown type"), path);
> +		git_inflate_end(&stream);
> +		goto out;
> +	}

Hmm. I'm not sure that I new test for this error (which may be
uninteresting, in which case it is fine to skip).
>
> -test_expect_success 'fsck hard errors on an invalid object type' '
> +test_expect_success 'fsck error and recovery on invalid object type' '
>  	git init --bare garbage-type &&
>  	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
>  	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
> -	cat >err.expect <<-\EOF &&
> -	fatal: invalid object type
> -	EOF
> -	test_must_fail git -C garbage-type fsck >out.actual 2>err.actual &&
> -	test_cmp err.expect err.actual &&
> -	test_must_be_empty out.actual
> +	test_must_fail git -C garbage-type fsck >out 2>err &&
> +	grep -e "^error" -e "^fatal" err >errors &&
> +	test_line_count = 2 errors &&
> +	grep "error: hash mismatch for" err &&
> +	grep "$garbage_blob: object corrupt or missing:" err &&
> +	grep "dangling blob $empty_blob" out
>  '

Great.

Thanks,
Taylor
