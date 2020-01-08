Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C229C00523
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 05:28:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23D7420705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 05:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="bjOqjMit"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAHF2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 00:28:16 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:32871 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgAHF2P (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 00:28:15 -0500
Received: by mail-wm1-f45.google.com with SMTP id d139so15668261wmd.0
        for <git@vger.kernel.org>; Tue, 07 Jan 2020 21:28:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=lRZEYXqWaGIpKsVGrefp253OTMSCQk208hNJo74CnHs=;
        b=bjOqjMit9rUp2E8Io1WkzNFhzKWnSr+OjTFhpLKIzZE9mUHFTpz+dr5FkHwbguJPyc
         /ZpnJLbFxX82yCOjJDGsDDaiGAGtZ1e3dqiJdIvhnTzfZHb9k8eqvWSMtHG9B3fbE4c8
         r6swS8AByyCvODmuWLjgOeXvTyGxhGNXM+2+Mo1FB5QCwWl2m1wc63RfIjy9IjeVYNSu
         O5Jioxs/iGnW8BHXwQ7dRRzrwYvfQlYWYP1YA8jx4Zafvob/j0BT9aChZyl8mTtC0Ffi
         GcSSTFO6VIjpprJzLOBW04VVwEB6x8gTJQSvEuuaZ+x+2I3GREPtIG4ChsXX0+xzoxLK
         4XWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=lRZEYXqWaGIpKsVGrefp253OTMSCQk208hNJo74CnHs=;
        b=RPpCazft++LFk1xniaC5u0532pzG8s9H75ANOJK6XrMfQta0m1kS7Ut/T5FfhxltZb
         JLmPHDysgwPGFrzO+2wRGh9q6hSCBGolbBS0FJPDbdf4fMAZESLju0OUPyjRUfFOjZbB
         wpJrFkUmdwP0Z5cZ36ahLkuk7lOJ/FpKXu0qfB+0Yai/KBNC30zpM9ZgUs/caoQDSKRi
         JySUmllPH86xPAk7KUAa/Ze74Vbmv6NAcxhCSmyV0Pq2gKS8Kevv5FLd4ysWCq2oRRWW
         ZiOJ0M37XHvdILbzyr1d9pDK2Ze0RXjpWCOAxLAy7QZovLWKOMZEd8axX2fTd6uZSsq9
         bp8w==
X-Gm-Message-State: APjAAAWVD3LH8+CL4FrQHxfDBIs24KJ/pFA9hDWnZuDIPiavDUINOx1x
        W8tzSuGhLDWOUYNpS5jhJ5TUcg9G5bhxJ5PHkA2NmGIcuJQ=
X-Google-Smtp-Source: APXvYqzxYActCY1GinRor3q2V/kvPeOqTrI4sbbECLWXVGoUzcFpzWTR7IujxWkN+t21aSya+XCJMDPvl1rM2szF6DM=
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr1543244wmm.61.1578461293871;
 Tue, 07 Jan 2020 21:28:13 -0800 (PST)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Tue, 7 Jan 2020 21:28:03 -0800
Message-ID: <CA+dzEBnT2Bgw7iwVWiHyCKs1V1oaSuEb8rR+dmiO7RbqpaVjgw@mail.gmail.com>
Subject: `git fetch origin ''` (the empty string) -- should this work?
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this seems to end up doing the same as `git fetch origin HEAD` but I
can't figure out why -- perhaps someone on this list can help me :)

$ git fetch origin ''
From github.com:python/cpython
 * branch                  HEAD       -> FETCH_HEAD

what I expected was `fatal: Couldn't find remote ref ''` or something
of the sort as would be seen when fetching some non-existent branch:

$ git fetch origin wat
fatal: Couldn't find remote ref wat

Anthony
