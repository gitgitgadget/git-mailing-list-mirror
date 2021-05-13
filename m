Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97810C433B4
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65F5D610F8
	for <git@archiver.kernel.org>; Thu, 13 May 2021 08:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbhEMIaC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 04:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhEMI37 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 04:29:59 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E54C06174A
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:28:50 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id n32-20020a9d1ea30000b02902a53d6ad4bdso22996637otn.3
        for <git@vger.kernel.org>; Thu, 13 May 2021 01:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7hc4q5QowVMeJtQkBRe0jt6qxWqMGklMFD9wvHtcNrY=;
        b=tyljFliaNE2qosEUmwmFyPvrKlmA8sqs5NL0+X6ePd51SyQL63m4vUmBWSaVumx1Gi
         bmy5Mn5ZQJRJlBTaSY+Qy+bIvfTPkpo50b7BZrH+bOKV7ciX+fy+Hqm5PpokrFOM/KNG
         eF2vWp1wqPQR2RsmMjHhq8UUwNChoLcZ2MYQS18u7qXK7Z8ITlv79bl6F+kcaDsB2nyK
         Q8ZassSQkh3gUlXfbmED59sxbvu1VlZ2rTISjZbB3wxtuc+BKSB9wf6Ynfi0dS2d6t5f
         H364ZHEaqh5tFHOXMCdEqHou9VAkTGkQlg5pg83ZHjj3D6R4fDvhXbRkhM+torM1Eud2
         xzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7hc4q5QowVMeJtQkBRe0jt6qxWqMGklMFD9wvHtcNrY=;
        b=SKSnlKbb/aKOT0GoBopj8MF8GpQm4Gd51smxmhYZXFeb83xxEEKcKUWdRbPO+pQ9il
         SUH/WknaKdh5NSs2iyOEpRIqbDki+XxVm3HwZGEYaZqgqpilUfd3Ue4TFSw/QKwbyNHW
         SAKs+lP2ibMoMNU9HoLT+C4SkI3V31AV0218D1NEmchgdqf3nAbBXBPAyjJMcjdHSCeu
         e4cfGA2jpFcWupAfyaMm4nbNVWEc5GS/sRaWdQgvxU0AdpabucLhztgFehpXV5eYX51M
         Yke3iIrmXuCbldUin/sOihpbdTvD4dEckXmy/kdPrKiW4/g2yK2oP4Hn/u/ilv/mN3py
         YBww==
X-Gm-Message-State: AOAM533TVjxUJsS9WM6MsaXi+0xqmXv2ppHhFvZDnH8u1mCATviijn5W
        TGxI/MDpId0T03sueyvKl8s=
X-Google-Smtp-Source: ABdhPJx+SDjG21QE6L2Z4Iry8t/eg3VFR6rEPzAsUPmGj76gitK5nzN2uZHqWjgNmPhI1vTiqj5D4w==
X-Received: by 2002:a9d:6c81:: with SMTP id c1mr20779124otr.248.1620894529542;
        Thu, 13 May 2021 01:28:49 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p15sm494923otl.23.2021.05.13.01.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 01:28:48 -0700 (PDT)
Date:   Thu, 13 May 2021 03:28:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?TWljaGFsIFN1Y2jDoW5law==?= <msuchanek@suse.de>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Varun Varada <varuncvarada@gmail.com>, git@vger.kernel.org
Message-ID: <609ce33fc57e7_5a820820@natae.notmuch>
In-Reply-To: <20210513074622.GG8544@kitsune.suse.cz>
References: <CAD2i4DALKgw2wG6QGs-oQhAHnS3AG1j1BSq2bxjPojVOtw+WjA@mail.gmail.com>
 <609b4eea1088a_678ff208ba@natae.notmuch>
 <20210512040926.GN12700@kitsune.suse.cz>
 <609b63e48fd49_6d7da2086@natae.notmuch>
 <20210512064733.GP12700@kitsune.suse.cz>
 <CAD2i4DBF3Tvf62Zyh0XnNH=5ifTD2QQNL5Fx01UHMzoTn3OMVw@mail.gmail.com>
 <20210512170153.GE8544@kitsune.suse.cz>
 <609c112066acd_71bd1208aa@natae.notmuch>
 <20210512180418.GF8544@kitsune.suse.cz>
 <609c2f98932f3_71bd120840@natae.notmuch>
 <20210513074622.GG8544@kitsune.suse.cz>
Subject: Re: [PATCH] doc: replace jargon word "impact" with "effect"/"affect"
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michal Such=C3=A1nek wrote:
> On Wed, May 12, 2021 at 02:42:16PM -0500, Felipe Contreras wrote:
> > If you and your wife are deciding what to eat for dinner, and you hav=
e
> > two opinions:
> > =

> >   1. Whatever is fine
> >   2. I really would like pizza
> > =

> > What do you think you should order?
> =

> That would be the situation if you comented on the patch adding 'impact=
'
> before it was merged.

No analogy is perfect.

> If you want a dining metaphor for the current situation it would be mor=
e
> like
> =

> 1. There are 100 people around the table eating lasagne

You are starting wrong. *Nobody* is reading the word "impact" right now,
and we are not going to swap the word in the middle of their reading.

This is a much worse analogy, and I seriously doubt you actually think
this remotely resembles the situation at hand.

-- =

Felipe Contreras=
