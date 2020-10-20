Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39024C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B557922251
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 19:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m9Vsp58j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390923AbgJTTMN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 15:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729336AbgJTTMM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 15:12:12 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4985EC0613CE
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 12:12:11 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id a81so2731402qkg.10
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 12:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=XRMdX0V4vZ/OOxmURVQcfv92bDnet79juMoE8tRwRuc=;
        b=m9Vsp58jP2DRGCcoDh193km/W3CUZ4ur4HfwaK1SDnBq+WZ/05OJb1J3dINR7HjvOi
         dKssqHhcRIfg2MfK4dGiEhi/e7Yk5IMoiQMB58j2kQ0ROUdFratwQkXErDyTAwYoqpnd
         gIjNwKlOY9tMxK9u4r0hnaGRm2XFenU/M3dg26KQAlqfmZq1M0snA6th4RU8zJWqIwkz
         qo6Uj6UyE6ZF1BFtLI3j1uQSztwv03SRxqctMYRzOzsbgx8sfEUP/6a0cpTgDQCGIzTF
         1qu81VOPlqLA8PRmbCjgCipdOtg7V2D89HaBSPkP3OQWdnWeAIf/9CEMxcPdgZvfS3LA
         6Rkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XRMdX0V4vZ/OOxmURVQcfv92bDnet79juMoE8tRwRuc=;
        b=O7DUbcT1y7xPv2Ufiip4KiSpuRBqQ9sXIUMy4VmFmBj3Hx7UKIc59AXbAMoZeja+nd
         lop1DNBFBumT16Hqx0oJnMmRTIw3I/ZuWyyfDcjoP6i17gHCOjCRtZil/TWvB4jqq52l
         mZh7d5gh4+o9PNrko1JliooTE9w+mJxdrVoMr89pPXpxev/QeZQ0vnz4pOfUN6G5oZbW
         t0edSEz8jItLA/OPdyp8GQkbuMZ+9wR6V5IB5L8UpoeVmvsEEksrR0JTbbcicjYTTbqz
         VeLhOUsIh63RTAF4Znh+KYn96i0KTHbHJnEaWbzPCrJeZkWswY9wkkwpEtf+u+KVJOTw
         23ZA==
X-Gm-Message-State: AOAM533wNQ26kxKZElnII8oDtnkeX1fDsu+djFObpcj0crFkS4cwEBZE
        ZqhHkf8esCorQVq1BbmDWhC7pPaZYJcbcfIrRAEd
X-Google-Smtp-Source: ABdhPJwT5fug4JT6ZMlZg2mZTwHSLqnTIOiCQx0JGAKDEtSgV0ExEecPJsXacpR5kGoYqaD+hogrylsUfAigvBEsmUj0
Sender: "jonathantanmy via sendgmr" <jonathantanmy@twelve4.c.googlers.com>
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:ad4:458d:: with SMTP id
 x13mr5042621qvu.4.1603221130468; Tue, 20 Oct 2020 12:12:10 -0700 (PDT)
Date:   Tue, 20 Oct 2020 12:12:06 -0700
In-Reply-To: <xmqqy2ktk11t.fsf@gitster.c.googlers.com>
Message-Id: <20201020191206.104924-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqy2ktk11t.fsf@gitster.c.googlers.com>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: Re: [PATCH] apply: when -R, also reverse list of sections
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > A patch changing a symlink into a file is written with 2 sections (in
> > the code, represented as "struct patch"): firstly, the deletion of the
> > symlink, and secondly, the creation of the file. When applying that
> > patch with -R, the sections are reversed, so we get:
> >
> >  (1) creation of a symlink, then
> >  (2) deletion of a file.
> 
> Good observation.
> 
> But I have to wonder if it breaks the support for (arguably outside
> the Git usecase) input that has more than one patch that touches the
> same path to blindly reverse the order of all patches

Sorry for getting back to this so late.

The only other case I can think of (besides symlink<->file) is
directory<->file, and even in that case, I think blindly reversing the
order still works.

If a more sophisticated rearrangement was needed, I would think that
even applying the patches in the forward direction (that is, without
"-R") wouldn't work, since Git is sensitive to the order of the patches.
So I don't think we need to support such input (since they wouldn't work
in the forward direction anyway).

> (instead of
> the obvious implementation of the fix for the above stated problem
> --- i.e. make sure the first patch is a deletion of a symlink and
> what immediately follows is a creation of a regular file, and swap
> them only in such a case).

This would make patch application more robust, but I still appreciate
the relative simplicity of the existing approach - the patches you see
in the input are all applied in order (or reverse order, in the case of
"-R"). You also wouldn't end up in the situation where you think that
your input works because it works with your version of Git, but it
actually doesn't work with an older version of Git or another
implementation. (I haven't researched how other implementation do it,
though.)
