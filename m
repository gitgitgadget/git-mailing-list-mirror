Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2044C433F5
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 14:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238010AbhLPObB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 09:31:01 -0500
Received: from mail-io1-f48.google.com ([209.85.166.48]:39679 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237137AbhLPObA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 09:31:00 -0500
Received: by mail-io1-f48.google.com with SMTP id c3so35425085iob.6
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:31:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dMsPSSbltfvy/CFtz5BaZHwqd+pf4+C/p4iWfzykikQ=;
        b=EfeqgskM+6wfwpj0iOi1ezbTugq9ie4U/nhf++87ul1NU2GBbwh0qYUcHiYQEvGTIU
         M6BVy4vIUVSw9oBrjaYrUGlxITBgNOtmcPZN+xzgadxf7vnWLVzDUrGNrBdCHObCzLDM
         CNCBLkfujXRRZIVZzAdm6Qs99S56ZO0dKWplyCLiNPJoadYXWE1g8OQML3UeIl0FopPe
         kQjdvVxbORVktlwDHOewIDDK6HEexxUHFBw3/+kpcV7D397F9AyPwYVXkIHPl7YHzHfK
         OwyvF3SkNXdX8LVxAVS4tfmp6v8LnWYdLm2/HrzTzFcsOgpbJ7CoMbH7fQLisGczobqS
         3Vhg==
X-Gm-Message-State: AOAM531j8Fv5BF/NFAPrO5xIR3oLmodqJYQxcdQvQ4hd6lH3X6B2bFOw
        zkdI/UX/ZqttKqzFTN7w8kUgv/hDS5OvT6FAaaoBiKN/Q7k=
X-Google-Smtp-Source: ABdhPJxMyzdc0jh3LkNfy6bZtNmUVK+icDBlZCj7NtvJSrV2tsKGaRJwIN9fM4wTY2cnLxOXAgJKLzu5KNLh1AKEEHA=
X-Received: by 2002:a05:6638:1603:: with SMTP id x3mr9385965jas.243.1639665059550;
 Thu, 16 Dec 2021 06:30:59 -0800 (PST)
MIME-Version: 1.0
From:   Erik Cervin Edin <erik@cervined.in>
Date:   Thu, 16 Dec 2021 15:30:24 +0100
Message-ID: <CA+JQ7M-ynq1cLN-3ZodXae=x-H5k7Ab6uPBwUFhG+kgtOvCgtA@mail.gmail.com>
Subject: bug?: ORIG_HEAD incorrect after reset during git-rebase -i
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Steps to reproduce:
1. git-rebase -i
2. edit XYZ
3. git-reset HEAD~
4. git-commit -C ORIG_HEAD -a
5. git-rebase --continue
6. git-show ORIG_HEAD

Expected behavior:
ORIG_HEAD should point at the previous HEAD of the rebased branch

Actual behavior:
ORIG_HEAD points to XYZ

My understanding from reading https://stackoverflow.com/a/64949884 is
that this is incorrect behavior.

Perhaps this is as intended but I would at least personally prefer
that ORIG_HEAD would point to the previous HEAD of the rebased branch.

Seen in:
git version 2.31.1.windows.1

Possibly related to
e100bea481 - rebase -i: stop overwriting ORIG_HEAD buffer
