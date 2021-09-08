Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F17E8C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 04:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C38C26113E
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 04:24:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhIHEXZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 00:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbhIHEXY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 00:23:24 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A12C061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 21:22:17 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v10so1140441wrd.4
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 21:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=sV5pClBKnHOW4MM39fmC9ruQsIlnwONxf5S4iuozL2g=;
        b=0gTikDrBOH4LlH35assAjWtGP8e3Vm9LYpUUfmxy39E3Jv8teBPeL0C59S8v7uqCsI
         oO2fpPTblwsf/sf8w8x18K1X6gTgg9os6slfN7drFxy9e0UToSWv/pXXb/1GyjMU0W0j
         LvuXkPfbXsRRlACpxcdAA8ooyEdtaiud267IYOW1aQE8lLpaGrD36DgquwXFKEe2SIcG
         lSWPK6dKCm9QGIWvfiti/gfIHfwTFpt//Bcl94mcdhwWQDXTVOQUMAwFkdOaPtGcPLOq
         d+AH3Y8vLdKBjtj9VpV73Stb5remqqdfzszWZEzjecYuGZxKziXz/6o8tTU6vTlek3RY
         2HaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=sV5pClBKnHOW4MM39fmC9ruQsIlnwONxf5S4iuozL2g=;
        b=T/gSeqyRx1RhA1gIOOB7JMCIMx450L2uHflizJCIv4jjoaYVORwvPqmO/RPFzEHrHY
         Cm5Tif5Io3FCpPRgIN89ksVOBsc2NyB3hcstNyNqzgw5IePhj7BlwFjt1ZUFHK1AD7Ko
         OFyvgZE1c0mbpjjWPOT8tCeatRY8lPIl4xEz9vl6Ra2R7Sl+qgp+ZZHcc7izUvwHLcAj
         hMtU8V4+h2EgA1ebWw3X77+pWEB1VuNfjExNpUe5tGVgiGs+iiXrg9dAC0pqwkBOyZym
         4l+xhTGLvMVpLOhwIqkkuvFhuQ8To3JvbnPke1SpX3J7hMHsd44D0X9FnokHGjtbRh5X
         O0Tg==
X-Gm-Message-State: AOAM532jNQuDBHpCi5Gvgk1QwPpx62vTiLQ7xZW/v6dLIfCbswjkdHPG
        cG91u1+6IrSNUa0o1V0IZR3lEwSnBkUapVnV
X-Google-Smtp-Source: ABdhPJyVPRzoiOY7ebD6zVr5bW+mc9iIWD77hDMIT1tnG422WG9u+xCagmaT5sDehc+Q3+tdsdJd9g==
X-Received: by 2002:a5d:4488:: with SMTP id j8mr1600765wrq.260.1631074935778;
        Tue, 07 Sep 2021 21:22:15 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h18sm852713wrb.33.2021.09.07.21.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 21:22:14 -0700 (PDT)
Date:   Wed, 8 Sep 2021 00:22:12 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/4] pack-write: refactor renaming in
 finish_tmp_packfile()
Message-ID: <YTg6dH6qQKFH1lnw@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <cover-v2-0.4-0000000000-20210908T003631Z-avarab@gmail.com>
 <patch-v2-2.4-7b39f4599b-20210908T003631Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v2-2.4-7b39f4599b-20210908T003631Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 08, 2021 at 02:38:26AM +0200, Ævar Arnfjörð Bjarmason wrote:
> -void finish_tmp_packfile(struct strbuf *name_buffer,
> +static void rename_tmp_packfile(const char *source,
> +				 const struct strbuf *basename,
> +				 const unsigned char hash[],
> +				 const char *ext)
> +{
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	strbuf_addf(&sb, "%s%s.%s", basename->buf, hash_to_hex(hash), ext);
> +	if (rename(source, sb.buf))
> +		die_errno("unable to rename temporary '*.%s' file to '%s'",
> +			  ext, sb.buf);
> +	strbuf_release(&sb);
> +}

At the end of the day, I really do not mind the extra copying of
basename. But if you were interested in a potential alternative, I'd
suggest making basename non-const and doing instead:

    static void rename_tmp_packfile(struct strbuf *basename, ...)
    {
      size_t basename_len = basename->len;
      strbuf_addf(basename, ".%s", ext);
      if (rename(source, basename.buf))
        die_errno(...);

      strbuf_setlen(basename, basename_len);
    }

where the contract of this function is "I will modify the buffer you
gave me (so do not read or write to it concurrently) but will return it
to you in the same state as it was provided".

That would be an improvement in readability (because of your idea to
extract rename_tmp_packfile()) but would result in no new copying, which
would be nice to avoid if we can.

But I do not feel that strongly, it just seems like an unnecessary
introduction of copying where we don't otherwise need it.

Thanks,
Taylor
