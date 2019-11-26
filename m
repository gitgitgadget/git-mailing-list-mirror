Return-Path: <SRS0=BbQ7=ZS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A3BC432C0
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 20:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 147452080F
	for <git@archiver.kernel.org>; Tue, 26 Nov 2019 20:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tNHsfGSo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbfKZUu4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:50:56 -0500
Received: from mail-ot1-f52.google.com ([209.85.210.52]:40134 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbfKZUuz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Nov 2019 15:50:55 -0500
Received: by mail-ot1-f52.google.com with SMTP id m15so17165850otq.7
        for <git@vger.kernel.org>; Tue, 26 Nov 2019 12:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=dATETz0c9WE9Rx7iuVfCBnuMGNT7RFY70mal4Gd4mfk=;
        b=tNHsfGSo+b3Ho4evGwdWDh4YgIZn5IeDqQ7AmrzfzJjYj+lgCik4dSW9oCM4J/VULP
         uu/oclfbrdR+lB6edtSnWPO4jbeQ8S+1pKM8y74qsgaUJpxkVrGzbex8V5BIY7YcryOl
         yVcA0Tq5zAxE/FoPhTJKiN86g0Jc/sigq49UkQ8MLm9KR1f3AvFNMJQvdJAPqMHuNBEt
         ObP7LJc6dl2M1+enGbhBAIc2NDiBruXb/5kDtaHFmvfUuJsWaK0OJpRX6u2LW5dlBI5X
         Ud/rvK8sp0+txb/uU6cq7hOtqrN26lxQxYuVF0+0kU6Yvdv9cP+IZXLLjJT292UybR49
         1rIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=dATETz0c9WE9Rx7iuVfCBnuMGNT7RFY70mal4Gd4mfk=;
        b=sOwmrUKbR+F+ylT+hBZ84wyZF2fQVkTe4jwAmmucJzx6eTl0BpW3o2jgwhlnPNx1w1
         kRI5PDkA1J+6MyWe1UEl7SY5JRcrOSAMGCPIVsgQHhtI4jnX+hBxCTqPzb6iGfbJEirL
         UvGkxGOmhek9IasA1Rt8uwTNIAwi76+P52Wp+BdrehkjNJQPoEHQj2PhOxkZIxxsWI7B
         J716AiwD7rZaeZ3AYJyaTyXlHlQIt/hSOVVJtfOsJXVHXH/QlamDBk3z7RGMPpy5NxwM
         O6yq+IkMLv2N3VsBNl1Daacm2jxz8GKJfRLNVSQNWdUThS4V8PvpQAN62i0c2EgZPtO0
         O17w==
X-Gm-Message-State: APjAAAWLTxBFjErgFoK6G6/gTEqdUh04ePwaZp5ZqZU0mDQERQXY0aev
        HRSyyRA3a4nzrEWm5YysihBwsNtHIh6uXPuTmIvlum53uoU=
X-Google-Smtp-Source: APXvYqzKypT0RB8EPmZKL0g0kgNx25AIlDgWUuhv7BGCCFGBWM4Cdp8RjMj2zq4l5b1TtqIyJ5KpTygLFyeFGGyLD9k=
X-Received: by 2002:a05:6830:22e2:: with SMTP id t2mr788321otc.129.1574801454186;
 Tue, 26 Nov 2019 12:50:54 -0800 (PST)
MIME-Version: 1.0
From:   Christian Biesinger <cbiesinger@google.com>
Date:   Tue, 26 Nov 2019 14:50:18 -0600
Message-ID: <CAPTJ0XEcMJEwPBEL4akncJ_A5XwyQyKL95fpf2tC0rNXJK65Og@mail.gmail.com>
Subject: Bug with "git rebase" when format.useAutoBase is set
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello!

I recently tried setting the format.useAutoBase setting to true so
that patches I send with git format-patch identify their base commit.

Unfortunately this seems to break "git rebase" completely, I always
get the following error. Is this expected? This is with git version
2.24.0.432.g9d3f5f5b63-goog

$ git rebase --onto  foo 4a7dabea39556979cbf6bcbdd98a9413ce129fd0
First, rewinding head to replay your work on top of it...
fatal: failed to get upstream, if you want to record base commit automatically,
please use git branch --set-upstream-to to track a remote branch.
Or you could specify base commit by --base=<base-commit-id> manually
error:
git encountered an error while preparing the patches to replay
these revisions:

    4a7dabea39556979cbf6bcbdd98a9413ce129fd0..12f4dc41bf9f018ecc1042830d5534de941f329e

As a result, git cannot rebase them.
