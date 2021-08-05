Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B24C4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 04:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3205260F0F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 04:01:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbhHEEBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 00:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhHEEBp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 00:01:45 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD775C061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 21:01:31 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id x144so2319968vsx.3
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 21:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=sccYa/2E8bgCYgV2bNsDSMhpT7cXENjaKXvqrwrWM84=;
        b=h7UKUeTJQABvMnlrhRiCMQs0ukwFpHSmHPhAI1/rCDMstOLvK/VRWqnfaP7+MllPhX
         kxkDvZvb5FB2nIlHLGX7R4V4uhjMOPnljmP86swrQY1vrAxOw8p41yxEddE6smMy7arT
         hAuiTceoyariViy/Nr6+TdchtQEcXDRAHSSy/wmf+kEqNrtoca5Jt8o7jbGoEKO5eKIM
         y2h+eq13aYGJ2sAFlyQFjOMmxoRaehbMffw+0jK3cQp+sEYB1x+xK79O8SrAhVEukF3s
         fOH/HyZgbFyEMxEAN4HPmxbvqxah8WQc7SA5sb8HA57EzWwHLvAn9FWb4DP4WnrdlLH/
         vKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=sccYa/2E8bgCYgV2bNsDSMhpT7cXENjaKXvqrwrWM84=;
        b=kVlMXtoR9RkMDCpKQHLv53BV9M0QDyYqSmAKw1DsCyWkmseAnLBvmho7elxAtJR9E6
         3ox1hc9OSXyGHTBZ8ioViLIaA4lqgaxii61HpZqAz/eNJWYbKDsSUp5cw1sxg3s5KBCj
         XaptnCZr1cNTF7bOicKrvVgFFuKrBOVtW2dQ++npCNvTQy7qRxOUYPu1WZ14FWMoRGrs
         5/5R3G0hUZ4L5BfRYkKl1QVR0l58mx7TMSXWrRDq/huPI9WP1eqUebZY4J7x6+ehMdIJ
         Qql2iR/mqhoUr859kf7LQoCUcg4LKECN4yrv7LDW/U28oFxiICcwzlw9pm3sJZfamR8t
         Etxw==
X-Gm-Message-State: AOAM5328q9rDZuyJLcE24adFfa8hHZpJe2RXuAbvB1D6PZ3hz/7wNGWd
        +j2R1//R63z0E6TKZTYgPJQT+UhRhRzRYaPTFKU=
X-Google-Smtp-Source: ABdhPJzraJP0Yvn3lv3zU0qJPR45Mm5rXBl51DVpITJHQu1kY2nFRocbf16biYsZCC5mQM9WBHRdruTN+8XoRbbZpqc=
X-Received: by 2002:a67:f854:: with SMTP id b20mr2810304vsp.32.1628136090924;
 Wed, 04 Aug 2021 21:01:30 -0700 (PDT)
MIME-Version: 1.0
From:   Joshua Nelson <jyn514@gmail.com>
Date:   Thu, 5 Aug 2021 00:00:55 -0400
Message-ID: <CAJ+j++Vj1gY93QuKDhDODXOJGXTiFFEzy0Oew+LWD7a5e7iaTA@mail.gmail.com>
Subject: Re: [PATCH v3 10/10] diff-merges: let "-m" imply "-p"
To:     jrnieder@gmail.com
Cc:     alexhenrie24@gmail.com, avarab@gmail.com,
        felipe.contreras@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        gl041188@gmail.com, hudsonayers@google.com, newren@gmail.com,
        peff@peff.net, philipoakley@iee.email, sorganov@gmail.com,
        tlyu@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> What happens if someone wants to build an older version of Rust?

For what it's worth, almost no one builds old versions of rust from source
except for distros, and distros wouldn't ever set download-ci-llvm = true. So
this shouldn't affect anyone in practice now that we've removed `-m` on master.

Joshua
