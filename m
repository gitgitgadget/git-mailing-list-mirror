Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848C51F463
	for <e@80x24.org>; Fri, 27 Sep 2019 09:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfI0JvU (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Sep 2019 05:51:20 -0400
Received: from mail-io1-f48.google.com ([209.85.166.48]:32838 "EHLO
        mail-io1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbfI0JvT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Sep 2019 05:51:19 -0400
Received: by mail-io1-f48.google.com with SMTP id z19so14810937ior.0
        for <git@vger.kernel.org>; Fri, 27 Sep 2019 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=janmyr-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=T5JIJH7W4CMrGzw+HYGmDJCnJGmPrn40AHeUf3nLJDs=;
        b=KeyOPrykwOD9otdhB/oa5lbKOp3GzZdMPF5+dypGPaJ21IHEQLEM/jYvxru96Vmq34
         EejqcwfHAOe3KKvVevjAFu+RD+yaH+Rzr3Ghc23wK+nN7zDvmDCMft0yEgcX9wevNx5s
         C96mLvEmkhiiVa2otufpxaTMmW78VOWeLtyGAontChcVB6yud167ojM9hr0f5lR4Lp5k
         K7+ybsg2Y/sy6jmntrtTuse+fCIEpG+SHbO0io9DKq2XGyAfoCoCzbgH74DpWsX9xvu8
         9KwSYzOfty6Tbzndr2FphMYovvExYqcP3AZr//zmFsuyQ4popWc9HnRXg3H9M/0ODHt8
         5oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=T5JIJH7W4CMrGzw+HYGmDJCnJGmPrn40AHeUf3nLJDs=;
        b=SXV4aKLkz2pV/r59EkgD90jFXXaB57fJ5IV0VlFvYJaM4fYMUemD2EkoOG5C1tT5hi
         XNXORsXra7Dij7tybR+uEW7WAZD4QVVhvq4qv+rkuy5Og9l1Ns6pzlfQG8QCZ3/E/LiJ
         oVu8RQRiu6h+l47eGAetblMAMW8dKdksMRJAaSF6lL9CYzWXqM95KO7fcAWImVUBHVXf
         cHIKZImzp3kooI1pFabc5yTQevJWwOZg7qKYnoeZXCNKckgjBe6AGaGEOC4iesGhw8g2
         llY9yQt+dL6GTOlUJvApPfWh9AhpH8g39AtJ+0ZEfBFWYzX0xDz4wN+i/fYbFgfGOfvW
         mwzg==
X-Gm-Message-State: APjAAAVCovd+mmksqk6lfIsec7QJMI0amW21Yws9M8BGdAn6vqWmrjb2
        iBgQzXKnxcdUQ4cN9zM5XCT8g6O17/vTdrawSzUg9kzOgW4mTg==
X-Google-Smtp-Source: APXvYqwjZ2vGKvy8YpoiswuEk+m3pj5dhAoB1ZwwC9Nvx/QsDQHhGwif4M/E6cR9npX3DhD9dk70RcXcU4hMqI73970=
X-Received: by 2002:a5e:c644:: with SMTP id s4mr7669712ioo.291.1569577878282;
 Fri, 27 Sep 2019 02:51:18 -0700 (PDT)
MIME-Version: 1.0
From:   Anders Janmyr <anders@janmyr.com>
Date:   Fri, 27 Sep 2019 11:51:07 +0200
Message-ID: <CA+UvoT7EBa6S6Fi7scYTo8mYKx=n1e=sPvxy5TRP3vG7gw97Xw@mail.gmail.com>
Subject: Possible bug in git describe, additional commits differs when cloned
 with --depth
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm not sure if this is a bug or not but `git describe` gives
different results when the repo has been cloned with `--depth` or not.

In the example below from the git repository the number of additional
commits since the
last tag differs 256 vs. 265.

```
$ git clone https://github.com/git/git
$ cd git/
$ git describe
v2.23.0-256-g4c86140027
$ git rev-list -n 1 HEAD
4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a


$ git clone --depth=50 https://github.com/git/git git-depth
$ cd git-depth/
$ git describe
v2.23.0-265-g4c861400
$ git rev-list -n 1 HEAD
4c86140027f4a0d2caaa3ab4bd8bfc5ce3c11c8a
```

In the example above the first version also gives additional digits
for the SHA,
g4c86140027 vs. g4c861400, but that is not always the case.

I came upon this discrepancy when using the value from `git describe`
in a build pipeline
where the system optimized the build by cloning the repo using `--depth`.

Kind regards
--
http://anders.janmyr.com/
@andersjanmyr
+46 733-99 03 60
