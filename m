Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 430CDC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 17:03:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9356139A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 17:03:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355508AbhESRFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 13:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355502AbhESRFN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 13:05:13 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F666C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 10:03:53 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id v8so15167654lft.8
        for <git@vger.kernel.org>; Wed, 19 May 2021 10:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Cw7JVJAG25z70J3eRe7TX3D9xZAs4o7p1iFCE6ukiB0=;
        b=tYTl8mnwDH1TiZ0NNrUa9GTTMp+TNBy+Dz1xtfl1M5bjltdHk7U2XLf9kBleNsLHnl
         XE/Iht+gkYbdLPvC/ANGlnlUUJVcWs1V8IIKdLrr1xe0hw2DA2+6EXNd438KxEizacAP
         oGV1+VVuPI7kPHcMZKhSayygvhZCfN0dDavxSGBI94P+YDz/QJGqHOy4Kq4JiMA9AqPD
         EwOhZv6ky1MoB9avkWQs+UfcMRYcmXrkJDnHIPrgeu2pojkpqJsfp+UTMEV8rgRvAEHx
         RRGHBytFrk9qXhQhDV0f1H9yzc/3vHYBnmWe7mkvRUIG/n0WuYzfJjksteBua6fVJsU0
         IGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=Cw7JVJAG25z70J3eRe7TX3D9xZAs4o7p1iFCE6ukiB0=;
        b=E1PYs2PdF9/A4OthlGJd0GTwWYnpZu/d1AxPdhLuKMTViCKfZ1pE2gsQx8wtBUIm+6
         oo4bdY2u3Prf0xNjzat5ErHzbLJvAmGTX9WuYiWyHsIrFMe4MeUDc75JFkqzpMWb6np3
         j2gLBmxGToUkJ4xE4VUKPHsTle9qGKfYj3ZidnAxQIsxBlc3K5jhbsL4KtBFAE3vLORV
         3Qf16iK/QOW2MKb6EmvmHk1S5E0f0V2IU5SW1hgBd8jZ2aTkbAXBD0rdqa/AauCnIH1B
         TOQ+MemJvwcZHZyzCgiz2A8YL+PofKLzqJWhURJLCQmrx36Qgpc610z9wNcCOLOm3+Ta
         tiWQ==
X-Gm-Message-State: AOAM530oI9D6lxcePAE92zf87RTrcFU6L0FSGjwdxnQAECcf7qioha5S
        1tFe3RFUgStYrY3/azIV2hb0ZiNiaf8=
X-Google-Smtp-Source: ABdhPJz2ww0PUv16sDrwvCV2ZOYYs5Z5avRcVgxEakXOOybOxzwubNKEN/TJLAbGoiM9LqLS8HMLtg==
X-Received: by 2002:ac2:42d5:: with SMTP id n21mr340406lfl.164.1621443831026;
        Wed, 19 May 2021 10:03:51 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id r14sm24807lfn.217.2021.05.19.10.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 10:03:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     huang guanlong <gl041188@gmail.com>
Cc:     gitster@pobox.com, alexhenrie24@gmail.com, git@vger.kernel.org
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CANvKV6anT0MV7GDeY_Cd2r+BwvMjsTdmjK+s_DKth7ZqL0XRUQ@mail.gmail.com>
Date:   Wed, 19 May 2021 20:03:49 +0300
In-Reply-To: <CANvKV6anT0MV7GDeY_Cd2r+BwvMjsTdmjK+s_DKth7ZqL0XRUQ@mail.gmail.com>
        (huang guanlong's message of "Wed, 19 May 2021 18:50:29 +0200")
Message-ID: <87h7iy7j0q.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


1. It's -m that does now imply -p, in "git log", in "git show", etc.,
wherever it's used...

2. Manual says "-c implies -p", "--cc implies -p", and now "-m implies
-p".

-- Sergey Organov
