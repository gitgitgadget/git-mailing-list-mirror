Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062F51F597
	for <e@80x24.org>; Fri, 20 Jul 2018 19:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbeGTUr3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 16:47:29 -0400
Received: from mail-yb0-f178.google.com ([209.85.213.178]:43134 "EHLO
        mail-yb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727554AbeGTUr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 16:47:29 -0400
Received: by mail-yb0-f178.google.com with SMTP id x10-v6so5066657ybl.10
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=HZPX4/Q/DeRljVT20//Ag5oOamXqAftGP0pPGgfOFEE=;
        b=WXl/IWUJ4lHbY/7ZPEyFo8iiTMp66uyUZpitYRqKo5GpfUGQfg/gSw27GzY0arAmIo
         F6bt0B7lkJEHngrZLauiirOsgf7mWx9QTYOsz6xjWBoVBOyt3ejVft95yGaEleMJOCeR
         mEJhXSES1thgpcIlsXIMmw3MmlbMCjvhdEidYoyUktFCsYvMrhUtLJlKXMN2nJNmzjja
         +2g7RihUwciAh1FIcm0A9wXrVa/HGvS1Gp77OJk8lwvBwGff2nywrr429z1qbwez5lwg
         c/7gTSyPySbAg9WO83VqY2d6+MbUY4fZJcgiQQLmT9ZAdkM51rmf8qUuwMpCRGg5Phag
         sJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=HZPX4/Q/DeRljVT20//Ag5oOamXqAftGP0pPGgfOFEE=;
        b=KXORA7bDvYnMjomz41ZIQ4IBOq6yxbkLg3Hwzvg+eVu2jKonWy6P40nK0EYW0JXBmb
         xqjqle6JfHnERQEhynPGyM6TMOBbZY1JHyYcjJZ/LvVEiPDwLKBtjOk0NzClOgykZgW7
         aTeHO+qATe+jkJ86DRmOniV4T+0s4FQbLFpJTAYtoVu5KGU5HW1QNgoSb8ldgAdo+2zy
         cfzO3xqI4N9ayR7tYrQYYliLa2+GuGpbLGhrlIyDXoV6fyiTX02OclwmUvbeD+foSjgB
         tsQE6MbLN+b12p5FrvYFH99WSfwQj15eOirdjOgQW1ZSL654Z1aMsBNbYnI1eHXol4m2
         t8CA==
X-Gm-Message-State: AOUpUlEJ5XmyivmO6gwGLSv2myWKY0vrsFsB7dpkl6mY1qRekEedoonf
        oDVZbjqIe5vybHtZG9fRBSf4U5imr2/lCv6Bv7eCIzCLAT7vDg==
X-Google-Smtp-Source: AAOMgpcrEWTPhsl4aeI1XA2PteSuPnoCksMuOXwANV1UT07S2AD1PByuAKosqBZqK2jkLWx37PrcwFkUn6Pxj7og55A=
X-Received: by 2002:a25:84d0:: with SMTP id x16-v6mr1898214ybm.307.1532116662506;
 Fri, 20 Jul 2018 12:57:42 -0700 (PDT)
MIME-Version: 1.0
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jul 2018 12:57:31 -0700
Message-ID: <CAGZ79kZYO6hHiAM8Sfp3J=VX11c=0-7YDSx3_EAKt5-uvvt-Ew@mail.gmail.com>
Subject: FYI: histogram diff bug
To:     git <git@vger.kernel.org>, jgit-dev@eclipse.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  seq 1 100 >one
  echo 99 > two
  seq 1 2 98 >>two
  git diff --no-index --histogram one two

In addition to the recent patches[1], I found another bug in the
histogram algorithm,
which can be produced with the instructions given above. At least I
think it is a bug as
the diff looks terrible to me. (It is a correct diff, but the output
is just bad.)

[1] https://public-inbox.org/git/20180719221942.179565-1-sbeller@google.com/

And I think the issue is in the algorithm, which is basically as follows:

1) build up information about one side ("scanA()"), by putting each
    line into a hashmap (and counting its occurrences, such that you
    can make the histogram)

2) "find_LCS" on the other side (B) by trying low occurrence lines
  and seeing how long the common consequential string match is.
  (I think this LCS refers to [2], not to be confused with [3])

3) The whole mental model of the difference
    between both sides now look like:

      stuff before the LCS
      LCS
      stuff after the LCS

    As the LCS has no output associated with it, just call recursively
    do_histogram on the remainders before and after.

This is my rough understanding of the algorithm so far.
    (I am unsure about the exact find_LCS part how and why to
    pick certain candidates for finding the LCS).

The big issue however is the count of LCS, so far we assumed
there is only one! In the example given above there are many,
i.e. lots of "longest" common continuous substrings of length 1.
We are unfortunate to pick "99" as the LCS and recurse before
and after; the other LCSs would be a better pick.

So I think we would need to find "all LCS", which there can be
more than one at the same time, and then fill the gaps between
them using recursion.
As the order of LCSs can be different in the two sides,
we actually have to produce a diff of LCSs and those which are
out of order need to be emitted as full edits (deletes or creates).
In the example above we'd want to have "99" to be a full create
and delete instead of being *the* anchor; all other LCSs ought to
be anchors for the first (zero'th?) level of recursion.

This bug is also present in JGit which this algorithm was ported
from, hence jgit-dev is cc'd (and furthers my suspicion that the
issue is not in the port but in the algorithm itself).

[2] https://en.wikipedia.org/wiki/Longest_common_substring_problem
[3] https://en.wikipedia.org/wiki/Longest_common_subsequence_problem

I'll think about this and see if I can fix it properly,
Thoughts or Opinions?

Stefan
