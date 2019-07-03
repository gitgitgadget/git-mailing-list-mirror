Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 107381F461
	for <e@80x24.org>; Wed,  3 Jul 2019 19:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727088AbfGCTB1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jul 2019 15:01:27 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38405 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbfGCTB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jul 2019 15:01:26 -0400
Received: by mail-qk1-f193.google.com with SMTP id a27so3688584qkk.5
        for <git@vger.kernel.org>; Wed, 03 Jul 2019 12:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ijSbgobKlp5uC4by6fCQi+Th1XXOm/M06L7xQkjCwTU=;
        b=D9VxAwFWLEdkz2NuiXKetC8Vsa0adbAvgHxBG6zgc5ATxaQ986zhDDpi7kD7kBYfM3
         g/b7ewMmWMNjYnkm/7hwy+aW6Wtn13HjVAiU2epgX8O/F5YVqYkngEZlrSlPQnGuZg3J
         Xek9lM9Q7Cr2fRj/J3Ot+89s8fpFGNqrM12zSQv8+agLPbrhKdL50M1r/jQdd6TBTvM1
         EWpdSjb8EC0ojzn5Inq0m0IdTVibaeFG3fkpIhyJ6zeYClBoa2tjBsUUptqoK5tW5Tf5
         DLitb8P8U2XPBFMjJtQLGVxgeGGTuWUxkgEGWnlrT6+fP6yf0TIabkNd+OvOa6EwDJ3b
         6sBw==
X-Gm-Message-State: APjAAAUZ2OD1Zvpnu+QzT19Wib1vskbLxAfH9WoIE8K9nWlwzj/XAPrk
        qjux1LeLzhKoPFUX1/uaZzc+1jVv+p2hg1uIpuc=
X-Google-Smtp-Source: APXvYqxQcr5S8C/78TD3yZJmI75CNP0ulQJtQ4Yri4S2ZBaLpWhlNpyWe1fbBSsKAnmdsApq4Pg++yTbnAu1r/ieKow=
X-Received: by 2002:ae9:e306:: with SMTP id v6mr31646137qkf.145.1562180485501;
 Wed, 03 Jul 2019 12:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAMPRpjUWBXCEagDB5RwsBTYSJWeypOeY47CGWOO95oZiSCTOjw@mail.gmail.com>
 <xmqq7e8z0ypm.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e8z0ypm.fsf@gitster-ct.c.googlers.com>
From:   Julius Smith <jos@ccrma.stanford.edu>
Date:   Wed, 3 Jul 2019 12:00:49 -0700
Message-ID: <CAMPRpjULRpzG+Xf8Ezc2+-4cVB7phGs9h+7nxhx-GP44__mfeg@mail.gmail.com>
Subject: Re: Submodule "git branch" says (HEAD detached at <incorrect-commit>)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the explanation.  So then to find out the current commit of
the submodule, I should cd into the submodule directory and say "git
rev-parse HEAD" or "git log -n1", etc.

Suggestion: for a moved HEAD, it would be nice to show "(detached from
<original-commit> now at <current-commit>)".

Thanks for considering, and thanks for a truly great software tool.

- Julius

On Wed, Jul 3, 2019 at 11:17 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Julius Smith <jos@ccrma.stanford.edu> writes:
>
> > "git branch" in the the submodule directory says "(detached from
> > <commit-for-D>)" but this seems to be wrong.  I did "git diff
> > <commit>" in the submodule directory to show that it was the C-commit
> > and not the D-commit as it appeared.  Could "git branch" in the
> > submodule directory be referring to the commit at the time it was
> > first detached and not updating after a "git submodule update --init"
> > in the parent?
>
> There are "detached from" and "detached at" messages.  Their use was
> somewhat inconsistent in the older version of Git, but at least
> since 2.4.0 (quoting from Documentation/RelNotes/2.4.0.txt):
>
>  * The phrasing "git branch" uses to describe a detached HEAD has been
>    updated to agree with the phrasing used by "git status":
>
>     - When HEAD is at the same commit as when it was originally
>       detached, they now both show "detached at <commit object name>".
>
>     - When HEAD has moved since it was originally detached, they now
>       both show "detached from <commit object name>".
>
>    Previously, "git branch" always used "from".
>
> "git branch" and "git status" should be using the same language to
> describe the situation.
>
>


-- 

Julius O. Smith III <jos@ccrma.stanford.edu>
Professor of Music and, by courtesy, Electrical Engineering
CCRMA, Stanford University
http://ccrma.stanford.edu/~jos/
