Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10B3DC433EF
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 17:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DA761506
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 17:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhKHR7A (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 12:59:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhKHR64 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 12:58:56 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46434C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 09:56:12 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id h23so17824743ila.4
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 09:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Iq8vVPRyXvfvF9lvH6yV9NNXvkx2JBx6RpwQNIhxSTU=;
        b=6AY53UBBYJIJrsLPNot/a23LkfTg67nhLt3koAyM+IXkE6IuUNLsoozs7BYuc4ypS4
         vAnV156ZxfYZaoGQomTCZap4lFZfE63clVBmIw7ZW2VJeriDtTZrxwOlBaPQVox/kSFo
         NX9Z2GiakDSb6rHeayrBo/VnCRO51ZZsclK/93uUYV5/HnCWA6U+uxCkUnHRdQiicd7n
         nNKyJDA2X6DSJzzGlzqrp+hH5ZrbzxY8o63bXp7Ma1zGIIgWj6riyQybySPAN1DGXJHw
         vt7NoCIOqvaDdl49I8wMFeGhFCPCQRxYksWWJZzjOEO7k1TxoxTB5gTPJY5laPE8+OZO
         JEeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iq8vVPRyXvfvF9lvH6yV9NNXvkx2JBx6RpwQNIhxSTU=;
        b=eWfibisKw1ZS9Pp9Gw0TPVi3D4MZLsAO0Dq7wlHqL9Q9mw7vE1qdnBotM76vu2dvL4
         EQ8Fz3GwY8CNOx3O4NGS3NZ12AYGgiR/p65qKkRbuaJCCz3EAC9pU8ln54hD/1bgF5LP
         xDTwxjRVHQXyBw+Y6FPQJ5mRBDW4MIa1RD3LxLbOiiaPux5CxmWUa8XQy5GE/HkFXGhU
         ya5W5P4ypQdzvOj5eZkhNWX1IhzcW8bORiJnIZEwdIWRVIomqW1VqfmCwgxyHZcAcc+X
         lQJfX146d0lvahY4PYoMYOswwLkIH3aO+Dm05rQJ1ov2tpDmtODSTpIf0CapqXXEj+x9
         J+Hg==
X-Gm-Message-State: AOAM533T3jNkaFr+XQO6RMIXk+NC9eht4jYn4+EMYpsmL/WozL0tm1k0
        x5R41tStYBM9DHWQa3IZLXYv7Q==
X-Google-Smtp-Source: ABdhPJzfAKKYEcGp2R3a18OvT1ZBmpb1diFcfL91HaBYcEJq/zrpz5DEqRt402L0wyCkBy7qSz1pJQ==
X-Received: by 2002:a92:c08d:: with SMTP id h13mr676304ile.60.1636394171642;
        Mon, 08 Nov 2021 09:56:11 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t2sm4210331iob.1.2021.11.08.09.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 09:56:11 -0800 (PST)
Date:   Mon, 8 Nov 2021 12:56:10 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Birk Tjelmeland <git@birktj.no>,
        git@vger.kernel.org
Subject: Re: [PATCH] stash: show error message when lockfile is present
Message-ID: <YYlkumkOWotx6umn@nand.local>
References: <20211107213012.6978-1-git@birktj.no>
 <YYiXw41upJfPS7l0@nand.local>
 <xmqqlf1zunqe.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlf1zunqe.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 07, 2021 at 11:10:17PM -0800, Junio C Hamano wrote:
> I would think the "fix" should look more like this:
>
>  	read_cache_preload(NULL);
> 	if (refresh_and_write_cache(REFRESH_QUIET, 0, 0))
> - 		return -1;
> + 		return error(_("failed to refresh the index"));
>
> That is, tell the function that the caller will do the error
> reporting (i.e. "QUIET") and do so.

Thanks; this is a much better approach. It makes Birk's change much more
direct, and does not require plumbing a new parameter through many
function calls.

Doing something like this (with appropriate tests) would look good to
me.

Thanks,
Taylor
