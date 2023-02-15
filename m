Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F7DC636D4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 22:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbjBOWR5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBOWRz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 17:17:55 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE8510FA
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:17:53 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33so239951wms.0
        for <git@vger.kernel.org>; Wed, 15 Feb 2023 14:17:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvfwvOEW1GUimOWboFGXs6odmN+vQBUy3hH2yGF3sM4=;
        b=Ov+al3bVH/fe3r8vEOJ0QWI2OA1oGy2sf76kB+SqwCLHmGaZXntM3+i1wbfDk78oKS
         IvydON4eC8zA/BpWbQ9j+GAN3/oJFXZpaM76pvlr5D61+WyANpt1ZtVzrHFT3bnMO4Nq
         qVB+oEgEhMvhDXef4ftK+kaaTBxsfZf4sFguYbf4G+X3KbPr68k588XM4HXKdk7kO3tV
         PATN65igE8ipvsD33zNE479MXbqJCKccIbK6djV68358oJCvWwTWhTV2O3Lo46+Qx4PR
         7WV6YC3ty46YMzch1wH8f8Jv6cHkCkJiKEljb4FB6VOSi2YtcGHfPZFaZk4YlEy/lxEu
         CQ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvfwvOEW1GUimOWboFGXs6odmN+vQBUy3hH2yGF3sM4=;
        b=TyF2QgsWfden8GxhmYwHzWcmDFVvxC7fijmkk9I7gnQijjQ2CxbrYqwZeTu7Jcr71r
         Rh4FaMoy22l3fb2mh8Ry1UqoF9AP86rTNmzoJVz3sW09fA0pO2uGm0yzANd4YjxRSPbA
         BjflUzX4zkPAvCT8NRbvHKbg6oljFffgFF8E2xdQ2B6UzhK1h1ILxAOhXY84/O+LBvzJ
         k3H1D6K4k5akEgPLa85kaBmpFjIpfosO6EkXhTHAPaLEKxxavJD92NIPofaCWa23iC7i
         Fv9b4pwDk2vfILcqK4kqDmwWDnFe0tcCSOZEBgPR9QNB843zwUbiat5ok6nMaR0UENZw
         63eA==
X-Gm-Message-State: AO0yUKWWRgmdti18lwfgzZsKRRiWGNWNEIZv359tloXmxiTHXetl33kZ
        jdI7TgwG2g3keLRujz2JkmE=
X-Google-Smtp-Source: AK7set8SE2rJfRJBhrPOJjguhqpVNDhcZKCVEP3/LmEpWtyj52HlnqzOolYMkiGvHuZCHgLIlnF6uA==
X-Received: by 2002:a05:600c:1616:b0:3e2:662:ade0 with SMTP id m22-20020a05600c161600b003e20662ade0mr1948302wmn.27.1676499472475;
        Wed, 15 Feb 2023 14:17:52 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id f22-20020a1c6a16000000b003daf7721bb3sm3445471wmc.12.2023.02.15.14.17.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 14:17:52 -0800 (PST)
Subject: Re: [PATCH v3 4/4] switch: reject if the branch is already checked
 out elsewhere (test)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <eeb0c778-af0a-235c-f009-bca3abafdb15@gmail.com>
 <f7f45f54-9261-45ea-3399-8ba8dee6832b@gmail.com>
 <02a15ebb-b927-1048-db2e-576abef9538b@gmail.com>
 <b18a5710-2791-f892-8460-dda7ea41d88a@gmail.com>
 <CAPig+cQpizjmhmDKb=HPrcYqqRq7JpvC-NZvY7B9eBbG+NrfKw@mail.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <c4dcfd83-593a-0c91-4f5d-04b172c160f3@gmail.com>
Date:   Wed, 15 Feb 2023 23:17:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cQpizjmhmDKb=HPrcYqqRq7JpvC-NZvY7B9eBbG+NrfKw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-feb-2023 23:17:42, Eric Sunshine wrote:

> > +test_expect_success 'switch back when temporarily detached and checked out elsewhere ' '
> > +       test_when_finished "
> > +               git worktree remove wt1 &&
> > +               git worktree remove wt2 &&
> > +               git branch -d shared
> > +               git checkout -
> > +       " &&
> > +       git checkout -b shared &&
> 
> The test_when_finished() call has an odd mix of &&-chain and missing &&-chain.

Oops, thanks, that was unintentional and hides an error ...

> 
> If you do use &&-chaining inside test_when_finished(), you have to be
> careful that _none_ of the cleanup commands fail, otherwise
> test_when_finished() itself will fail, making the entire test fail,
> _even if_ the test body succeeded. So, &&-chaining the commands in
> this test_when_finished() is undesirable since any of the `git
> worktree remove` and `git branch -d` commands could potentially fail.
> Better would be to drop the &&-chain and ensure that the final command
> succeeds.
> 
> It may be a good idea to use `||:` at the end of each command as
> documentation for readers that any of the cleanup commands might fail,
> which could happen if something in the body of the test fails.
> 
> The `git branch -d shared` cleanup command fails unconditionally
> because it's still the checked-out branch in the directory. You need
> to swap the `git branch -d shared` and `git checkout -` commands.

...  in fact, that needs to be "git branch -D shared" to successfully
delete that unmerged branch.  Considering also, what you pointed out,
swapping the two commands.

About the `||:`, maybe it's a good idea to keep the '&&' and let the
test fail if any command fails in the cleanup.  However, if that is also
part of the test, maybe must not be in the cleanup... so I don't have a
strong opinion on that.

I'll wait some time, if there is no argument against the change, I'll
reroll with the fix and using '||:' as you suggested.

Thank you for your review and comments.
