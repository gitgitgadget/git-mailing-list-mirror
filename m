Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024B0C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 21:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE5B60FBF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 21:01:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242799AbhI1VCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242572AbhI1VCm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 17:02:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E48EC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 14:01:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id 145so48835pfz.11
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Mb957kPaFl35YecmGIyFs36PNCRfV3U5o++5k+xD6s0=;
        b=duTc288/GcSA3zFyIPO4vAn4inBzawsdQwcbdWTs7A6QPx/IeLwgXk2WfaTJSIklCm
         lYZIRTdOzSt/p6Z+GjMlcZ3eD1vw0Y0tUMC8AnkAzC5e4Ead6H4GlFGK+Y4BS2361aaW
         0sTzU2lMAGEuhf8gpOK3D1Bbp2VAFdYZUqAooYI6NGkMupvmVTCUoJGumws/BhtgDlV8
         dAj6RrWTBauZB/YgxnF6tTh6dctnvn61hw/gN3Iz20wO4DM2Rc/od5nlaAMr04x+J+wT
         LXUBj4fbG9OQ4NLwqbIv8YVPfdGpStV/7kmqToGWYqrFnaeFCIsKtwm5w8a5lUBPRfGo
         GzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Mb957kPaFl35YecmGIyFs36PNCRfV3U5o++5k+xD6s0=;
        b=tFT77Mc+mpUsuAc0yToPAZFwK0D1yjeGJUcAaNgse5u6kGaYNoYJ4NDPCqj0BXb9lm
         sqP6aiT0JddesjnHpFn5pTqlnjmFl7wSoL6sGmB1IuuekS8sVdd1IkT6u1/TDdzLxIHU
         sTJdjB4FmOcK5O79FSczWMLcQH4xMXPWaQtxwJifJoTv5WYgu4I2cnRpv8vIMfHRKeHL
         kSl72kIcE8mxfKS96/CzEhuD52v75U6ASbzxrLNZxG0MhAXVqdHqoKGunz4sJbHvR6oE
         AqnHuZvy2A8IsXIU7Id7QqfQexkzLTnphblsO86lP+BBdFfgoo5C7p683xLlXbhS5IBy
         UTXg==
X-Gm-Message-State: AOAM530pMtKlB49lFggk7hhPjmtMVVWMTcgtonbpj9EeVvEvVpm1mH1F
        OaMdAiCTytWiZtTtU80aJdQ=
X-Google-Smtp-Source: ABdhPJx6dP2ZUGEo0/xtAPslrrbCfuhTS6sryAvLddbLY6Ndb5TSiu761suKlq3LxmBgVcpmuQL70Q==
X-Received: by 2002:a62:1e43:0:b0:447:cb0b:4c6e with SMTP id e64-20020a621e43000000b00447cb0b4c6emr7584686pfe.1.1632862861361;
        Tue, 28 Sep 2021 14:01:01 -0700 (PDT)
Received: from neerajsi-x1.localdomain (c-24-56-227-232.customer.broadstripe.net. [24.56.227.232])
        by smtp.gmail.com with ESMTPSA id r18sm58495pfh.214.2021.09.28.14.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 14:01:00 -0700 (PDT)
Date:   Tue, 28 Sep 2021 14:00:59 -0700
From:   Neeraj Singh <nksingh85@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Neeraj Singh <neerajsi@microsoft.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
Message-ID: <20210928210059.vy5isvmcj75vufdu@neerajsi-x1.localdomain>
References: <xmqq8rzhmsi7.fsf@gitster.g>
 <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <87v92lxhh4.fsf@evledraar.gmail.com>
 <xmqqilykliiz.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqilykliiz.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 10:25:08AM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
> 
> > I haven't poked at it much, but haven't you and Neeraj Singh (CC'd)
> > independently come up with two slightly different changes in
> > tmp-objdir.c to do the same thing? See the tmp-objdir.c part of:
> >
> > http://lore.kernel.org/git/543ea3569342165363c1602ce36683a54dce7a0b.1632527609.git.gitgitgadget@gmail.com
> >
> > And your:
> >
> > http://lore.kernel.org/git/67d3b2b09f9ddda616cdd0d1b12ab7afc73670ed.1630376800.git.gitgitgadget@gmail.com
> >
> > I.e. yours has the object database managed outside, his has it added to
> > "struct tmp_objdir", but it's the same objdir dance isn't it?
> 
> They touch the same tmp-objdir, but unlike the original use in the
> receive-pack (i.e. responding to "git push") with the intention to
> add the objects collected in them back to the primary, remerge-diff
> wants to discard what was added there at the end.  I do not think it
> would directly help the bulk-fsync stuff (but I didn't quite see why
> bulk-fsync stuff needed to _add_ new functions to tmp-objdir API,
> instead of just being a customer of tmp-objdir API), where it wants
> to do the same _migrate() dance in the end.

Both Elijah and I needed the same functionality of having a writable
ODB in the current process, which wasn't previously provided by tmp-objdir.

I'm making a new patch which is an amalgamation of Elijah's version and mine.
I'll rebase and resend my patch series with that version and I'll also make
a modified version of Elijah's branch available on github.

Thanks,
Neeraj
