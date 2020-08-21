Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4AFC433E3
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 05:22:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EA5921744
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 05:22:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HUxVvbN+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgHUFWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 01:22:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgHUFWp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 01:22:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E8EC061385
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 22:22:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q93so449031pjq.0
        for <git@vger.kernel.org>; Thu, 20 Aug 2020 22:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=6/N85p80HNTxtx/BFbz36M1bHUgXkxRaw7JEfcbI8gw=;
        b=HUxVvbN+ZalEn7y93FuQseAH6i59pBxu5wh+c/C8MGyT/J/ib+EQKznpCNO9aLy9Rj
         olqJ7i2mrjXdB4t0Wjj9PVkYC7Kpf5e4roO2MmkAYQKsoiGtnOKpIPare61HNfqInB7S
         w7HpeJ36mztFL5pBMRmI+DnMdtPjaVgGaNJhmSbFZ+931F1nZsBilZgLC4OWka8phvGG
         VA8ivYM+wsPZst8qft6ebrMLvJ+36rtDPl4d47l0pFNgkwek8ZYsyi49PJGY9I3eSaD1
         TARHewo7f+qpHRceQEEuRjUPzkJix2RWgq5Pl05pKyyDxIkbCqB6ON6dl32TjjfVHKEm
         Q05A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=6/N85p80HNTxtx/BFbz36M1bHUgXkxRaw7JEfcbI8gw=;
        b=taZH4ggUYPdupR7A9x8H2d7RJmRNFeZqrHC0jYw6OYM8myg22RuliJKCno2UBLu+6Q
         AYU4L/vixMSx2RYIAiVMRgsAWX6+PXCUT2AnLoW7ONo2D6olAkkOCoqpgiAvV7xmdOK5
         uuw6uOMiIHe5D3qQjnp1Gz0vlY8ooXXf55ahy3MKF60RkpTOrMfE02PVf4LxNTvq2O0F
         IxzaG1zOWNpmoci2NxmGfAw4UZFCyMMAToHKIjy+3o53A93+lPgSsh6t3O6UXbFHySxS
         QQhgLBJro66DlaNvUEB+pb53VbH1aUcGzZkNpZK9xLh/6MhNxTo/ff3d5X7B6h/wjyzM
         muDw==
X-Gm-Message-State: AOAM532KFug5R5vfSy3BB8dZQnqKzEbLPVw3N15TFoZBPvCInXlBtzz0
        a5XPKvNZ6E1uDmXQXjI0/i4=
X-Google-Smtp-Source: ABdhPJyVfVFDj6cjUoZfA+Up5uDXOU7OvbqbBhmnsDVTRoMQpHBE5EOBmhXlhMswVyVUGybfO+BeKA==
X-Received: by 2002:a17:902:9787:: with SMTP id q7mr1200016plp.0.1597987365050;
        Thu, 20 Aug 2020 22:22:45 -0700 (PDT)
Received: from konoha ([116.74.59.254])
        by smtp.gmail.com with ESMTPSA id y10sm898124pff.177.2020.08.20.22.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 22:22:44 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:52:35 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     peff@peff.net
Cc:     Johannes.Schindelin@gmx.de, chriscool@tuxfamily.org,
        christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        kaartic.sivaraam@gmail.com, liu.denton@gmail.com,
        pc44800@gmail.com, shouryashukla.oo@gmail.com,
        stefanbeller@gmail.com
Subject: Re: [PATCH v3 4/4] submodule: port submodule subcommand 'summary'
 from shell to C
Message-ID: <20200821052235.GA84497@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818020838.GA1872632@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> The "missing_src" and "missing_dst" parameters in this function are
> unused.

Yes, they are unused.

> I _think_ they can be safely removed, and are not a sign of a bug. We
> seem to fully handle them in the calling function. But this is the first
> time I looked at the code, and I didn't dig too deeply.

Sure. They an be removed. I am sending a patch for the same.

