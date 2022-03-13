Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D25C433EF
	for <git@archiver.kernel.org>; Sun, 13 Mar 2022 22:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiCMWbr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Mar 2022 18:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiCMWbq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Mar 2022 18:31:46 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C53F1C114
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 15:30:36 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id r2so16186429iod.9
        for <git@vger.kernel.org>; Sun, 13 Mar 2022 15:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:user-agent:from:to:cc:subject:date:in-reply-to
         :message-id:mime-version;
        bh=IeZJOoEoUgEMBaxD1SP3GxjWrlwcW1Vaa680s833K/Q=;
        b=Aau2dYnqzGP41+rLSnCoqDOLhBaCHCs61295dqJXK0f+teNLORgIBzGKbKj1Kmozm5
         FzmoummmGS6whjuU+6xH2yYE/k2ZhCjjJW2IQOalfYv3OG1k2ztYL6sC0kUAgs4mdQ1b
         dN8xe+39KpJrYtqEyBlxpQo+MEG0cTCjPZ1EImOSFMu74378XKhonY+wJy5l4HWU5s7t
         w+32RUc+dJnucKx1Kh2D8/YxY71O1+FhyEcUS2tYvqcCRfeUham8FEVD0vw58yxw+nvo
         yzauXmAnsH6HufMrDf3c8QBmhRZKsbVW60yhxl5qqFPvYryZ88L6sh8nQQKUeHv9D8+B
         bYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
         :in-reply-to:message-id:mime-version;
        bh=IeZJOoEoUgEMBaxD1SP3GxjWrlwcW1Vaa680s833K/Q=;
        b=5ppI303tzgMRmrtosHbVoo2O2UZq7h9JWWRzxecWrE2up9S/PWKgMgsPLzhQnK4H3Y
         xe01pNCr2TD+H1ud9KAsmLacmJYUwO29oRZPYsJbSv7s+bGrNaicHGat+9MWX7TQxPjg
         HjMOT3CKamEMGQjx1A3XG5E6DccdduYGb1KdXtWJ0AKoxYNqwjbkP6krQ3Q5clpkgxXx
         EuUlz+B4mnj9wQO2p+o18BRNe42w8KpW0oH4T07V4WkjuR6J7EZ9R23JrVrgGECMdwHY
         HoDi1/bGOYOPrPaqcVmLsKe1PYgROm4eYH/sCwlZZFgT61V2eaW2OkPJlqAwAKRo7QKP
         mmKA==
X-Gm-Message-State: AOAM533r7sdJDCYwO8ydaPrRv3ORLhvx7o8QZs8U8eVdI6L/oZk8jpTR
        Sy7+yhFreJVfU95im6BwhcfDXRu5Jcw=
X-Google-Smtp-Source: ABdhPJy2bd/6q6greLN91n21ci85cbkDM8PzdhQkgzF/j72baSAIyd3AME/rzr67uT72yskhJGVuhw==
X-Received: by 2002:a05:6638:12c3:b0:319:9b70:5ad8 with SMTP id v3-20020a05663812c300b003199b705ad8mr17656649jas.132.1647210635320;
        Sun, 13 Mar 2022 15:30:35 -0700 (PDT)
Received: from EPIC51148 ([199.204.58.10])
        by smtp.gmail.com with ESMTPSA id w2-20020a056e021a6200b002c655123821sm8668328ilv.37.2022.03.13.15.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 15:30:34 -0700 (PDT)
References: <878rtebxk0.fsf@gmail.com>
 <Yi4oO+ifSK8OH0Mt@camp.crustytoothpaste.net>
 <020501d83703$2f8785f0$8e9691d0$@nexbridge.com>
 <020901d83713$2b446ac0$81cd4040$@nexbridge.com>
User-agent: mu4e 1.7.9; emacs 27.2
From:   Sean Allred <allred.sean@gmail.com>
To:     rsbecker@nexbridge.com
Cc:     "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, sallred@epic.com, grmason@epic.com,
        sconrad@epic.com
Subject: Re: Dealing with corporate email recycling
Date:   Sun, 13 Mar 2022 17:23:36 -0500
In-reply-to: <020901d83713$2b446ac0$81cd4040$@nexbridge.com>
Message-ID: <87mthta3jq.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


<rsbecker@nexbridge.com> writes:
> What about abstracting this into a map-email or map-identity hook of
> some kind? So, whenever there is a need to write an identity
> (committer, author, signed-off-by, etc.). That way, anyone who wants
> to, can implement whatever policy they want for replacing emails with
> some other value in the repo, and back again.

This is an interesting idea, but I'm afraid it might be difficult for
forges to implement support for as opposed to something built-in.  If
that's not as difficult as I might think it is, then perhaps this is a
viable option once fleshed out.

> It might be good to optimize it so that the hook is only invoked once
> per identity per request so that git log does not become insanely
> expensive.

I'll add that Windows (and our particular environment) makes this
troublesome as well.  Currently we see a base cost of 300ms for starting
up a process.  Given how many identities git-log and friends would be
chugging through, any hook would need to be capable of staying open --
feeding identities through stdin.  I'm not sure run_hooks supports that
right now.


--
Sean Allred
