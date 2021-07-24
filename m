Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E794C4338F
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 03:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5622860EB5
	for <git@archiver.kernel.org>; Sat, 24 Jul 2021 03:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbhGXDQL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 23:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbhGXDQL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 23:16:11 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C492C061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 20:56:42 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id h63-20020a9d14450000b02904ce97efee36so4072345oth.7
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 20:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=eU1/Vns6fMTVrKAtq9PTRmOtd8uBDAJW5u8zdhQZ90s=;
        b=B9HSZHk5EKpomJX/dQPNKS3mQVLqDCSv3eMq/+lj4uTAEEOPdrSOGdwxaJ8IUPL6B6
         Wym8A2iDIfbUWxCPCI8DcGyFrRm8nmKvZGgMuCc579CZkWXNqHjdxVmrbC5vVDOAJrSE
         HGQsmK7qnAQ+YJ7tZM7ARf9WVeYCFzLIJ0GV/X8MwRGVSXI+UtQO7j+3Pf3QmdkZj4aY
         zNUt9qW0r85ELLZFm/g+s0fCyTSQIHEXXXf6KD9CBnAYcgYIpeMx0EZzR/KeCPdjBNKP
         CA8BS0Joq2MtZ/xcEofZxn3jGWjC13Y0XKD8cc1PhSWwdmkCVC2K7uDLQSfLIOylKjUS
         /hAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=eU1/Vns6fMTVrKAtq9PTRmOtd8uBDAJW5u8zdhQZ90s=;
        b=rnShOLo8OhlwOtRXQnDEUDeVAXfm2ur5k/3aXmHtcWF3j337o0+GcUL5KKKjhjGuQE
         W7NrBWm8z+RcSYStW2SzoEO6j7QUQM9aT+pb0hrjjPJS14p0uWnXgqAhTNZfOdHfFoNN
         cXoGgaYHx3gooRKFhoIuZXLLqb8ErNYBLVG5XxaC4m0upGOF+k44F7Pc4nRD0QLkPuHY
         fBXj+Qc9SyzPJV8GydNcggfpSNMdlwbRntMuyT5RgQkz1l6qzkybXxrzNQkKSudPbv13
         TxpW6CpAXZ9pfSiJB9xBJqT1/CMyLgRvu//0emKDS2WsdmcWWWtev2ObBIaSnFkZ6fxC
         fENw==
X-Gm-Message-State: AOAM5330bVstwX571RJl+ZYaXwwWJw/T1FMEb3Jxea04O042e9J5TEYP
        c5TA2OUFlby88++l6G+BYeY=
X-Google-Smtp-Source: ABdhPJz/HH9iSEFLwzVQwLbubRs+0q9uVTZarY2scGT2UoTX4to4grhIMhhEAQWaVDKE8HELeHitfg==
X-Received: by 2002:a05:6830:418f:: with SMTP id r15mr4949754otu.134.1627099001826;
        Fri, 23 Jul 2021 20:56:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id n1sm2123477otk.34.2021.07.23.20.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 20:56:41 -0700 (PDT)
Date:   Fri, 23 Jul 2021 22:56:38 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Alex Henrie <alexhenrie24@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Stephen Haberman <stephen@exigencecorp.com>
Message-ID: <60fb8f766963_1105920870@natae.notmuch>
In-Reply-To: <xmqqo8asln78.fsf@gitster.g>
References: <20210721221545.1878514-1-felipe.contreras@gmail.com>
 <xmqqy29z9r94.fsf@gitster.g>
 <xmqqtukn9p0g.fsf@gitster.g>
 <60f8c8c92a215_1d0abb20859@natae.notmuch>
 <YPpwIazVxL4GoLbC@coredump.intra.peff.net>
 <xmqqwnphowdx.fsf@gitster.g>
 <60fb0a916c9cc_defb208eb@natae.notmuch>
 <xmqqo8asln78.fsf@gitster.g>
Subject: Re: [PATCH] doc: pull: fix rebase=false documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> >> But that does not necessarily mean swapping the parent order would
> >> produce the history of a right shape, either, even for those with
> >> the "first-parent chain is the trunk" worldview.
> >
> > Why not?
> 
> I gave detailed write-up in two discussion threads linked already in
> this thread from 2013 and 2014; as I said, I do not think we want to
> debate that as part of the discussion of this documentation fix.

Sure, the discussion about the order of the parents is orthogonal to the
discussion of this particular documentation fix, but my comment that the
order of the parents is "obviously wrong" is correct. Even you said so
yourself in the 2013/2014 threads (I would gladly provide the links if
you require them).

I've spent several man-days re-reading the old threads (multiple times
even, and not just the ones from 2013/1014), and I just spent several
man-hours re-reading them yet again today.

My conclussion remains: the fact that the behavior is wrong is not
debatable (at least in some of the circumstances).

I will provide a summary in a different thread soon.

-- 
Felipe Contreras
