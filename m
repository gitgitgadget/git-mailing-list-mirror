Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7399AECAAD3
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 21:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235077AbiIAVAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235072AbiIAVAP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 17:00:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 418C4A00C3
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 13:59:25 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id y9-20020a17090322c900b00174c881abaeso8124776plg.6
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 13:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date;
        bh=6brB91Kei0Nurn7t4H2VYDxfS6nFqF8DaFCrVKcOVcM=;
        b=ftqGhIJP6pexWs7Ut8F2C0p1LZFj8KmomLR1jfmwa77TujusUalvL2WKJgVx05hvKs
         wecQAqZW/yfxHuuEC3hrOMaiMngvLaFJZkfnGKcBKWYMDkyKtM6xG9owdC8SRyAHQZy5
         K88U2+POAjzspy3O0Lv3wT9MnKOeUbPjpk6b6sVC1iw6fpEAPjHFuREoEvOofGSiMXcb
         aM/pxR542DCob+mTjf39h+JMHGMZu50FUavjyHknzGAkC6NQyaeJ0Hi02e3N7nxjNhUp
         GNkpIaNiMQA1+eQ6IoIwkAGipHqXKXyJmF8Y+/w/FAGnCp4NI5sgC1ZUrm3Rez+tMLN4
         dhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date;
        bh=6brB91Kei0Nurn7t4H2VYDxfS6nFqF8DaFCrVKcOVcM=;
        b=d8LOVU9ULYPXwZ31/m1/W64cfrQOKLdDKQcKL8pT+IkmIHfrfjvIAXkiphFruXQuUL
         X7pAe0Ii5iZKu8BthXefraeDWBzTGZi+30Zhp2rcu3lsHqQ9458yUQxUc1gZkJYIjfF5
         CfuAF0my+6cn+ca7+Y4n5fe0mYwKhXmsEIeZ3PsOJcoZLhMH7dUPx0qrDmursewKfarB
         oI6OiUkiaoJC7QF/i42yjGdwV6GG4aRA7IKbWEG9aO3V+L/kzQEBQQtvCb8617sByGi0
         pe3PdMS183MRmgfAsz/PsLav3b592CwTe9NO9ZS9lVqE9yA35Tz/DIpgUhx8EbrQt7Xx
         EKtw==
X-Gm-Message-State: ACgBeo2uCPSWSd+sWLmsXJRKujqxIwG/dSLYneOsIUKBkPPD+YAt0Dpz
        EbiH8U/dJv6yuYCps2bhb/9anXZkKwwPpw==
X-Google-Smtp-Source: AA6agR6UaaMl7x+s4qSD0qo299OpTIkDE8vU1ZZlknDie8tVsru8TdrOZcQldjlywlWDT7/qZgJiVy1uqF3XHQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:1a14:b0:52d:5fee:d46b with SMTP
 id g20-20020a056a001a1400b0052d5feed46bmr33005265pfv.82.1662065945202; Thu,
 01 Sep 2022 13:59:05 -0700 (PDT)
Date:   Thu, 01 Sep 2022 13:59:03 -0700
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
Mime-Version: 1.0
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
Message-ID: <kl6lwnambylk.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v4 00/33] submodule--helper: add tests, rm dead code,
 refactor & leak prep
From:   Glen Choo <chooglen@google.com>
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> This series is a "prep" series for the meaty leak fixes for
> submodule--helper, see [1] (which will be re-rolled on top of this
> v3). The v7 re-roll will be at [2].
>
> Changes since v3:
>
>  * Addressed (hopefully) all of the small feedback, just typo fixes &
>    commit message clarifications.
>
>  * Marked a parameter as "const", which helps reason about subsequent
>    things in the "leak" series.
>
> Hopefully this is ready to proceed past "seen" in its current form...
>
> 1. https://lore.kernel.org/git/cover-v3-00.32-00000000000-20220821T130231=
Z-avarab@gmail.com/
> 2. https://lore.kernel.org/git/cover-v7-00.17-00000000000-20220831T231003=
Z-avarab@gmail.com

Thanks!

I still have no comments on the attributes and macros on 30/33. Others
may want to take look at that.

I spotted one typo in 31/33's commit message, but maybe that can be
fixed on patch application.

Otherwise, everything else LGTM.

  Reviewed-by: Glen Choo <chooglen@google.com>
