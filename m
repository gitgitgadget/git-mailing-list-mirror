Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F11CC4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1549D23AC2
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 12:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgLSMIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Dec 2020 07:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726456AbgLSMIs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Dec 2020 07:08:48 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF223C0617B0
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:08:07 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 15so6000086oix.8
        for <git@vger.kernel.org>; Sat, 19 Dec 2020 04:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=E592oVf3gpaLaSPQ9ky7Mj8qlmBz7Yxe6MxT/p5Qbkg=;
        b=YMB3RKedcZXod/x8rVZq1Q+rGvJNQ8JZt3RcbhlfHHcgCAM7mNs+v8Jcci5kXL/RrT
         wcy34xm+LdQW2BzjLwh/89CVZcXVTiJMWK7zakQzlDWCwUd14kM+bwiMLb1ZmX13/piT
         PN01YnWkhdOGZj6puoZJUeYS2QP67TkyU6jLloKGTVoW6JMspiMJaYbx2nQek1iBMWCj
         nIDsvUJxpGLYH/reOaQW8Eqq7LGyMBMWHRa3hlvlYhtNICQhuvANBkOorABqpX9bScgn
         y7vCT+75ppklVeIimRurUIGCr3kLpFUqwKhMCm+Zmawv4WUs3BAZ+EHikV46PJwLkVJ/
         g6Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=E592oVf3gpaLaSPQ9ky7Mj8qlmBz7Yxe6MxT/p5Qbkg=;
        b=tVS4RY50zDaqgLq7pJ0axEEqdYJN1LcTtOH+LdFm4oLM2sqaz83Dyx8IcLx897TV2g
         oAJFeUWEEtpwZcPeB9BYu5HKnaWU66hBLWAKYeYIaay+PVvCOuh13QQ4rIEPMnlYrW1n
         P6/0bMnH5MlxxAooI0LrbTyKY18edD6UUaobAs7zEGZFjL6M+kcKvUqNeLy/dpsbE28J
         wwsQxg3mrnWHty0Vpmr/clGEvW/Zmup7BxjjxiBaQp/4CsHpXE2aKWD+2YMaxeHoxDlM
         4PfKxEQKmBDM9ffIlZu1VZpgAW6MVdUn/5u/US9lMfn72mamERFZQ0cTkOrrljpoDa3w
         ALOA==
X-Gm-Message-State: AOAM531VGYj8qI1rO/UfJu+wsOkU1XF75E4yZiUHFJq2oY4UN72qpDQm
        kVmc7FmnzfLGA1prku1G2msD3ZD5acwesg==
X-Google-Smtp-Source: ABdhPJzWOpWqH5wLGSyXuCj1wD3Iu1kZQk8GWyVizkf4KGroQmqUIJAnmo7+Z+R0g2/ARHAM/09iuw==
X-Received: by 2002:a05:6808:2cb:: with SMTP id a11mr5613953oid.93.1608379687103;
        Sat, 19 Dec 2020 04:08:07 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id n13sm2524557otk.58.2020.12.19.04.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Dec 2020 04:08:06 -0800 (PST)
Date:   Sat, 19 Dec 2020 06:08:05 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Seth House <seth@eseth.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        David Aguilar <davvid@gmail.com>
Message-ID: <5fdded2523e7e_1de0de208e1@natae.notmuch>
In-Reply-To: <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
References: <5fdaef83a40ba_d0e26208f6@natae.notmuch>
 <e5c73fed-b87e-2091-794e-19aced4dd25b@kdbg.org>
 <20201217094424.GA75257@ellen>
 <5fdb3471c6bb7_d6d032087@natae.notmuch>
 <20201217175037.GA80608@ellen>
 <5fdc0e6dd79a7_f2faf208a1@natae.notmuch>
 <20201218023534.GA117762@ellen>
 <5fdc18a91c402_f2faf20837@natae.notmuch>
 <20201218054947.GA123376@ellen>
 <5fdc7a7d3a933_f4673208d0@natae.notmuch>
 <20201219001358.GA153461@ellen>
 <xmqq1rfmqc8g.fsf@gitster.c.googlers.com>
Subject: Re: [RFC/PATCH] mergetool: use resolved conflicts in all the views
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Seth House <seth@eseth.com> writes:
> 
> > I think where we're not seeing eye-to-eye is that you're focusing on
> > potential "negative" consequences whereas I'm talking about having more
> > information about the merge rather than less.
> >
> > There is very likely no negative consequences for most, if not all,
> > mergetools. I wrote the initial version of diffconflicts ten years ago
> > and I've been using it nearly every day since. I'm fairly confident in
> > the end result. What is a fact is there is undisputedly less information
> > about the merge if we overwrite LOCAL and REMOTE; as I've written,
> > I think the tradeoff is worthwhile for most tools but a per-tool
> > configuration will allow people that feel differently to choose
> > differently.
> 
> Thanks for stressing this point.
> 
> When a user or developer asks for a reasonable feature (e.g.
> configurability to suit personal taste), especially when there is no
> obvious downside for adding it, the burden of proof is on the party
> who refuses to add it

Sorry, but no.

You may be the final word in the git project, but the burden of proof is
an essential part of logic, not project-dependent, and that's just not
the case.

*Anyone* that makes any claim has the burden of proof.

That is enshrined in the latin maxim:

  Semper necessitas probandi incumbit ei qui agit.

  The necessity of proof always lies with the person who lays charges.

There is a reason why in the US justice system defendants are declared
"not guilty", and not "inocent".

I have written extensively about the subject, for example: First
principles of logic [1].

If a woman is not wearing a wedding ring, the person that claims she is
married has the burden of proof, but also the person that claims she is
single. *Both* have the burden of proof. It's only the person that says
"we don't know" that doesn't.


Is the feature reasonable? If I claim that it's not reasonable, I have
he burden of proof, but if you claim that it is reasonable, so do you.

That's just a fact of logic.

> ---they are the ones who have to adequately explain why adding it is
> actively harmful, not just the proposed addition is not necessary
> [*1*].

No. Both have the burden of proof.

Only the people in the default position (we don't know if the feature is
reasonable or not) don't require burden of proof.

> There is no need for any "evidence" of "negative consequence" at all
> to ask for a way to selectively enable or disable a new feature.

Yes there is. Not to ask for a feature, but *demand* a feature.

But such burden has been met, which is why users can turn off
mergetool.autoMerge, so they can already selectively disable the new
feature.

> A new feature tends to trigger unexpected bugs in unseen corner cases
> more than an older feature, even without any concrete numbers, and
> that is good enough reason to insist an escape hatch that is easy to
> access by users to exist.

That rationale is meeting its burden of proof.

But users do already have an escape hatch: "mergetool.automerge=false".


On the other hand the burden of proof for the claim that some tools
might want to disable this flag and not other tools has not been met.


Moreover, ignoring arguments doesn't magically make the burden of proof
from your side dissappear.

Is there a conflict in this example?

  echo Hello > BASE
  echo Hello > LOCAL
  echo Hello. > REMOTE
  git merge-file -p LOCAL BASE REMOTE

Cheers.

[1] https://felipec.substack.com/p/first-principles-of-logic

-- 
Felipe Contreras
