Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FECC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 14:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7283723B27
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 14:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgLROqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 09:46:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgLROqd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 09:46:33 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3197C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 06:45:52 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id s26so6011388lfc.8
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 06:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=rlOPXZiRhjoWx3DceVBcfVzqKa2nRWLvbGRj0Kv4xuk=;
        b=pT0mLZNKmL5ApSD0mOmSTHTaRRCanOwyc2b0L/ssqLvjovHyXF/I0u+3k3Dlv0yvT0
         07aIZErD7y96ggSQBZbG7Y9PA7WonfXVyC0A9NKjIBRuhyHsctUQA7NnJRhnJ3jysqxP
         UUA4f7tLdWi2Lydya/9TAC6X2h9PZU2mcuwHbZ2sNTHmSHMGS7gn8pjKAkyVcHdm0sDd
         WP55EDnYb08iZK74GiR0Y3BwPhnvMz4HdpDyR/hVdhhU1bfwWI0pxM3mx4luhT0EmiU1
         V8Lj4AiOATFDuYcxRjKDrAw7prEzyuB6f2M+MFfz6OTQ1TcYGAjFNmNhF5YALVuRkqiz
         vCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=rlOPXZiRhjoWx3DceVBcfVzqKa2nRWLvbGRj0Kv4xuk=;
        b=rkUd/I7/3I3TAIgr/tJms1ZeLp0Ah4kYYadsuDbYixnh011/vtfDTRrX2uniWl6wQZ
         hnBdIH6JvtTYU+2Px7IkOG8oRORvZz9jAANmEMwNBCrOFO7OOUXAFI7mKVmSvRx7J8fe
         8ZjXaof0iuefxJ5gvJOVIwPKZBezz6wegQLsu8JK1PCgCS9GmHZVHyI/2ut91maeruXD
         Pw6MgQjJzfEXrdFc64z/fOcd/YB2wkFQhKy+mqcOoWMEBcdd2dB2sBJUHSE8wgJ7l8+1
         LllxEP+gmVofq6NZOHZlZyuSBU+wXDny2IlUHRy+I9OtAKnCzZqh+Sq2lJWSedovo59b
         9WIA==
X-Gm-Message-State: AOAM533dzl4cZ79T2ReztrwSyC4CuRtT6eK+54f8932/fQAeWfW4CP6L
        /1rBfXdWQRuCTcyIy09Ln5veOVg/q68=
X-Google-Smtp-Source: ABdhPJwkapcn9bsT0mOPwUsBX+Mp/Q+JL+VdfOG3RZabWBXP4WIc7+pvJERMh7XRJu1QcItaLTYkgQ==
X-Received: by 2002:ac2:5086:: with SMTP id f6mr1583191lfm.593.1608302750988;
        Fri, 18 Dec 2020 06:45:50 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s2sm948998lfs.2.2020.12.18.06.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 06:45:50 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 28/33] diff-merges: add '--diff-merges=1' as synonym
 for 'first-parent'
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-29-sorganov@gmail.com>
        <CABPp-BExc7rBCVEvLLs1u_hXurDTtWxTKg0ZN0+PA-21u_ShkA@mail.gmail.com>
Date:   Fri, 18 Dec 2020 17:45:49 +0300
In-Reply-To: <CABPp-BExc7rBCVEvLLs1u_hXurDTtWxTKg0ZN0+PA-21u_ShkA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 17 Dec 2020 22:19:40 -0800")
Message-ID: <87r1nnb2aq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> As we now have --diff-merges={m|c|cc}, add --diff-merges=1 as synonym
>> for --diff-merges=first-parent, to have shorter mnemonics for it as
>> well.
>
> In all the other cases, --diff-merges=<short> is equivalent to
> -<short>.  Here, --diff-merges=1 and -1 do _very_ different things.
> Is there any concern that might cause confusion?  (My gut reaction is
> this is probably fine and people won't try to make such a connection,
> but it made me worry just enough that I thought I'd flag it for you
> and other reviewers to at least mull over and maybe comment on.)

I wasn't sure about this myself, and that was one reason to make this
separate commit.

I think this one also came from the idea that one might want to have,
say, --diff-merges=2 in the future and get diff with respect to the
second parent.

Thanks,
-- Sergey
