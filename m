Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE64C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22AEA613D4
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 18:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhGPS7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 14:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbhGPS7P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 14:59:15 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476A0C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 11:56:19 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id w188so11987269oif.10
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 11:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:message-id:in-reply-to:references:subject:mime-version
         :content-transfer-encoding;
        bh=Dp6st5CufBC2Rjq3a23Np42I+3zXwaH6bD326nCQKac=;
        b=C6e5pf3g2GH58rsF0WxLAq7nni7M2N4l9vFmu8uydIotoOnHTMmq3mTjuYr+sgw5hm
         81qZBhb2ev5YCUZ3uQ+Qb329belbuN/I5Zst0eZUu387cnSjaZ6iEKEzpvVr+CalLjnf
         cGk5CW7PJOEtu8/mFpHNokV/BZHrE8UdHkmJpGpPK6UatRiBwjgaOHkjHXnXzoZZlCEf
         l6uEH/8u+qCJKZXshtu+Aa5iREnty0WpcKpYINCsK9h83p4rhYFlbD4kgHb/STcqE+4/
         zGJyn/H2RneLR9G7ELOSysd5eWfpuCZiZt/8zrKhkbkX+RWwtAPukqrA+HePwWumME2W
         gvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:message-id:in-reply-to:references
         :subject:mime-version:content-transfer-encoding;
        bh=Dp6st5CufBC2Rjq3a23Np42I+3zXwaH6bD326nCQKac=;
        b=svHk5qd7mTjcvsiiXZTvCltOanEyAHc3VOlT2t7pbm4aM14jX5RqsKBREysBiAChdH
         DvDR5aWZIjMSW7qwF/7Z0gYJXr0lYqawjMr3/NQI90k04K6JbHUGN3DRE9ZPfWAhCiS/
         iYVFG6yKFuey0aZpYxXYNLlgYcczc9Ag5VEpn5CwER5yS/U/9eSmf2vapdC4cRy9Ubo8
         yDTXM3CraXjxtL9R4cb6kSUQA9WdVL5rGVT2MQ5DqBYphKeNvCjJu2TRlMO5XfL0JgoO
         Olror+M+rcHRX6o9DBGZHlYHsqcUvRAcxrFbpal4PqL34ugZJAAKCyYoUWQbDwZ/sbNM
         YKAg==
X-Gm-Message-State: AOAM532afBWwObGeLU/hYCHyC2+RE/0r8KNyKiIKdTkIeopoKc4Bwumd
        GiXWl/eUFManeipBb9ZvHNX3Ga6v9g+Ugg==
X-Google-Smtp-Source: ABdhPJzgmfmpGt70Z+pCjR4kdW1GYJGpLOXE5PoPlq9IvmtVvxznIGCWgzey/d3WUTbVr/s/BcaOXw==
X-Received: by 2002:a05:6808:201d:: with SMTP id q29mr13046821oiw.9.1626461778606;
        Fri, 16 Jul 2021 11:56:18 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id s16sm2054684otg.51.2021.07.16.11.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 11:56:18 -0700 (PDT)
Date:   Fri, 16 Jul 2021 13:56:16 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Message-ID: <60f1d650e2667_330208e@natae.notmuch>
In-Reply-To: <02f1f12a-0ff3-ef46-fce3-e222b2867309@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
 <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
 <60ec6d91deced_a452520825@natae.notmuch>
 <54644739-2138-8086-1696-d3c52960216c@mfriebe.de>
 <60ec74c513b2b_a45252081b@natae.notmuch>
 <0d7bd249-2aba-236a-9f93-3a5b30182d15@mfriebe.de>
 <60ec93155663f_a231f208fb@natae.notmuch>
 <3a84e4c9-4e48-1cbe-4fe6-150ff56c8508@mfriebe.de>
 <60ecbe577a086_a6b702082@natae.notmuch>
 <d3678ef6-1bcd-2666-87dc-751aef2ca1a7@mfriebe.de>
 <60edb8ff814cf_ab6dd208d9@natae.notmuch>
 <02f1f12a-0ff3-ef46-fce3-e222b2867309@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> On 13/07/2021 18:02, Felipe Contreras wrote:
> > Martin wrote
> >> You and I will make the connection between "something happens to the
> >> branch" and "something happens to the commits".
> >> A lot of people with less experience, who a busy looking through lots of
> >> stuff to solve their problem, they will not make that connection in that
> >> particular moment.
> >> Heck, I've seen highly educated people missing far more obvious things
> >> like that.
> > 
> > Once again I'm not talking about what they could miss, I'm talking about
> > what they are thinking the command will do.
> 
> Well they think it creates a new branch with the given name. And that is 
> *all* they think.

No. You are avoiding the question.

-c creates a new branch. Obviously -C creates a new branch too.

Once again, *why* would they pick -C over -c? What do they think it will
do differently?

> > Yes, and that's stupid. There's plenty of unnecessary warnings.
> 
> Yes and that is why we do not need to add
> "a solarflare may damage your pc while you perform this action"
> (As was previously brought up)

Exactly. Unnecessary warnings are unnecessary.

> > The fact that you have to do it in USA doesn't mean you should.
> 
> Well, yes. But the point is, there are people who miss out for more 
> obvious things.

That's almost meaningless. Like, *some* people have more than five
fingers per hand.

Yes, but how many? 1 in 2? 1 in 100? 1 in a million?

Bothering 99.99% of users with a useless warning just because one (who
is not the sharpest pencil in the box) might make a mistake is just not
wise.

> > Our objective is not to reach everyone.
> > 
> 
> "everyone that uses git" (and wants to be reached)
> 
> And that should be an objective.

Impossible objectives are no possible to achieve. Just like trying to be
liked by everyone. You are just going to waste your time, and fail.


That being said, we don't have to agree. And we don't have to
continuously discuss forever. At some point you need to send a new
version of your patch, and I think that point is long past due.

Cheers.

-- 
Felipe Contreras
