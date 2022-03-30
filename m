Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE74EC433F5
	for <git@archiver.kernel.org>; Wed, 30 Mar 2022 07:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243717AbiC3HPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 03:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243721AbiC3HPn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 03:15:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24BF16BFA4
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 00:13:50 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id w21so16878333pgm.7
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 00:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAtjHyyEOYV2R5et3LMq420uCK1kJ2nEGUv3Q3hKQWQ=;
        b=ko9Vdb46dzVWXfpFV7aSh00GcTLt6LbFOI2mAed7wX5M+KAtrltBDfRs20NfKwX9dc
         qbNQTSxoT8o3EkMHC67a9dVP5XUrRoZO1Yz0sAOZzBFeiM0GWkfAKG/h5crvNRklTXa5
         I65ITYUQqjQqf79XkOU8NmistbqbtwH2c6ZfXFWJ1wbZ7UEWBjbi9T83vS+Era7m/k37
         zf86THZj/in+ZlRorGm9x/pPP2/+nfxETmV7eRIn23uheAFH1+WeAfWSLEiTvUIMEfuN
         bnLiycmThe+hRZQ0iKZ+Up0q5oHjhHEJZOyo2xoXmxEGeRT6w9d9Q9OzSQbeIX9H5H9f
         wKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAtjHyyEOYV2R5et3LMq420uCK1kJ2nEGUv3Q3hKQWQ=;
        b=6QxaVon+BR6g1v4VpKc6FEbhRVREgofrjCdp4A9+r0huxAZAj7Eo6fuHPfyHcJLODg
         C/48a1a3NmwyWNvrQLOgoFhaVXIpy6O+P9XeDskxm6/fB/UDAeHeoQ8b21ojI2RI7+Nw
         IegrOpVRVJ0P5t31Omf06clhF2qaln4KR7SIE6A/By4+NjfrG2LSe7lQtViGMB3v+j8r
         jdkjA2zDKfIOYHxRa+ORbxJBaIc8caiXmSvtegsVsJiN5xKuTZOEwYxcyvNDOLMb39JS
         jwp+hFPlW/c8npurr7uL7eDGebYFB9qEcIycRmty+lh8MyH5RXLK0YrzCx27xsetaWbG
         etwg==
X-Gm-Message-State: AOAM5330t37sovigc8GcsFLt6PyNxiFEZ5t2SY7yJtRGF6K0HP5JO3fe
        MdPvxomaRLOLBknmZ0FtJIC9lEZUSH4IJQ==
X-Google-Smtp-Source: ABdhPJwYJilC5MLM/kcQaM4qc2VMvmed78X6rgLLE0NwLjfV9o2xk4JYVkm68tCauJtsRj73FHjo5g==
X-Received: by 2002:a63:3309:0:b0:398:1bfd:21fd with SMTP id z9-20020a633309000000b003981bfd21fdmr4967177pgz.598.1648624430131;
        Wed, 30 Mar 2022 00:13:50 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id v8-20020a056a00148800b004fa9bd7ddc9sm22230766pfu.113.2022.03.30.00.13.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Mar 2022 00:13:49 -0700 (PDT)
From:   Han Xin <chiyutianyi@gmail.com>
To:     avarab@gmail.com
Cc:     chiyutianyi@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        hanxin.hx@alibaba-inc.com, l.s.r@web.de, neerajsi@microsoft.com,
        newren@gmail.com, philipoakley@iee.email, stolee@gmail.com,
        worldhello.net@gmail.com, zhiyou.jx@alibaba-inc.com
Subject: Re: [PATCH v12 3/8] object-file.c: refactor write_loose_object() to several steps
Date:   Wed, 30 Mar 2022 15:13:44 +0800
Message-Id: <20220330071344.25676-1-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.35.1.55.gde4365fc52.agit.6.5.7
In-Reply-To: <patch-v12-3.8-3dcaa5d6589-20220329T135446Z-avarab@gmail.com>
References: <patch-v12-3.8-3dcaa5d6589-20220329T135446Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 29, 2022 at 3:56 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> 
> +/**
> + * Common steps for loose object writers to end writing loose objects:
> + *
> + * - End the compression of zlib stream.
> + * - Get the calculated oid to "oid".
> + * - fsync() and close() the "fd"

Since we removed close_loose_object() from end_loose_object_common() , I
think this comment should also be removed.

Thanks.
-Han Xin

> + */
> +static int end_loose_object_common(git_hash_ctx *c, git_zstream *stream,
> +				   struct object_id *oid)
> +{
> +	int ret;
> +
> +	ret = git_deflate_end_gently(stream);
> +	if (ret != Z_OK)
> +		return ret;
> +	the_hash_algo->final_oid_fn(oid, c);
> +
> +	return Z_OK;
> +}
> +
