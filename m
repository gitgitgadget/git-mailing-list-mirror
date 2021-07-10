Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81304C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 16:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D30C61355
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 16:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbhGJQfX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 12:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhGJQfV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 12:35:21 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B0C0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 09:32:36 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id a6so13980630ljq.3
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 09:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=eR60qaDqq3Jz8sBI/jnxDhVfLaYlZivxqjPK0oJSukw=;
        b=F+H8z9qGW/V5mxTqip6h1phmQHQCCEXZb7rBSFRLGFp+3A9V7CKF3znZXdO6cErnSs
         Vmb+GhzwgPM2SYJX4cjHnAvYHxlfDG8sS55kJUL8pxBnJsUiXiuoYjVF9X+1ythdPz55
         QpEr+B6vJtYn+oNDdgfkGEzBTTezXxCSgTzopTw7NaMROEyIUK9M7ylO7fJbADY8gncN
         2w1zU1a9HOI/PTP/MC0QBRspaNJ9aZAIxgWuT0v1ZRai6Ub5u0OfFWOgw/9hbgdTnJna
         gIECv1jbBI+JTeRA5zTJw0+5iitdjCWGAP1Fw7DgMsS4AfWNWYJ+DARUIBq3G1FckKNr
         zmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=eR60qaDqq3Jz8sBI/jnxDhVfLaYlZivxqjPK0oJSukw=;
        b=fL0T6XTIa8YWZMXca1WbPyVYEVJ+Kgpqp+WL02/EzzEjab2hCSOKggN1261aYwz4RD
         NQitb2OK4VnUinOhxHEP+MNWsAR01KyawKJn0x+Q0LuJSssmH1B13/yyu3ZFEVCV4+ic
         t9Yq8GiZ9Q7QKflXt3BAoU0P9SB5193Tal6qZQ4yH1uXWOcmwkYFK9+4+NcmqfhyQmKJ
         wfoyUwASZBWq9jfVmM4nicG1gl9uPzs3kEVHw8HawdiN3tWuROG+ziysSRUvRmcRxdcA
         Pcivv+001n3LbXBDZVX2Nz/z/mLKBWjjSLc3NgVRb3aIb4HKYYsRbgE0ov75YKzU+P1A
         Ncjw==
X-Gm-Message-State: AOAM530xnLdaSaNrP7vjhP6iPneI3L+gdmpMkYPFpL9vn9NPqhyDHeMm
        KSrnwFH9DI/cgiqytMIeW2ZswaEXkPg=
X-Google-Smtp-Source: ABdhPJzJ/oh9Ij5wMXeFwNc8LWYpVEnKQVGOQyJinQHwCPIqvgQ1mz3SuEiayjQNscEoPqAs+84mEA==
X-Received: by 2002:a2e:9116:: with SMTP id m22mr26038383ljg.199.1625934754214;
        Sat, 10 Jul 2021 09:32:34 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k13sm739783lfv.64.2021.07.10.09.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 09:32:33 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Martin <git@mfriebe.de>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: PATCH: improve git switch documentation
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
        <xmqqy2arrmba.fsf@gitster.g>
        <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
        <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
        <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
        <877di13hhe.fsf@osv.gnss.ru>
        <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
        <60e67389a4adc_306ac1208fd@natae.notmuch>
        <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
        <60e736e72da68_30939020850@natae.notmuch>
        <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
        <60e762243aab1_30a7b02089@natae.notmuch>
        <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
        <60e79c31aaa72_30b8a4208c1@natae.notmuch>
        <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
        <60e874e1c6845_215320861@natae.notmuch>
        <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
        <87im1ieaba.fsf@osv.gnss.ru>
        <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
Date:   Sat, 10 Jul 2021 19:32:32 +0300
In-Reply-To: <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de> (Martin's
        message of "Sat, 10 Jul 2021 13:05:54 +0200")
Message-ID: <87a6mudt9b.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin <git@mfriebe.de> writes:

> On 10/07/2021 12:24, Sergey Organov wrote:
>> Martin <git@mfriebe.de> writes:
>>> Actually, "new" or "create" would make sense in "git branch". But in
>>> git switch, they actually raise the question "create what?" / "new
>>> what?".
>> I believe that's because "git switch" tries to do too much. "git switch"
>> should rather switch between existing branches, and do nothing else. As
>> I said once in this discussion already: trouble writing good
>> documentation is often indication of some flaws in the design.
>> Creating (a branch) is fundamentally different operation than switching
>> to (a branch), and that's why the former doesn't fit into "git switch".
>> 
>
> Right, yes. But creating a branch is often followed by switching to it.

Yep, but here the creation is the primary operation, not switching, so
putting this into "git switch" looks like design flaw. These 2 actions
are fine to co-exist in "git branch" = "whatever you want to do to
branches", but not in "git switch" == "wherever you want to switch".

Logically, there could be something like "git new" that does create a
branch and then switches there by default, or something like that, say:

   git new feature3 --at origin/rc-2 --track
 
And while we are at it, do you guys notice how 2 concepts are mixed in
Git commands? I mean, the interface seems to mix object-oriented and
action-oriented commands, most of commands being action-oriented with
only a few unfortunate exceptions.

Let me try a short survey:

1. In

  git branch ...

is "branch" a noun or a verb?

2. In

  git merge ...

is "merge" a noun or a verb?

To me, while the latter is obvious, it's verb and specifies the action
to be performed, the former looks more like "whatever you want to do
with branches", and thus the "branch" is a noun there and the command
thus is object-oriented.

From this POV, to me specifically these 3 commands:

  git branch
  git tag
  git sparse-checkout

look like exceptions which should be eventually obsoleted after their
features are moved elsewhere, provided Git community is interested in
regularizing Git interfaces.

Thanks,
-- 
Sergey Organov
