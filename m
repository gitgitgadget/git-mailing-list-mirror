Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_C,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDFC7C433EC
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 06:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E4020714
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 06:53:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cj8ySONR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGXGxx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 02:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbgGXGxx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 02:53:53 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF45C0619D3
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 23:53:53 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id z24so8875659ljn.8
        for <git@vger.kernel.org>; Thu, 23 Jul 2020 23:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:message-id:user-agent
         :mime-version;
        bh=cNgN6JVKtwU3B/6isfH9ACdD8ytdH+gqE3isPbEB4Xk=;
        b=cj8ySONRkKbs2CHjztrIIszBuv0Cr09ssHOOWZoFa9vAHrQ/sRRmcwayVIKmW09TEO
         XmCOAqYRzc4jMYacNb4MuHGqW40QtOSzWPeTW7pM93xdp2FchIjfXZbRG0BjaF6igaHv
         TPKUOYfPb+axARYcxs98nzux5VCI9JKFcgtJ0UoAICfYjfYtgl8dOppdFJTKPffGBlU+
         ZfVihcZGHAwBBveO3h+eh1obJn1kzIMobSewimQy1KSmHc0N0E0Edk4GeCKcLHuYnJMM
         MtmXwG/kHXDPgksX5M67upMn+Us+VRX1o1rRTi+VV+fNG5BvIyegCdQ1U7cptD4wifYR
         YEsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:message-id
         :user-agent:mime-version;
        bh=cNgN6JVKtwU3B/6isfH9ACdD8ytdH+gqE3isPbEB4Xk=;
        b=TjPURZWlGIsMGjsWdpucctT8IXgunmTICKpHOBYKDelbQHhaULBqxr2gynJeqPsJg/
         g1Biv+Y8ljeFqp0Ay/jwvX0ugOTmfnOfu4INgea5fl76P2boK3velLFrJpRqUcEM/C82
         pFMIdn1Wziw+2llKLolTuSVslNM5kOuwlPz8yu0wTa1rUF1jfbE5eFbTJ3McueB8GWPL
         PJpnlTFiXkNs5GMGFxuK5Y5D4OM23ojct2NudvhiChXaEWaNZwT34HuvoSoQjrqTkmdI
         afp6b/ykkPAmm28n5GtW1mALsUTrrzF9y0olLHeBQ3ETZYlFoFAhWx8n7I8Ag80w+CWK
         CKjw==
X-Gm-Message-State: AOAM533VExRtRi8BycsB2edh5MW0jhKRZFbQ2evUUt/2GTE4a1fcILc/
        wDBi17Vfa435yhJCzz8IHu5weUxk
X-Google-Smtp-Source: ABdhPJwJ7e1ixy9heeXERbRpCE6rcKqHVwE52mOWLGqP64Je4rHMksoVZyDBk+7cgM1HBhMopdh/vw==
X-Received: by 2002:a2e:7615:: with SMTP id r21mr3541900ljc.124.1595573630613;
        Thu, 23 Jul 2020 23:53:50 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h21sm34896ljk.31.2020.07.23.23.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 23:53:49 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        "B. Stebler" <bono.stebler@gmail.com>, git@vger.kernel.org
Subject: Re: Improving merge of tricky conflicts
References: <a0418859-c62e-c207-a1b0-1b1aaf178527@gmail.com>
        <4df975f0-e4b1-afa1-cac1-f38e6d31a0d8@kdbg.org>
        <874kpzmhis.fsf@osv.gnss.ru> <xmqqwo2v45hq.fsf@gitster.c.googlers.com>
        <87tuxzl00h.fsf@osv.gnss.ru>
        <20200723182648.GC3975154@coredump.intra.peff.net>
        <87blk6yrlc.fsf@osv.gnss.ru> <xmqqimedq5c8.fsf@gitster.c.googlers.com>
Date:   Fri, 24 Jul 2020 09:53:49 +0300
Message-ID: <874kpxwghu.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>>> You can also do it after "git merge" aborts with conflicts by running:
>>>
>>>   git checkout --conflict=diff3 my-file
>>>
>>> but do note that it will check out from the index, overwriting any
>>> resolution you've already done in that file.
>>
>> Though now it gets really odd "git merge" itself doesn't have this
>> option.
>
> A command line option is cumbersome that you have to type it every
> time, so configuration variable makes 100% more sense than an option
> to "git merge".

Fortunately Git already supports configuration variable, that we both
agree is a nice thing to have, so I won't have to type the option every
time, no.

> If your merge used the merge (as opposed to diff3) style, and seeing
> that the resulting conflict is not easy to review and you wish you
> used diff3 style instead, it is way too late for any option to "git
> merge" to help you.

  $ git merge --abort
  $ git merge --conflict=diff3 side-branch

or, say, entirely imaginary:

  $ git merge --redo --conflict=diff3 side-branch -- my-file

if merge had --redo option and path limiting support, that could be
handy for other reasons as well, as I have already pointed elsewhere and
you disagreed, but still.

>
> But having an option to "git checkout" lets you move forward from
> that state, so it also makes 100% more sense than an option to "git
> merge".

Actually, "git checkout" is not the place where I'd expect to find this
feature in the first place, so to me it's rather already 99%
illogical.

If "git merge" is what gave me the original result, it's some "git
merge" variant that I'd expect to give me modified result as well.

Yeah, I can see how Git machinery is an excuse for "git checkout" to end
up being used for this feature, but only after I learned it is.

> So, it is not odd at all.  Just compare between merge and diff3,
> think which one would often help you, configure to use it by default,
> *and* at a rare occasion where the chosen default does not work for
> you, let "checkout" help you.  The thing is, unless you first attempt
> to "git merge", you won't know what shape of conflict you would get,
> so you cannot choose the right conflict style command line option,
> even if one were available.

What looks odd to me is that for "git merge" I need to use:

   $ git -c merge.conflictstyle=diff3 merge side-branch

as you yourself pointed, whereas for "git checkout" I can use:

   $ git checkout --conflict=diff3 my-file

even though it could have been:

   $ git -c merge.conflictstyle=diff3 checkout -m my-file

as far as I can tell. A minor inconsistency, but still.

If I got your arguments right, you think that having short-cut option
for "git checkout" makes sense, while having similar one for "git merge"
doesn't, whereas my argument is that either both make sense, or both
don't.

Anyway, it's nice we can still do these things, one way or another.

Thanks,
-- Sergey
