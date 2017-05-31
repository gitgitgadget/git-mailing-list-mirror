Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ED081FD09
	for <e@80x24.org>; Wed, 31 May 2017 15:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750998AbdEaPpd (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 May 2017 11:45:33 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:32876 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbdEaPpd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 May 2017 11:45:33 -0400
Received: by mail-pf0-f175.google.com with SMTP id e193so12446294pfh.0
        for <git@vger.kernel.org>; Wed, 31 May 2017 08:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:from:date:message-id:subject:to;
        bh=q6VuPWq0zFuU44nt+JXL6HxQSjWU5R6BzbrsgU6V4S0=;
        b=a2R7FKs3DBzFnsPThUwD3rNo70BIAM22zpz6HFA5alyqgk9KjgadtntoJ6Mm/FxPwY
         BXBr0hMcVInU7+/++S0Tidyv8uFABL/5UBWN73EpV0gukZKizue/5gp3JR5WB4wD02cN
         aTc2IDxhZwDSeL5gD/LC2WWcBzJxWwEvPAJDrFPN6JePG3K0lYmXz/coI/l5+ArvbyAg
         pcJg65q6OxRfytZS4iKVwLhAsjR1VjHZpzuJtqjlP+DhMSFqQVPiM0I1RQrBgEpmYn2d
         V4aq2NoubdNN5IyUEH1izx8lqOJdkpgPWHCFwldxhk58W5NB7k7zkwdEf49kuX3mMEe1
         UqNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=q6VuPWq0zFuU44nt+JXL6HxQSjWU5R6BzbrsgU6V4S0=;
        b=KZ8wrew2SkQ5vEeUyTXJ6TvzxB/HJI8mKBqFrbvKRx+b3oY/MXjOzg4sTGLwOVoB0l
         JQ+sJGSqfATnYUeAxPAeWLtDtj1uIt211EjhohXbAqMpFEF1gb5ZkQJl/TXIX9XXCVC0
         p3B3I2fddNn82LZawWBv9wZYkvCvio2A3yTwNh3M1wl+w+7tdSyt0oKtp5fHpB+Aft99
         gx3NAGfhx7+ccAp384MtsZFo2mfLrVvm292OabP2oRYHUNhb1BvcKqnsvT9UhCIdboRM
         YkGGGYBaQgrfK5pkV4b4Mr3efrUTFieMO+C6+pIBoPMj44r7qeJAPkWfuzTu1PiFUny5
         D6tw==
X-Gm-Message-State: AODbwcBhR7robzHpqpygCjSS+/4EsdaeAjX6QcCYt7SiOfJ9+mMBeMfc
        IvXItGVGcjN1iXlGKMSHWO12l1acu+ui7ao=
X-Received: by 10.98.159.135 with SMTP id v7mr30857820pfk.57.1496245531907;
 Wed, 31 May 2017 08:45:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.78 with HTTP; Wed, 31 May 2017 08:45:31 -0700 (PDT)
From:   Anthony Sottile <asottile@umich.edu>
Date:   Wed, 31 May 2017 08:45:31 -0700
Message-ID: <CA+dzEBn4EKzDqS0pCHHsPtGGJc1orf5weKKh0GN-GkE+fVYGcg@mail.gmail.com>
Subject: bug: `git log --grep ... --invert-grep --author=...` negates /
 ignores --author
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Given the following commits:

```
asottile@asottile-VirtualBox:/tmp$ git init test
Initialized empty Git repository in /tmp/test/.git/
asottile@asottile-VirtualBox:/tmp$ cd test/
asottile@asottile-VirtualBox:/tmp/test$
GIT_COMMITTER_EMAIL=foo@example.com GIT_AUTHOR_EMAIL=foo@example.com
git commit --allow-empty -m "foo"
[master (root-commit) c9df62b] foo
asottile@asottile-VirtualBox:/tmp/test$ git commit -m "blah" --allow-empty
[master 9e3ee9b] blah
asottile@asottile-VirtualBox:/tmp/test$ git log
commit 9e3ee9bc1adab2ae8eb1884a8f6237da18dfd27b
Author: Anthony Sottile <asottile@umich.edu>
Date:   Wed May 31 08:40:59 2017 -0700

    blah

commit c9df62b93298a247fcfbe24ed4282ccf95448f47
Author: Anthony Sottile <foo@example.com>
Date:   Wed May 31 08:40:49 2017 -0700

    foo
asottile@asottile-VirtualBox:/tmp/test$ git log --grep bar
--invert-grep --author=foo
commit 9e3ee9bc1adab2ae8eb1884a8f6237da18dfd27b
Author: Anthony Sottile <asottile@umich.edu>
Date:   Wed May 31 08:40:59 2017 -0700

    blah

commit c9df62b93298a247fcfbe24ed4282ccf95448f47
Author: Anthony Sottile <foo@example.com>
Date:   Wed May 31 08:40:49 2017 -0700

    foo
asottile@asottile-VirtualBox:/tmp/test$ git log --author=foocommit
c9df62b93298a247fcfbe24ed4282ccf95448f47
Author: Anthony Sottile <foo@example.com>
Date:   Wed May 31 08:40:49 2017 -0700

    foo
```

I expect the same output from the last two commands, but the
`--invert-grep` one seems to match _all_ the commits.

I can try and dig into this if I have time, just trying to get a count
using this as a workaround

git log --grep ... --invert-grep --format=%ce | grep ... | wc -l

Anthony
