Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4A220A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 06:26:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726036AbeLKG0y (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 01:26:54 -0500
Received: from mail-yw1-f52.google.com ([209.85.161.52]:35239 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbeLKG0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 01:26:54 -0500
Received: by mail-yw1-f52.google.com with SMTP id h32so5003953ywk.2
        for <git@vger.kernel.org>; Mon, 10 Dec 2018 22:26:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=aVLetoBXPdhDZ6AZ8/WnM2W0xVm6k9e95QBQ33pOcP8=;
        b=QOLSf9IlsvZnHps/dIbbrXz1HkEBfiv6Xd7zjxxuZ2wq0GAvVWadIKs1/+XUqPJFo0
         IZgig7Dp7mkMNYnHJC+oQadUzbovAbUXTIw6L9KNNA1sukmdGigw9pMGPt1OlBPyM7Ap
         OyqRcLQFa8PP1qJSeFmnf6cjoN8+Fkq2c5YPYKNWBut95dSlO/Ge+xEzmdtU6NgqFYeh
         26yRbG/cx/C8caCAWSB7HmZdyd/GsJMpJ8EiA8YmQawdJT7/wQz3zDo7Qe09X2CuNd3s
         IObeXNKiyOwddXGsTN85Z9WZL0I0dHceMuuy/E7cHw6QDS14uCGnhDuczr6Gw1KpGSWo
         bnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=aVLetoBXPdhDZ6AZ8/WnM2W0xVm6k9e95QBQ33pOcP8=;
        b=WRsh+4CM8AgJns7BzQXTj8oaEAg63JLSksvJX0CH1N1mdkyQ6SHPWRO3qFq4kqZRV+
         aEyVcGnjmDE9+lKDhVCL3i+TjnWUPAxXVGPNbkwaxOOyYo8caBLlEfVNGglHQ5V91EbB
         MgAPnY0rk2XBPcAJJXPqlVW53kNZsjdZvRo1/LMEuSu/ub7e+VefOX9R/lVBQBJYUfli
         fdoIuJXZPnfBTepAiJ8x0fULBc6j/GcnLkxQbGCtvt3+8Fvi8R8nRG+ufRAfTiZICRdn
         cVP6/V0bIt9uHYm0YiRLpdcMpEKshzi1DOHt734llchC6eHfo9EgxcnayZaukmDr+jbZ
         1PfA==
X-Gm-Message-State: AA+aEWbCnwwR512Y2OaE/EXxojgM1SS+r7BerJnu3dEjd5FC/TYBljRT
        OgG4q1Ry5YsW8Bd6WNLa2P/q78H5Kjm07AmUPjPsdozz
X-Google-Smtp-Source: AFSGD/X5DZI3mz0Og3FXh6pKvYVSeZT9mHT1etsPL09aXfsGnfMCaYhSA+3OFy1VqIe/MbpI/5L8CLDnvFu3xm1M1rE=
X-Received: by 2002:a81:ac0f:: with SMTP id k15mr15226430ywh.469.1544509613573;
 Mon, 10 Dec 2018 22:26:53 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?6K646ZOW?= <thexuc@gmail.com>
Date:   Tue, 11 Dec 2018 14:26:42 +0800
Message-ID: <CALmyJ=OaZAgr1i1DXMRQqCVWnKvO=QZH6AeGj8YfKMxAnRz6GA@mail.gmail.com>
Subject: [BUG] git help -a should no use page when in pipe
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To whom may concern,

Since git 2.20.0, invoking `git help -a` will cause git using page (e.g. less)
to display help message. However, such behaviour is not desirable when
`git help -a` is run inside a pipe or invoked by another program.

Step to reproduce the bug:
     git help -a | cat # this freezes the command line prompt.

This bug also causes issues in `hub` when invoking `git <alias>`.
More detail can be found at https://github.com/github/hub/issues/1963

I would suggest `git help -a` only invokes page when stdout is a tty.

Thanks for your attention.

Best Regards,
Cheng
