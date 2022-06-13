Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80EFC43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 21:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiFMVpT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 17:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbiFMVpR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 17:45:17 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AC96438
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:45:17 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id x18so4877039qtj.3
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 14:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VZXpEgEVptwZ9a3tfwIhcxuPdxRvjaf9eNTryOHVABE=;
        b=SXZrH6J5aQu+snkdaT58W3wh+7lf4ukKQu5aQI5DhCtv8sZvS0uwOCr6MBv6wxd39X
         AgE3FtcNXPR2gBBWLwHwTge+ydvpN2QAkEz455kg+uaGl4HHpk/kSTHi280xWLDx+d21
         j2V9226HZMgiTxD8Uwbbydodmy6onMQ447+RA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VZXpEgEVptwZ9a3tfwIhcxuPdxRvjaf9eNTryOHVABE=;
        b=DVFl9lpL3czltF8ebcaNKlzV2PBUUul/+uUYRcnpmfWEPe9IhHC6ZnNdRioHUrstlP
         48rhqVVo5C9OXNklQVPHA/Ep1ZTrDZLMlqNrUqddxWn+xJlfaeoRZmqLatJpADOA/rTY
         7PbPMpN7S4PUlVdzFtGPRUeOeTw2kmHZTHQYE4UuC7ty2AbdMzJ4fOnOcmp8r3E2OrmZ
         B9DAKJMT7UpKTlDuTNrr43Rh7Dg3BzFaCGJfaMKU4/oh/ZGhqy5yJ1DY71V2dXo/GPIZ
         5MlzudaVCqW6rrMdRZfK+s595IGUnx/Hd1cUnjxGI6tqTw8KwtO0MYK2tNcDe6N0zgN7
         TCWQ==
X-Gm-Message-State: AOAM53145npN7KhBD3GvGxBMjCiXwqqZfXH3rcuyDNZJ9eCTQfk/vm9D
        Jin5QsIAbltyCZDteEYCoEvex6aYOBOQWQ==
X-Google-Smtp-Source: ABdhPJzqZHjKTxmGpco9b8K3SFgNI1ePyteYMyMy1qjQE+LmmkL8d87k7JTqWCkINqxZ2wKrWu8+Vg==
X-Received: by 2002:a05:622a:4f:b0:305:2678:714b with SMTP id y15-20020a05622a004f00b003052678714bmr1642953qtw.143.1655156716101;
        Mon, 13 Jun 2022 14:45:16 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-30-209-226-106-245.dsl.bell.ca. [209.226.106.245])
        by smtp.gmail.com with ESMTPSA id h5-20020a05620a400500b006a6d4261f40sm5182170qko.111.2022.06.13.14.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 14:45:15 -0700 (PDT)
Date:   Mon, 13 Jun 2022 17:45:14 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: Repository corruption if objects pushed in the middle of repack
Message-ID: <20220613214514.udtn35w7j6q2lrbh@meerkat.local>
References: <20220613203145.wbpi2m3ys3hchw6c@meerkat.local>
 <YqepoUMb3rkKgWqB@nand.local>
 <YqerC883GiwHiiZU@nand.local>
 <20220613213221.iekmfjihho5ujfq2@meerkat.local>
 <Yqet68Sll1cz+ySY@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yqet68Sll1cz+ySY@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 13, 2022 at 05:36:43PM -0400, Taylor Blau wrote:
> > I'm not sure that's the case, because the object that is missing is the one
> > that didn't exist before the repack started. In the scenario you describe, the
> > pre-existing unreachable ancestor of it would be missing, not the newly
> > incoming object. Right?
> 
> Aren't we reporting that the newly pushed tree was broken _because_ it
> had some links to sub-trees that no longer existed?

Hmm... now I'm not sure, and I don't have the broken repo in front of me any
more. :(

Well, the upside of this happening on a routine basis is that I can make
a copy of it next time so I can be more helpful in troubleshooting this
situation. Let me sit on this and make some copies next time this happens
(even if it's super annoying that it happens to such a large repo), and then
perhaps I can give you a better answer.

It's just strange that we've been doing something similar like this to tens of
thousands of repositories (e.g. those on codeaurora.org), and it's the first
time that I see such consistent corruption manifest itself. If I were to go
with my gut instinct, I would blame the shallow checkout on the client, but I
don't have any good way of explaining why that would be the culprit either.

-K
