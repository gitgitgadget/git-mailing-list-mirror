Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E77C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9CE06141C
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 14:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbhFKO1n (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 10:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhFKO1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 10:27:42 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9EEC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:25:35 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id x196so5972914oif.10
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=vwSpVpn9ZFmXx7uGjMetyaY2x4cRZPdNJO2qyTk7NBc=;
        b=Lp+tEWT3EApxQJjQzQB4hXmAb6EJ3ArfWGCjxcb+honNx3SJWKK4VRB6gJpNwLfVBs
         Cd9PSqj8zyueC9vWe2FS5XUPerwuwufuiY2a92AJihbZjSB8i8kNPj4pCxykLxxTzwWT
         jGNiM9ooikHE64YUHUoMTExfx/lw+2Fl9kuFj88ZZzpMc9ZSJexWQlPbNpaV8wloCq6U
         Cf5hkKatI9H2B59ZqXGtYVybrDuEwAJxmxAb7n/6tomReZfNxSSJoRCDFQkY0vef34Ux
         LSSaITNZRnED9MhLusiOzBJugeGrGblsgjpKmeUUPe0yKZ/OrQBJfUz69nl2Kh4mZRLi
         O79Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=vwSpVpn9ZFmXx7uGjMetyaY2x4cRZPdNJO2qyTk7NBc=;
        b=GvLnMcUjbQqHYBR2mRWOSrOq1Fq7NzKEAUMGZKfE0l4NEQ8ChdmHg5+lojdOky8fGf
         hoUiq2a42y/uOmQMEPvff/w8PNGYQeHVKJk/YnHd7fbUYbZtDsw2rF4z4Q6fwgMVGdgY
         PdYQtpw64HycSs87hRQgJsAGIeyBHnWArBe+X66rZ0cYoqG2P5bdKRaQTIpmjQhhv8lm
         zkHNXYFVgR/BPEVwtb8N6Tl+BJwINL3NXFusjdHRXZiMqKFF5ju4c4eLvUqmqrfTenE9
         XX9gFxTTNipkrdPn17U0IOI0c6XG6yA7CfUhN3Q0SsNFbIs/yCc+sDZhrH1/fxreUj5S
         Sj3g==
X-Gm-Message-State: AOAM531ivdwOZZ8n5tSv4GTedSd3rCvC/KUlycsgzpcJezrPc/xadsKD
        r8y5jCE5ojGrv+yNWNhFWPU=
X-Google-Smtp-Source: ABdhPJzCY0KANKj0EvS8BN1CxgX20ckWnmAm2/6x/DABB/a2xXoiYt1X/h/NGAZk6T0tQtqybLQgaQ==
X-Received: by 2002:aca:b5d6:: with SMTP id e205mr11674019oif.91.1623421534469;
        Fri, 11 Jun 2021 07:25:34 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id f7sm1149979oot.36.2021.06.11.07.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 07:25:34 -0700 (PDT)
Date:   Fri, 11 Jun 2021 09:25:17 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Message-ID: <60c3724de35b4_3ad920839@natae.notmuch>
In-Reply-To: <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt wrote:
> Am 11.06.21 um 08:43 schrieb Junio C Hamano:

> > Rebasing to catch up with updated upstream is a different story,
> > though.  The same for cherry-picking an earlier change to an updated
> > upstream.
> 
> I've reflected on this a bit more as well. I've forgotten about the
> "catch up with someone else" case. That is certainly helped by diff3
> style. I retract my opposition and am now neutral to a potential change
> of default. (I still don't endorse it because it upsets my workflow.)

All right. Fortunately we have a configuration for that.

> The case that inner conflicts are presented sub-optimally under diff3
> remains, though.

Indeed, and that's something that we should consider fixing, but it's
not necessarily a roadblocker since apparently many developers have been
able to live with these sub-optimal diff3 inner conflicts.

Personally I have never experienced what you posted, so maybe there's
something else happening behind the scenes.

Maybe merge-ort changed something.

-- 
Felipe Contreras
