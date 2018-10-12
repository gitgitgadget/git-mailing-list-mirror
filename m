Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D08E1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:44:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbeJLVQm (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 17:16:42 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:46611 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728574AbeJLVQm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 17:16:42 -0400
Received: by mail-qk1-f196.google.com with SMTP id q12-v6so7647220qkl.13
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 06:44:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qyPJ8XlPjfE2jyhctlVCV4a+SOw4QBjaFWAlUMFFDDw=;
        b=rjkUhrNf9l1a1dPnBA+ls7fqTVgEviB6FqkLV2nyQzouY7enzdmyertwGST1FRw5gI
         3DfwZ1Dv1CpxazKsPBywuZ8qQs7zXJxKbmy2wj0yEX+dagv9nxw5K21Q8TmuFCXefvvl
         8wLhLysXrKSYsHnMmOdiQvYhYvyHnnyONI97UNGzwtIheZYgc1O+LM/Dbr7aWvi20oMP
         ZtEdye9bC0b8LSOJZbw2i+FLGyc1Dcfs9UHfIP5z8uTRdunmrKm5mDy9JF6+nS6UA0tH
         L7JLXQa3imZ/0plB7Z3KANxViSJwdGkgPzv+1QVuXoTWOEbphxUgW4Ptwk7w9SOuZFCF
         3i2Q==
X-Gm-Message-State: ABuFfoidpD8w7LJL2BBRhyBIV2329te4RWJ7mCRYXx+I9sABQL9AcPNk
        lz3a4YvKOJi4y2j51aLFRr+HqbN8DgHg8IOUVMI=
X-Google-Smtp-Source: ACcGV62ym1w7NjbZJMZrvAHq+xszZgW9uxodV5y35hjKqr3L1qvVoYnPq77ecrgfGqSvkJ6gGb/vf8KrRYwQXkhwvNY=
X-Received: by 2002:a37:8fc7:: with SMTP id r190-v6mr5809943qkd.36.1539351850379;
 Fri, 12 Oct 2018 06:44:10 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqva68dqip.fsf@gitster-ct.c.googlers.com> <20181012133321.20580-1-daniels@umanovskis.se>
In-Reply-To: <20181012133321.20580-1-daniels@umanovskis.se>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 12 Oct 2018 09:43:58 -0400
Message-ID: <CAPig+cRCfO=3BB6bvDSKLKkhiSA-4=p4-zZkAXvN446_6B1_HA@mail.gmail.com>
Subject: Re: [PATCH v4] branch: introduce --show-current display option
To:     Daniels Umanovskis <daniels@umanovskis.se>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 12, 2018 at 9:34 AM Daniels Umanovskis
<daniels@umanovskis.se> wrote:
> When called with --show-current, git branch will print the current
> branch name and terminate. Only the actual name gets printed,
> without refs/heads. In detached HEAD state, nothing is output.
>
> Signed-off-by: Daniels Umanovskis <daniels@umanovskis.se>
> ---
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> @@ -100,6 +100,49 @@ test_expect_success 'git branch -v pattern does not show branch summaries' '
> +test_expect_success 'git branch `--show-current` works properly when tag exists' '
> +       cat >expect <<-\EOF &&
> +       branch-and-tag-name
> +       EOF
> +       test_when_finished "git branch -D branch-and-tag-name" &&
> +       git checkout -b branch-and-tag-name &&
> +       test_when_finished "git tag -d branch-and-tag-name" &&
> +       git tag branch-and-tag-name &&
> +       git branch --show-current >actual &&
> +       git checkout branch-one &&

This cleanup "checkout" needs to be encapsulated within a
test_when_finished(), doesn't it? Preferably just after the "git
checkout -b" invocation.

> +       test_cmp expect actual
> +'
