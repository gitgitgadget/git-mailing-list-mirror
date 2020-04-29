Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA54C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684A4206D6
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 19:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c4ZDydIW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbgD2Tuq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2Tuq (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 15:50:46 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815CEC03C1AE
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:50:44 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id y3so2765720lfy.1
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 12:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=117Hv46TV7qWnTBrz6/b0btgNhRAexzvg9uOOkMWncc=;
        b=c4ZDydIWwLYNMh6zttpTWF0XqNUJJi1V+uwNpxj1cfsOv/SPzzs0yl7feVLi5zHgsT
         fFY3oYXLg1Ke6dDAk3wcOmZJ1v/bp1LI61L1VK0eLmJqoZ2gIu19N+jL6oP/IETem/FV
         GjcL1rnYOi9ZPSNCT3yHNhBYTEmwS2ETUUAaEZNbg9pV+8TfkEE6TujQ/1YsUJB8V2Zz
         su4yserlL3xnqH05b+ZR0mP90zIrYCD2Y2VE1nwVi85Gihq+BslMvSeWMnKBKn9sYNQL
         aPuFzO2CapvSxqpZyP92pYcc+LI4WLb9Ap28XoiWTb5XyE9VhZBX0jdaXbKQXd0TeSbk
         Xdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=117Hv46TV7qWnTBrz6/b0btgNhRAexzvg9uOOkMWncc=;
        b=OYndLQYKE+3j0WazTsqM9X5BBweA9EsezRsAy69YeCQxnmTXMhRq4R51BTwNdvn67f
         BBEe9dNIbapGf3bZdr9XUdD1+0oMeeW5gsnJf/WQ0e0SUhBQWWGulR4M1kQQvQKFalYb
         6KaVl8zu/hx+mUevSAnD2M9B78/TmJzhU9An/0nRX4Rtb5DkhDELZ1r1fM+NaaRKhrxc
         EV2Q5mMbwHE0Eqq+mIx6rf00emKdZV941K/+TZseBjp45z04z3ssWl9H9K5SCWtu7crv
         /zJW1XeCSbwugCpOsK6Hocsxny2wE7dYSCsXmorBjyvlQum/8X7YdYkEW+SkZd0D97NV
         5YVw==
X-Gm-Message-State: AGi0PubfhMj7rnS7b7g8Uuisv022Q7s2J50UlvA/Kd2nnn6yD8+h4UOf
        5JKa5oNkTD6JUJDsuvDlXNk=
X-Google-Smtp-Source: APiQypKB8lI2sPHkTO2Y3+qvssIQBlUkqVaZqC5RjXWiDL/eCi5b7ZfkfxkeT36ctqJmAsLuT7Jy6Q==
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr24149072lfl.170.1588189842945;
        Wed, 29 Apr 2020 12:50:42 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v17sm3324320lfe.34.2020.04.29.12.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:50:42 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Ivan Tham <pickfire@riseup.net>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
References: <20200429130133.520981-1-pickfire@riseup.net>
        <877dxyo1k8.fsf@osv.gnss.ru> <20200429190013.GG83442@syl.local>
Date:   Wed, 29 Apr 2020 22:50:41 +0300
In-Reply-To: <20200429190013.GG83442@syl.local> (Taylor Blau's message of
        "Wed, 29 Apr 2020 13:00:13 -0600")
Message-ID: <87v9likr5a.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

[...]

> In my opinion, it is fairly clear that 'git branch -D -' means "delete
> the last branch", and not "delete a list of branches from stdin.

Honestly, I'd never guess it'd "delete the last branch". No way.

"-" standing by itself in a command means stdin, stdout, or otherwise a
typo. Using it for any other meaning is a blasphemy. Sure, nobody will
die because of this, but it's /extremely/ confusing!

BTW, what about mistyping:

$ git branch -d - f my_branch

for

$ git branch -d -f my_branch

or some such?

No, it still doesn't look like a good idea to use isolated '-' as
suggested by the patch.

OTOH, for otherwise unusual @{-1}, @{-}, or @- I'd immediately realize I
must consult the manual, so these would be fine with me.

Thanks,
-- Sergey
