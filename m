Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73BCC43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 00:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A590020787
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 00:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FICGKAte"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389752AbgDCAXa (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 20:23:30 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37156 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388971AbgDCAXa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 20:23:30 -0400
Received: by mail-pl1-f193.google.com with SMTP id x1so2011438plm.4
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 17:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xQTHwBEAxwCG1C6nV82HGMpvkFKvKWTbtkNGcnj54TQ=;
        b=FICGKAteVTErwWuqEH7AGsbKdTgOd2tO2RFNbuniifIDgDuV8gqaHcFyC1l3hnpbW2
         dpgm1MOebbCGdvpRuEzp3eGoIW7F3LKLknk+JTbOS+QiJ5R8P9uSfOswVPhulaHzcRCq
         KQUv0hTHaB9aHPsgBaSjvwS9H6g5o3Ujrh8BdwTPzwr1sNTCHTmUUnoi51RAbHCPRJV0
         U3ikCV/kOyGdK5JzCzIQWBx72X6WX4gfrJvo873D+ir6dHDR0koFa4lLC8kgXQ+VbDed
         2ecPZ/L3CnOnHhGroAGM51XLfIP4sAHgTcmVj6RFz7JQaLlFVxm5gpQDWT5DMPKyGd+Z
         tMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xQTHwBEAxwCG1C6nV82HGMpvkFKvKWTbtkNGcnj54TQ=;
        b=dUE88oBhaFpmM9DmeQEpdIykMAjfrnY/MPsDwH/pLem+ipzB56B2KYfLOsajhfDmT1
         mYtJ2D4+uF1uvEpd9phjhQKkMm+PSyjlaqZhJMJ/Gl57eu/QFmfSryi2VSCChEQ+5voI
         Fq8K5yCzGzJ3nNinzeSBxXbiN2l9Cv4e6tVkOHc0ynUgBHZPMJe9NHAIHfb49hJCt75o
         d9LqSABYkBKDk8DLr5o73u70fnnoD8SXOGMDlPQRy5fuytPQWv2b2vXDJPOfBi4AWxDo
         phD4dTO4o+eKyr67yZxWrghPyeLqGtZfx/nUfL4NGU7igPoSey9MHf3j8/rmb+xcPxZq
         4N1w==
X-Gm-Message-State: AGi0Pua/slKTwJ8dAV2X/3wCAG18uWw0tHRvAV1/U37rXhjp1GQg7rJ2
        VwiXF9wAlcm6p83WkZ0lIQmOJ3iF
X-Google-Smtp-Source: APiQypLGaqtDQdie1ArJbEVQHaxRxJ8bxLVEe/hvRnuSDJpOF/cuwa4tUUPsrqF89arnILABz6SYJg==
X-Received: by 2002:a17:90a:9417:: with SMTP id r23mr3248738pjo.192.1585873407597;
        Thu, 02 Apr 2020 17:23:27 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id g75sm4465083pje.37.2020.04.02.17.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 17:23:26 -0700 (PDT)
Date:   Fri, 3 Apr 2020 07:23:24 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 0/6] Travis + Azure jobs for linux with musl libc
Message-ID: <20200403002324.GA29543@danh.dev>
References: <cover.1585474409.git.congdanhqx@gmail.com>
 <cover.1585832270.git.congdanhqx@gmail.com>
 <xmqqsghl3hb4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqsghl3hb4.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-02 10:53:35-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Đoàn Trần Công Danh  <congdanhqx@gmail.com> writes:
> 
> > This is a nearly rewrite of this series, because there're GitHub Action
> > allow running directly inside container.
> >
> > => I rewrite this series to prepare as much as possible for the GitHub
> > Action series.
> > ...
> >  .travis.yml                                   | 10 ++++-
> >  azure-pipelines.yml                           | 39 ++++++++++++++++++-
> >  ci/install-docker-dependencies.sh             | 18 +++++++++
> >  ci/lib.sh                                     |  8 ++++
> >  ...n-linux32-build.sh => run-docker-build.sh} | 39 +++++++++++++------
> >  ci/{run-linux32-docker.sh => run-docker.sh}   | 28 ++++++++++---
> >  6 files changed, 121 insertions(+), 21 deletions(-)
> >  create mode 100755 ci/install-docker-dependencies.sh
> >  rename ci/{run-linux32-build.sh => run-docker-build.sh} (63%)
> >  rename ci/{run-linux32-docker.sh => run-docker.sh} (43%)
> 
> Thanks.  The above diffstat makes me wonder if it makes more sense
> to do the topic from Dscho first to migrate existing CI targets to
> GitHub Actions and then add musl job to the ci suite on top?  That
> way, we won't have to worry about azure-pipelines.yml at all here.

You can ignore the change to azure-pipelines.yml in 6/6
to reduce noise about Azure (it'll be deleted by next series anyway).
And declare that this series is working
for Travis only (as same intention of v1). New diffstat:
---------------8<------------------
 .travis.yml                                      | 10 +++++-
 azure-pipelines.yml                              |  4 +--
 ci/install-docker-dependencies.sh                | 18 +++++++++++
 ci/lib.sh                                        |  8 +++++
 ci/{run-linux32-build.sh => run-docker-build.sh} | 39 ++++++++++++++++--------
 ci/{run-linux32-docker.sh => run-docker.sh}      | 28 +++++++++++++----
 6 files changed, 86 insertions(+), 21 deletions(-)

---------------->8----------------

In _my_ opinion, I still prefer have this series first.

But, if we prefer to have GitHub Action first:
- We'll need 5/6 moved to that series
- In the rebased of this series, we'll change about 10 lines in GitHub Action yml.

If people think it's better that way, please tell me, I could re-order it.

-- 
Danh
