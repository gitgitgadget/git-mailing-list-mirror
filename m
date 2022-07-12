Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA5C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 15:21:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbiGLPVe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 11:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233044AbiGLPVS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 11:21:18 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F821FCF7
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 08:18:31 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id t25so14488156lfg.7
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 08:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AEYrrThKrMdlv0M2jjWpsCY3sUHp407xzu6rPuwKqBI=;
        b=GDF+wcjjD5hygYVCXL3cUn02SFn/W9lwUh5YXFa/g1csd/aqUVeYYAri4I+sKPImnB
         xF00djSTA4rXF+jEzPm8L/q3oqsMBI6pAG4wZpdCKbrA9vCse6SCFOKMTBr0TvuwOZPI
         +UP5z/sxUtu7qcGVIAvU1Zp3rvfnyDOuYLFdayDo29eyiNCKX5sDNueCuGrcVpLAH5tl
         hNUYWlKuGMYNa6TufqsxjR1P6W1PUGlFU8/4tGgzx3xgCg3q4ViNKTbrNd7qNchil9hB
         6z51QF1v1DNkIxbnWV+K4jKheG95XVHHL9sVYPhOyD1IjV2RW6/6klPdH/glmJ2hocY+
         pRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=AEYrrThKrMdlv0M2jjWpsCY3sUHp407xzu6rPuwKqBI=;
        b=0p+aHFavXYXCYJXKeMe36RVATLKd0K7cR7KVpKGsYx4vLa3MfUalC12byap17VDXR4
         eXxAjKA+OE+KtJMhYYWJ356i+EX/hcxjmMi7MyrxV0bb2KS5ZkikWW3pybx4hF/Khh2f
         BPTV0beMHD7DBVI3B4d2Y0Z4ayoxyYOp3+jwudDUmIQv+zkFZmRXisRy/Ljbv5xtFMPd
         5lJYF6xJE5UN/k0qeLO6/btuKIv4iFmvUnuI/lTq90/yPp/gQtjCCHr0D1rYUNrKXWCK
         GSGvEWGc8Wpk02ZeHXODJTLJlOOxKGtqaVVZ6W8BX5EfPlpiu7CsLqyNth2dDgn0Emxm
         wO4A==
X-Gm-Message-State: AJIora8i1+jdtTBGVFjfVXIlXwXgKIYKnYvyZvm2L76s1BmZCJ9Pj2Ih
        gP/lCdnJcJRpJOkLZ7OaE0fiFQOFzXQ=
X-Google-Smtp-Source: AGRyM1uW84i/T82Mc69csEBd+3mxIRwPa4sWR52RD5NPOE+ojfIIji+Ma4/hCOUGpRxT41U3ndiQPA==
X-Received: by 2002:a05:6512:2814:b0:481:981:23d7 with SMTP id cf20-20020a056512281400b00481098123d7mr16207157lfb.75.1657639109335;
        Tue, 12 Jul 2022 08:18:29 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id h28-20020a2ea49c000000b0025d71ab224fsm1104082lji.55.2022.07.12.08.18.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 08:18:28 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Thomas Guyot <tguyot@gmail.com>, Jeff King <peff@peff.net>,
        Gerriko io <gerriko.iot@gmail.com>, git@vger.kernel.org
Subject: Re: Why is reflog so obscure?
References: <CALF=2ANoq1eL-RqK_dLaVThoxbvfhzgPJXFHyD1kX8CFCPx3XA@mail.gmail.com>
        <f0bb8ee8-9b38-45a7-a54b-24cf245bb3c8@gmail.com>
        <Ys0e9MxIWQj/pVXx@coredump.intra.peff.net>
        <a8d2a61d-b86f-9b89-6391-36c58c390a12@gmail.com>
        <xmqqo7xuif46.fsf@gitster.g>
Date:   Tue, 12 Jul 2022 18:18:27 +0300
In-Reply-To: <xmqqo7xuif46.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        12 Jul 2022 07:23:53 -0700")
Message-ID: <87ilo2we9o.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Guyot <tguyot@gmail.com> writes:
>
>> Thanks for clarifying that - I suspected it since we can do
>> <branch>@{<date>} although I didn't find any reference branch reflogs
>> in the documentation. I could've missed it... Is there a way to read a 
>> branch reflog?
>
>     $ git reflog ;# lists entries of reflog of HEAD, starting at HEAD@{0}
>     $ git reflog HEAD ;# same
>     $ git reflog HEAD@{4} ;# same, starting at HEAD@{4}
>     $ git reflog master ;# entries of reflog of "master"
>     $ git reflog master@{0} ;# same
>     $ git reflog master@{now} ;# same, show with timestamps
>     $ git reflog master@{4.minutes} ;# same, starting at master@{4.minutes}
>
> For the branch that is currently checked out, you can omit the name
> when you use any of the @{...} notation, so 
>
>     $ git reflog @{0}
>     $ git reflog @{now}
>
> are often the easiest ways to view what you did on the current
> branch.

Very handy, thanks! Would be nice to have this in EXAMPLES section of
corresponding manual page.

Honestly, I tried (admittedly not very hard) to figure how to get dates
from "git reflog" a few times, but every time I gave up, so this (along
with the --dates option turning dates output on) is not very
discoverable.

-- 
Sergey Organov
