Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00073C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D563760F6D
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 01:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhIUBpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 21:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbhIUBj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 21:39:28 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49802C03D77C
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:50:58 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id u6-20020ad449a6000000b003798010ad14so193238513qvx.10
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6WLZkpFwdzpj+dWZawLUytRsghV4uEmgxPnhxzHkgO0=;
        b=jtBFw7kqRfEtJ9X03RVaGyPYS8pDn+qfIavlZTY4ykoBz0WjqrgsQ1/PVL0ogoNACN
         goX1QP0+npuRvTjcfECblwrRlO2SULVMmHO+XU8u6KtAx7IdvBOJbDRaTZfpuxyKWfHQ
         0z03loNdtFSRwzK6YyDq2gHud1HdPdIg0GPiLXTgDuc2uJ1WxoKIGUr/5HnrDjhmXinY
         pjr7NPkmiAE3gceVoJ7IOuskbhhL3rgkXh3pPbqrsPLqIuBaTzoEp3wzqxha8mbK5sEu
         ojDDKvQBvdoDjg9WoNKeTnb0SvX3yWLdcKoSaQGY3IZoXwKrCtH3gLvqChb/scKGYCsA
         8SjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6WLZkpFwdzpj+dWZawLUytRsghV4uEmgxPnhxzHkgO0=;
        b=b2INjMXbExHgnESRjqYhUPZqYPIn9T9rBm+qMy9o/h/mmvlPWNKfMT0wHA4vKU/oUS
         5o/1lOIQc2zK6uIH0sbaKj3FEVLUJJSBr2WpFSBUUydxF6CHQrdyWgVF8+2N7ljq+wjv
         fplsb7OI57l1ZlXxE8V+W/c4Mlm/KCEYuITeIYA3V938KhWpoF/QkRrS2RO8EZ4i3Ort
         VfNf5WocBbfNo7ZZld/3pJ6lhpWDSA3Ud1kLiaiH+y788NVHRkIl9obd9ApdVQtKN6vF
         taR5KeUok7gkEICV2O3rhf2XZJLPh7f+uC0HtUQTgVIESzORdgtDBHVFVXS8wz7drcEd
         ENHA==
X-Gm-Message-State: AOAM533osr59UWJHLQY9mj2S40TsDDb9NZLXYoeLmKA8SJ7HZVgr/lMa
        wrQKCkXPzStT8rAMNwWYqXwV+G5I4t7+/jQWYYkZ
X-Google-Smtp-Source: ABdhPJxcKZ9Hc+K0P6kwN83OQ9/ywPWdU1PFA3mbw2rmxB0Dv3Sxnhtpua1XxTKSlPPd/xZ8rHV6Hm62lwnf0GwKu2L8
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6214:40d:: with SMTP id
 z13mr26973940qvx.38.1632167457397; Mon, 20 Sep 2021 12:50:57 -0700 (PDT)
Date:   Mon, 20 Sep 2021 12:50:54 -0700
In-Reply-To: <YUjbKt0Hw0ieHcaN@coredump.intra.peff.net>
Message-Id: <20210920195054.66688-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <YUjbKt0Hw0ieHcaN@coredump.intra.peff.net>
X-Mailer: git-send-email 2.33.0.464.g1972c5931b-goog
Subject: Re: [PATCH] clone: handle unborn branch in bare repos
From:   Jonathan Tan <jonathantanmy@google.com>
To:     peff@peff.net
Cc:     git@vger.kernel.org, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So I don't think this is some clever or subtle behavior, but just a bug
> in 4f37d45706 (clone: respect remote unborn HEAD, 2021-02-05).

[snip]

> But the unborn case has
> an additional side effect of calling create_symref(), and we want that
> to happen whether we are bare or not.

Thanks for the analysis. Indeed, I missed the fact that we need the
create_symref() side effect whether the repository is bare or not.

Reviewed-by: Jonathan Tan <jonathantanmy@google.com>
