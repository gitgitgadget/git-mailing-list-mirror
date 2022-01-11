Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B9AC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346058AbiAKTGV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:06:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243166AbiAKTGU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:06:20 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72B2C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:06:19 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id y18so52793iln.3
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 11:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=lKVy8hP7II2Qh1xXABEDSo6wwtoOu6yGVPcLPBnXTfM=;
        b=OB1SEt12/AIDfXgA3VGS2L72cF4iDsXKHlbVCAPpBegwaUTqpDWb5LkyZ5JoxA+7IH
         KQB8xQP7LKnGWzpCI5moGDxbfUMIl6zdZD0wjufP/PG2Eo9QXU85c3T+2tRYtyIwqA2m
         aKN2CzZO4MGZfDPd8ffbNBw4kWCoWuVhz+qTfLKGgb5wDEUrHmF2O3JJqmQxsOk/AYpD
         /EHIT91cFNhdscpoxYYAxxBdaGP+ecZlWO9uGPWfO7BbFJz1082AF8p7QozSkrZwPmrV
         cP81ERxBQjLXUGeyzRkM8I1b3mhRsglqWfuK4doQF2UU+A1/BQXGlWcpga3w65qw4Xt2
         rKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=lKVy8hP7II2Qh1xXABEDSo6wwtoOu6yGVPcLPBnXTfM=;
        b=3z5qi4f8jo9pVJ+4bVRlZWHkRUDzF6hlhf+9bdEKUcLgxULGttdcRLyo+mPcasSFlA
         Q+geOrU/osMT5ADbUofaH5iiru2bcowuorOcQRvC5PBrDiBg4uSXqPrHPS0Ib+geSJ80
         kKpQ2j2+QMvTsChFptmkCIaeA5Im95lgQnNVa5ssmh5zcfz92Emx9gmFfLJBjSSwLG3x
         rae2/AM+HY9ycpaIDEZfpDZcZIKi2YZZUZxPh37P1xkfoQRq805qFOypOc4QhStyd86p
         WfcwH1ooVgKWsjAMomPWpBfZeVzbLYswrLAAEvnBL8qgs4NiC6oZQoekOWztb7glzDaW
         JZjQ==
X-Gm-Message-State: AOAM532dZFs0x9Iwu+1bGJjNsBmS9T2Pc3U9WUSIl2to13Xnd44RuW+y
        tfaVybsnAZfY9J4nzWQWuIHCIQ==
X-Google-Smtp-Source: ABdhPJzVLekAJr1VlMWFr+GXMsCe8oAzsC8+M0TGcgYJgdc/vtGs1W07aM60T4o671bPcAPC+rkK+Q==
X-Received: by 2002:a05:6e02:18cc:: with SMTP id s12mr3265763ilu.6.1641927979297;
        Tue, 11 Jan 2022 11:06:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f25sm45171ioj.52.2022.01.11.11.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 11:06:19 -0800 (PST)
Date:   Tue, 11 Jan 2022 14:06:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 1/3] test-tool genzeros: initialize "zeros" to avoid
 SunCC warning
Message-ID: <Yd3VKjvb7AR0/wI9@nand.local>
References: <cover-0.3-00000000000-20220111T163908Z-avarab@gmail.com>
 <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.3-4dadf7320ab-20220111T163908Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 11, 2022 at 05:40:21PM +0100, Ævar Arnfjörð Bjarmason wrote:
> It isn't important for optimization to have this be "static", so let's
> just initialize it and avoid this warning on Sun Studio 12.5:
>
>     "t/helper/test-genzeros.c", line 7: warning: const object should have initializer: zeros

I agree that whether or not this variable is declared statically does
not matter for our purposes, since we call cmd__genzeros() exactly once
per invocation of the test helper. So we're never paying the cost to
re-declare a variable on the stack since that stack frame only gets
created once.

And I don't care for the purposes of a reroll on such a trivial
question, but I do think that this patch leaves something out that was
included in the cover letter. Namely, that this is not the first such
warning of this kind from SunCC. Or in other words, that we have lots of
static const objects that we depend on being zero'd (and which we can
safely assume _are_ zerod, since they are declared statically), but that
each of them already generates a warning from SunCC.

Mentioning that would give readers an impression of why this was the
only spot touched instead of every static const variable.

But if you take that line of thinking further, I have a hard time
imagining that it's worth fixing small issues like this in piecemeal
when there are already many such warnings. We _could_ fix all of them at
once and amend Documentation/CodingGuidelines, but that seems like a lot
of work for an issue that does not seem to be causing much pain at all.

> diff --git a/t/helper/test-genzeros.c b/t/helper/test-genzeros.c
> index 8ca988d6216..5dc89eda0cb 100644
> --- a/t/helper/test-genzeros.c
> +++ b/t/helper/test-genzeros.c
> @@ -3,8 +3,7 @@
>
>  int cmd__genzeros(int argc, const char **argv)
>  {
> -	/* static, so that it is NUL-initialized */
> -	static const char zeros[256 * 1024];
> +	const char zeros[256 * 1024] = { 0 };

So this transformation is just fine, but I imagine that we probably
could have just as easily left it alone.

Thanks,
Taylor
