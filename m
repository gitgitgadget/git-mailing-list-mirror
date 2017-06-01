Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D935A20D0A
	for <e@80x24.org>; Thu,  1 Jun 2017 17:59:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751145AbdFAR7n (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 13:59:43 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:34138 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751122AbdFAR7l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 13:59:41 -0400
Received: by mail-pf0-f170.google.com with SMTP id 9so33665042pfj.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XtvePJfPttAzknxlk4QWT/ZNunMrf+USOXDY8XVOT6A=;
        b=ZeBgESdryPaQZrln/P6zkY5ArL4IyDvCAuCdvZfU30eGKx0bwIHxytPMieQ0GUtKJ2
         3nSp/e5GeoLSuHs7SOC19+S18KS8H3X1DQfOSFxCGMMUZMvt+m35gaW/p8e1pRwTUqMo
         sMBPGA39Ca3yOZKpPQ1w9/J3eDJ5MY4sCePcn0Pmbyc9KroAW/JvC15dpbqR1EARbm1q
         2AR7Jkw0t/ETFV9NbX03BB5LkPsPIpoWm5kdAdk5O3qSoMSJPGc/AwKQQMMzM6XpGHNj
         Y4A9G2gHhQt/abVa2kD0fqkmLgVb28Au8ubbjGRg3h7K0iFAkSixwniWK+/l6ck6VCVm
         O/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XtvePJfPttAzknxlk4QWT/ZNunMrf+USOXDY8XVOT6A=;
        b=oa/cjtkEjn8ye2XR+iiy86jLa5YpEiwGiAOrpUM5+ycaaVRjpwqotGOjDy6UE5ar6v
         XqSluk1viViSiEinrW8WGIxJ7NIqkzjCOkINbF8CwDiExg36tjssTdJGvCKdq5FW13zi
         jnB1UUeKYpGZPNYvpIXfe80RKLy4dLnYqOwgxndq2qwMi3rDJnJfchXFDiRqqZp8pq/j
         ExDFZ5rGsay4/7G/C8ICE4RKZhvmb+exhvDlSVogsMcLh/YBthfe1jnQdHP1JV2dM22H
         vlCtEtBlS6k7NecOJ/OWNy9hGoh02UWtFmTt5O7GKN75ORV8qSkRIKDHg/klk5SRG86O
         ZDog==
X-Gm-Message-State: AODbwcAPHvojqB/I6qEJQEvhelAgIG8b/geRgHCU93wRX8425KG0YIa8
        bOJrwOHhQ8ZHoRptl7KdFrKoG82JlZJd
X-Received: by 10.84.248.73 with SMTP id e9mr97627763pln.76.1496339981166;
 Thu, 01 Jun 2017 10:59:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Thu, 1 Jun 2017 10:59:40 -0700 (PDT)
In-Reply-To: <6762A30E-C558-4085-943B-AB85EBF18706@gmail.com>
References: <6762A30E-C558-4085-943B-AB85EBF18706@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 1 Jun 2017 10:59:40 -0700
Message-ID: <CAGZ79kZiPgsFaj23QvtgEgUhMiA5ygowY4OorSnzEfCdbv=a7g@mail.gmail.com>
Subject: Re: RFC: Would a config fetch.retryCount make sense?
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 1, 2017 at 5:48 AM, Lars Schneider <larsxschneider@gmail.com> wrote:
> Hi,
>
> we occasionally see "The remote end hung up unexpectedly" (pkt-line.c:265)
> on our `git fetch` calls (most noticeably in our automations). I expect
> random network glitches to be the cause.

There is 665b35eccd (submodule--helper: initial clone learns retry
logic, 2016-06-09)
but that is for submodules and only the initial clone.

I tried searching the mailing list archive if it was discussed for
fetch before (I am sure it was), but could not find a good hint to link at.

IIRC one major concern was:
* When a human operates git-fetch, then they want to have fast feedback.
  The failure may be non-transient, for example when I forgot to up the
  wifi connection. Then the human can inspect and fix the root cause.
  (Assumption in human workflow: these non transient errors happen more
  often than the occasional fetch error due to network glitches.)

For automation I would expect that the retry logic is actually beneficial,
such that you would want to have a command line options such as
"git fetch --retries=5 --delay-between-retries=10s".

>
> In some places we added a basic retry mechanism and I was wondering
> if this could be a useful feature for Git itself.

There are already retries in other places. :) Cf. f4ab4f3ab1
(lock_packed_refs():
allow retries when acquiring the packed-refs lock, 2015-05-11), which
solves the need
of github on the serverside, when they have a very active repo that
multiple people
push to at the same time. (to different branches. I believe that forks
are internally
handled as the same repo, just with different namespaces. So if there
are 1000 forks
of linux.git you see a lot of pushes to the "same" repo)

>
> E.g. a Git config such as "fetch.retryCount" or something.
> Or is there something like this in Git already and I missed it?

I like it.

Thanks,
Stefan
