Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D73241F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 02:59:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752554AbdAZC7k (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 21:59:40 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:36537 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752478AbdAZC7k (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 21:59:40 -0500
Received: by mail-oi0-f54.google.com with SMTP id u143so128885231oif.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 18:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammant-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=AW0WnzShsaGu4x13Kz/0SngxREhI15D/aL82CGF8nyA=;
        b=nWLjpY445P5uPQWmcC0iGGxDjhH9/MOwU0Nql/h0CenIt60a0Wn29xT2TA9E2M81gU
         i1hsOJXwLKCjxOy9xV2tvcaZRP65K+W2u9tFbBBQk/iVqrOghnj6ow+pZqYUNEiCc0yI
         6z4AGhJ4Cdu1ZM6PJhadBRLgMPnAWKGbYCtRst3XL2vE3zAx18fg9Af6ca8Hw3GV3DZw
         2zbLJp3MaJgzoHOfM6p7EvMqdwqfkJaOkydbtYyhWmpCJnfqPRESmuH8qgOrxxjPY19Y
         b7nBOviEUoDZdHO2e7mnHMKjaOt9YMW1AC1CL9+f3b5l+Fn+P1e8R83VLIi7EGWSNhHq
         +WzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=AW0WnzShsaGu4x13Kz/0SngxREhI15D/aL82CGF8nyA=;
        b=g+Z+LpbEtOKz2o4SWLUS6UXwTrfiHy5w/ouSZuhUXBlYqLJXg7PmQEt/cRF6KuzWV+
         qtW4wimK2JStfdR5g+VhBAsZud7l4KBk3BwetxOef0l/SCqN3tPzpfUAC2sJuFey/co3
         dlLyvA1Cuh510HXD6+GUtEhwOswk9/GZ63Sokb+GNY16/DGEhnjnQWZSNbEHDk3PjHhs
         Ym1qNYBXm4h1Mi8i12y3jPv39C5voOI3sis97kpvA9r1HAA7VD9fQBo7wDQXlOngy5KG
         bSmrKncdA+PRC0ZG2bqCId2HTfGvpPSapu+vumD2jWguz4pQ2cm/PZ2RTihoPHQUMUPg
         KTRA==
X-Gm-Message-State: AIkVDXIuI9UuD2VE/mVIeDnUJMNHGwTSNRpwxX+pWy+tMQed0/wcuHKuE5/81AklIhW+dhBN4IuYJaiq5j9FpA==
X-Received: by 10.202.114.6 with SMTP id p6mr338865oic.216.1485399579247; Wed,
 25 Jan 2017 18:59:39 -0800 (PST)
MIME-Version: 1.0
Received: by 10.182.143.1 with HTTP; Wed, 25 Jan 2017 18:59:38 -0800 (PST)
X-Originating-IP: [65.78.25.171]
From:   Paul Hammant <paul@hammant.org>
Date:   Wed, 25 Jan 2017 21:59:38 -0500
Message-ID: <CA+298Uh=bfCJq3hmVdGUsinAgKFQd86em_J_8fwB9jQR5PZVgQ@mail.gmail.com>
Subject: sparse checkout - weird behavior
To:     git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a simple reproducible bug - something unexpected in sparse-checkout mode:

  $ git clone git@github.com:jekyll/jekyll.git --no-checkout
  Cloning into 'jekyll'...
  remote: Counting objects: 41331, done.
  remote: Compressing objects: 100% (5/5), done.
  remote: Total 41331 (delta 0), reused 0 (delta 0), pack-reused 41326
  Receiving objects: 100% (41331/41331), 11.91 MiB | 7.98 MiB/s, done.
  Resolving deltas: 100% (26530/26530), done.
  $ cd jekyll
  $ ls
  $ git config core.sparsecheckout true
  $ echo 'docs*' > .git/info/sparse-checkout
  $ git read-tree -mu HEAD
  $ ls
  docs rake

I didn't expect to see 'rake' amongst the results.

If I take out the asterisk on the echo line, only 'docs' is checked
out after the read-tree operation. Even if asterisk isn't allowed, I'd
not expect it to fail in that way. Sparse checkout documentation is a
little . .. . sparse it has to be said (sorry).

As it happens, I have some more complicated cases where
sparse-checkout is doing the wrong thing in the working copy - and
I'll work towards reproduction of that/those after this. Best to start
with a simple reproducible case in case there's a simple fix for more
that one similar bug.

Regards,

- Paul
