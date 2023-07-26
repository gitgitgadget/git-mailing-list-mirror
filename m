Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54141C001DE
	for <git@archiver.kernel.org>; Wed, 26 Jul 2023 23:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGZX2l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jul 2023 19:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjGZX2k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2023 19:28:40 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E7419BA
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 16:28:39 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d05a63946e0so313317276.1
        for <git@vger.kernel.org>; Wed, 26 Jul 2023 16:28:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690414118; x=1691018918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=46xwfYV07Ivw0gewofZ15TaG5TRubi4m70Ahp8p+6bg=;
        b=p8LM4isc+1Y+/LG6VjmL6YPoiTC9CCFJ+okWxwb7eEGbCieoUJaRx5xVYOTmWjefMv
         9BpzudihgmbzUCToiIliUphCgMcsclE3O/NYiEQY/bQSBPRdeEq2KX1HEUVrClKCnnxG
         w2slwHqp9i8FtA85JiqbYqi0Bt7xuh0tzvb1IiY/NsUlDJimhfYxvIobdVWqMIctKCTz
         I53KltrLZh63gDiarweIzIGPKL8K4g1TZ2xbcaha3/UoUUG7SQGpYAdiJGTbvkUhH+sr
         qG4Zr04cI5N54mP4+0VPH69rWbaN6DyO1jKxPVKQwZqkpnpNJOj1kzrO4176H7m9eXf9
         AZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690414118; x=1691018918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=46xwfYV07Ivw0gewofZ15TaG5TRubi4m70Ahp8p+6bg=;
        b=atVplQMrc27oX6NkwR29Lm3bcEz7FWuYoeCsszBhj2NfLwjZyyjQOUTUNyGkZx+cYl
         7eD6tYmoZHonrV8Ip3ZxgA+klpe73Mitd8NaYnkVEVHLdLcPP9KutXU8L/3XaPAu3A2W
         20etYgW8KnNTfxHoQLagUVH/zv88zD5yKFmZR7/mWOppSRdK2iKhs/PAyDT76WS5SJE0
         aK8zVWOmbb5gK+iVIhuPZg9+sOcFansfkqbJDH0h6rIVSk0xf3npPd7DrlhUpYV0eNPm
         XlJCsIPnFT5zl+O9Glwlw5NkwRvC1hvOvYtaYqOaIEY/7bPT+qpU2jLlvD3jtnygWu+P
         0tmg==
X-Gm-Message-State: ABy/qLazAKx9Su1Nwo5gmzc/JFetjb+iLmkthS9A1mf7h3ufCOJP8vbX
        xfApaBPqLOXiS1jaBf9g6ub8RBuW5opiFT4qOxI30Q==
X-Google-Smtp-Source: APBJJlE8PQVZJlYn/wjoM9AfVZSzdQ3jGHs04tazAFHoiD+Jaa8bgSA+hOjbOkhvECcadV5KMikKMw==
X-Received: by 2002:a0d:e203:0:b0:56d:9e2:7d9e with SMTP id l3-20020a0de203000000b0056d09e27d9emr3538143ywe.21.1690414118368;
        Wed, 26 Jul 2023 16:28:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h2-20020a81b402000000b005707d7686ddsm92718ywi.76.2023.07.26.16.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 16:28:38 -0700 (PDT)
Date:   Wed, 26 Jul 2023 19:28:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 5/7] t4216: test changed path filters with high bit
 paths
Message-ID: <ZMGsJTxBXZ94lhMU@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1689889382.git.jonathantanmy@google.com>
 <5276e6a90ecb84cbca3b14a27dc055cf81d27ac3.1689889382.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5276e6a90ecb84cbca3b14a27dc055cf81d27ac3.1689889382.git.jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 20, 2023 at 02:46:38PM -0700, Jonathan Tan wrote:
> +test_expect_success 'setup check value of version 1 changed-path' '
> +	(cd highbit1 &&
> +		echo "52a9" >expect &&
> +		get_first_changed_path_filter >actual &&
> +		test_cmp expect actual)
> +'

This is a little bit of funky indentation, I probably would have
expected something more along the lines of:

    (
      cd highbit1 &&
      echo "52a9" >expect &&
      get_first_changed_path_filter >actual &&
      test_cmp expect actual
    )

but this obviously doesn't merit a reroll on its own.

> +test_expect_success 'version 1 changed-path used when version 1 requested' '
> +	(cd highbit1 &&
> +		test_bloom_filters_used "-- $CENT")
> +'

Same here, but neither of these is incorrect.

Thanks,
Taylor
