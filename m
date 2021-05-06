Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3675DC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 12:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC0CF610A1
	for <git@archiver.kernel.org>; Thu,  6 May 2021 12:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbhEFNAl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 09:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhEFNAk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 09:00:40 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEFD5C061574
        for <git@vger.kernel.org>; Thu,  6 May 2021 05:59:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i9so1082470lfe.13
        for <git@vger.kernel.org>; Thu, 06 May 2021 05:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VtqDuUtTXe9pAYa5W1esnMgHYp+u2XQ34djPKcHkJCE=;
        b=ZliGo9Uo18I7K5/6a/Ik/53FhJQ62n5F5RNRKU+tpDpnlXgL5fL8HhTL65Bfmq2y4n
         pe17E8O2Sqj9wVB8wkRYh94y4BMrT3nOmPhO8VsnVQe3vzXfy8taNRUxLJKb4r6pFaq/
         HHS8APC0w4YfIF8l6h8MlWmO83cJq6CjwMcpmEGsujWP/X981T4B6IDuVZh/QGwFze/Q
         jUMiCQT5qIVYBeFLL4CWYll5+xrTXEVdx85ldYn7d83jy1AtysN5Hfe0g8GvEW0Haz57
         mHhPmeFfDLLuVf3gJVdbNuhDaCABSSmrqP6G96uPn9b5gn2P5yRYCpu8fA/lK4Gzqwe3
         GNtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=VtqDuUtTXe9pAYa5W1esnMgHYp+u2XQ34djPKcHkJCE=;
        b=gM5MNbwcnP3iaZopPTypaNLLG77/A3zjGXiLBW3b6lwWVPDoA4uuyAICo3d2/f0DkS
         qWQFNiNL92YZhzc9hLUxqRtgqZ2b69Cuvz4a6v3d6/HvC9ygHVHdxmtwGAH9qfpw2mYz
         QCA9EPkDIyXqk8BU9WhdOLG2IhbEMkKxPAbUtba6KrH1eSYR/8SzmHE0nSmKrztdy1In
         THsvuxKwsM8vZ4FCJuSo06Z8GlyOPdmcKPtgfK9mXA1JqXzqjaEfSO+qsD0WLN60byt+
         Sv2hfJzITXLDzvjRrYJLTEvZHVFCz8j7QLiBkGX5AKND1SFXy2Csa4Fe3h6l3B1/ThSp
         gtWg==
X-Gm-Message-State: AOAM531sIyMS/AmnU7cJT0nDL5g1l+vylcm+PWSpwlfzOwFlxg/KXPtq
        7cgDFZ72JGVNCgvTdvUXlUuS/bBC9BE=
X-Google-Smtp-Source: ABdhPJyTk5RrgT45RrMCPxhgd9JuP5hoQoydyc7ZVZVi2SvYtWOl8nEo2hvQUxPs048Okj6zNtip8g==
X-Received: by 2002:a05:6512:11c1:: with SMTP id h1mr2692698lfr.107.1620305980018;
        Thu, 06 May 2021 05:59:40 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id 134sm653008lff.165.2021.05.06.05.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 05:59:39 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: Why doesn't `git log -m` imply `-p`?
References: <CAMMLpeR-W35Qq6a343ifrxJ=mwBc_VcXZtVrBYDpJTySNBroFw@mail.gmail.com>
        <xmqqwnsl93m3.fsf@gitster.g> <87im45clkp.fsf@osv.gnss.ru>
        <xmqqmttgfz8e.fsf@gitster.g> <xmqqy2d0cr5l.fsf@gitster.g>
        <87v9837tzm.fsf@osv.gnss.ru> <xmqqzgxfb80r.fsf@gitster.g>
        <87czu7u32v.fsf@osv.gnss.ru> <xmqqtunj70zy.fsf@gitster.g>
        <87eeemhnj4.fsf@osv.gnss.ru> <xmqqbl9q7jxf.fsf@gitster.g>
        <87r1imbmzz.fsf@osv.gnss.ru> <xmqqy2cu58vo.fsf@gitster.g>
        <87tunh9tye.fsf@osv.gnss.ru> <xmqqim3w3dvx.fsf@gitster.g>
Date:   Thu, 06 May 2021 15:59:38 +0300
In-Reply-To: <xmqqim3w3dvx.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        06 May 2021 09:27:30 +0900")
Message-ID: <87wnscuif9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> No, I don't mean it. The idea is to let -m be alias for
>> "--diff-merges=on -p",...
>
> Ahhhh, that makes a whole lot of difference.  Thanks.
>
>> If, on the other hand, it's just me who fundamentally misunderstands the
>> design, then I need to be corrected fast, before I make significant
>> damage.
>
> No, it was I who was confused, as I somehow incorrectly thoguht that
> your plan was to make "-m" identical to "--diff-merges=on".
>
> But if your plan is to make
>
>     "git log -m"    (no other option)
>     "git log -m -p"
>
> behave identically to "git log --diff-merges=on -p",

Yep, exactly.

> and similarly make
>
>     "git log -m --stat"
>     "git log -m --raw"
>
> behave identically to "git log --diff-merges=on --stat/--raw", I
> think that such a design makes quite a lot of sense.

These I honestly didn't even think about before, but now, after you've
brought them, I'll pay attention, thanks!

>
> It will still keep the purity of "--diff-merges=<choice>" (that is,
> it only is about if/how a merge is expressed in some form of diff),
> while solving the longstanding usability issue of "-m" that led to
> Alex's "when a user says -m, diff output is expected", that came
> quite early in this thread.

It's nice we've reached mutual understanding!

The only remaining issue then is if we just go and do the change of -m
semantics, or do we need to take some backward compatibility measures?
Looks like we are rather safe to just go, as it's unlikely there will be
any real breakage. What do you think?

Thanks,
-- Sergey Organov
