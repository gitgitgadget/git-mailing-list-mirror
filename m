Return-Path: <SRS0=Hc2o=CM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2108C433E7
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 09:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E8C9206A5
	for <git@archiver.kernel.org>; Thu,  3 Sep 2020 09:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cjtJEvjY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgICJji (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgICJji (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Sep 2020 05:39:38 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E313BC061244
        for <git@vger.kernel.org>; Thu,  3 Sep 2020 02:39:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j2so2437119wrx.7
        for <git@vger.kernel.org>; Thu, 03 Sep 2020 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=+N1mp7Sp3vJI2PRJBRrFrY58m7ZI0KwbGlgZ7qfurB8=;
        b=cjtJEvjYMdzgICjXHhHeIPN/sFSqgC7d8RdrpwRcDhLy65k1YFT2Y0RaeyVn3bwmvW
         k6tgmVt5XZnWsOOwH2jc8eFbWXmQ2O/8e+FOzz8rGOVHmjmJOYEhjMQ8kD4Lstb77Frp
         gFd+e1C9nw+CIzWKhnLV1cOBb80xgD5Y5p27V/1YpCGN52VHdOE7sHbIqCVOtWKuo6ND
         /QaU8J5x9/SXwN9AV5tZyNia1myosIXtbr0wxV9FXim0kkhDh/w4v3hYuyY8ieD3fETj
         WFbk1gBTTueuUt+2fEhAbVununKzZPbftrbQzSMEnQnIfUD26wi4zm2kepFzRx5qgSZX
         C+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+N1mp7Sp3vJI2PRJBRrFrY58m7ZI0KwbGlgZ7qfurB8=;
        b=BAZqFSSBdfJCZuJxkhWJ4QuQ/Z2dIkRfyOCRwOLxaFWfFD2CmdeTOAMVn3rTpA1SDu
         YpGSMWBHsDC8zg5kaB4yOgD/BfTybsu/LU2kSfxMx9M02N+kFm4DsyaSbcJuCj0MwuJm
         /oOXNT/hLUq1oTIoJHkx6eN4L+4A+Ej6Kf5jZQX6Yb5sMxFiZRJkEEn/dhXTIBxaNg4o
         rbUm99EYilNpYIG7CQOfRE5tchXzSvmI2FIZ1q6RKUTUmVKtDbrtssFDyIukiWxf/6ah
         SnwZ9eR5HZp99rBx6RMfQB318yx9KzMp46QI08ZpdzJucd16xHGlRte6aE4YvoT4s0sI
         YICA==
X-Gm-Message-State: AOAM530rCQWolXUXybYq4xV/zQbBxitTUlhIqSwxjTjFETsrAOs+nEK9
        MT4B2mMDe3QTL+o6RJvoJYItdYaITIgbdV57WuLt5A67TnM=
X-Google-Smtp-Source: ABdhPJyVwG69XipAHLEbqA262OMEgzSOCO1QwjjpR82ckh5XvVNOFKqsL0N6JETFWt5xvPPR881ddj9z8WhKgnG4iko=
X-Received: by 2002:a5d:5090:: with SMTP id a16mr1558433wrt.247.1599125974592;
 Thu, 03 Sep 2020 02:39:34 -0700 (PDT)
MIME-Version: 1.0
From:   Victor Toni <victor.toni@gmail.com>
Date:   Thu, 3 Sep 2020 11:39:06 +0200
Message-ID: <CAG0OSgeb0jcUmkjp+yzCPYkxQWCZFy3gYM9o7TfBGvtf4M08NQ@mail.gmail.com>
Subject: Aborting git rebase --edit-todo
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When doing a commit or choosing what to do for an interactive rebase
one can just wipe the whole content of the editor, save and close to
abort the action.
While doing a `git rebase --edit-todo` I came to the conclusion that I
would like to abort the edit and did the same. The final `git rebase
--continue` got me rid of the rest of the commits...
(Fortunately the "missing" commits could be rescued by looking into
`.git/logs/HEAD` so thumbs up for that. )
Unfortunately the behaviour of `--edit-todo` was a bit surprising and
somehow doesn't feel consistent with the other actions involving an
editor.

Can this be considered a bug?

Best regards,
Victor
