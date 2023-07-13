Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E879C001DD
	for <git@archiver.kernel.org>; Thu, 13 Jul 2023 14:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjGMOY5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jul 2023 10:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGMOY4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jul 2023 10:24:56 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39D2268D
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 07:24:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-579de633419so7289937b3.3
        for <git@vger.kernel.org>; Thu, 13 Jul 2023 07:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689258295; x=1691850295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aA2VttawQoszyf0U4APyP5HFkEW0Co87mUTc0QbASig=;
        b=AwPqEv2mjHAED483701vpLJwl7tTaHlXHVeJGhKNEofY98geHAiN/+XWpdr9+qzimS
         3WX4wHXvUr/Cjh+9ZmBnXmt9mpvM+YWWDcPjCuzbeVS2k44npZj2zTdw8RdhXIZlzcdP
         1cz7thbIUX59lphPR89NT6+iESTqnQTzDCud6OBF3Rr0y4rtZyQzGYZPxx0O9DclZtqX
         akWfoB6Eu6GiFt7UHxIARjPGmDlqz9/yIWlyzsRScAORn9PxiwdqJAaz6oEJQvJmMIOz
         ZgMLnfDDrPuQBbtShRICC6nBX/jjf/mxfLsXAc+tQt84ohVXYId09U785LyE90kBwHez
         EWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689258295; x=1691850295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aA2VttawQoszyf0U4APyP5HFkEW0Co87mUTc0QbASig=;
        b=brxoilyLLp7ADpwOVBmcm+UQ8G1bBTJxm4DE07vA2Lv2DvFa2V5D2kQQ+clObNWX/L
         +GQv/vp7DNerSpTKjhkEDg/l0WNnGJ4uIsIKAeg6WDL7DW4c4Ah2BXlfsqM+nsRvGL2N
         fhUmsbMAADglEutBjrUNfktwh6wa3X2qHMPA/E451ddlwnr6GiFF9VAHvN0SvIdbgHB+
         NJHthA40yL/gKP3AjYbmFWdT/OlZN5lqEiMKKTaaCGsb9+hpsl4+QSA9lvV4CYiBhBHG
         EJBie0BAnIt4TORynW/xdOA58G3SaC29tCG7UC9ci/2LqaKI26MUw8094KgXLcsvxEZP
         TqCw==
X-Gm-Message-State: ABy/qLa+3j7DYNTa00Rt1L736XvWEL+bc+E7F4cK6jbMrUD+9VXoVl6/
        0rtpRWttKuBts4vn2XwP6nmAzNZ8wv94/4YyezU0Ig==
X-Google-Smtp-Source: APBJJlF36cTMeLQ0s4DACTSu0WPQHxg/uHDA2awUJsVA5IQDZTrQzRsNN33n+rAj+LHWtFWakhs9Ag==
X-Received: by 2002:a81:6c57:0:b0:57a:dc8:27b5 with SMTP id h84-20020a816c57000000b0057a0dc827b5mr1501109ywc.11.1689258294875;
        Thu, 13 Jul 2023 07:24:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y66-20020a0def45000000b00565d056a74bsm1784856ywe.139.2023.07.13.07.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 07:24:54 -0700 (PDT)
Date:   Thu, 13 Jul 2023 10:24:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 02/20] packfile.c: prevent overflow in `load_idx()`
Message-ID: <ZLAJNbIBFUPHYhlt@nand.local>
References: <cover.1689205042.git.me@ttaylorr.com>
 <d6902cd9e7f7f2a6b8044c8fb782a28c23e15600.1689205042.git.me@ttaylorr.com>
 <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5d2cf09f-34c7-9a88-bab2-8bf348dd13bb@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2023 at 09:21:55AM +0100, Phillip Wood wrote:
> > diff --git a/packfile.c b/packfile.c
> > index 89220f0e03..70acf1694b 100644
> > --- a/packfile.c
> > +++ b/packfile.c
> > @@ -186,7 +186,7 @@ int load_idx(const char *path, const unsigned int hashsz, void *idx_map,
> >   		     */
> >   		    (sizeof(off_t) <= 4))
> >   			return error("pack too large for current definition of off_t in %s", path);
> > -		p->crc_offset = 8 + 4 * 256 + nr * hashsz;
> > +		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));
>
> p->crc_offset is a uint32_t so we're still prone to truncation here unless
> we change the crc_offset member of struct packed_git to be a size_t. I
> haven't checked if the other users of crc_offset would need adjusting if we
> change its type.

Thanks for spotting. Luckily, this should be a straightforward change:

    $ git grep crc_offset
    builtin/index-pack.c:	idx1 = (((const uint32_t *)((const uint8_t *)p->index_data + p->crc_offset))
    object-store-ll.h:	uint32_t crc_offset;
    packfile.c:		p->crc_offset = st_add(8 + 4 * 256, st_mult(nr, hashsz));

The single usage in index-pack is OK, so we only need to change its type
to a size_t.

I could see an argument that this should be an off_t, since it is an
offset into a file. But since we memory map the whole thing anyway, I
think we are equally OK to treat it as a pointer offset. A similar
argument is made in f86f769550e (compute pack .idx byte offsets using
size_t, 2020-11-13), so I am content to leave this as a size_t.

Thanks,
Taylor
