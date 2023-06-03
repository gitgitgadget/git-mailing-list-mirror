Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160A1C7EE2C
	for <git@archiver.kernel.org>; Sat,  3 Jun 2023 02:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbjFCCEs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 22:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjFCCEq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 22:04:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB19F197
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 19:04:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3b9755961so3721832e87.0
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 19:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685757884; x=1688349884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WEEbBSSLwFWrQF05yOYc9CcfUT0556FNnbLddwtIdg=;
        b=W+LMFKz0MIyUGmSB9dLCWp/B2xMSr/Z6AYyp+Nnc9myJGeKEJ+bfReQ+Of9zG02Wo8
         AwlKOcOIEgzhbooIJGMhW3+Z21hodThYrSypWcCbSPLJttm7dGx/uqFKRpu23oa1wBlB
         p3RDsGMYCRu3pPpexf7/bkNc1HTmf0t85TEGjIixNvZMsTEDzSIzCjayRl9pTtyojPua
         MmYyW/WELNR6RYtAuGsVX6L5P4XL2LNbeMk5+V+pr+B2IYKNHtpn0J8CUKQyyVaJGHDC
         f5Zjf0VxFpItT6JivPL6u2ItD2AgspNhQkboQIe9TNwqWn+2zd69DevDhP7ga/ZseESo
         6cKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685757884; x=1688349884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1WEEbBSSLwFWrQF05yOYc9CcfUT0556FNnbLddwtIdg=;
        b=lNxfx8ILjncFw/9csz5QaSV7hu042OsjJH+Q5ihdLUzMxRn2SkXgWLpiPlxzjQtO4p
         RUeDCmuY3RPVKFUgaXPbUb/RAjMg7nfG9zzhA67lF3a22k7ajHQRiqTSelhgB9VYVydF
         OuOn2AUj8fETuabFix3Z57U7QbSXVGE3B3bWbv0NAIBpXyw/Aey2XCxVcjVrZuwMbAvu
         PQ4JjsSiO0OLrEhhzF+UM/PUAoBzactNOK5RIm1pkflX0/vpW7xJUKJR042W3Ucp//vZ
         OulbX/06k1/tFoiL+TVXqjN6omPxOs1hW2/lHWXGm5Z+mIk5FbJwMOYd/El4IKmcWxhF
         83XA==
X-Gm-Message-State: AC+VfDw2jEGs3xqqpYuDpgUVhggjFcHXj93Jw3TzJNcIwpM1A3wVPxnl
        3tf9042ziSP+obcduv3+H4u5FMsyujLSNdldJC0=
X-Google-Smtp-Source: ACHHUZ6LcNFchLUs8tFIO2uko0MKPTz27KQZeta5wG97Dl8NvuoMfnF82SW/cPJQ9gF69qi/O+R0wkv3V/hM2m13ir8=
X-Received: by 2002:a05:6512:78:b0:4f4:c7ed:8586 with SMTP id
 i24-20020a056512007800b004f4c7ed8586mr3123900lfo.2.1685757883829; Fri, 02 Jun
 2023 19:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <CALVMLfLw4P=VnBOYA-WbHRNPZiAiO05h4k+cSvPJuaqkjgp5ew@mail.gmail.com>
 <20230602192700.1548636-1-asedeno@google.com> <xmqqilc571hf.fsf@gitster.g>
In-Reply-To: <xmqqilc571hf.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 2 Jun 2023 19:04:31 -0700
Message-ID: <CABPp-BHZ6a8VEuK=miMAcBG9RbUz+epuQ+d1xvwbRj_tsnYqcQ@mail.gmail.com>
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Alejandro_R_Sede=C3=B1o?= <asedeno@google.com>,
        asedeno@mit.edu, git@vger.kernel.org, sunshine@sunshineco.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 2, 2023 at 6:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Why does name-hash.c end up with two definitions?  Aren't we
> properly guarding against multiple inclusions with
>
>     #ifndef __DIR_H__
>     #define __DIR_H__
>         ...
>     struct dir_entry {
>         ...
>     };
>     #endif
>
> or is there something funny going on?

There are two _different_ things named "struct dir_entry" in the codebase:

dir.h:struct dir_entry {
dir.h-  unsigned int len;
dir.h-  char name[FLEX_ARRAY]; /* more */
dir.h-};
--
name-hash.c:struct dir_entry {
name-hash.c-    struct hashmap_entry ent;
name-hash.c-    struct dir_entry *parent;
name-hash.c-    int nr;
name-hash.c-    unsigned int namelen;
name-hash.c-    char name[FLEX_ARRAY];
name-hash.c-};

So, name-hash.c cannot include anything that includes dir.h.
