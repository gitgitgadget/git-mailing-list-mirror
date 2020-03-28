Return-Path: <SRS0=KP1k=5N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6BB2C43331
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 09:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B89E20716
	for <git@archiver.kernel.org>; Sat, 28 Mar 2020 09:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="oaTB2XlL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726186AbgC1JwH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 28 Mar 2020 05:52:07 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:43691 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC1JwH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Mar 2020 05:52:07 -0400
Received: by mail-ot1-f41.google.com with SMTP id a6so12476757otb.10
        for <git@vger.kernel.org>; Sat, 28 Mar 2020 02:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=gpSoGJUGDZHsKko1Np3EuG2SgswkosNRE5+p96q8ap0=;
        b=oaTB2XlLjyfCioH3Dy3BXqKtbTwMFodDdLZ9mrUKUeIJR5MCiT8vd5nk/EVpqh/nuG
         uBAuHwqmqL3xdr97mM2i67foS3reypWdtfZFD5Blm4KGabvU9Db0S5fJES67X3Kf7jTX
         poqr9YMUYA9DzN0Wko0mZU5WVJKZM61uyI/wgGPdhw5UpnrJW6T5cN4OFdUHTLJZyBwI
         aA1HKJtVhKCHhgfEnq1Lr9sDHxM+qF/9c9vjCF68eAoIyGVlt3bK9yrZReidb/4xy/Ow
         wRAG1FmWRypLGrvMGlNIqujK9au8jBlSnxq0Qul+KkO1IefbAG0VsVCQYfA/e8afRPfd
         8CjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=gpSoGJUGDZHsKko1Np3EuG2SgswkosNRE5+p96q8ap0=;
        b=pVKvqljqFZusUvFjxJKuVi70NVkYgKoE6t/sZqE8cyg5H+OVQdAH15l8Z/3rQVvoyW
         kIpcDbai9rmQqW+XqOVX9Utp0BqNThd8fXLbTjS1QVY8BKt1gzLKjAbqOhFhFJ4eAAYw
         PboqTFJ/EqwKkt87Mvo0PKYfwQWdxbyrqaPyR1phgctl3drHgnJy1LLtSFVZPz6upTRc
         3aPOxK3elo4BGR/jSv6lbJB1RbK+UJtGGHJG60V3SvHVHKUPetKOTSAUWtHVxH9DH8Si
         FjZaLUE6AQQ80ZAIHPxNySDQzNmr/yGwsRJFWUbL/Ppnf7CVg2ezx5jDaNlfn9yc1key
         YUUA==
X-Gm-Message-State: ANhLgQ15ukB85KxxsPVY0C73P9vgsE1WU+W7f7WO/rM+k3zf4EAanKSY
        EAVf/C+VGwDfvCiQIqdeFWfOsYlJFu8YXpXJt7nQ1bX9
X-Google-Smtp-Source: ADFU+vsGmbWWWPyb6PbbKWZlRPEG0mhhTcqkD6bEGg6dQ5Tu0oYjVI89JRVJLSHDAnT8xwcHRCRsPl74WX2zL/lDjQc=
X-Received: by 2002:a05:6830:146:: with SMTP id j6mr2092812otp.117.1585389126202;
 Sat, 28 Mar 2020 02:52:06 -0700 (PDT)
MIME-Version: 1.0
From:   Bastian Buchholz <buchholz.bastian@googlemail.com>
Date:   Sat, 28 Mar 2020 09:21:08 +0100
Message-ID: <CAJTX9qSjnPGKEBDB_ma5QqWOwop5s15kskKQ7EU2ne7VFEBnfA@mail.gmail.com>
Subject: Git 2.26 rebase.backend change issue
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Just wanted to report that I am running into issues with the git 2.26
`rebase.backend` change.
I am a maintainer on https://github.com/FredrikNoren/ungit which is a
UI for git using a http server / browser architecture.
We are using `git rebase` in non interactive mode (e.g. not specifying
`-i` or `--interactive`) on the server and with git 2.26 this fails
because it seems that it now runs in interactive mode by default. It
tries to an editor on `git rebase --continue`.
Specifying `-c rebase.backend=apply` fixes our issue see
https://github.com/FredrikNoren/ungit/issues/1301

It would be great if the new merge backend would also support a non
interactive mode e.g. by respecting the `-i` or `--interactive`
option,

Thanks and regards
Bastian Buchholz
