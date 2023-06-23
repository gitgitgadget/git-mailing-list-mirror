Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F741EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 20:57:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbjFWU5e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjFWU5d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 16:57:33 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A128A2114
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:57:32 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56938733c13so13859057b3.1
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 13:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687553852; x=1690145852;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=05OoIW7S0x7UYOA3FoSMWBsE5OAbW60fDyXpQLhdhmc=;
        b=zwva6wYCkBp57+y1WhfgRyw6/opJWYg4QY7ROjqOaK+PKZgaZcE27zeZYpxcL/kbaR
         miC58vtsoR/Y7eNKhip5cypluD4uOrcmW1FehxanRaDxQMPGD3wubkpyp9zSe15z8Vxu
         qlAxaZjh1Lde5zzy0ioHv49jJckMytJqYeR2SDVOqT0AMPx14fyqj0ybQXZx8pCcdJN6
         S521oDYMx1beukDLG3zgGOQMZQCfqq1K2pzEbK4iqEdBfcFoHtnsQtC+wiVVSso/e2Jg
         1kYaCjHh3PiDEUVeOb2aR7Rqojgy+9AC3vzlOEMsYGn8dtUSRlb4ayL+fdwnymmS/I86
         jN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687553852; x=1690145852;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05OoIW7S0x7UYOA3FoSMWBsE5OAbW60fDyXpQLhdhmc=;
        b=gnJf40EGHSWQBytp5dA9mo3MbkzSpXhZ+crqKeA3Bmh+fT+WaM6alrTsZ+Ev0H3Gzt
         gXULaqbe70fRaCdjFE4aoKKQcGBJ+FFmfcPYOIeagTH01gaMBJ35x/PEUhvRTDeig/Zi
         LYPZEAkqM8KnX/l8edNA9kQuB/MLwtDCv3vVOKABzUzHx+isDksikHShI30+oW1Us2pr
         pfrn7mYMQXIRXbHNbizsjlkgfXRatwHiO9La1BZ8/9wTHRzbn7RHw5CUQzxa5NPKG8IX
         EJwhcMa6C8pr/rVMF/mzWpe2nY81AcyRzB9z0uPQIR8bFCJwVHKtoxiow4tSujEMg0YK
         2BJA==
X-Gm-Message-State: AC+VfDzeNYv715b2bCiL+exm1jDfipO4g2+RQVxoCLZq1REQQPQ0Z8S7
        ZxSEV3HWvYAqhe5n13G/YWTp+7DFo02itAin/+38
X-Google-Smtp-Source: ACHHUZ6Lju92YL0aUr3WQI3WtNk7n+mfoxIA7zmMuW+cTYw2UITH37XwoATps4rALUbkKwZXNncNdHQMIcPm2T+8JRAv
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:7ab2:ee09:eab1:38cc])
 (user=jonathantanmy job=sendgmr) by 2002:a81:bd05:0:b0:565:e903:6ad9 with
 SMTP id b5-20020a81bd05000000b00565e9036ad9mr9187525ywi.9.1687553851951; Fri,
 23 Jun 2023 13:57:31 -0700 (PDT)
Date:   Fri, 23 Jun 2023 13:57:29 -0700
In-Reply-To: <8ec24b018e9a8a0767b1811aeb604eb97647bb4e.1687290233.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.178.g377b9f9a00-goog
Message-ID: <20230623205729.3258822-1-jonathantanmy@google.com>
Subject: Re: [PATCH v3 10/12] config.c: remove config_reader from configsets
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
> @@ -2429,11 +2427,7 @@ static int configset_add_value(const struct key_value_info *kvi_p,
>  	l_item->e = e;
>  	l_item->value_index = e->value_list.nr - 1;
>  
> -	if (reader->source->name) {
> -		kvi_from_source(reader->source, kvi_p->scope, kv_info);
> -	} else {
> -		kvi_from_param(kv_info);
> -	}
> +	memcpy(kv_info, kvi_p, sizeof(struct key_value_info));
>  	si->util = kv_info;
>  
>  	return 0;

Ah, I remember seeing this memcpy from the previous round, but forgot to
comment on it (I only commented on another instance, [1]).

Other than that, up to here looks good.

[1] https://lore.kernel.org/git/20230601233550.429921-1-jonathantanmy@google.com/
 
