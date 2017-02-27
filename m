Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 555A01F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 13:42:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751440AbdB0Nlq (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 08:41:46 -0500
Received: from mail-oi0-f44.google.com ([209.85.218.44]:34382 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751387AbdB0Nln (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 08:41:43 -0500
Received: by mail-oi0-f44.google.com with SMTP id m124so12128068oig.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 05:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ko9/gBqLbf+j/PA5GvBDOiH6QkhRKpBbdXwgVJjhLBI=;
        b=KYSqLXecAIoPh3lmPmZRD7FInLk9yai/I0QLecxORZYpx/BmzTE4X9ba5h1tfNZXLn
         pJKV1Pfsmu717lfGJoEGoKJYNuX8lhPeP7keaF1XmPHwzOJHVYNw8rkCJulwda7onTp6
         n+3c2g8VxC/qLCUgDlSGh7Sw/iuSjcw1okyURbEsSKs+wvrsEWGAKzLE05ApBqYfHumw
         +uZbmR7olalRfXG3rvDjnbbf9I8F+p0jgkaiDkWTOU3b9E4xbfDGHKvAh7OTjrbqVDch
         idKljYycP2WtV7ZmW9E8oippnMDFE4WAvYZLV1zfUstn4V7xeZlBKpTo2dJrVU+OJBOG
         TfNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ko9/gBqLbf+j/PA5GvBDOiH6QkhRKpBbdXwgVJjhLBI=;
        b=FEyEfDYuFHjerryyBtAjZe9NTqrBkHt42KRYJhlEEOQ9YiPNTZN9gCt4rPghCTq7Ei
         2Gge5u93gd7l3Byy708eAmhM5+ZcIm9TFufSDvu04M9xfA1Zcs40UhzRtI5omCqVipDl
         2geVcSp9hmOncR5MF8XTQ3Sam4c6Q56fja8EG/GxO4FV13Tfbr6O1bqQUyY+YYPxMgq3
         zSAGrKXSOTxOMDUqfvIarWCY0MsA60Jn0HTKu4P5POmYhDZhevCLKyRq8qVloY1nlLad
         yAJLOm130PuhsKCptAVoHUbS3wqMj+T3iMHe8FQYJorkn4GFRGIPHkRYxJDp85/DAkeS
         axpQ==
X-Gm-Message-State: AMke39kbgYlzXq4DN9gcapp8Rs42U3i+FhQiR+94dF3PDRy0D1C4gtft10Wg4b89ZXIxW0Yg7aRmVNkSEguZuQ==
X-Received: by 10.202.183.138 with SMTP id h132mr7336949oif.95.1488202389910;
 Mon, 27 Feb 2017 05:33:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.2.40 with HTTP; Mon, 27 Feb 2017 05:33:09 -0800 (PST)
From:   Dmitry Neverov <dmitry.neverov@gmail.com>
Date:   Mon, 27 Feb 2017 14:33:09 +0100
Message-ID: <CAC+L6n0YeX_n_AysCLtBWkA+jPHwg7HmOWq2PLj75byxOZE=qQ@mail.gmail.com>
Subject: 'git submodules update' ignores credential.helper config of the
 parent repository
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I'm checking out a repository in a non-interactive environment and
would like to disable interactive credential helpers. According to [1]
it can be done by specifying an empty helper in a local config:

  [credential]
    helper =

But the submodule update command ignores the helper specified in the
config of the parent repository. To reproduce it, fetch a repository
with submodules requiring authentication and run:

  git submodule init;
  git submodule sync;
  git submodule update;

the 'git submodule update' runs a default credential helper. The only
way to disable it is specify helper in command-line:

  git -c credential.helper= submodule update

Is it by design?

[1] http://marc.info/?l=git&m=147136396024768&w=2
