Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33B47C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B56D6113E
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 20:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245508AbhIIUI3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 16:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245526AbhIIUI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 16:08:28 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E500C061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 13:07:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y6so4889754lje.2
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 13:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UEN5EVZzs71pcpaKfjyQY43Kr8f7Mw0bA0VUZ4yPmA4=;
        b=mEBzeriQJWzrg9AULPnztgdpDxMFSFRcyUY3dMf3jo6rZG1l+/17cpMiDw6tJMU+NQ
         wnpx48RcbPb20pYvEDY4Si/G2SfIuqhbVJfgxK8jmCUeih7zTj+hlxs2Yjcm6H2gDzSB
         NKuL6nrHgWO4r/hckLXm25VYXKG5pJGQ5MggXf2S38DlWPrNuAilJbFH8y8Gx9bMxmBp
         /1AZosV186Pit1kKRemGHuqJU1yA6nk0b8DmsFNCES6Rdg6AVWYJbDM5rus6/Aje0cxP
         NVr7ujh68d27b7iCZSpBoojQQ+tytBfpVwVGTI+iAmfcmaqohLBbILZpZvr8SI30c/Ow
         XF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=UEN5EVZzs71pcpaKfjyQY43Kr8f7Mw0bA0VUZ4yPmA4=;
        b=EHwUfEvvXFBNZ/bBZKp6UeYQtgGf+m1lDnIAc5QJytJ6cQv6NhAYQyAupV1OtK50gP
         rzFILc8PBjOI0bwz8jzEfzzOZMvz+FtPITrSsi3EhbYkfX4AEGpccLSYzsDjH4DsSfDc
         TrOZoeosr8S9Y2+sZhzsHRGvzav5JyOQmG29jdgvPJ0NDhISHYV4VEwnLH/kcgTEsHia
         Utuur9ezt9biD2pZPFRPLOSc9zgsNis2/chd5+Bqy7OSf5IODuc1liIOXY63GjnshSiz
         O8L0ZEVqvh+oFcz209WWLA+8DT9N2jqi71EogHsxi94KlVoqbmbRN2+wHsVc8YU5RBW9
         i8KA==
X-Gm-Message-State: AOAM530NMM+Ru5tl82cmy/9gWFBl9AdtWPaq9pApQsNwC6WDnxe1WExX
        F4tFvSK31TwbdWj/Kld6h4OEUkH0nqQ=
X-Google-Smtp-Source: ABdhPJzupiz8DwapBSkih9yEWAd1lrw5Z/fWTsmGp9DLLkjSjtN2HAp710bO3e/Op7UKaMUacMWMPw==
X-Received: by 2002:a2e:9607:: with SMTP id v7mr1199146ljh.405.1631218036048;
        Thu, 09 Sep 2021 13:07:16 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id bi25sm298899lfb.68.2021.09.09.13.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 13:07:15 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru>
        <cbd0d173-ef17-576b-ab7a-465d42c82265@kdbg.org>
        <xmqqilz91xvq.fsf@gitster.g>
Date:   Thu, 09 Sep 2021 23:07:14 +0300
In-Reply-To: <xmqqilz91xvq.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        09 Sep 2021 10:07:05 -0700")
Message-ID: <87pmthldhp.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Gitk does not want to look at a commit and then decide which incarnation
>> of the command it wants to use (--cc vs. -p) depending on whether it is
>> a merge commit or not. This decision is delegated to command that is
>> invoked. Therefore, silent fall-back from --cc to -p in case of
>> non-merge commits or non-conflicted index is absolutely necessary.
>
> Well explained.
>
> "-p" in general is an instruction to show some form of textual
> patch, and "--cc" and "-c" are the variants (i.e. compare with each
> parent and combine the comparison results) of it that naturally
> degenerates to the normal patch output when there is only one
> parent.
>
> "--cc" also flips the "m" bit,  which controls if there is any tree
> comparison should be made for merge commits, which matters for "log"
> family of commands, so in that sense "--cc" was made to imply "-m",
> but "--cc" inherently means "-p" for non-merge commits without any
> need to say X implies Y.

Except both Git documentation and implementation are in some
contradiction with the explanations above, as far as I can see, so this
looks to me like a kind of wishful thinking, sorry.

[One can read, say, year old Git documentation, prior to recent patches
(to get rid of possible bias), to see that it describes different
picture and explicitly contradicts some of the statements above, and
then I definitely did no steps to move in the direction described above
either, at least intentionally.]

Anyway, here is the current reality the way I see it (this description
assumes "-m imply -p" patch by me has been reverted due to introduction
of slight backward incompatibility):

-p enables diff for non-merge commits only
--diff-merges=XXXX enables diff for merge commits only

--cc => -p --diff-merges=cc
-c   => -p --diff-merges=c
-m   =>    --diff-merges=m

where "=>" means "is shortcut for".

Simple and clear, except -m is an outlier, as it does not imply -p.
Further, -m produces inconvenient output unless --first-parent is also
in use, and then --first-parent already implies -m, rendering explicit
-m virtually useless.

Due to this outlier, all the recent changes in this area were targeted
to make -m useful, similar to --cc/-c, not to change --cc/-c, or -p
semantics at all, so that finally we get perfect:

--cc => -p --diff-merges=cc
-c   => -p --diff-merges=c
-m   => -p --diff-merges=m

Please also notice that with this system there is no need for every
(new) way of representing of merge commits to support "fall back to -p
in case of non-merge commits" at options level, as it does not have to
deal with non-merge commits at all.

Thanks,
-- Sergey Organov
