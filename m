Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B50C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62722206D9
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX7i2Mnt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgD2Tzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:55:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Tzl (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 15:55:41 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2288C03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:55:40 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id u6so3969069ljl.6
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=MyfrRWqQ+JM+Aa9T1eNIeVn3GElhUwC1PdGGE+GcRnY=;
        b=PX7i2MntnQQUuORCQRx4SZZJDNbiU+DJu1lAF0bhj6Ft16F+vVFx7EPdnm7vo0t9+w
         Y2rXX7zzXN+okC4rkqtVd6nwnXtYV3yELhc9SgEibG4SLB4QuB0jF90h2Osa1WYw08ao
         83vQMr5WpgSwhkmPounzb25mCSsGVDtvy8F0STDRfqLUeE6HmYIbzHuo6UHJDP+itlxQ
         Z47Utq6RVwsPrFhOTTU0js+tBBt//EXUcyVvi+asKwI40hiHlWY0rdCvmRcP6meByKTQ
         fFGx0IUnEOUBkyNif6BqQshUvr5FeAJXb6XlBWJIYZOrVIi81X8yOE8jixYLeP7g3fQs
         gd5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=MyfrRWqQ+JM+Aa9T1eNIeVn3GElhUwC1PdGGE+GcRnY=;
        b=bfBdj1+eNn0FovxoSfFp+4ZI9fFFj+kUnHDKcyI9tLRs3xJhJnUy9BWC0tOBtynoGq
         3uEZLrTMdif3CT8ZTXR++hZJA4RT00tLLS0vlNcbYuE35gWOlTngfTYLoxNykB6PFZ2r
         1ED+nvGtSJhrAsVEDuDHic7JLv0dYztaS0DcgS04FrzKMCIlr+eCWTE6aZMTGiaJr4kE
         d6OHvvXFd8rR6KkXrAT3Zb029RAfP2Bd4/GdKZsQb8gImfr1RumU6xnhV3TgfouXXdYY
         dHjBnplvprbmerXhNyaO0FEeTeMStpiKo2toxrNmzfgO85jaAaLh7arkJM/ETeRo+i7F
         YemA==
X-Gm-Message-State: AGi0PuZ9/azTw48ZCZeuOuUJfYRbcDqDs4n64pdbbyVecKDYkqrQ9nat
        8mVTurZ84mUlXftNjXDBoIzx0Tlr
X-Google-Smtp-Source: APiQypLhzrNnU/RXKdH80Cq6+Elm0vPT1rBwh1+V0yquJd/Cx+9nTyjvUe3g5yKRp1ad5bHCEn1QSg==
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr22317185ljh.65.1588190139438;
        Wed, 29 Apr 2020 12:55:39 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id t16sm3521529lff.72.2020.04.29.12.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:55:38 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <xmqqk11yw0r9.fsf@gitster.c.googlers.com>
Date:   Wed, 29 Apr 2020 22:55:37 +0300
In-Reply-To: <xmqqk11yw0r9.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 29 Apr 2020 12:27:38 -0700")
Message-ID: <87pnbqkqx2.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Ivan Tham <pickfire@riseup.net> writes:
>>
>>> Add support to delete previous branch from git checkout/switch to have
>>> feature parity with git switch -.
>> ...
>> Is this short-cut /that/ important to create yet another confusion?
>
> I do not think it is that important, but I do not think "cd -" is so
> important, either.

Sure, and git shouldn't need to repeat other's mistakes.

-- Sergey
