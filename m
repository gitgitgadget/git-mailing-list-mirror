Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 374FEC76188
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjDCWRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233786AbjDCWRH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:17:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035F726A2
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:17:06 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id v6-20020a05600c470600b003f034269c96so8702882wmo.4
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680560224;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SXXVP+7caEvHXT7TqMMsegQn9ap5p1N37DKace1hWCI=;
        b=MksfXNVfbKlVA8OpjMc6sMx6OycYYW2ml1EjaZQ5ItTxCVz/BRU8DIVntBdGRBdScy
         nX/wIKBm0OenYFeun89oBroSegiHHYyTaRq5Bjcbm1ZPY54vDz/oMHd1dRGgKL9XuukM
         nokXJao9oLui1uprjqEhgd2BfBDeRlXjXhBqmfxunQmv5Jsn57ujG0SoOKLDKX+T0CBZ
         x/fNupooKLMH+APhCSk3rP0ynfOlDgGE36YAx7nGjjASTSzve2mOUw0Z/3vGXH1d0AQR
         NJ5z/AVZOvOquRcrcQg0LrsL+dDAOEQfP2ZDpFG5m7Lsv3Aa4XaXdTK2reB9a7p+YTOO
         FUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560224;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXXVP+7caEvHXT7TqMMsegQn9ap5p1N37DKace1hWCI=;
        b=i7GVEgszvdjQFzPLr+dov/ZN9EElspfq1lipgxm3GXUtKXwmIBmc+yfd2jXYsw5caq
         mtjMMqvf/dALyBEk2XS2zkip4lepEDJfcflOKu60n8zr+JfS5zzia+ORhiwP2SCOcUhG
         HzNOYvZUzIpekSWd6Vwd8HBYkUnT1QeoWdUhFCOpkswvB2qYanptYn4P7UwFgOJVqXLO
         ro1EbkdULfGMzNna08lw/FcwF6ky7QNiuE3o1faPFX8dghGcxmLyzrDcGiBvBxe7Z5B7
         DuqrnARgix9EqX+YjY4SFUdYQiguEZdxIIfkmYgAVBoGzTdt6gB5H6bW0a2VtZWUq2sj
         fKYw==
X-Gm-Message-State: AAQBX9eb6lE8TmuKnsAdMMle8UsFeuxEemUUytN4xxxrPJQ4k940ZLfp
        pf/vF75gsVGO8BoJqAbc4tgDG4stDOLo/pyRhjY=
X-Google-Smtp-Source: AKy350YXcaTQHTg/A8yBo2SqbmuroVAPSciCfH3VrXLgR8gg/FEu84J/I0od6jF8M6l6HVCDqmTj0nGZ3RDcEcFEGfk=
X-Received: by 2002:a05:600c:20f:b0:3eb:5a1e:d524 with SMTP id
 15-20020a05600c020f00b003eb5a1ed524mr228866wmi.3.1680560224396; Mon, 03 Apr
 2023 15:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230402000117.313171-1-cheskaqiqi@gmail.com> <xmqqilec4ra0.fsf@gitster.g>
In-Reply-To: <xmqqilec4ra0.fsf@gitster.g>
From:   Shuqi Liang <cheskaqiqi@gmail.com>
Date:   Mon, 3 Apr 2023 18:16:52 -0400
Message-ID: <CAMO4yUGnkR5Jj5m52LXb9+LQUcJyjMW_RcFM2dzALAaKa064dQ@mail.gmail.com>
Subject: Re: [RFC][PATCH v1] write-tree: integrate with sparse index
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2023 at 4:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> Has the test suite been exercised with this patch?  It seems to
> break at least t0012
>

Hi Junio

I commented out the 'test_perf_on_all git grep --cached bogus --
"f2/f1/f1/*"' before
running 'p2000-sparse-operations.sh'.  I did this because I found that
with its presence,
even without adding any code, the tests wouldn't pass.  After commenting it=
 out,
everything worked well. (In the patch I submitted above I did not
commented it out )

Thanks
Shuqi
