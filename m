Return-Path: <SRS0=YD5J=2F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822B9C43603
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 20:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DE4A2467B
	for <git@archiver.kernel.org>; Sun, 15 Dec 2019 20:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kw4+rF7A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfLOUbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Dec 2019 15:31:35 -0500
Received: from mail-io1-f41.google.com ([209.85.166.41]:46143 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfLOUbf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Dec 2019 15:31:35 -0500
Received: by mail-io1-f41.google.com with SMTP id t26so4353883ioi.13
        for <git@vger.kernel.org>; Sun, 15 Dec 2019 12:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=jA4H6nZIqiTTsSPLvQiZ/Qx1+5IdyiAicZvwf5AnHqM=;
        b=kw4+rF7A39e7UK+4ABrN1pydO057YZP7hZjCRDSfD7rxOCtBTlhNLPqXPlY2MsJDVk
         mskztTeXUzIy4dvQ/qOyUmqfJu3kl/3aDn9X7qih2WmZa/AyVzG+hV0F1+6ZUKgfo+ld
         /vUESWRxjEGGGzO/c9AOHWTBh/3tc49e5URUy1oNvGgcFzSetJx3Y4FgJPTc3MS/Cpyk
         8DE0IypkQmW4CMo72vmcz2+xypTRyU+BX7eNRzJlSTpmFMXwjvTc7UNMJyJxnVxPuiD9
         welFGKvxvMPho6niIEWzWSrA/of6EysxnXLMTgG8uY6QE94TMrB34q+o4ty+3Nhg4FS3
         aI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=jA4H6nZIqiTTsSPLvQiZ/Qx1+5IdyiAicZvwf5AnHqM=;
        b=hAdO4tPh3GNzLp0YDaib6w2ggKhggwgsKZuEd4tUE8sIiGZLBTlIQM69tOJ7vJyL9J
         EpoCA54HznqVbiQ5j+dirtgRuLZmRIEcrez3DkZXUKA+qtIxwE8CKZH56RIiJNQHmWcF
         4LCi6qjyLvw+Ch4iR5i3DMmggmNJkuX3gBgoRoj0/FLcFHPkn9g5fouEMajqE42jdV5W
         gZ7P4jqKgbjkcdvkD54WH/vNl0r81ioTUM677tmVRLNmrlDquOK1l258AueydwTYQxE/
         xFSMp9G+jpHqi6dftLUGcTodM9PSAiX1ku8m9v+zrFhwSmD6eMpK2BdrJ4cD6XAdIylC
         4W8Q==
X-Gm-Message-State: APjAAAVABIBGhAXPeJ/Q/ntnwdx10tFiVP1EIgNquLtiM9w95pqM9qyD
        yuv4IFH0D0cHz3k12b7u6LaEJQ9ZEPQX1zvFL3fAJ5qc
X-Google-Smtp-Source: APXvYqz18s1bridW815A7XABs0sPqIrNfC0FeZSoG6r6dk+iRrVWm4PJqhApl36GtZfVPeNSODnIYlAvcJIe0irt4kg=
X-Received: by 2002:a5e:9617:: with SMTP id a23mr12232381ioq.243.1576441894374;
 Sun, 15 Dec 2019 12:31:34 -0800 (PST)
MIME-Version: 1.0
From:   pp yy <yoann.mac.donald@gmail.com>
Date:   Sun, 15 Dec 2019 21:31:23 +0100
Message-ID: <CAK60LiX0g8mNVH5YY0JNOuUNRNYp+URt=2MyH758OAWpX_Phxg@mail.gmail.com>
Subject: [bug] Adding -z to git status seems to disable relative path
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Maybe i missed something but i can't get relativepath when adding '-z'

$ git --version
git version 2.17.1
$ git status -s test
?? test
$ git status -s -z test
?? plugins/git/test
$ git -c status.relativePaths=true status -s test
?? test
$ git -c status.relativePaths=true status -s -z test
?? plugins/git/test

Bug or did i missed something ?

Regards,
