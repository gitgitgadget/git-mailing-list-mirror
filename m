Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1210C1F463
	for <e@80x24.org>; Fri, 27 Sep 2019 12:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbfI0Mzl (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 08:55:41 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:36001 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbfI0Mzk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 08:55:40 -0400
Received: by mail-ed1-f54.google.com with SMTP id h2so2250310edn.3
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gY/2HabndTukQ86clZqDIiTQcoATwHE6J5WuT+GeOyo=;
        b=pzwO/MMei928jKmZ/WEuucvtaEvgrAXItvIBf91HYeYe72N+rZFYo3EdkQUcQeICDe
         +nrPd8k6xXo5VspQvJgM65y4wBdykVpzL8xRmOiYuqsunMp4Bap4WErYL22kCMrar9BX
         RS+OSx41hqpNSWsn298JX9w7xfT0fvHbIaTIL3g4oLD8iJpnYoaBXtqTpKl47ZO9UUYN
         9yvZCIdjduwU73mn96HdFiIBatiKzitHpUxz5EHtnWn+xrRkMBU/SitfSu0M91GUIGX7
         xnhfV5UmC6oEyGKXqSI9OGMrvG13s1vDsU0X4QuBn6g4udoMA67Nva8u4BR7SajaiHBF
         vTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gY/2HabndTukQ86clZqDIiTQcoATwHE6J5WuT+GeOyo=;
        b=XY8V145Emh5pxXNoF1qqWL38+11ZxKj6sYnWGwrHBokQ+YvISZ8NuRd4H8MQhetnCZ
         KLhCCiLsMVhns76nqyG01qrpLPnBXa/GT4KRN5IrnebJhwYOt2A5PE5hEA2LfrP6yf+p
         vZ2AqQgNGnEjOdvvT/70g7muS05ZSiaxL4uSRUPLDFoQn05SU7K+b3SA8CPol5gpE2pi
         QszRwds7KP6dTwbPA4yD09XuKhnnywFiKd788AH8FKDM4hD/DvFQ2VuRop6IieQ9lM1y
         vlmZuECB4fAs0nNgO3JNQ9g2pg13tbrMexULS6LlnoJ97WE29w444ulC6+Mg4vYIkDIv
         knVw==
X-Gm-Message-State: APjAAAWZvuLbesabmDpgikxVkcJC4Orru5vO3GefZiuIzDsNORG+cNeA
        VcD14H3IajgJthIITdBQ1QI6nZKnSsg6cvbH5WKSSoODhyE=
X-Google-Smtp-Source: APXvYqwjvGcVLMTFBxTTOezr2QILP/ZkQK3Uc3K/PlTLZihZdz1vJo75ddC5tOak0CKpMr2t+4KE1sYY8mGYsthkpeA=
X-Received: by 2002:aa7:c6c6:: with SMTP id b6mr4293368eds.19.1569588938841;
 Fri, 27 Sep 2019 05:55:38 -0700 (PDT)
MIME-Version: 1.0
From:   Ian Kemp <ian.kemp@gmail.com>
Date:   Fri, 27 Sep 2019 13:55:27 +0100
Message-ID: <CADZUK1cjvifbFYk9w6+vE95jgEBuwjoOi_1QfZHoPFBXuXHCCg@mail.gmail.com>
Subject: Feature request: different exit codes for git stash depending on
 whether stash was created or not
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Currently, git stash's exit code is 0 regardless of whether it
performed a stash operation or not. Third parties invoking git stash
are therefore unable to determine whether a stash was actually made or
not.

It would be helpful if there were different exit codes for the case
when a stash was created (working directory dirty) vs when a stash was
not (working dir clean). git stash create suffers from the same issue.

There are various workarounds for this e.g.
https://stackoverflow.com/a/34116244/70345 but they aren't
particularly pretty or reliable, hence this request.

Regards,
Ian
