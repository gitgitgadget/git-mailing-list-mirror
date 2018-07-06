Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D1D591F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 21:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933116AbeGFVaB (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 17:30:01 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44217 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932496AbeGFV37 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 17:29:59 -0400
Received: by mail-pf0-f194.google.com with SMTP id j3-v6so9362557pfh.11
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 14:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iltDnDkXskzKQYGxJ7qRyWkKsIgXWOuceGRa4B3fGno=;
        b=o8gnoJqBHZYzZHKSQTBN/ga9bbfDcd3acc6jDiNS6CIjDpizndEDBYp7gGRWQ7uOLT
         Q8BDPhqvqwt8eNtMS1/qmwzkfkTqSJNlq4dSgOai+zn/pjolE1a1VJGNSth2vGPnJLso
         RNY5U67n/kfOdfh2fLYyeqHoOGxzTLFpZapNHljFhhChaBo//TekpA+cjxbDfSjxFCYx
         BMHQd6XbSljbJ33i2MbsW+37FYFcFFFrYr2yRHIebu5w0ZL6Q7NmET0mn2+u1v9sCzim
         Gd+KrJNhIHSIHW6xjpwQWkjTkt69Pvg64MqUoHnRJGyqsomkwPPifAiewg3ep8/Gq2gf
         g9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iltDnDkXskzKQYGxJ7qRyWkKsIgXWOuceGRa4B3fGno=;
        b=J8eeG+Q99kYw1baM7B9NH6VxJ+MFn3y04DpZX6FWUL3p+kVWVTm7QRbvnlQmf/hLVO
         DVBFzJck1PUO43qgNRz1AoTEZCK4jfRF3GQvrB/0Q3qMaDn/yEEA5w2PTD9Bpj3RJ+rf
         UOxyhRaHaVGjpG24OaYlj3c3kzZSBlmdsvHsU8YUim60/RZXbas1K9sKOqO49BFvIaXf
         dhAIwirBl0JlEsAcLOF3qkcWxf3DI6oVYUy+twpJ6MrE1f6xk0Tvshlw4mYG7TMofes4
         sxtR34t5KIIgwavFH0YfrmAWHK1r97NwFlghVSp7UcjY00PuE2MVp56kMNEaksi8oYks
         3+DA==
X-Gm-Message-State: APt69E1WFmOuKopuqWMOq/QQ46N5m28dHStjqSG+5ZGqfsqExU+Mkjg8
        xccaKMhVpbFUYewGbCjyZpg=
X-Google-Smtp-Source: AAOMgpcee7GoUUW1mY38dzEBY8xwSr9p7uoJyUwrY6sQmwZIdkOozTeQQPsSSpDuRqrL2l0zloqOUQ==
X-Received: by 2002:aa7:83d1:: with SMTP id j17-v6mr12209885pfn.236.1530912599285;
        Fri, 06 Jul 2018 14:29:59 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id d188-v6sm17229176pfc.96.2018.07.06.14.29.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 14:29:58 -0700 (PDT)
Date:   Fri, 6 Jul 2018 14:29:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH 0/2] Avoiding errors when partial cloning a tagged blob
Message-ID: <20180706212957.GD6195@aiede.svl.corp.google.com>
References: <cover.1530905323.git.jonathantanmy@google.com>
 <20180706193847.160161-1-jonathantanmy@google.com>
 <xmqqk1q8jfak.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqk1q8jfak.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
>> Jonathan Tan <jonathantanmy@google.com> writes:

>>> When cloning a repository with a tagged blob (like the Git repository)
>>> with --filter=blob:none, the following message appears:
>>>
>>>         error: missing object referenced by 'refs/tags/junio-gpg-pub'
>>>
>>> and the resulting repository also fails fsck.
[...]
>                            Naïvely, I may expect fsck to follow the
> same principle--when it encounters a reference to an object that is
> deliberately missing, refrain from complaining, regardless of the
> place the offending reference was found, be it inside a tree object
> or a ref.
>
> Perhaps that line of consistent behaviour may be impossible due to
> the way the reference is stored inside a tree object and a ref?

Yes, exactly.  I believe this is why we did not treat refs as
promisors when we introduced promised objects.

We could revisit that decision and make refs into promisors, storing
any extra metadata on the side.  That would be a more invasive change
than this series does, though.  In the model used today, where refs
are not promisors, this series is the logical thing to do.

> E.g. a reference to an expected-to-be-missing blob still lets us
> know that the missing object is expected to be a blob, but a ref
> only stores the object name and not its type, so we can tell it is
> missing, but we cannot say it is OK to be missing because we expect
> it to be a blob, or something?

The main downside of saying that filters should not be applied to the
objects named directly in a "want" is that such objects could be large.

The upsides are that

- it makes the protocol more consistent with the current invariants
  maintained by "git fsck"

- down the line, it should make operations like "fetch just this one
  tree" a little simpler, since you can use

   filter blob:none
   filter tree:none
   want <this tree>

Later we could introduce a separate kind of "want" for which filters
apply to the object named directly, too, to provide more flexibility
for the client.  I can imagine cases where a person would want each of
those two behaviors, so I don't think we are incurring unnecessary
complexity by always sending the object named in a "want" without such
an explicit filtering request.  So I'm comfortable with the direction
this series goes in, though I haven't looked at the patches in detail.

Thanks,
Jonathan
