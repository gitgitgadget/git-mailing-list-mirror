Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B44C43217
	for <git@archiver.kernel.org>; Wed, 16 Nov 2022 14:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiKPOyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Nov 2022 09:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiKPOxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2022 09:53:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C972D754
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:52:50 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2613248pjk.1
        for <git@vger.kernel.org>; Wed, 16 Nov 2022 06:52:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ANP6hlwQTnShiisIb/TK41UFUL2Flv2dhQziuoh5aiI=;
        b=pDmdzSsm2BHslNn0oHKaIfbpgIMAj4XXy9OA919lGB+pYmaHURJ2k8zg+VWplaeb/R
         NnIqElBdVmEQT5AbfsbwAxFJSLp/TG0XTJWl/Ujnh13S2SXP84Mr+AZaaZutWnddbJLV
         lG1P+jJJMGldbZ9p1weyF/Baw2zT6QKLlHp0f14o0G2GjcI43ogu3HCcCm+HaQ57AlMq
         7PyXvEGlGPLFWsqSLepx9yiwuai6lTxY5aU7TgQgKc5jEOH6V6NmUijdPfeNyGzrH/Ky
         dvuQhTNMES1LY7KmKwS+hTO+94ZEx7BHQOXtuYBj6m/S7kegg6awd20tUyfQETKbQcEa
         y8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ANP6hlwQTnShiisIb/TK41UFUL2Flv2dhQziuoh5aiI=;
        b=gcMPRRbPfYe0dYrMIPyxzniRlcGnmMTPwHqeNfa8blaMeKT+3lFx/FLrXpzRH3qT2o
         j5N9uyGDiiDnLDO857eGIC/CTQAGiCvqPXBcay0nc7EWLGjcHr1G3z2ot+LshwXca8K+
         d/C24fBaNmjPBXSjuzupJkFWr/7iXlY1O4cxqERr09bnwgozSuaQwO7yEPQ1f1PEVR4n
         Vw+3pvRAMvhujBjyowrsz3sJeK6KTPgxjJz4YozMx2c+EBu3dDtCHy6JHdZvTDFQO/Pu
         Y7HgKoZ93qMW0B0C6g6KQxqa3iAHgDCjSOoHAdYU33/ApPrjEqkRB1HS0+sfu5ta8bMk
         Qj8g==
X-Gm-Message-State: ANoB5pkku57RspCshf9mEwaNDTroOSfwytfn7obhmah+SKpRya20y7oE
        rUwG7y5RBDKt7JUW+ia6sVg=
X-Google-Smtp-Source: AA0mqf7wCzxeTPfp1axW+nc7ECpDU2mSSOhiz6Xo55kkJgbBlavGdBVrZF8c+vCmGrr02TAnTK5VuA==
X-Received: by 2002:a17:90a:f684:b0:20a:df72:e61f with SMTP id cl4-20020a17090af68400b0020adf72e61fmr4162678pjb.87.1668610369636;
        Wed, 16 Nov 2022 06:52:49 -0800 (PST)
Received: from localhost ([2001:ee0:4f8b:a070:2a99:1bbd:b117:5037])
        by smtp.gmail.com with ESMTPSA id p4-20020a622904000000b0056d73ef41fdsm10926675pfp.75.2022.11.16.06.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 06:52:48 -0800 (PST)
Date:   Wed, 16 Nov 2022 21:52:45 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect; remove unused "git-bisect.sh" and ".gitignore"
 entry
Message-ID: <Y3T5PQmrIHrV9m46@danh.dev>
References: <patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-7be23b6faa0-20221115T093130Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022-11-15 10:32:42+0100, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> Since fc304fb52f9 (Merge branch 'dd/git-bisect-builtin' into next,
> 2022-11-14) we've used builtin/bisect.c instead of git-bisect.sh to
> implement the "bisect" command. Let's remove the unused leftover
> script, and the ".gitignore" entry for the "git-bisect--helper", which
> also hasn't been built since fc304fb52f9.
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
> This goes on top of "dd/git-bisect-builtin", which just landed in
> "next".

Ack,
Sorry, I forgot to remove it :(
Other than the reference for commit, looking good.

-- 
Danh
