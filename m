Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F22BC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 07:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233257AbiBOHwh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 02:52:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiBOHwg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 02:52:36 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5D3BBE2E
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 23:52:26 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id lw4so11585360ejb.12
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 23:52:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0Wt9j+U25CUVAK8aWM0ruByEJ4cI87heqiv6oHyskvk=;
        b=I5eJ3ufcsdUYObjD/WoucfmkpvWPLIOCr+8Vjt6aniU92de5f3oIsJXKBTM0z1L+PD
         78SfVL50iMOXhJqW4MEEytMqUjc2Ira39/BHlqQFbYtmy5b7jjr/PF5wOKYNVPnII9ZN
         oK23rrhl5iqoPyzzs3lBQYHBEbz7IwCjSW0PLE3KfWAOcwqb/Epw7l6YnB/3mjU3b+x6
         SNfYe43tl9CoUYFTejOHpgPTEeqWFfxf+OnUyxR6DIXS9+vu8JsCrMbLD8ZdIuk5FSQ5
         9vJvzEE9R0N0uIT1dufylkTd12mCPFlUen1Ms4zf17AkBtKXYA+fn4ZGTz7GmUNlhH3X
         JLxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0Wt9j+U25CUVAK8aWM0ruByEJ4cI87heqiv6oHyskvk=;
        b=hwwQ0t2jMt1HvYbyYmaLdpZT0h4iv2md73L7a6JwT/aZxVEvcBRtj+oDge/SCxuSDV
         f60Vbt0R3D6jYk78C3t1RAe6s4KmEM8iVvWDWt2DkJP26B2lNYg8SYTTM3AsDGKAF0wI
         0n1+RXfs1BWYD+C3gtyvNjGPEcn3MVr9YzC9tKJpeOtQg0nvwtgsR9Thmj/xUQlYs0tD
         Hzq8cxfpguLfhywT4lSmLgAYDbgJZwm3yHsY/XA5HjBKBgyeKLULt9iFXu+SSucWYqt5
         FeS2a3/kgyXpndzEsePaGXC+es7sQUwd3J9iNuoxAF8RIsIu5yto93N0kZHpcyXsqnA5
         5ABg==
X-Gm-Message-State: AOAM53304gkLWuHJznIAPOIriT30trB0X8U+k71a76hcnfb+yQo1SKzJ
        D0CTo392NnXHQtqzBwD5F0BsP629iqItQgAMpTk=
X-Google-Smtp-Source: ABdhPJyhyA4L3vsFtM6bMCb7agIsVCRNNR3scq/OZCLDaDgDA7dTGgZWvldKP7AXb/zKs1IoxYvEcOml5FUcwgKQGaY=
X-Received: by 2002:a17:906:2811:: with SMTP id r17mr1940583ejc.31.1644911545442;
 Mon, 14 Feb 2022 23:52:25 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644565025.git.ps@pks.im> <54fdee845bea7f67f46817417f8e5a504bd39665.1644565025.git.ps@pks.im>
In-Reply-To: <54fdee845bea7f67f46817417f8e5a504bd39665.1644565025.git.ps@pks.im>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 15 Feb 2022 08:52:14 +0100
Message-ID: <CAP8UFD0MQCpFfWg2FP3S1VpDAxCwp3WGucFPn7K9BZ7UnckNLw@mail.gmail.com>
Subject: Re: [PATCH 4/6] fetch: report errors when backfilling tags fails
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 11, 2022 at 9:03 PM Patrick Steinhardt <ps@pks.im> wrote:
>
> When the backfilling of tags fails we do not report this error to the
> caller, but only report it implicitly at a later point when reporting
> updated references.

Probably stupid question: are we sure that it's a bug and not a feature?

> This leaves callers unable to act upon the
> information of whether the backfilling succeeded or not.
>
> Refactor the function to return an error code and pass it up the
> callstack. This causes us to correctly propagate the error back to the
> user of git-fetch(1).

Even if it would have been the right behavior when backfilling tags
was implemented to return an error when backfilling tags fails, I
think it's interesting to ask ourselves if this change could be seen
as a regression by some users.
