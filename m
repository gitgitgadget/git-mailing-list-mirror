Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA0F8C77B71
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 21:41:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbjDNVlj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjDNVli (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 17:41:38 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1C21F7
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:41:37 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-54ee0b73e08so370215937b3.0
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 14:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681508497; x=1684100497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1zgKeUyKRkC/kpUBDPOpWu/AUYm3hxwOc8+uEvS7RzU=;
        b=ZvYBeAmTEOekE1vTKr6XUpRhJ7iI62O4sec9tTA5TQpitfoN23m+Ua5meZ4qOUGqhn
         yX/Ud9eJrMJSq4v5X7GeqmcnpE+gvWKbGxudn4tZeenSLqwLxDCyJGLKaGsLT5A7PwUt
         GuRFj0FDgFyyzo8QI6VjcDqrwLvQaaAJY46qpwxx55VZkPnPdXL886HSsQN6cyq65UGu
         B6g2P0E72bbB2ANk61H0zWBJQ8uU77NEyLA/QDjbl5zG8/LLa4fmHP3RvPJ52b6m5lSI
         cNG2d5Bi4Wc31HIbdhv85g5Op95MU2syFyPyaYFtfulDwwm3BXsfre9WqR/FmGmVjxLS
         OaeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681508497; x=1684100497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zgKeUyKRkC/kpUBDPOpWu/AUYm3hxwOc8+uEvS7RzU=;
        b=dMxk+Zp8JRSbw1/JdaIKbXkgwceCXF+6RYR5DQvlF4GgdLe5nT8B2rSosJPE/F9BRM
         XilUlW5oWjlqvkDftz2leFGXFfkzdpH2hU7MikERiCkDWJJ5XED8lknYTxfF6ECZeIWG
         1JFvRIO6xhe5UdDwFm7g1hkvWdi3s59ZzTkUtzZqfCpNdBdSdg30MfbuL1XWV60uHOGf
         DpvzBIg/mc+v6qlKzR79AxGdXv//wixPTFY1FjuKNa+etNuhiGHCMHnfyO5NiZoxc/RU
         7uSNBK+lA3i2VPmKqoSbns612UuXEhsYZqVWyjxJMu5VBJ5QHeKjrvum9ypIxbJadnj+
         Zh/A==
X-Gm-Message-State: AAQBX9dQdAn/AJ1YY+CV0r1YNgXf7wchCvxsCJu+aKrGkuVfaGjzzVIo
        A0DFbGhnCEqVa3rQ0DtQwR2V+Dx9ccUzPu9QYs4JMg==
X-Google-Smtp-Source: AKy350ZkRjif/wklh5BBpwzqOU7LBfJ0dT5iQZ7FAkY/DGuyJzx3wd5OB+64qTNiQ2SxAAmvAASkyg==
X-Received: by 2002:a81:494d:0:b0:54c:b26:b0e with SMTP id w74-20020a81494d000000b0054c0b260b0emr7834904ywa.25.1681508496855;
        Fri, 14 Apr 2023 14:41:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p190-20020a81b1c7000000b00545a08184e9sm1439451ywh.121.2023.04.14.14.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 14:41:36 -0700 (PDT)
Date:   Fri, 14 Apr 2023 17:41:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 4/5] Documentation: document AUTO_MERGE
Message-ID: <ZDnIiuFC0/LaP8K5@nand.local>
References: <pull.1515.git.1681495119.gitgitgadget@gmail.com>
 <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0cdd4ab3d739e07357ea9efef2cdece633db6ebb.1681495119.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 14, 2023 at 05:58:37PM +0000, Philippe Blain via GitGitGadget wrote:
> Closes: https://github.com/gitgitgadget/git/issues/1471

Neat. This does close the corresponding issue once the result gets
pushed back to gitgitgadget/git. TIL!

> ---
>  Documentation/git-diff.txt    |  8 +++++++-
>  Documentation/git-merge.txt   |  9 +++++++--
>  Documentation/revisions.txt   |  6 +++++-
>  Documentation/user-manual.txt | 27 +++++++++++++++++++++++++++
>  4 files changed, 46 insertions(+), 4 deletions(-)

These changes all look great to me, well written and explained.

Thanks,
Taylor
