Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C4AC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 23:45:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKBXpB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 19:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKBXof (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 19:44:35 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0D45A1AB
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 16:41:27 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id b16so432018yba.2
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 16:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1ysy1e2Eq0faGIvBwCu9U6k+1arWdTdBXmkLOtNnXs=;
        b=VzA7dYPrBDkEfMI+keO1Wjadq0MH19+PbOs7CxO04d8+s3GqTm3eL5OdsvefsrKIzd
         WaFuqR+Fo34cnT07uFkMVGiYXVajlyOWyWh3VzBYKzWb05GS0UBlmUkQMaei+4/oGjmO
         JBJY1QzPJrgB6TEin5OSKxtuYbg8VC9TIJrucnaXNyiBJzwob/GyTssvttotdha8OTW2
         At3Jw76ZZosJhL+T/tujiLpXMl++rkfBi3iXNuTF5mBDsSTQRY8Vy5+RUnzvKewfrpVU
         VAtqxbfwzWRMbYjkZVKKe5xMils5JDCFUya9cSX6rsi+/6b+P9/OyYdA1tjLK487V3rq
         1vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1ysy1e2Eq0faGIvBwCu9U6k+1arWdTdBXmkLOtNnXs=;
        b=S+dunMKW7exhUgYV0DuO5EYvZj24pqxGu0P+f8oIWUAXvq43XfiObD2guTcah87rRs
         x+xU3z4Af/lEHt33Oq3j4CbRTK3arXn8V0bDN6xVeuS0WA3YF/7Oil4+JzaONM2TJEmo
         dvQSXra//FIZLoRz1cHR2OdmD+Xif1lDtHStGDY/gFCCc2VBMG2f4FXZZHXiVX/+CfbY
         zeVrSu2QS0yNJCUh99Twe4u/gQv0KYqutM1tKTYR1xCXmLIU6YLRQe4ZsjR3/pRML/yT
         m5Bu5DVMyxwVTleYZmDl8ZooAksfghjjz80Y9Y8oIfw34xtrYTRmrQ5oJJQVPSLYMjzH
         nvVQ==
X-Gm-Message-State: ACrzQf2O9ZRjr8GMMgm+1Z5nVWkYVf22eRhSVc7pbCQmctr19QpWhsu4
        aqva0PPdhsNfYvzeb59xeYd1h4WZmMMPve/+WQ4wlA==
X-Google-Smtp-Source: AMsMyM7GaCDkz8REDc+twc4opWq/wL98ZbTUHtf64rH6aQa4wFDrfV082r8rhqCsDd8pOj6nnt+ub+amge0Pyy7oyBE=
X-Received: by 2002:a25:d216:0:b0:6cf:e9f4:ace2 with SMTP id
 j22-20020a25d216000000b006cfe9f4ace2mr5928226ybg.84.1667432486972; Wed, 02
 Nov 2022 16:41:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAJyRyRo7oVAfLx8MONO=Y8KhLvL+tJgDTbCUezR1AFa73R5pbw@mail.gmail.com>
 <Y2LgzmTvElmRTsoe@tapette.crustytoothpaste.net>
In-Reply-To: <Y2LgzmTvElmRTsoe@tapette.crustytoothpaste.net>
From:   John Soo <johh.soo@arista.com>
Date:   Wed, 2 Nov 2022 16:41:15 -0700
Message-ID: <CAJyRyRqMPX93-Oa5XMvZtDTRxh0SisUhOFAWhv-6hXR5sEkQpA@mail.gmail.com>
Subject: Re: safe.directory and ACLs
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        John Soo <johh.soo@arista.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian!

> No, the permissions of a repository, whether standard Unix permissions
> or ACLs, are not relevant to ownership.  The question here is whether
> the owner of the .git directory (that is, the value of the `st_uid`
> field when calling lstat(2) on it) is equal to the effective user ID.
>
> When you the path in `ls`, you can see the owner and group of the file
> specified, and that owner is what matters here.

I see. Is that by design or an implementation detail?

Kindly,

John
