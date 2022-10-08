Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8214C433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 03:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJHDfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 23:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJHDfv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 23:35:51 -0400
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4172B03D5
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 20:35:50 -0700 (PDT)
Received: by mail-io1-f46.google.com with SMTP id 137so765237iou.9
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 20:35:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y12C/MwK6ukAzPJ/HL765pGxgVlZmx88pBl8U5VpVJ4=;
        b=vg3RP7NqoMVf0rDWDk8WgawVdN2inj2cvrsRr4Ygq37x1KqLZKBq8y9M2lJ3JuVPk/
         YV5Fjq5k/4QWbvWWbAp8//HBvij8H8ySdwtRhohqb14/mPpUAz/z6byIf4ycpdL7FCcl
         QxN5zV0nTx2h0PdohMOG2ng8vXWu8Aptc/l38SE+ZM1akhiI+F6bB6iHO020k+e3cdVZ
         83UCQt1XvF4QhuVaJwHl8bF9FG3aPsWRA48B47AfOofGcOwdlB5LS5XSRj5JYXme+RSx
         +q2n3CsvThDdlRdLcbx/fr2fM24I7fbrrIEhxqyJMUP08QIy0oC/5RqRucUvCXbsejFz
         wYeg==
X-Gm-Message-State: ACrzQf3Uzg0AWjFCv0jzpMAGcp6XBW8yeFWal1tN3GcPOckWLQ++rPGI
        4kQxJH1pqPjyj7t0E8Ax4H/X0CdeOUhQTY5T0BNdEM20BqU=
X-Google-Smtp-Source: AMsMyM4jSzVPSWy0JyELnpwHayaoYqmI+5B0aKK4mYcrLI3EraVbJXCOkZVzID58nqp6vgWJzZqInuowa/us6aUoxg8=
X-Received: by 2002:a05:6638:2602:b0:35a:66ec:8d99 with SMTP id
 m2-20020a056638260200b0035a66ec8d99mr4380903jat.170.1665200150271; Fri, 07
 Oct 2022 20:35:50 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqleprcn08.fsf@gitster.g>
In-Reply-To: <xmqqleprcn08.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Oct 2022 23:35:39 -0400
Message-ID: <CAPig+cQZ_SehTLoFEtBf2Xv=8iw3-DkjQfP3R9J8kUm3DjkLBw@mail.gmail.com>
Subject: Re: [PATCH] symbolic-ref: teach "--[no-]recurse" option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 7, 2022 at 6:19 PM Junio C Hamano <gitster@pobox.com> wrote:
> [...]
> One thing that is slightly irritating, however, is that I do not
> think there is a good way (other than "cat .git/HEAD") to learn that
> you checked out 'maint' to get into that state.  Just like the output
> of "git branch --show-current" shows above, "git symbolic-ref HEAD"
> would report 'refs/heads/maint-2.38', bypassing the intermediate
> symbolic ref at 'refs/heads/maint' that is pointed at by HEAD.
>
> The internal resolve_ref() API already has the necessary support for
> stopping after resolving a single level of a symbolic-ref, and we
> can expose it by adding a "--[no-]recurse" option to the command.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/symbolic-ref.c  | 16 ++++++++++------
>  t/t1401-symbolic-ref.sh | 14 ++++++++++++++
>  2 files changed, 24 insertions(+), 6 deletions(-)

Should this be accompanied by a documentation update or is the patch
intended as an RFC?
