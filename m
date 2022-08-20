Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2BC25B08
	for <git@archiver.kernel.org>; Sat, 20 Aug 2022 18:40:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiHTSk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Aug 2022 14:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiHTSk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2022 14:40:56 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B33D44556
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 11:40:55 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z20so9147080edb.9
        for <git@vger.kernel.org>; Sat, 20 Aug 2022 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=wZ6LYt7CuvrjzMEqgVHHkvCu/zfQC6rhOZzbZIG7X4U=;
        b=Z8L1fIYkUPrMJNModRiqUSAIXB1/MJs3MltE7pwy++8vAaA/HlAoiLsRmx4qmVB+xw
         pTbElbRuWDc5+vtGlC1TOH9QbO+A3KK9IIjk0cdmBW1gT4S4YsT6wwvba/2QNQ7YwSRB
         e+hXYjrGWOJIg5dEicSXQtHCA2orXRuDY4NT6sckHY7I+ei2vwWDWThSTXwgCx4SvQ3R
         /aaPCpGRpMMQp79wG6vVG/yoZLeMe3CX+s5ASB70JuyJmeS8+rn6Neeuix8rFQHnoVRE
         VrG6zz33HeZM4JaBPEtg7VmdAfGJnfhph0mEWGAqghmfFDqHZ2W7UDcR+yOdvi9pdDiT
         lRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=wZ6LYt7CuvrjzMEqgVHHkvCu/zfQC6rhOZzbZIG7X4U=;
        b=35v+vr3qdr79/pShCQ6aJTb1VVA28ETNdDnCqP8gMD/W/3xB5QR6UAnIS8XwBpvZMK
         QOP5OY8PWhabPbXH2sQvRRcuBNxupZkZcybbux6BzA8uzh2u27Rh6u+hcliXO0aD7ojZ
         +5JGLASYRDNH91JKrne8Ym6zkQlDalhbrL+PhGCbQvyvgtSm1HMJKZy2+0ChbWFsj8nX
         Txosgga5JnuJWWvDJz2vt/TpofPnoeHTkxyJdrH0bVHRZYC7SOUhzDNLT2gmJ0v6k8bm
         5sbb8E69aXDSOfBwaZ1TKDoaEvJmRFIrwCtgGbyKe1xiZaUXZG/I2dtl0c8ser6FKS51
         LL+w==
X-Gm-Message-State: ACgBeo2fTa9gYAsrW6vN+nmq0R+C017eDPxFjxKtZodgbPWi48mTZ3dV
        hjL9FrZyu9ILfpnIqkDxTkqVQzz/FR/OXxlD3sc=
X-Google-Smtp-Source: AA6agR5PQE2loiQek1fMzK78pSb+nmEao37vEmc8iM1CgMhV0nPEZ1/+NJxSVFjkvSR0K8VS1rwJD2r/b9IXj3hIQ8A=
X-Received: by 2002:a05:6402:14e:b0:443:f58:17e9 with SMTP id
 s14-20020a056402014e00b004430f5817e9mr10473881edu.106.1661020853500; Sat, 20
 Aug 2022 11:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660944574.git.me@ttaylorr.com> <4ddddc959b042faf7ae98a8e8eaa05e77f9ea23e.1660944574.git.me@ttaylorr.com>
In-Reply-To: <4ddddc959b042faf7ae98a8e8eaa05e77f9ea23e.1660944574.git.me@ttaylorr.com>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Sun, 21 Aug 2022 00:10:42 +0530
Message-ID: <CAPOJW5zmbQ966KXjaEvxk-oHu01BsxwszUTu3et4SYGFCAegCA@mail.gmail.com>
Subject: Re: [PATCH 6/6] midx.c: include preferred pack correctly with
 existing MIDX
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <derrickstolee@github.com>,
        jonathantanmy@google.com,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 20, 2022 at 3:00 AM Taylor Blau <me@ttaylorr.com> wrote:
>
> +               if (-1 < preferred_pack && preferred_pack < start_pack)
> +                       midx_fanout_add_pack_fanout(&fanout, info,
> +                                                   preferred_pack, 1,
> +                                                   cur_fanout);
> +

All the other changes make sense to me but I have a question about
this particular change. Instead of adding all the preferred objects
again (but in this case these are being added from preferred pack) in
`fanout->entries`, will it be better if we call
`midx_fanout_add_pack_fanout()` function from
`midx_fanout_add_midx_fanout()` when above conditions are met?
Something like this -

    static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
                                        struct multi_pack_index *m,
                                        struct pack_info *info,
                                        uint32_t cur_pack,
                                        int preferred,
                                        uint32_t cur_fanout)
    {
     ...
          if (cur_fanout)
                start = ntohl(m->chunk_oid_fanout[cur_fanout - 1]);
          end = ntohl(m->chunk_oid_fanout[cur_fanout]);
          if (preferred) {
                midx_fanout_add_pack_fanout(&fanout, info, cur_pack,

preferred, cur_fanout);
                return;
          }

          for (.....) {
          ........
    }

It may reduce some extra code work but also could decrease readability
of the function(may be). What's your thought here?

Thanks :)
