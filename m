Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4757C76196
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 16:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbjDJQqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 12:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjDJQqT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 12:46:19 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B88199E
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 09:46:18 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id o1so7130708lfc.2
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 09:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681145176; x=1683737176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YswnB+fr1IdiOjLZTT/GUe7J5btV5HxBrkEZT5Aag8I=;
        b=SHMx1T8qLueuXwMnEXcdYW5WTMl2aplwF4OgtIGKcnOch7U9XymuzaxmGsR/pNFqfQ
         ZSmRyzdY0KNIhMOdi3wnrTUZc8a0e2pFUqjpJGBIWiTn0Z4vUy6SllcKmuBd16ZQ65MV
         Gf/EJWM74PyIGPQ+2Ls9KWOca97Lo3NLv9dnwiiX8iwhEjJ2n8y4SxPCwWERqxuwLhJv
         BUrs36CgDD+aJS6C64UXN6elmIyuGzFI8Z4iOSkZzN2LA6gYaivUNN5AV8bMXxlHNRgh
         c5ne0UdBf/lZoAGSFA0Zs85QZ6Vi25md4wVNeYIYYRNRtzd+9KVzbNmXbBHi63XTyfZc
         w0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681145176; x=1683737176;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YswnB+fr1IdiOjLZTT/GUe7J5btV5HxBrkEZT5Aag8I=;
        b=wee9lYvDd9KSnOEFgHtnJjySevgmQlP5gAhB4Y7JXffEDEjLAdEXJv8HhK4i7awABO
         UHevLfMmSCSeZnAsOVHTwfrLpVDv0xxp/WRMIN53xamn7+9/yPeBuD6gRa+Q8FHjiOZG
         msuppiIFcQnkPeWB+3ojfa8RMWrEwc1jtmOdpUnQ7G3D5j6CzE9k+y+6gWOUXCYzofhm
         K0xLOW+w0CoAFaRMLHKclgt+uQfKBsQvZXr57cLh74DN5XzNTKeQv2Eb14+2LF10WRae
         acRUu9VqjJzJkhF2iJa/S/uF2hXr0qVHU8bHdM3qghIcV7HZ3M73KUKvE3Jvrv8vqyWm
         2Egw==
X-Gm-Message-State: AAQBX9fSkFXKUOt4n8/sKgj75nYXukSbH+LhPquUh1bIO/6UxXU/m6Ef
        73k2gvSZug9bm3I7zqlbLS6aOVeowECbg4tvNw0=
X-Google-Smtp-Source: AKy350bVMwLnHHn1lt6e+Gt7T2GnEPQT4a0w4Vi0Pd71/l/phIpEo/By7rkDSBK8JmehGBWeCsTquEfyAhDj9VYFKlo=
X-Received: by 2002:ac2:5188:0:b0:4d5:ca42:e43e with SMTP id
 u8-20020ac25188000000b004d5ca42e43emr3134268lfi.7.1681145176415; Mon, 10 Apr
 2023 09:46:16 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1678893298.git.phillip.wood@dunelm.org.uk> <cover.1681117706.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <cover.1681117706.git.phillip.wood@dunelm.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 Apr 2023 09:46:04 -0700
Message-ID: <CABPp-BGUa_Aot_2iPmTWh1KvuL7mS4OSwXX-ArqgFSd8nU-+ig@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] rebase: cleanup merge strategy option handling
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 10, 2023 at 2:08=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Cleanup the handling of --strategy-option now that we no longer need to
> support "--preserve-merges" and properly quote the argument when saving
> it to disc.
>
> A hopefully final re-roll to fix a memory leak I spotted in V3.

Doh, I clearly missed that leak too.

> Changes since V3:
>  - Fixed a memory leak added in V3. The array returned by
>    split_cmdline() is allocated on the heap so we need to fee it. The
>    array elements come from the string passed to split_cmdline() so do
>    not need to be individually freed.

And in particular, that string that stores those array elements will
be freed by the strbuf_reset() that comes immediately after the
read_strategy_opts() call (read_strategy_opts() is the sole caller of
parse_strategy_opts()), and the fact that the string is freed is fine
since your parse_strategy_opts() passes them to strvec_push() which
will xstrdup() them and then own them.

All that to say I agree with the fix.
