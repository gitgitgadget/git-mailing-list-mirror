Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38EE7C433F5
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 07:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 126C460EE2
	for <git@archiver.kernel.org>; Fri, 17 Sep 2021 07:08:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbhIQHKB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 03:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhIQHKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 03:10:00 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F95C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 00:08:38 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id bq5so29110517lfb.9
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 00:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZI3Oo/KXhK8dnWCfWUeyWSxh95FT2b/n1nPrtEnvbSE=;
        b=PJg4/2K9NMYqAhwBxdP2bbB6Y9pAP/mTvtf2JboRGR+DmtG9dyulBc9O+bvef1GqZS
         zXEKqBzvBviRvbafmtQZ9ikf3WMJivEOouLnJ1NYZCj7UjKbUmLqRvNGJ1X988EzH/43
         DhdCC52n67HsdunvUPIfrQyuB/Mpj2Zr6xqaSUDhczZks5l4ZxRlo+05DEM7O8DRbl9K
         I119haM3JqBn97j3YvWEU6Azc7ekQAMDEjTLG7mJNaveGhZD7hTcRxfhuPY1Q2+hdhZO
         VLrVyDwlOT/Dwq4fUhLm2Os1fy63oBecmHo9yJpDqoMxddxAkG46silgs0n1zu36NNPR
         WlbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=ZI3Oo/KXhK8dnWCfWUeyWSxh95FT2b/n1nPrtEnvbSE=;
        b=3PedNIxPX6/yiuGid2K0Y4EtOMb4+WNO9j3M219Gnumlz+xZwDt3ZZvCVErfYDdxPz
         lxFTam4aG+Zgilf8PF8SZ4uU0RqE0wxClE9Z7Mea6soFxemToSWAVAvAUv9fr5ritb+q
         pJJ6b632CLCSH6f44r0M/nSk9UwH6vDHAmS8mXYOb+Rv+UGk4y2f5HaK7nS7u2023hfA
         fzvarBF1O1oq+FrudG11AuqxEotHiEQvf7z08T9LrsxWc3x90/4fn+mkacjoOJTerPNq
         gkcB0t+xF/VgP4IgjZR4oM4cJ9MSmjLkSwrZbdvYLM6UBCg53O5XHTExnImBsIPJTgHh
         yA7w==
X-Gm-Message-State: AOAM532iAhOTZzx9G965O6NHglbbADUZtnjshgO6fKuqZSfyF20FmV7O
        NYn6zx+inLUNupf7hVCUTc6bIuyFB2U=
X-Google-Smtp-Source: ABdhPJwd4dE5Q+gdTsM1QNmPEHbKQU2mVga+HM43A1C+408915RJx4I5cVOcQkhThr1f7zDCpa+BEw==
X-Received: by 2002:a05:651c:3dd:: with SMTP id f29mr8269239ljp.69.1631862516308;
        Fri, 17 Sep 2021 00:08:36 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id m10sm453776lfr.272.2021.09.17.00.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:08:35 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        Paul Mackerras <paulus@ozlabs.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: diff-index --cc no longer permitted, gitk is now broken (slightly)
References: <e6bd4cf7-ec8b-5d22-70f6-07089794df0c@kdbg.org>
        <87h7f4tf0b.fsf@osv.gnss.ru> <xmqqy288b64q.fsf@gitster.g>
        <87pmtjkwsj.fsf@osv.gnss.ru> <87sfy497ed.fsf@osv.gnss.ru>
        <xmqqy27wrzmj.fsf@gitster.g> <874kaki1nb.fsf@osv.gnss.ru>
        <xmqqzgscqgmv.fsf@gitster.g>
Date:   Fri, 17 Sep 2021 10:08:34 +0300
In-Reply-To: <xmqqzgscqgmv.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        16 Sep 2021 15:50:48 -0700")
Message-ID: <87bl4rk7bh.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> I'm not sure I follow. What "show -p" has to do with "diff-index --cc"?
>>
>> My only point here is that usage of *--cc* in *diff-index* is entirely
>> undocumneted, and that needs to be somehow resolved.
>
> It was a response to your "historical status quo that is a problem."
> I do not think there is any problem with "diff-index --cc" (except
> for it wants a better documentation---but that we already agree) but

Ah, now I see, but it's exactly lack of documentation (and tests) that I
was referring to as the "problem of the historical status quo" on the
Git side, so I was somewhat confused by your original response.

Also, it's still unclear, even if not very essential, what exactly that
"status quo" is when seen from the point of view of gitk. Does gitk
actually utilize *particular output* of "diff-index --cc" for better, or
gitk would be just as happy if it were synonym for "diff-index -p", or
even if it'd be just as happy if --cc were silently consumed by
diff-index?

> I wanted to give you some credit for having worked on "--diff-merges",
> an effort to generalize things in a related area.

Thanks for that! More to follow )

Thanks,
-- Sergey Organov
