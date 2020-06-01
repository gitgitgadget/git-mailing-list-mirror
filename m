Return-Path: <SRS0=PU/F=7O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B03DC433DF
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 00:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33D202074A
	for <git@archiver.kernel.org>; Mon,  1 Jun 2020 00:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYR3WiVe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgFAA2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 31 May 2020 20:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728359AbgFAA2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 31 May 2020 20:28:53 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0211AC061A0E
        for <git@vger.kernel.org>; Sun, 31 May 2020 17:28:52 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id u10so4779742ljj.9
        for <git@vger.kernel.org>; Sun, 31 May 2020 17:28:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=me1xA3gAcLIIQNaYa1miGIKy4R812zpdvIdEMKUuhLQ=;
        b=aYR3WiVeFItjffxjoPZQC6aVq+pdYGlLN9fK+k8NMiLNxzUDXld099G7Pc7XRBkQx4
         MZ2G/BJCq5ocnSQ1ZcBqUwtOWqUDC6sZtTnvfvF4F1c0oK42tMCbKAPZ9zZmc6Z7spQM
         TP9HI4Iy1XBwfhay5uU3wPLTrLgvmSNeAzYIFiZMFiZXv/mruN4JikntY2N//5+MZe/T
         IS01R5SmllBWKlWS3zSGLatVi3Y9cDPTP3HMF0v+nlON1yoSpUiugycj/ySF2cvC3oE+
         gK05WH/3wIaOVIKgbyt3noRu6yo01QNWqD7eWP7n+DnN9vPA3OBWAddjuyosj5sbod5p
         ITqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=me1xA3gAcLIIQNaYa1miGIKy4R812zpdvIdEMKUuhLQ=;
        b=RnFiqGd5Uf5lrSvQgzM9cDzb7NEAwY0ttMmrotkY+Z/8npoWK77z5McH5sHMt+z0OG
         2ATT63j41k4EDdLdl+yPgPEJSHkVmgaOcgH4B979c1qvw9+fl/QhPP3GPmnm7RhOTd5H
         EKypK+z5DsW+pxkxAxQuX4GPLS2y261uF10F3jlJy5hZfXKiKVX2ls/ATQHNQlpMceBz
         qspDw0xmzTWt4tSDDi2egDPd/c9umsk/ljA9mE3jeWF+dYv/yi3i9lO93MLoOnHHLCD9
         eEdfNlQYa77YiAAYp6jtow4YbwLJuRS5XGUBohdc1ZZH151px/06KtVKNB/TivllvmzG
         riqA==
X-Gm-Message-State: AOAM530ZUn9cBtMYfx/iDM6GstPEx0Ltqco4ewQXWB8URigDfc4xUbff
        BRzpLTH4f70Q+Y6twc9YWj4/WCkviCxxv7+AkV19aNlljFc=
X-Google-Smtp-Source: ABdhPJzNv5SbAM5BhsJDQv0ksKGaCFnadOzuPNTxaFO1HV99VMlGyE9xyOP2XqyZIr+PNFLB6A4lQwA67fLJTOA9aww=
X-Received: by 2002:a05:651c:2007:: with SMTP id s7mr1588947ljo.418.1590971329770;
 Sun, 31 May 2020 17:28:49 -0700 (PDT)
MIME-Version: 1.0
From:   John Siu <john.sd.siu@gmail.com>
Date:   Sun, 31 May 2020 20:28:38 -0400
Message-ID: <CAGKX4vGhTbEqZS9+iYA2wZWRRaddQC6O4KV+zLaNYKkZgN36Xg@mail.gmail.com>
Subject: Git multiple remotes push stop at first failed connection
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git version 2.26.2
OS: MacOS 10.15.5
Install via brew

Let say my project has following remotes:

$ git remote -v
git.all "server A git url" (fetch)
git.all "server A git url" (push)
git.all "server B git url" (push)
git.all "server C git ur" (push)

When all serverA/B/C are online, "git push" works.

However "git push" will stop at the first server it failed to connect.
So if git cannot connect to server A, it will not continue with server
B/C.

In the past I have server C turn off from time to time, so failing the
last push is expected. However recently server A went offline
completely and we notice git is not pushing to the remaining 2
remotes.

Not sure if this is intended behavior or can be improved.

John Siu
