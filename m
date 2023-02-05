Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 338F7C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 21:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjBEVIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 16:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBEVIt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 16:08:49 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D727AA5
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 13:08:48 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id lu11so29118738ejb.3
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 13:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7HeREuBKMJXPjsWCKgq8f0gfZUOa91sF7eDHQzPSNL0=;
        b=gkasXzOD5f/X40gB63TQwaazcvgxNHePnmhQjrYJdj2WiOksgovMWEaDuXGT4uw3Mn
         bt085NbcRfTG3aVQTI739FGJ7Z7sJxdIgv64/9WVm8/L9p9aFs4G80TWOSWiOWb9uNr+
         PcRF+rEAeibPrwgDinxpysnxw9y1JnRScfWCP8CpE0aSBjmJ1ayL72ua1IU8k3Rmp4Dh
         DvbMqDp9ICczBgIv2m+x1OJ+PKwezX5D1gfle7zKdGd8zMm61wMcIe6jcVrozUVryDcx
         623OqF4Ww5yxE2sEVmCu5yaFePlc+xpEDZrNPfs/XI1s1pRgSJr/gs2PjKhPIx/1plBN
         ImiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7HeREuBKMJXPjsWCKgq8f0gfZUOa91sF7eDHQzPSNL0=;
        b=iDFP+uCyuuv7exDkIg4JQh5GgWnKwP0jJ7PAVLuZFjqAG7lRq9Cp/btVVe3a5Mra3Q
         yIDWT9oq0eM8K3UZ0ACCzHA9yPACpm8WEPB5Waus9oMw52efxbpPFgvg7FKdvmdk1dic
         YLC1i7aMDdu795PTzVZNSVpigkzhYq0rra0Ff1UZTrR/SyRiI0N35k8u3yiGy/XcWw+T
         BJkthlhvAVcXK9OF3JAg7h4KOVTOsNupK24HdSwDfDg18D+LlDEVjen9+3UlF68wJxpF
         M0Pk0cyaW/3gquhe55pV6jL4sG2+CaTFGm1gTRbEDUGHv4vAKqFnmjbRZZKsIVH2CxZH
         Qaww==
X-Gm-Message-State: AO0yUKVxbphSthjPmj3qxuaoQHu6hqalxFskMuswRAnLXVYYv8gtwFP2
        zlFZ9Kg2yZFoP6c0kLQtCt0=
X-Google-Smtp-Source: AK7set+7aHjj9hRRBB85XlPsBixcIdQlAFVQcp0pNA/fpbrhhKRa2jBszY9XqGmSYDp31JS1DdQLOA==
X-Received: by 2002:a17:907:3e82:b0:878:6755:9089 with SMTP id hs2-20020a1709073e8200b0087867559089mr24046006ejc.39.1675631326604;
        Sun, 05 Feb 2023 13:08:46 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id e15-20020a1709062c0f00b008964fdd5bbfsm2107109ejh.155.2023.02.05.13.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 13:08:46 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pOmFh-0006Zo-09;
        Sun, 05 Feb 2023 22:08:45 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: use strcspn(3) in name_cmp_len()
Date:   Sun, 05 Feb 2023 21:59:10 +0100
References: <7315487c-c97c-b8a2-d3b2-4fbf642495dd@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <7315487c-c97c-b8a2-d3b2-4fbf642495dd@web.de>
Message-ID: <230205.86357j95wj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Feb 05 2023, Ren=C3=A9 Scharfe wrote:

> -static int name_cmp_len(const char *name)
> +static size_t name_cmp_len(const char *name)
>  {
> -	int i;
> -	for (i =3D 0; name[i] && name[i] !=3D '\n' && name[i] !=3D '/'; i++)
> -		;
> -	return i;
> +	return strcspn(name, "\n/");
>  }

I wonder if this name_cmp_len() is worth keeping at all. If all we're
doing is wrapping strcspn() (which b.t.w, seem to be less "open-coding"
and just that it wasn't known to the original author in 5d4a6003354
(Make git-pack-objects a builtin, 2006-08-03)), then just inlining that
in the two name_cmp_len() invocations would be better, or maybe:

	strcspn(..., object_reject);

Where we previously declared "object_reject" (or same better name for
such a variable) to be "\n/".

>  static void add_pbase_object(struct tree_desc *tree,
>  			     const char *name,
> -			     int cmplen,
> +			     size_t cmplen,
>  			     const char *fullname)
>  {
>  	struct name_entry entry;
>  	int cmp;
>
>  	while (tree_entry(tree,&entry)) {
>  		if (S_ISGITLINK(entry.mode))
>  			continue;
>  		cmp =3D tree_entry_len(&entry) !=3D cmplen ? 1 :
>  		      memcmp(name, entry.path, cmplen);

The return of tree_entry_len() is "int", so that's a new implicit cast,
but that seems OK in this case (and the "namelen" is another thing we
should convert to "size_t").
