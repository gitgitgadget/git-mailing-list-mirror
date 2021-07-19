Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4554C12002
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 07:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 848EF61164
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 07:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhGSH4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 03:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbhGSH4e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 03:56:34 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C35C061762
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 00:53:32 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id i11-20020a4adf0b0000b0290263e1ba7ff9so1725062oou.2
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 00:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=62jt/AghBNdWutFi0FzUmrPrjHfBo2KVF+Jt98vldvs=;
        b=MDHc9iQILSJDiQ/t1hWDVllgz07JtqEhdJiSMgUdtpd90Dm2jfqkE2YoqSgq6mLfGS
         qgl7G/xkbwzhHO8ckdgJBGWinoabTLa8szrMZ2m9etGG7TRf11ore5a19ptpEBGuP3JY
         qVyaDwzI2KFcjjwprDGQj5ara42bjVSZDIqXHafvK2nc/cY2H9+HBRiLanEfL1biolbB
         jbxLPgdFhkc1t9mrqRXY0v5WcH9C69UJzdmZE6muTIEreHqhHVhJABnSOeMceONKX9ju
         aKgcIAc+FVRYwDLL9zU0kpJxm70g6FZs6VNmXSpVjxkG9dYRu6Y8la4gwtcCq7Lhs68P
         S3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=62jt/AghBNdWutFi0FzUmrPrjHfBo2KVF+Jt98vldvs=;
        b=uS4hyYRG+2hTMFBGUU535XYSSttTckQT/Hcl3szHy4yVu8Z3u3dfMtxDkpfD4gxUF1
         CTwOwrZEyn7MUrLGivuEEZA0TNLe9uEkwYkVsdqKotdAS/1CGah3cRi+6ssUglWbvQZQ
         BVjtRMT/a1nR0ws0Jk1AN3hkthb+2Chjc1JxjP2nmorz0HyqARAZ9uTXaeXSiIvdBAga
         LfOn34wIC+AaS5uDccajkU0p1O3usf5rwTxmpS43e0Kr2zFJWeKER5ixaXGzELNVwZBM
         mxr8mXIB0VLkgM1ExI/iC94AmuZk2FtYzBRhoDh4ellwhPfe3ymL3x62UVQ4hCGdc2GC
         BvYA==
X-Gm-Message-State: AOAM532L1Ywxm+Asj60msWQR7plafF54dBk05KgspH8z2Q2Jmi4OLilo
        /DWruPmivMXl6euQL9FegVLerQqFnNXm3A==
X-Google-Smtp-Source: ABdhPJzF1tSVL6TywM1wqmhm0hQW7HBglEym6RQWCRKvjorG/gKgsAB7Iy8CG5cCQHdJQ6kk0uA4Ww==
X-Received: by 2002:a4a:6c0c:: with SMTP id q12mr16445156ooc.81.1626681211996;
        Mon, 19 Jul 2021 00:53:31 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id w13sm3662800oia.1.2021.07.19.00.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 00:53:31 -0700 (PDT)
Date:   Mon, 19 Jul 2021 02:53:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <60f52f7a52671_1e0a42083b@natae.notmuch>
In-Reply-To: <YPUrSB8+zEur+ZBt@ncase>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt wrote:
> On Tue, Jul 13, 2021 at 06:07:12PM -0700, Junio C Hamano wrote:
> [snip]
> > * ps/perf-with-separate-output-directory (2021-07-02) 1 commit
> >  - perf: fix when running with TEST_OUTPUT_DIRECTORY
> > 
> >  Test update.
> > 
> >  What's the status of this one?
> 
> From my point of view this is ready, but it's still missing reviews so
> far. The lack of interest seems to indicate that nobody has hit the
> issue so far, and I wonder why that is. Am I the only one who sets
> TEST_OUTPUT_DIRECTORY to a tmpfs directory in his config.mak to speed up
> tests?

No, I do the same, and this other fix for TEST_OUTPUT_DIRECTORY is being
ignored even harder:

https://lore.kernel.org/git/20210707030709.3134859-1-felipe.contreras@gmail.com/

-- 
Felipe Contreras
