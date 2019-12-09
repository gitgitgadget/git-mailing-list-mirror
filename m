Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.3 required=3.0 tests=DATE_IN_PAST_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD8EC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:32:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E32A2068E
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 15:32:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbfLIPc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 10:32:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43220 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIPc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 10:32:27 -0500
Received: by mail-io1-f65.google.com with SMTP id s2so15159487iog.10
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 07:32:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mpbr6GIqQ2klLm6HtlKaR6jQYRnHpmLbfyaAZnISDV8=;
        b=qFgw1cMG4KLXg8VsL8vifhiQbd3KQkcGNWiz3ojh1zDRnE8+D10U82dCBFbDcKrGoR
         +ZJ9HkIwb169qwC1cDQJhJy6h3WhLxE8Vfo7gEGh2BqPLDWe57iNnXYUKPexzyfKj8ql
         VQ2TquEFc1ANYNm08h62m9iQh7x4YPX5lLV8LHjWPeuQmV3INVvUB8FLdDGVbqJHedPg
         J1dWrXv578bTJBD8vUsQeUy+KVHevOGNWUTx3IGszWM9gEYVGGbjLkg+CSnHDoMsjOSI
         8geer1tF2ZHYiZPqId/9Tnvbj9C6k4mQV5NL50rXWURL5lCxrwTPAhiGu3fXgkikifs+
         F2rQ==
X-Gm-Message-State: APjAAAUkdUTd8eRcZvwTrMLv9gTrUiSIFAR7K9bDDsjTsM3usbqv4jjg
        SMSLTX+q9cZQFG/8UUSIwFp5g6Wd/RMhLNBRnYOVl1fC
X-Google-Smtp-Source: APXvYqzW7JITMjrr56AqknTTbqupD/wpkxqwYZ8TPh3LIjvWCY++5cN1Y7ZgbtZVGudPRk9ykHMRm/xZjG7A79LbL3s=
X-Received: by 2002:a6b:db12:: with SMTP id t18mr20340326ioc.11.1575905546498;
 Mon, 09 Dec 2019 07:32:26 -0800 (PST)
MIME-Version: 1.0
References: <CANxxO2MGJ2Wo6Y-33KzzPXz6vktRACk0Oi2Y6o_s-cDFRhG7+Q@mail.gmail.com>
 <3b9408a9bd87ea488c4a6b9bc2583aba56ce3949.camel@swri.org>
In-Reply-To: <3b9408a9bd87ea488c4a6b9bc2583aba56ce3949.camel@swri.org>
From:   Ed Maste <emaste@freebsd.org>
Date:   Mon, 9 Dec 2019 06:45:57 -0500
Message-ID: <CAPyFy2BjWx2Hp+H__kDFRFZZjcK4hc99oKqkZQjXPLfQE=2SPg@mail.gmail.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after 315a84f9aa0e2e629b0680068646b0032518ebed
To:     "Strain, Roger L." <roger.strain@swri.org>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "marc@msys.ch" <marc@msys.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 9 Dec 2019 at 09:29, Strain, Roger L. <roger.strain@swri.org> wrote:
>
> I've had to further
> customize the script for our internal use, and those changes aren't
> something that would be useful for the public at large.

Would you describe the sort of problem you have to work around with
custom changes?

I'm starting on a path of trying to fix git-subtree for failures[1]
encountered in a prototype conversion of the FreeBSD repository from
svn to git. The misbehaviour I encounter occurs when split encounters
a commit for which the path being split is empty in 'git ls-tree', and
the commit is actually not a subtree commit. I'm currently
experimenting with hacks to skip specific hashes during the initial
subtree split. On reading your mail I realize I could address my issue
by testing for the existence of a specific file though, which makes me
wonder if the issue you have is similar.

[1] https://lore.kernel.org/git/CAPyFy2AsmaxU-BDf_teZJE5hiaVpTSZc8fftnuXPb_4-j7j5Fw@mail.gmail.com/
