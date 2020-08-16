Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EBC2C433E1
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 00:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAC320675
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 00:14:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtlPktxQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgHPAOS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Aug 2020 20:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbgHPAOR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Aug 2020 20:14:17 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 266A8C061786
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 17:14:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id l23so9528363edv.11
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 17:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JgaKx/vxVvasuAIISaYVQ43pXhtcAIR2V+TkzWbX0w0=;
        b=FtlPktxQ41IeuTM7SKFBXejlkDxzpQGCYgeoHhD5H4lzt+BQ+urfhm/yre8KxgjJ58
         UXIOyHMBxXl3/yGtQpqJ/2yvLEsfknp7uFFZupo2euOw7M5Yaj/IcaesRvKRcJMhFvWj
         ROCyddEPISwtsDfpaAQz3b9fHWowtnfaqNpbDx8IaQvqMboYSfoX5+l2ZroysDoyGpU/
         WiBKO6tIIQpii7rpOvBNeX1gAVQvGoLWNrdBQ0rIvwhK/8VMv/fV1j0KFsoPXdOkg9S1
         An5/TwOFWPV+O8VW04d9rJdtSu4SNe5405D5mNK3be2YvSyfudsmc0FD5A2Ttn8ZTNSh
         kGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JgaKx/vxVvasuAIISaYVQ43pXhtcAIR2V+TkzWbX0w0=;
        b=t/gsC4bUblDEXJAeT3EVajx2ss2wsOzZ9DaRIP72GzaRW2Vh90mnRd3VKpPpfMZdVv
         hLfhjyDFN7OxAMw6RU1tPbiXMfn8wqMVEFjjQkOqU/4mhD7rDiYn9Kuyuoz89GM19T15
         vz/iISZOAwslGvvGpOZRGItt3oXKywD75pxhB2p79w93sTGoTg8BPp97+9sxTnS9+L1q
         L6SC9MOnMQX/CjoOeG7OI16DCxgKAZ5hwR6liws04snDJxa7cSVFzXPT9QCr8PRNlOTj
         52hsYy5GvMYuPKQSkLzpTRIMZ+NiRo3Ay6OMp8hq/TI4/+gEFV+rW5CnAwbvn816YwBf
         oy0g==
X-Gm-Message-State: AOAM531GE3ssZeVV2OZTxT/1i9PgUAyZi/TEeGxJLB7gBfmNluBAu4LA
        VP1VOfCEw0Ht0ndPDblz+w4=
X-Google-Smtp-Source: ABdhPJxZJ53TZMB+Y739fgIYmlOnxhCzj09+YEY7CD/ROSvLcnTPG+wcq2f1GpVz9mYtNPXRsrLSbQ==
X-Received: by 2002:a05:6402:22ab:: with SMTP id cx11mr9140742edb.102.1597536852785;
        Sat, 15 Aug 2020 17:14:12 -0700 (PDT)
Received: from lesale.home (193-83-182-249.adsl.highway.telekom.at. [193.83.182.249])
        by smtp.gmail.com with ESMTPSA id js19sm10943491ejb.76.2020.08.15.17.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 17:14:12 -0700 (PDT)
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     sorganov@gmail.com
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        solly.ucko@gmail.com
Subject: Re: rebase -i: quick/inline reword
Date:   Sun, 16 Aug 2020 02:14:01 +0200
Message-Id: <20200816001401.1144752-1-aclopte@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <87sggab031.fsf@osv.gnss.ru>
References: <87sggab031.fsf@osv.gnss.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> >   !f() { GIT_SEQUENCE_EDITOR=true git rebase -i --autosquash "$@"; };f
> 
> These are very good and useful features indeed, and they are examples of
> batch processing that is very handy for automation, but lacks
> interactivity. What I rather have in mind is being able to put all the
> messages /simultaneously/ into my favorite text editor and edit them
> more or less freely till I'm satisfied, then "commit" the overall result
> by passing it back to git. Essentially "git rebase -i" on steroids.

git-revise is a third-party tool that can do this

https://git-revise.readthedocs.io/en/latest/

For example, "git revise -ie" allows you to edit all commit messages in
@{u}..HEAD in a single buffer.
