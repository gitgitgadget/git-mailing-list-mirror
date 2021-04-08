Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F51DC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA00461008
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 19:28:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhDHT2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231420AbhDHT2v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 15:28:51 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B82C061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 12:28:38 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a7so4965817eju.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 12:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=QUApxAMOgUJ3YEPQClhHIb2wuszG3EAv/Z73LvilrUI=;
        b=iTZJ8Y2nMs5u8GJI0NqTHlBnCQ6mSB/EWnnLhzcHBtAEc6VRT3bq/xgdYuA9Tc8x/z
         wmUf3rqYhpE/S4kk3DqeMmmCRf5O2g0lwk0FtUa0l1QuP3Cn1HKWlUgU8ay5Bl6fGq0a
         Y3BGnqsAufR+WUre8AzaioXykGYbsOsAh4533QQRdxRMBDy5BUE4h5Ry/unPiQfV8lq1
         1FIj4cLsRjYSep8xSItD7NR2qOfcpOJnLo2/9fayHSQTY5U5bSFA/6ki5rMwSEhVpUmn
         k6SSI+O8d8CZW2oadJUYxVDe2Xd6R0K4mlWn3qDbJvBgVQ3mXvO7j18zPl5B0clePy+O
         CSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QUApxAMOgUJ3YEPQClhHIb2wuszG3EAv/Z73LvilrUI=;
        b=eN15Hs9y0fgDcfvhuSEEN69HCfrxabLvxU3w6+0aJI6taMynMWUiwfjF9KNAywpmNR
         Sc12ZUwHr8c9A5tPbZGjYDb9ila4saPwX6bJLYuDpOMxu2Ub4rtIKu5SGeR3AUdFu6zs
         1jEIQnX78Pylx4uLbnl8EQXnbj8bJCV0kP/kT/t9zv9Y9Dk/451723rZqY7zslnwcvEE
         a+EaBldBVjpdJAF5KPzKJSEDnJtlnseEkB3LhaycJdxNNdwxwIfW2+M2Eysu3rquTluI
         JZhF8AqINVAcceDuD7GYBp1Rwz4mNl4cFb67CTvTvyNZg7ItS6GW6cR7IpGPjm2VglDe
         pvyg==
X-Gm-Message-State: AOAM530FsarDceCgL4AdzQ/rvP3Unl0TL9ZYwc3PqJEnivSFetOlzm3V
        ddy6E4L1hooeTnnAg7e3O6q1PXpUvrKPz2W7KqhXBJf0
X-Google-Smtp-Source: ABdhPJwKAR65CyaeaO7DIM8Qo+qHfs88utEejuBZx/cLr9YujS7svGiXoPMeFhE14gSxa0cIZ8IPiN1ojla+wzVW0Mg=
X-Received: by 2002:a17:906:5906:: with SMTP id h6mr13002173ejq.288.1617910116758;
 Thu, 08 Apr 2021 12:28:36 -0700 (PDT)
MIME-Version: 1.0
From:   Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>
Date:   Thu, 8 Apr 2021 12:28:25 -0700
Message-ID: <CAKu1iLXtwuCQTS0s7_LEm0OJF-4s0UhPhDW1r5Zb7=GsSPfpdQ@mail.gmail.com>
Subject: git-p4 crashes on non UTF-8 output from p4
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When git-p4 reads the output from a p4 command, it assumes it will be
100% UTF-8. If even one character in the output of one p4 command is
not UTF-8, git-p4 crashes with:

File "C:/Program Files/Git/bin/git-p4.py", line 774, in p4CmdList
    value = value.decode() UnicodeDecodeError: 'utf-8' codec can't
decode byte Ox93 in position 42: invalid start byte

I'd like to make a pull request to have it try another encoding (eg
cp1252) and/or use the Unicode replacement character, to prevent the
whole program from crashing on such a minor problem.

This is especially a problem on the "git p4 clone" command with @all,
where git-p4 needs to read thousands of changeset descriptions, one of
which may have a stray smart quote, causing the whole clone operation
to fail.

Sound ok?
