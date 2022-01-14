Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A612C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 07:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234269AbiANH7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 02:59:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiANH7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 02:59:13 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 016CDC061574
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 23:59:13 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id l15so15526665uai.11
        for <git@vger.kernel.org>; Thu, 13 Jan 2022 23:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hhKRsATZdEg9Q95S3i+aIn1AdsGPnmWuJ4MZRNRuXDg=;
        b=M4O8a+2SNnYzh4AhW6kqjwH322gZ6W1I41ykZa8+QrYV4kArsC1u/O93Q5icrVxFYF
         46p+IRGDAYCmVkeBpCxhvYui37D9KBNGPlJT0C2w8aGIfuYpNhDH6aLvS++UoolhTzUy
         ZDhBW8EpFuLkkTaG4ZinPVC3bhH22PHXZT/LIn+lLr+wc0hBB6WNKFuWlDHDY3xaNDSV
         3/yJh84DShQdWCfIiVtyoOfReRVbcwddNzrZ3dgdTWvMTQqmthDxCDKIOqvhEI3CYqU6
         ys0oXOk8jb/EhSws5o5S7Ql6L1ym8eGTsWOVmIIPSx5S617ZXZQQt9cc7X5S+rFWfozK
         uO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hhKRsATZdEg9Q95S3i+aIn1AdsGPnmWuJ4MZRNRuXDg=;
        b=RoMjlrtMB/u5W9vNr90gwBIWx1JC4ksLcODQIN/ZM/BT8OUn76PMu74znTw4TdWRw2
         raBd0B88cKHFg0nDT4cwf9IyPL0JcEanWXEzxtPYOAr7xkJFtuUvLO2qBnIN0DHjO/e/
         URGk1J/U8Aj2XLz4ba8PgfaUt54jJW37J6El3W6x+Vgp30kc+KYYsAmiFCCNs+YiY1yl
         IvQUe+Z8zeM4I51J41mdxv0s9Dc6o5z193Wf8n87y+wiDzdHPfS8DqIQfTY2DA/mhTqu
         3h29uaUAZunUINRz2Bm6II9G0BgEO620CESflfkAvbxrrP/PFIKnYoeIpHz2oo+eK86J
         iPMg==
X-Gm-Message-State: AOAM531vU7V7dXfHo8xSNH7NaLK4WteEYvNJ6FjdHRC/qonNtPjFec8A
        RFfNLDvX7+5hBXD8jW4mXplvGVaxy5fKVakGhzw=
X-Google-Smtp-Source: ABdhPJz8OoDUmiUowJmiq5M4Xs/w04Rzgxc3/tFFtPvTC5p7qksOG55ZzPqaG5iPlGPuhmWEWScl35y+n9DynDS3VQU=
X-Received: by 2002:a67:d615:: with SMTP id n21mr3954287vsj.43.1642147152035;
 Thu, 13 Jan 2022 23:59:12 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641978175.git.dyroneteng@gmail.com> <b04188c822c32aab6ef59099a0c9078aeda065c3.1641978175.git.dyroneteng@gmail.com>
 <220113.861r1cxgxx.gmgdl@evledraar.gmail.com>
In-Reply-To: <220113.861r1cxgxx.gmgdl@evledraar.gmail.com>
From:   Teng Long <dyroneteng@gmail.com>
Date:   Fri, 14 Jan 2022 15:59:01 +0800
Message-ID: <CADMgQSQ3oWAbDMK73hEwZKJHhO_k8CuJdC2TNWW0+kv1TzYfRQ@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] ls-tree: optimize naming and handling of "return"
 in show_tree()
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, tenglong.tl@alibaba-inc.com,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Teng Long <dyronetengb@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 13, 2022 at 2:55 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:

> Re the $subject: Is "optimize naming" here just referring to the
> s/retval/recurse/g?

Yes.

> Personally I think just a s/retval/ret/g here would make more senes if
> we're doing any change at all, and in either case having this variable
> re-rename split up as its own commit would make the proposed control
> flow changes clearer.

Do you mean that I can split the current one into two commits,  one does
the renaming work and another one does the left work?

If so, I will do this in the next patch.

>
> This new function is a re-invention of the object_type() utility in
> cache.h, and isn't needed. I.e....
>
> ...just drop it and do this:
>
>         -       enum object_type type =3D get_type(mode);
>         +       enum object_type type =3D object_type(mode);

You are absolutely correct.
I will replace get_type() to object_type() in the next patch.
