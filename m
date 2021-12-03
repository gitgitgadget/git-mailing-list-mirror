Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC2BC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 22:40:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383441AbhLCWoH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 17:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383440AbhLCWoH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 17:44:07 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A5BC061353
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 14:40:42 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id j7so4159137ilk.13
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 14:40:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W7aRLaoNv6hNhqxRcXVoOgQOi1mnX21a+Yj5VqFJAIw=;
        b=HfvzMxPPMKCiNwRNg9hTz3TGDs4RzjUAQ2yyr9e5EqJ/hv/0N3694A8DI1OwWHmKwI
         pCWyaBeB8DeiknoQBVT+mhJ246hxKQY1k6XkDYGgad25WAkBMTu3PoO0mTBF/dTdSPSr
         YWuaom1C8CgB4feyicQ5bCslVL7vr2Vc79BKDifdOHohECpXDHuyzz/LX4pvG6g3LbUT
         aNfapBSwU8YpU56xbZrb7RZPc1T1euwiwi+YfZUjTUJuM2CfHrt3B0enIYpmIG2lB7jw
         fqgUsu6vf55sCrLu4dhMoM3cmDsQX2hB/pv3pTx6syqPkywzHsj4rJNdAH5eG0Fe1K1T
         2uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W7aRLaoNv6hNhqxRcXVoOgQOi1mnX21a+Yj5VqFJAIw=;
        b=Kljzmoo9gVpv20mhLLDYlwi9Dduc4V+Jr7qDh01sZXpSuA+pMqwsuNvR46flggBP38
         rPj8fsZuFmhQVET2SQ6qxbzLkp6wpXkoLQU3yp6ERH/K9Jl+l6p0NZfQQO/8pp4Ahgte
         W00pd3eyND4WL3eocnfKeeoxIqVi6TtfjqVKzGH5LItHwPBam8c66ThBXHSYfVBzl0bG
         5IcPXMHyt0FgtidqdocdGqhrklM6pJhNf6eNzQpNkbNLF8oEzMiJFhTRnNCm6RV6q2ov
         k4ambv+lVcfE4QL0/BHHXffcozhmhJbKzbvGteZn8cYDRtOZlROZ/ZyMffKENUTw+vKf
         5nAg==
X-Gm-Message-State: AOAM531i5o9z+agqx9pdafptr170XuiYbroHhXGhnkQBDxZzVa1pkJXZ
        1j5Aoql7R92YaHjvwG1nbui7OA==
X-Google-Smtp-Source: ABdhPJwurxYsSQq23tEyBSs//ZZqBkXU+QVCwxQ50Kai21DG7KfP77Fz3HjWsASsO1JmmIwbnbZHCA==
X-Received: by 2002:a05:6e02:20e7:: with SMTP id q7mr21692297ilv.3.1638571242017;
        Fri, 03 Dec 2021 14:40:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i26sm2903352ila.12.2021.12.03.14.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 14:40:41 -0800 (PST)
Date:   Fri, 3 Dec 2021 17:40:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, larsxschneider@gmail.com,
        peff@peff.net, tytso@mit.edu
Subject: Re: [PATCH 04/17] chunk-format.h: extract oid_version()
Message-ID: <Yaqc6FYo1pLhsNSB@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <ea245b7216067093fdd3a5b2e3a9390f634c8af0.1638224692.git.me@ttaylorr.com>
 <2d5456f6-5a4d-1600-83f3-2b6d3e1b270a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d5456f6-5a4d-1600-83f3-2b6d3e1b270a@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 02, 2021 at 10:22:05AM -0500, Derrick Stolee wrote:
> I notice that you don't use this in load_pack_mtimes_file(),
> in pack-mtimes.c but you could at this point.

Hmm, I'm confused. Te extracted function converts a pointer to a struct
git_hash_algo into a uint32, but here we just care about reading the
four byte value we wrote.

Thanks,
Taylor
