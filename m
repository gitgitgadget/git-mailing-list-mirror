Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F181C433E0
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 17:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA5A32084D
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 17:06:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="npKdiyMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgFLRGq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFLRGq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 13:06:46 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B21C03E96F
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:06:46 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id r15so8951062wmh.5
        for <git@vger.kernel.org>; Fri, 12 Jun 2020 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=EeJOm4/hXAjNW/I8HEnjCrRNEt/TyhXn1/+e4jrSoZc=;
        b=npKdiyMWYhrAkb0r+sBk/ssuCfIdYWWfDN7//a42iERQbZAPyXTCpmKXFlztFqZErO
         jkSUsxXfS4qmMNTQRjw+ovJSa3VAI3ZgFnXSjo/jB09fLXiNk2+vpKUNSC4BBFfrmK1t
         7OXutHA3XcztDBB1jdSH0PVkzJ14+en65t7uzgVDWAga7pHuAFn7B2ih8mVBauNhC6RA
         O1buTKQcIZ4OmxERU+U4lwxayIxjrHzDgNTjQMpLrHXtoMrfKewvUkzhmjzSDjK2IH3j
         +inrI2vGwJtTJcioL0cgLwfODZkIq1GhJoscN1H+nTVI8WriGB+WixMP0bU0zACllpqD
         +sGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=EeJOm4/hXAjNW/I8HEnjCrRNEt/TyhXn1/+e4jrSoZc=;
        b=tali8aqUZV3CYyZp0s7nUktoNbmsv8heAM5ienAWta+Q8sjQbiPHeEdAKb7ppLe8dG
         qxyGTXREHY7i+5ExgTy9NoMKqEZURNAwrH+o6+/kixQ9yx9QbBL7/llU/rQ/LaVINAbg
         +A90InPJ8KBvdrb/wZcszyIfxJtG5kyjeb3VVeSxBGv7RjjpKXOSQFLGWfJfzRMNvfcv
         cVacDvaTn8e7rC1q2+p0CuYWK39s7xDIpteXJnqsjwpTxGi8WVnyzEW15RzhPcPDRLnG
         L+JHLePIM7Ai3+nf6ydf7xSQ+2grvH1JYvd5/xMHYsAlmAqZ4CqDPhdmxqdL0u1A6vNA
         f6kQ==
X-Gm-Message-State: AOAM530cGOuVQrzIUOrqRBLQ1DpIdEEBQGcITa83mSJzxMMwU82UwYwD
        mgoSZat5ZEOcy80SnVnSkTNYt8Nfo1ugENz9qen61sIBNOo=
X-Google-Smtp-Source: ABdhPJz3tvX50jOC/Z2e3CaM0ygVidOut3/Twl+HObKS1DPfqWMc5a0rVUaKr1kf3RLGwHQOfcccAFw6clBue36YW2o=
X-Received: by 2002:a05:600c:2054:: with SMTP id p20mr14583481wmg.153.1591981601061;
 Fri, 12 Jun 2020 10:06:41 -0700 (PDT)
MIME-Version: 1.0
From:   Anthony Sottile <asottile@umich.edu>
Date:   Fri, 12 Jun 2020 10:06:31 -0700
Message-ID: <CA+dzEB=OiqaEW0CEQoChStZYcho68J9ysH_XYp0Qupbrgg1Jxg@mail.gmail.com>
Subject: git for windows: isatty of stdin / stdout inconsistent
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

this seems inconsistent with posix platforms

(using cmd.exe, git 2.19.1.windows.1 though I've validated this with
other versions as well)

>cat .git\hooks\pre-commit
#!/usr/bin/env python
# note: use python3 on linux platforms for shebang
import sys
print(f'stdin: {sys.stdin.isatty()}')
print(f'stdout: {sys.stdout.isatty()}')
print(f'stderr: {sys.stderr.isatty()}')

>git commit -m foo --allow-empty
stdin: True
stdout: False
stderr: True
[master (root-commit) 9c7716f] foo

but on linux:

$ git --version
git version 2.25.1
$ git commit -m foo --allow-empty
stdin: False
stdout: True
stderr: True
[master (root-commit) eb8435a] foo

it's also weird to me that `stdin` seems flipped between the two as well

actual issue: this is breaking coloring detection in https://pre-commit.com

Anthony
