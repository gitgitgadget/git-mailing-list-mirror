Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D8351F406
	for <e@80x24.org>; Wed, 16 May 2018 18:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752014AbeEPSTV (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 14:19:21 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39461 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752208AbeEPSTT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 14:19:19 -0400
Received: by mail-wr0-f195.google.com with SMTP id q3-v6so2607073wrj.6
        for <git@vger.kernel.org>; Wed, 16 May 2018 11:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=XsE7/edeUwD5lzxytam0gt5660p/CNpQ4GNCC3rJ4K8=;
        b=LebrpMvRPr5tmsFg3DB9ktxOgEN2YKd5sQsKUh8d46T7KYIfTVUa9UrbFEo1ifg8BQ
         aukqQt9/S1NhszIg3429T8FQqceoWsvoQZfBx/uJr83FV4C5nywP59WzK8fGx+wvcnXh
         kjrS6/CerVjr38DNsvW9iRQPAoGMBgEPeOSdCJZsH3ePy8aVtN5jfBBuRSVCRK5vpO8/
         Nq5tU5KeWYYSF1AHBFOopXMSG7HmpGgSikxpvt4T7gTzzI2URNHbS1wQFUAH0GWvBoOs
         CWw6jAV0QiQwd06oi+HJTuoEW/t+rZP4dDAhn77KjyI/dxJoR/QFaZFLYOYBF4wktr6V
         YE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=XsE7/edeUwD5lzxytam0gt5660p/CNpQ4GNCC3rJ4K8=;
        b=iQ6YMSfKf4KImIIeCNjJ7DtrzbM9FgbtHmb+rbczaA9Bor4yXz0lSnnd9RKredJJrU
         5KpztHhFqwP5JFPbaRds7astU5al0vh1HtG3rNsiY1j7ICJFmUKjMkC+3eHtfhJI9nTg
         ylkAORWsTE4fvuz/wcz771GIKn95TDYQaMQyc0UsgXD5ec/9rJrYTbO2rlS3f2YhwCns
         sLIz5i1hvdP/NVsBPEIuJEAMbrVZQrV7v8klDKo6Ac9TtPsLfaG9unomes23wEXJODse
         m8hhZ61ryKN0/IHvxN1Ai6JoUsxb3sk269ZWgBO/M3AT2FVfBkZe1x5k2YboQjr4AXDa
         iPiA==
X-Gm-Message-State: ALKqPwdoOc4z35IW0sQJOoA9iSXZG1gYI9CIFWsSpYWN02iqCvU4Q8J7
        yFSdWZ4bUcO8LXEbETc3MvvqjEuZMsWsNglZbbfzw6Zs
X-Google-Smtp-Source: AB8JxZq4CEm5AtsNjAnTUFs2pEiu1ix/oJ/q8ztmC/Fh3At70kzI6Qa53dlvNxvnL68CD/jnwxJo0XQqAPoyM1fcgc8=
X-Received: by 2002:adf:9814:: with SMTP id v20-v6mr1763561wrb.93.1526494758264;
 Wed, 16 May 2018 11:19:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:db03:0:0:0:0:0 with HTTP; Wed, 16 May 2018 11:19:17
 -0700 (PDT)
From:   Mehdi Zeinali <zeinali8@gmail.com>
Date:   Wed, 16 May 2018 11:19:17 -0700
Message-ID: <CAJeoX+5ZGFS0yhXwaESzx4kTHn9AOLVF5d2MBU-Sr8JeQRBSxA@mail.gmail.com>
Subject: Git log range reverse bug
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git Version: Version: 2.14.2

When reversing a range in git log, it does not start from the expected commit:

$ git show 8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b
commit 8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b
Author: Some Name <SomeName@SomeAddress.com>
Date:   Mon Nov 3 19:01:53 2014 +0000
.
.
.

$ git show
Author: Some Other Name <SomeOtherName@SomeAddress.com>
Date:   Wed May 16 16:49:10 2018 +0000
.
.
.

$ git log --reverse 8e11b4a41ec21e47fb0bf8b76e1edba739f57a9b..HEAD
commit b4cfdb39f75070f143cdc2c4fbb98f4c6ee94260
Author: Another Name <AnotherName@SomeAddress.com>
Date:   Mon Apr 29 22:16:32 2013 +0000
Some Commit message

commit 6e6d5cd2a07985ae647fc19e7404ce1edf908949
Author: Yet Another Name <YetAnotherName@SomeAddress.com>
Date:   Mon Apr 29 22:35:00 2013 +0000
Some other Commit message

.
.
.

As you can see, the first commit is way off of the provided hash
Mehdi
