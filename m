Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C4BC6498F
	for <git@archiver.kernel.org>; Wed, 24 Aug 2022 22:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiHXW3B (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Aug 2022 18:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiHXW27 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2022 18:28:59 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ECE7E307
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:28:58 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id m11-20020a17090a3f8b00b001fabfce6a26so1434360pjc.4
        for <git@vger.kernel.org>; Wed, 24 Aug 2022 15:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date:from:to
         :cc;
        bh=6Gc/xhlUJgLVGONRcf4svma3XtLPBgIsGzkpxEa7RlQ=;
        b=cds3OVHKGDjKUddjymKPrro6edpbzMWUblGlv/MVEoyRyIb8roo14TPTrofBMR0FPu
         sz8+6h7Kcyp5Lsk+0mmT539nGLmkzovZa3nWMZIeHhAIbLYpSpq0/fG/svBi9qIwKZmQ
         p1uXRuKAe8X+PrywEruICMhx+b0npT4g7BxDYESwn4ATRG4CzdXBN6p2eY9+Mj4Ft/lP
         ZVSfx89jx3NKTMaOioyxuBk0UuF2DM+sVmYvdUkmlEvuJjcfHZXte7JU8yLpGdbxFVCk
         xx0xSG2R7aTAghapdgUgrSNlaDHSh2Y5NS/Nk7/AV/O80jpZwFkDLaWaIsuBB+VCrOJa
         ojWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:in-reply-to:date
         :x-gm-message-state:from:to:cc;
        bh=6Gc/xhlUJgLVGONRcf4svma3XtLPBgIsGzkpxEa7RlQ=;
        b=yc/MVTti6y03E7tSKeluPcve64t/3AaiKsedqjhDFw8Ml7q/HfFvPhKbwlyfO9xLi6
         nVguGmssz7uD8DBBic18z+ro9GzzKnv7S4fJOIAjwBB6sHiSRCbmk6FllyeLxtnUAlqW
         RCRfFkG6CWfC3NbsfJgZ7YfM8FODeLh+9ukBr7H0sr8Oh6b0woaDLHcsjK/8ffnt9Br6
         IMPXkiHArr7GrpTYK7k5m4SLyqSkr2xY40Cpj+onIMXBdcvI7hCrpjVBXC8VGUMtgwod
         kdoVWChGnRtbVfpJ3t4jpc7SmHzngLeNaLTVxSr7B5MSyggkEGu0Y+O6DbEVgoaYbZj0
         ijKA==
X-Gm-Message-State: ACgBeo3NHaINb72mF4MJ6KGMNw7cmYoqpdP1GlQJoClEOi6EuCsAC9cV
        dakr5juRC+Z793gmK77w8ek/oVGn5KSbeO8Vls7Q
X-Google-Smtp-Source: AA6agR47M3WutiyYduERTtLpTzhxxHZozzTr/JKqvzkoanS0qjBIqIpQb2+w6fzswPnz4DrX2up5zsAK08Jpc11X/Jvl
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:82c5:b0:172:bb8f:a584 with
 SMTP id u5-20020a17090282c500b00172bb8fa584mr963334plz.49.1661380137841; Wed,
 24 Aug 2022 15:28:57 -0700 (PDT)
Date:   Wed, 24 Aug 2022 15:28:55 -0700
In-Reply-To: <eab55cef-62bd-af2b-c295-1e76beca032f@gmail.com>
Message-Id: <20220824222855.1686175-1-jonathantanmy@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: Re: [PATCH 1/5] t3416: set $EDITOR in subshell
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:
> Hi Junio
> 
> On 15/08/2022 17:53, Junio C Hamano wrote:
> > "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > 
> >> From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >>
> >> As $EDITOR is exported setting it in one test affects all subsequent
> >> tests. Avoid this by always setting it in a subshell and remove a
> >> couple of unnecessary call to set_fake_editor.
> > 
> > Unnecessary because it reuses the one that was established in the
> > previous test [1]?  Or unnecessary because we know "rebase -i" would
> > fail even before it gets to the point of asking an editor to tweak
> > the todo sequence [2]?  Or something else?
> 
> I meant unnecessary as the editor does not change the todo list, but [2] 
> also applies.

Maybe this is moot with the other changes you're planning, but even if
the editor doesn't change the todo list, it's still necessary, right? At
the very least, we need to suppress the default interactive editor and
replace it with one that just reuses the input file without any
modification.
