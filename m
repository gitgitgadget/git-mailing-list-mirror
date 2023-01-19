Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF9EC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 23:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjASXor (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 18:44:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjASXop (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 18:44:45 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1F69F38B
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:44:44 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p188so4716570yba.5
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 15:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gVqcZN9IzpmpHcNUydKC5RqGc3f6xtfqHwn720yQEHM=;
        b=EYwhTSW9moDq969FJmIPoSRCqfmurW9ubfhVmIl7MXmmR0FeJ4Xj/8MeXJ9LJbXFmi
         R/ptn39+jZOrn1ySJ/CmJahRGjeep34qYf67x3eUibFcDhEBYDloCt5FXKWvj6/i7ycU
         VlNgB2ttPqSs1UU0hIS7BjUpnlTTFDyhW8GTAbAnDtWKu/vjbOxiz+cUNBbyg5eDevY+
         vtg7bDQ/dLjXQzo4tQF+YbZ+3ANq1RWVrC8sprki6XAjDy/ApQOYOnwB5hL7DMoiJMsR
         GKvOW6pFC99jGfUikyh8aIHNvUu+fg/v1E2k5WKfk5NDeUx1lPpO9GtoiNrey4JHd8ep
         vccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gVqcZN9IzpmpHcNUydKC5RqGc3f6xtfqHwn720yQEHM=;
        b=3ypT4oGonGjeAmJBrcPnB7OvB22/tb2nxngfbUIczMSesU273e4m9cckI/Q5rc3k80
         +oqg4MvvCO2rIrZ1EQHtTEOUGbXTLkfXmLQToWsgb8DMS+jw8fwddpeZcnKXE/X5s7J9
         +8p372l8jtR6MIO626+P/mDza9CWpIBq1G1uYNZPYTInoPJqYlXtjBKkOhR6ZrjVIsqq
         rffGC+PMQq859BlA7P5PyGH/6oeWCHrM5fsTVOqZxouAF8AB0HAW0rBaTvfq2OyiMC/E
         GaoRkIZ1WMTqxuClIj5u3E0zAaMA0dZMccYpY7lMqQGuUXmqiOeqPFtwtLRqlqJ/UcI4
         JNeA==
X-Gm-Message-State: AFqh2kr1tkdVzF2Z68yLVGMg7IMBauiMCasrijJxbZitwDXcapsesP0i
        tH0ZpNDwLvzE2piPMqpkYRYih9yR8VTyBNad2CC2zu64wynFb8jdfnI=
X-Google-Smtp-Source: AMrXdXvTxW888UZ0VKDPBZUFzWMQPlYKoCH/s40OJojMoTqTLXsrCugYZJFB/oNWp2wAIKH1dnQnbx1WqfaLNVMXE7M=
X-Received: by 2002:a25:814e:0:b0:7c5:d9aa:1493 with SMTP id
 j14-20020a25814e000000b007c5d9aa1493mr1697859ybm.510.1674171883648; Thu, 19
 Jan 2023 15:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20230119220538.1522464-1-calvinwan@google.com> <xmqq8rhy172q.fsf@gitster.g>
In-Reply-To: <xmqq8rhy172q.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 19 Jan 2023 15:44:32 -0800
Message-ID: <CAFySSZA6MgjejnoBa7HrXAQBNb1zE93aASVZogabAK_ArDNmnA@mail.gmail.com>
Subject: Re: [PATCH] fetch: fix duplicate remote parallel fetch bug
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> As it always is possible to edit .git/config manually, it is
> necessary to perform deduplication like this patch does on the
> consumer side of the list, but do you know if our tool create
> duplication, or is it entirely something the end-user does manually?

I checked git-remote and there is protection against duplication
there, but I'm unsure if there are other places where remotes are
being added/renamed. I discovered the bug initially by using
git-config.
