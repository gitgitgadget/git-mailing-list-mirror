Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F84C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 03:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKUD16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Nov 2022 22:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbiKUD15 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Nov 2022 22:27:57 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123D32B199
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:27:57 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id v3so10015332pgh.4
        for <git@vger.kernel.org>; Sun, 20 Nov 2022 19:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VhH3SHAm/WWOkUPrj6MDImxO/gVJP3J9okcnzp2rgxY=;
        b=aGL84kTcVWAgnEetOR61PINf/dpKLY7NbpiY2yQQnkQ2itTsgK2GgV7GyI57XCG05C
         +Kno5VHFDxQe9L48oWKJ/XwkwcZIynF3d+79nZgMfUJMwZ9ys422haf76C3BCPWIKqPb
         k+I7Exa4zlzCMfEi0f+wvG7ygGTGcYP9ANgxblSb31KyFr4g/dU6jm0oKOOyefEQfLu6
         k4H/GCsx2iGuALIWzDIzB2BBFf2d9hv3bwxqEzxujZCKdFuIlJ1aY6OhJP+403VSxDCJ
         +/aZZDXIMeFszHpB8x+ReooP6LDB/w5jHiEIGwDze0iHAtULv5Oky6P+qXv6wZgGQBAy
         /pIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhH3SHAm/WWOkUPrj6MDImxO/gVJP3J9okcnzp2rgxY=;
        b=XBxayQcDnpKLg9bWuP0cg4ILlNw1gRwIt/JwKob/L2eEDIOBygQhrlB42RGvH7nQhw
         pd6hWFATIxBBATcR5uoTTVebu5DNKSSPe4zTHvi2HOeKqwikbWroW1liQcFgp4IfxX2X
         UVDDvvF+AG1IeuMXhoPYWeKzH9BrvrlUPrsCUAnnC3FhwNw7L5m1UOOUWwGc3O7EF7We
         bY8jwuHOZGd6mKb3TMEPSRL2b/jUWiWGlFNshKl5kdZkD/OHqYQGzL9G5yNIkGB1j+kM
         6GKDhX44ZPkTUu2T94yIjfOl2mXP02nBC0qz/RbMV3uBQucMhVN3/HHwXHkAwaLZZLvE
         2KRA==
X-Gm-Message-State: ANoB5pn51vOJp1LrUGEJmwBHTyHRQbyDeh7J9Y/rfGRHD6FxcSI9Zgng
        782fdNNQTUsDr5XUZ3bsz7k=
X-Google-Smtp-Source: AA0mqf5nsJcWOkWdIS/FvDYTy28ctf1dxUTV38a4LgJToV3cmmQZ3TwkOgxd/XX9/nZIlWuR+oUNYw==
X-Received: by 2002:a63:5262:0:b0:477:6e5d:4e44 with SMTP id s34-20020a635262000000b004776e5d4e44mr199531pgl.7.1669001276423;
        Sun, 20 Nov 2022 19:27:56 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id nl8-20020a17090b384800b0020d48bc6661sm9366484pjb.31.2022.11.20.19.27.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Nov 2022 19:27:55 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v3 0/2] pack-bitmap.c: avoid exposing absolute paths
Date:   Mon, 21 Nov 2022 11:27:47 +0800
Message-Id: <20221121032747.76571-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <Y3auMxCWJW6Otqhy@nand.local>
References: <Y3auMxCWJW6Otqhy@nand.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Taylor Blau <me@ttaylorr.com> writes:

> Yep, ditto. Teng -- would you mind sending them as a short series to the
> list so that I can pick them up? Otherwise, I can do it if you don't
> have time or interest.

Sorry, will send today.

Thanks
