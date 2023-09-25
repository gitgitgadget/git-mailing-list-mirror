Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9C8CD4857
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 18:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjIYShZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 14:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjIYShW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 14:37:22 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B59168E
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 11:37:15 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-59e77e4f707so86020687b3.0
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 11:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1695667034; x=1696271834; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpmPaXu55nwBk9qmgleBxHLUjQ0w3oWqs2kjLH8cH6I=;
        b=camgpu4kVobNYcwkSS92w0rKq4QKN1tpkunRZnPJc8UvQG2/lwJ/zGFhVwwybm1VTH
         aWYSr21mEu7vG2GbTXugaBCOIt5h1up5nftQ3tkNqo6tenWWy7D3wd22i8iG/Un2CkWB
         30L0sYwzUnaPK2zL6S2sxXIOdWtggcgxtFu57BgNHXva5vbBuKlGZH1Y6oMQMyRZqFAH
         9Q3MBEzeYDCBNxr/N4N7TsVXH0rIXx+zn1M3n+emRQNL+sUun17CtbNL94XjeE6ALA8n
         G36CpB6OkXL55OkVK9orbxFceYYD3/XA57ev0HTUVW1Mr7IZfNe94sSnaDHzAbSuE4Xq
         yG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695667034; x=1696271834;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EpmPaXu55nwBk9qmgleBxHLUjQ0w3oWqs2kjLH8cH6I=;
        b=TJrJGKs9iXV5DiXR5Xk4cYJutem3sb6Z14+imc42Aquns90PDhObq9D34jl9PaqCqB
         Mlm0IYgPDO93UAPzMupnhqVpO4h28zEhVOYE4sE7/Mj1nLZO7Mw/hWazvojJW7iro0GX
         pKZ0SIF8VZfevdKHHchYcKEInI6F1xAAlHY09v+mUORvbDcNVJyrlh0K/jyFjZkIHpoA
         SEZAOo+HhmkTsHjvaV+ofupJCm07ZooARUVd7EZmMEqsdNfgl0FSBn/hY+80eCSV3Abn
         LHq361A/rB9HIC+1VzT+2NpAPAdYPrwWdBRWwrctELEhozwJa7MAVGz4zIpzzDmOd8R7
         MZLA==
X-Gm-Message-State: AOJu0YyIahyUoPafodLxQi2vaTNweLYZqgkwuYM9wbxTQ7YRK0BEQ3M3
        nEYiWWtasK9bhGCRRmDPUP6dqoxlyBI7nirIprU4TA==
X-Google-Smtp-Source: AGHT+IFYhCHQPRAiVCGFc58Q6hwMdCRRGUpAktGaZDDQmgvU9B8oaMoEkHLfJ3Poidgmrmyv6s3Ipw==
X-Received: by 2002:a81:4f8a:0:b0:578:5e60:dcc9 with SMTP id d132-20020a814f8a000000b005785e60dcc9mr7646936ywb.10.1695667034499;
        Mon, 25 Sep 2023 11:37:14 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x2-20020a818702000000b005869ca8da8esm2516682ywf.146.2023.09.25.11.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 11:37:14 -0700 (PDT)
Date:   Mon, 25 Sep 2023 14:37:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Git / Software Freedom Conservancy status report (2023)
Message-ID: <ZRHTWaPthX/TETJz@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In last year's "Git / SFC" status report, I promised that I'd try and
share updates more regularly about our project financials, things that
SFC have shared with us, etc. I'm happy to report that I have kept that
promise ;-).

This email will serve as a report on the project's activities at
Conservancy for the year 2023.

The previous report (from last year, whose format I'll try to stick to
here) can be found at:

  https://lore.kernel.org/git/YyELnLai0jXsnt3W@nand.local/

# Background

Git is a member project of the Software Freedom Conservancy. The Git
project joined Conservancy in 2010 so Conservancy could help us manage
our money and other assets, and provide legal representation for
trademark matters. Conservancy doesn't hold any copyright on any of the
project's code. Similarly, being a member project at Conservancy does
not grant Conservancy any influence in the project's development. The
technical direction that Git takes is up to us.

Interested readers can take a look at a more full picture of what
Conservancy does for the Git project at:

  https://sfconservancy.org/projects/services/

A "Project Leadership Committee" (PLC) represents the Git project at
Conservancy. The PLC currently consists of Junio C Hamano, Christian
Couder, Ævar Arnfjörð Bjarmason, and myself.

# Financials

The most recent data I have this year is from 2023-09-18, so these
numbers should be more or less current.

We have ~$89k USD in our account, up ~$19k USD from where we were in
March, 2022. This was a relatively good year for us in that regard,
since the average year over year growth we have seen over the past is
closer to ~$10k USD/yr.

Here are some top-level ledger numbers gathered since the end of
March, 2022 (the date of the last report). Note that this is all
double-entry, so negative numbers are good.

           $-22,058.48 Income:Git
           $-21,566.67   Donations
              $-491.14   Royalties
             $3,098.57 Expenses:Git
               $217.14   Banking Fees
               $452.22   Conferences:Travel
                 $0.00   Filing Fees
             $2,236.03   Hosting
               $193.18   Tax:Sales
               $-27.40 Assets:Receivable:Accounts
              $-131.58 Liabilities:Payable:Accounts
  --------------------
           $-19,118.89

Like last time, most of our money comes from donations. This year just
2% of it comes from royalties (last year this number was closer to 5%),
all from Amazon affiliate links. 10% of all incoming money goes to
Conservancy's general fund (the above numbers are after that 10% has
been deducted).

Last year we spent money ($452.22 USD) sponsoring one GSoC student to
attend the Contributor's Summit and Git Merge events in Chicago, IL.

One notable change from last time is that our hosting fees have gone up
significantly. These are entirely from Heroku's change in policy to no
longer grant the Git project hosting credits for the git-scm.com
project. Our costs in the meantime have been supported by a generous
donation from Dan Moore at FusionAuth. The below email has some more
details:

  https://lore.kernel.org/git/YkcmtqcFaO7v1jW5@nand.local/

It appears that since the above was written, Heroku has a new (?)
program for giving credits to open-source projects. The details are
below:

  https://www.heroku.com/open-source-credit-program

I applied on behalf of the Git project on 2023-09-25, and will follow-up
on the list if/when we hear back from them.

# Trademark

We hold a trademark on the term "Git" and its logo in the space of
software and version control. The report from 2017 has a good overview
of the details there:

  https://public-inbox.org/git/20170202024501.57hrw4657tsqerqq@sigill.intra.peff.net/

Last year, in response to some discussions we had with folks at
Conservancy, Christian brought a discussion to the list about rethinking
the way we treat our trademark in the future, particularly with respect
to enforcement.

  https://lore.kernel.org/git/CAP8UFD3WQ64FuXarugF+CJ_-5sFNBCnqPE0AEBK-Ka78ituKTg@mail.gmail.com/

Conservancy has brought up this topic with the PLC a few times in our
meetings throughout the year. My impression is that they would
appreciate us taking another look at that discussion and (possibly)
rethinking our trademark strategy as a result. I encourage folks to dig
up that thread and share any thoughts they might have.

# Travel Budget Allocation

Like I mentioned above, we sponsored travel for one GSoC student to
attend Git Merge and the Contributor's Summit last year year. The PLC
formalized this process a little bit more rigidly in 2018. The report
from that year has a good overview of the details.

Similarly, that whole procedure is (still) open for comments and
suggestions. Our main focus is to make it possible for new contributors
(particularly ones who have participated in programs like GSoC and
Outreachy) to attend Git Merge (and, specifically, the Contributor's
Summit) where it wouldn't otherwise be possible.

# Conclusion

That's all for this year. I'm happy to answer any questions on the list,
and I'll propose a session on it at the Contributor's Summit tomorrow,
in case folks want to discuss this further in person.

Thanks,
Taylor
