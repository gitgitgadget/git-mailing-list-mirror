Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65A04C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 16:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238478AbjEKQxU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 12:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237885AbjEKQxR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 12:53:17 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7518610EB
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:53:15 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24decf5cc03so6174203a91.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 09:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683823995; x=1686415995;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FolEOffXw91EzV+WrYjGyrYPN5aIqLJFUeWDIhjPiI=;
        b=h2dtg+bdAmq8p8E4beeBRoOOODaR8pIWYlyqEvA5OhMWdVr/WqlA7L59kiuSNUwXFO
         k/gZ0U6Z3Bq7X/j7MFlIMSm/Ifl5L/Edq0r+QAZwBShNAf/6KvfP7x8zSmH3JX5fMQQg
         gwZfauiHkoL+/CO7IZQvvwzpRf3deI+6EHyByIX33htw5FeBk+ozDtDWVblUhLRINj/s
         JUmVvx9QuCr/26jH/X+ATU3a4D/wA1vfxvEYk/75Ra5FN2iFtI9bwx4jX/UMiWzcnU2l
         cOXrfZX07Zm0GvOD13aKCChb/eWFmMH3CXaZLEjh1pl7YTh/veczmiTYV4ZTqYjawfrB
         p3+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683823995; x=1686415995;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2FolEOffXw91EzV+WrYjGyrYPN5aIqLJFUeWDIhjPiI=;
        b=Ylybk2zu4bHcP8mwDYxOBXyovy4oZqBFPFJbCmCMwS714XPK8sRGC+wgC9SaYe49Ah
         gl9KSENgxzW3ePVbtocDxd0WLuVpEQlg7Jl1cDnuQ+4dEavp6dB2Zqsyc3RHTLss/ynD
         8taI7D3XBVWcq/Xgd+ob2vNpYPAFl/kWLSBhO0VZICH1xKYxJpJEmfvLiWDJG219FIva
         BPWo14iQ3LasSfgLzDgZKid49RrIYUoc54lSbHiyMYyxjnKH4BCv+Il/yucnb11gCk+S
         0WMGu8CRX0AKh+2LQH4vSUibi8/trt2ANcZHK7mayvs7C3nEe95RULwlUWNPO2fVEDb/
         sy6w==
X-Gm-Message-State: AC+VfDxYfiUv1aY0MTQiyjcPC0Api5HK0hxsfn+4PDGNEK8EUIiKFrKi
        Itd+G7PmoDb6JmwQxyHe3LQ=
X-Google-Smtp-Source: ACHHUZ4Rc5mKGHmivj4ll+7qGgs8mB8Kk+raBpAgSezE2EfVFwEwmQT9oud3btqDwKnxQMGxeBt+mw==
X-Received: by 2002:a17:90b:3648:b0:250:32e2:5681 with SMTP id nh8-20020a17090b364800b0025032e25681mr21457495pjb.6.1683823994834;
        Thu, 11 May 2023 09:53:14 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id fz23-20020a17090b025700b0025095a2d9efsm1137300pjb.27.2023.05.11.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 09:53:14 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v5 0/9] fetch: introduce machine-parseable output
References: <cover.1681906948.git.ps@pks.im> <cover.1683721293.git.ps@pks.im>
        <xmqqwn1g3vvk.fsf@gitster.g> <ZFzMDCK8rprq6qUs@ncase>
Date:   Thu, 11 May 2023 09:53:13 -0700
In-Reply-To: <ZFzMDCK8rprq6qUs@ncase> (Patrick Steinhardt's message of "Thu,
        11 May 2023 13:05:48 +0200")
Message-ID: <xmqqilcyyfly.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, May 10, 2023 at 11:05:19AM -0700, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
> [snip]
>> >     - Patch 4/9: Reformulated the commit message to treat the missing
>> >       left-hand side of displayed references as an inconsistency instead
>> >       of a bug. I've also added a testcase to verify that direct OID
>> >       fetches continue to work as expected.
>> 
>> Again, the direct OID fetch is a good thing to test here.  I noticed
>> that the test added here insists that the standard output stream is
>> empty when the command errors out, which is not consistent with [3/9]
>> above.
>
> I think you misread the test: yes, we do test stdout and stderr
> separately and in many cases assert that stdout is in fact empty. But
> none of the added tests are about failing commands.

Ah, you are absolutely right. Sorry for the noise---I do not have an
objection to ensure that program output in the successful case is
predictable.  My main concern is to avoid giving unneeded assurance
in the failing case.

>> assigned DISPLAY_FORMAT_UNKNOWN with this change, so [6/9] could
>> lose the value from the enum, I think.  The defensive switch
>> statement that has BUG() to notice an erroneous caller that pass
>> values other than DISPLAY_FORMAT_{FULL,COMPACT} is still a good
>> idea.
>
> Ah, right, `DISPLAY_FORMAT_UNKNOWN` isn't really needed anymore. I think
> it's still good to have valid values of the enum start with `1` so that
> it becomes easier to detect cases where we accidentally use a default
> initialized variable. But that can be achieved without giving the
> default value an explicit name.

Unless we explicitly take advantage of UNKNOWN being 0 and perform
clever defaulting, the result is far safer if you get rid of it, and
instead give 0 to a real choice that is used as the default, for two
reasons: (1) naturally 0 initialization work fine, (2) we have one
less enum constant people (or editor's auto-completer) assign to a
variable by mistake instead of a real one they intended to.  I agree
with the last sentence of your paragraph above.
