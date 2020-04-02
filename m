Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65006C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42E7F2063A
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389092AbgDBPLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 11:11:46 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46156 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389041AbgDBPLq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 11:11:46 -0400
Received: by mail-wr1-f66.google.com with SMTP id j17so4577316wru.13
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 08:11:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6vWewH2FSjExX68it7oIR2BzYjRohIM0cuS7+FE8qXI=;
        b=Ef52kgiWgfPoPeTRj1nequtu436oLMI9bKVTPamctvtP1/Afz4aKEW45ykQDCiTVL3
         ThyVuuWoXuxR4D6utp3xaLkPGf+1nUb73Ae+HtCAa5hZDARuOo4Dtpvp1QTM1ZYUyJUv
         Ap84zV311Fz5owWzAsgB5HH90uK1xKUYOsdBtc1Ez04cPZ6Y5PfNNCCmH0WBEylXRM93
         86EX4LV0XIySIG4rDfIkRza8aLo/dB0uGbQabZGmMXbMZZKCr19bOR154yfNUdmfrZnp
         uznbPK0QWx8EAFk5Buux9StsUwOaUBCL0iIIKXLltWd8PqWp2koc8VT7veuD1yWrIIg2
         jHlA==
X-Gm-Message-State: AGi0PuY+dX9lZVmYN/bEmRxWschPt07xMB5NVXVwHPHEkVBB5u/7Mh0q
        POpDdTnWYUAqeGWLBVYlqXiZ8m8PIHs+SdmKvbQ=
X-Google-Smtp-Source: APiQypIXngkHF8XgHefp1VrDxRv4AAocNE1kOF+rl4r4zQjSJGM6qnALv5x310l2JRJuG14mgrKPZNIwL+RKu3mwbXU=
X-Received: by 2002:adf:a350:: with SMTP id d16mr2141113wrb.277.1585840300116;
 Thu, 02 Apr 2020 08:11:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200402084251.85840-1-zhiyou.jx@alibaba-inc.com>
In-Reply-To: <20200402084251.85840-1-zhiyou.jx@alibaba-inc.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 2 Apr 2020 11:11:28 -0400
Message-ID: <CAPig+cTp3AhYXX_cjU48yLyMHBF1fOgwHw2ZC5rGWvYFE_bmQw@mail.gmail.com>
Subject: Re: [PATCH] git-submodule.sh: setup uninitialized variables
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        xuejiang <xuejiang@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 2, 2020 at 4:43 AM Jiang Xin <worldhello.net@gmail.com> wrote:
> We have an environment variable `jobs=16` defined in our CI system, and
> this environment makes our build job failed with the following message:
>
>     error: pathspec '16' did not match any file(s) known to git
>
> The pathspect '16' for Git command is from the environment variable
> "jobs".

s/pathspect/pathspec/

> This is because "git-submodule" command is implemented in shell script,
> and environment variables may change its behavior.  Set values for
> uninitialized variables, such as "jobs" and "recommend_shallow" will
> fix this issue.
>
> Helped-by: Jiang Xin <worldhello.net@gmail.com>
> Signed-off-by: Li Xuejiang <xuejiang@alibaba-inc.com>
