Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C834A1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 20:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726209AbfBQU5a (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 15:57:30 -0500
Received: from mail-pl1-f171.google.com ([209.85.214.171]:35244 "EHLO
        mail-pl1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbfBQU5a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 15:57:30 -0500
Received: by mail-pl1-f171.google.com with SMTP id p8so7678527plo.2
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 12:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=g0e5VAlOdTn4v6At80Ao8KxmL8l4DV3t8uEaGdrHHJM=;
        b=jLMtSSboIvhCPVW/d379mxQlVNGYvHzxveXcRgywk5fw6eN7E2Jre0bSr1SlIHR7yL
         UgulSG5+W5FtwPRSPHA3bMI/c7Eu18AIEVA7KWk5WcI6JKvlyNxHObJmsp5FPc6VGqAg
         /Xjo28y3nKu73KAYBtzyiGqBZbHMvghOQ9JGwYjtsaorJSekzSvCK9Ove2MSG+CI5ooF
         YGCWyCP6dEiNmOi2j+DcAL6xHBiTZxAeQGtD85IJM6qFHNQ7rUzZj+ALdtmpOWWlAvnj
         Z2mlJu6luv1jWyg/RUqDQVrbqNrumhW56UyJni2Q2XdfprFRT0HrUn4bQZogGFWYIAXS
         Ar/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=g0e5VAlOdTn4v6At80Ao8KxmL8l4DV3t8uEaGdrHHJM=;
        b=PLRxJ8dy2uk7NELG6d+6sp/6Ti3AexIuQTyejHvw4Fdb6eNsooYEbpiXZy5iCBroKe
         qUv0zAKYBDJbJNGoVrMwl5VOBxN6CrBHDLDpZtZwBjxPyHj1pVv8LcBGGsG8GOuE6u2T
         SUL7wZ49VgrtKsJL6lAuhpJM9cWIz8kfNuKJEoy5BcMYGq84DfGqF4r/GhWlgXP+GBcm
         2Cft5q8OEAW3UXqHspSO987ojHNfgzbfggm4kH/W0BYMb/QhSXDqtKHaktKwn+AQQr0a
         7jft/dbp3OkGvDLx5EwjN3ixzZer+w0rZpkpjkeKy06nN+4OETqikUutBZ0hTjU6+daM
         azAQ==
X-Gm-Message-State: AHQUAuZIPEC3YtGSTRx92fEHoZ4h9KRVQZ8kCoHLC0ijKW04qncSNouq
        lr1IinJdHfc3hMzCeE3m4/6T6rX0pl/bQE/X55hEvQ==
X-Google-Smtp-Source: AHgI3IY1def33KbNLN5UETYOu522ivfUJ1XFeA0BnOWj3sAXu6kstZyXCJul+HAehaCgV88Ks3IbL1aJEizGAIx8CTY=
X-Received: by 2002:a17:902:8498:: with SMTP id c24mr22192336plo.265.1550437049548;
 Sun, 17 Feb 2019 12:57:29 -0800 (PST)
MIME-Version: 1.0
From:   Roman Gelfand <rgelfand2@gmail.com>
Date:   Sun, 17 Feb 2019 15:57:19 -0500
Message-ID: <CAJbW+r=j2vwEUQArUdBUQL8FW1R7200Tw7sJqhgfP990CCCoGA@mail.gmail.com>
Subject: Reverting merge commit
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Consider the following...

1. Release Branch
2. Each of the 3 developers are working on their own features.  Each
feature is a branch.  Only one developer is working on each feature.
3. When a feature changes have been made, the feature branch is merged
into the release branch.
4. After the merge in 3., the developer working on this feature needs
to make more changes.  That could happen several times requiring more
merges.

Now, I need to remove the above feature from the release.  If there
was only one merge with the feature branch, in question, into the
release branch, the revert of that feature branch commit in release
branch is simple.  All that is needed is one revert.  However, if
there was ie... 5 merges from the same feature branch into release,
there has to be 5 reverts.

The question here is...  Based on the above requirements, what can be
done to remove a feature branch, from a release branch, once,
irregardless of how many times a feature branch was merged(each merge
has additional change(s)) with a release branch?

Thanks in advance
