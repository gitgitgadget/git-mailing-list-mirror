Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C638C4708C
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8446613B4
	for <git@archiver.kernel.org>; Fri, 28 May 2021 21:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbhE1V3S (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbhE1V3S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 17:29:18 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018E2C061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:27:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so4804660otp.4
        for <git@vger.kernel.org>; Fri, 28 May 2021 14:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=4yYKisGm9LlGuuyj/IV+WlLpa4pb6Nu18BTaRj33aXc=;
        b=sRI/tFT35/2hCZfWAErcnDyNOcM+cQHrfraGFrCny4gFtwq0AaJSfpwAfpj+c3jd5z
         xws9iOHzLVhECru1eBZGx7UCHzBE0TbThLjnoleGYF1b3z1PcyyqLtIZJvETmkaK5yCw
         WGYNSaSpTMgVgRLsO8ecOGbP90232peOPMoCMM4ypF/wx2zBJn7gj818E6nJ7f6OfnWI
         1UbYeuaP/5CbBIGwLBjcrDH1TOEnglSNHxYws+SXY3bOPE+gFTGLgwKFw58hr3tucF3N
         vr2W6wdUGA0LDsz6Aku3DWX3O9Xh2G0TWIy+xFtgsT7rbX1hNbpU+krGKply5xH1T7rt
         9kxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=4yYKisGm9LlGuuyj/IV+WlLpa4pb6Nu18BTaRj33aXc=;
        b=I9XAqSOiRToNnzkbKdz094NSCq6QWsr26sCZLlG4Mgd5DAY3xa1kPlBMUMAJhKUzeX
         yK3ITxzTSurzkVemXF5eDMM4fDNJPToOQIYjW8cvlDDEPmWHqrVVsC3olRzpMiEyMuUV
         d0zPUs9Tfm/ec0FsmMSsocWPTwnEOL8oMHebRIzW9oBwRUvUVsYxtcy6hfYL7B4jOWsB
         fxfW/s7KpxPp256JoupGwY7iC9HHSJ9tl2/fg/UHSKgEcEEb7hVjl7wmBu3iuu/g1+af
         WeErg1ADqTd+gmYthfU+jVnlH6Qlsf+lLFJDSRl2UyopTOhAmfVb6cZW8PpC9FL2pAEg
         XUlA==
X-Gm-Message-State: AOAM532VSwzsRdzrkDQczsMJjMstYWxUhtDlqocVl7C1mQNqRzJfPCsR
        MIqe1Sc1Kg4MHkz1i2Ihftg=
X-Google-Smtp-Source: ABdhPJwB3FXoYw5lpd0BTGLp8hpI6/450PVhkdmwfB4QmFivjcoYwzL1qefC8otS/VS3QC7bSodufA==
X-Received: by 2002:a05:6830:1205:: with SMTP id r5mr8907989otp.359.1622237261241;
        Fri, 28 May 2021 14:27:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a7sm1355550ooo.9.2021.05.28.14.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 14:27:40 -0700 (PDT)
Date:   Fri, 28 May 2021 16:27:39 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Mathias Kunter <mathiaskunter@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramkumar Ramachandra <r@artagnon.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <60b1604b66329_2a3717208eb@natae.notmuch>
In-Reply-To: <CABPp-BFPXWy0GwZwT0weNs1DKMKFC4ds2tLJWcVQBOKxPMomFQ@mail.gmail.com>
References: <20210528201014.2175179-1-felipe.contreras@gmail.com>
 <20210528201014.2175179-4-felipe.contreras@gmail.com>
 <CABPp-BFPXWy0GwZwT0weNs1DKMKFC4ds2tLJWcVQBOKxPMomFQ@mail.gmail.com>
Subject: Re: [PATCH 03/11] push: reorganize setup_push_simple()
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, May 28, 2021 at 1:10 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Simply move the code around.
> 
> Not quite, you also deleted dead code.  Made the patch a bit harder to
> read because I was trying to verify you did what the commit message
> said and it took me longer than it should have to realize that you
> were also deleting dead code.  Might be worth including that fact in
> this sentence here.

OK. I thought that was obvious.

Shall I update the commit message to include that fact, or shall I add a
separate patch to remove the dead code?

Either are fine by me.

> > -               if (triangular)
> > -                       die(_("You are pushing to remote '%s', which is not the upstream of\n"
> > -                             "your current branch '%s', without telling me what to push\n"
> > -                             "to update which remote branch."),
> > -                           remote->name, branch->name);
> 
> This if-block is safe to delete because we're already in the !triangular case.
> 
> > -
> > -               if (1) {

Techically this is removing dead code too.

-- 
Felipe Contreras
