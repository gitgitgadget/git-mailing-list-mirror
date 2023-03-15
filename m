Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB81C6FD1D
	for <git@archiver.kernel.org>; Wed, 15 Mar 2023 22:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230467AbjCOWpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Mar 2023 18:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjCOWpd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2023 18:45:33 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 942F8158B7
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:45:30 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id nn12so20501424pjb.5
        for <git@vger.kernel.org>; Wed, 15 Mar 2023 15:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678920330;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PkU9y1PP2PdIJmrv74RWtKSjRooXkQ8vFdHDOyb3AFo=;
        b=py13b+Y99PHNXm8WzsYIwZ7iDS7yGIKouqm+u9KNHA/BpvFSZoDmOdbYPnjJiw2jOO
         widP5DRplMH5y+Oe5+wVqW+A27yCdrXKhS1Urt/t3e4i/8Jo1KV4NHefOhLz2/tPUtf5
         SZ9hee2F9lolHQD+LvJmJhCrmaN520C1aXKd34Rhu9aSh9/ajV5MQFyrmgrE8W4Lwwlw
         ZnLdstoG1WIXVxYC8zHbORW2OIPaipw2WlSI5bxVCouhu4ephJ2pjquzPZJ7WGsjhl79
         7gTeIaZvGmgyKp5W74qz6HMPhE/SEnrMrdDMjrqDVjvmjUPsnAzooHzPXGuFwE0fMW7I
         H6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678920330;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PkU9y1PP2PdIJmrv74RWtKSjRooXkQ8vFdHDOyb3AFo=;
        b=48IccplOE/To61pWiOub3vRis+nnH1MTBSWDVZ68nkt2oIu/dWE6DizR4zvqeUzjDU
         tGrcE8emuq0gPhXdf7ib9lRrluKP/Pc+6yBrpJnEYucCITJydAtnhQmW3greRwmtkw5O
         6jXRQoSFcGMHL4Fq6q9jtkX3Om6RQeVrsihihqpfev29yL+R3VR1/3+vO+Jl95FEHjRQ
         DylPTt9S/avsGx1Ljy5OmxoTZ/YdjN4bYapJSL9PNPVlGADBgmkXRVCEIRm6bZ5Isyxv
         sN6/WM+f5oi9oKzI6ylafRV/f7A81Fgcrge9Oigc7dA+tGCVLh+PVYIPXxtBB1096f7W
         AKog==
X-Gm-Message-State: AO0yUKUOSjVWe4syLjNv1TXDTsmAVzZyQQGr+Y60OP6dhA+Dks6CMedB
        Yf1as1LXPe5Q9OCGe3IG2GY=
X-Google-Smtp-Source: AK7set9twzx6APEE0IAGfbXamwsCzjrAlN9yTXlc8IVslDNtYjH3We98PvhSF6lfFVfpzVoClRuZZA==
X-Received: by 2002:a17:90b:1b45:b0:22b:b82a:f3a2 with SMTP id nv5-20020a17090b1b4500b0022bb82af3a2mr1629410pjb.11.1678920329949;
        Wed, 15 Mar 2023 15:45:29 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id r15-20020a63204f000000b0050bcf117643sm3313091pgm.17.2023.03.15.15.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 15:45:29 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] fetch: deduplicate handling of per-reference format
References: <cover.1678878623.git.ps@pks.im>
        <d45ec31eeaf42ee042bad04efd69668144df3138.1678878623.git.ps@pks.im>
Date:   Wed, 15 Mar 2023 15:45:28 -0700
In-Reply-To: <d45ec31eeaf42ee042bad04efd69668144df3138.1678878623.git.ps@pks.im>
        (Patrick Steinhardt's message of "Wed, 15 Mar 2023 12:21:23 +0100")
Message-ID: <xmqq4jqlocqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> Both callsites that call `format_display()` and then print the result to
> standard error use the same formatting directive " %s\n" to print the
> reference to disk, thus duplicating a small part of the logic.

Hmph.

If format_display() were a function whose role was to prepare the
contents on a single line, it can be argued that it is caller's job
to give a leading indent that is appropriate for the line in the
context of the display it is producing.  "store-updated-refs" and
"prune-refs" may be showing a list of refs that were affected under
different heading, together with different kind of information, and
depending on the way each of these callers organize its output, the
appropriate indentation level for the line might be different.  So I
think the current product format_display() gives its callers is
perfectly defensible in that sense.

On the other hand, if format_display() is only about showing a
single line in the tightly limited context (in other words, both of
its callers promise that they will forever be happy with the
function showing exactly the same output), then this refactoring
would be OK.  In addition, it may even make more sense, if that were
the role of this callee, to do the actual printing, not just
preparing a line of string into a strbuf, in this callee, by moving
the fputs() from caller to callee.

So, I dunno.  The result of applying this patch leaves it in an
in-between state, where the division of labor between the caller and
the callee smells somewhat iffy.

Thanks.
