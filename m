Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36246C7CFE8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605F524741
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tCsvk5fj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbfLMRtV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 12:49:21 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39001 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfLMRtU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 12:49:20 -0500
Received: by mail-pg1-f194.google.com with SMTP id b137so170387pga.6
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 09:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wbp2p3Nr6V8kQmDYkathF5yFVEbHBIgGAJJkG4NiS7Q=;
        b=tCsvk5fjvrOK2uYbEMsggrwcmaF581UyhIgaDr8ezKiwY7FbCg0l3ev7cvzl0W7BBO
         EGgm3KdSOegGywB+FHIoQpAcDSQceqYKSnUL3q9y2lw/fwCdKSCnJLj4hY+Ps3dAqvbK
         C80Ag/HjIgyQ8KERoEGqw0gx/MvRt7wgrR3elYnP66RHTjYCPIWE/fCmPDXZwA2NZWEN
         fegS88qCkZrvcSabv7+lVbp0u9jceWcCQakM8q3oniSPJ2ICcR8jXAXBqzq+NhS8om4z
         go5X6JyH29zzq+V+HK+QtJzzt+uwLfPAMlWH2ogO6cs1VmmH0nyWuzk5i60lIc076tpA
         AYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wbp2p3Nr6V8kQmDYkathF5yFVEbHBIgGAJJkG4NiS7Q=;
        b=ZkDGbbgrlnjW5fVUluzbyttZOXE+5AoNp0ko8U2N9QngXRqrpcRm4itvnE/i3zfXcp
         U5Igp7urSOyTbWDIYZMfkfhxd/gkpnhMt747xu6ieipd11WJY3x1/EPyTi2Bs6v07ywL
         WFbgcFzJmQGPIbP/gm3te9zwAgCrcOLsKt5VEJGfUOtGxuGfFZOtRAUqauVFYnjDLLMX
         WvvDbH2OHgDP1Ve3WulY7xpc/ZnBrGxNIiz3UMR3mt5+P0ayRL9En6bQUNUGPzfpK7z1
         ft2AC3EiFsOvs/LJNgmlkfJoEaTPI6Tm5w/tIH7UuSqgVZKtvQpdV7LvTqCdFSfiDFQe
         0PAg==
X-Gm-Message-State: APjAAAVdpcu2DAenmYb7uno7eWVh+jS05JaTA2SnO/oHiMUbSl31Okb/
        Z6y0dt+IplxiPuthtkvKgg+sIQ==
X-Google-Smtp-Source: APXvYqzzr32/onxZPH2ARb8VB9XqgFDbHMuaCPQWl3MsZjZSVCV+9aIotUL1o562+CJFFYXa7/BpMg==
X-Received: by 2002:a63:510e:: with SMTP id f14mr687957pgb.35.1576259359901;
        Fri, 13 Dec 2019 09:49:19 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id d65sm12239273pfa.159.2019.12.13.09.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 09:49:19 -0800 (PST)
Date:   Fri, 13 Dec 2019 09:49:15 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Kerry@google.com,
        Richard <richard.kerry@atos.net>
Subject: Re: [PATCH v3] MyFirstContribution: add avenues for getting help
Message-ID: <20191213174915.GD135450@google.com>
References: <20191213013128.6268-1-emilyshaffer@google.com>
 <xmqq36dom9bf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq36dom9bf.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 13, 2019 at 09:20:20AM -0800, Junio C Hamano wrote:
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > Since #git-devel's traffic is fairly low, it should be OK to direct some
> > questions there too.
> 
> Correct me if I recall wrong, but wasn't #git the original IRC
> channel we developers hang out on, and then somebody thought "the
> traffic is fairly low, so it should be OK" and directed non
> developer trafic there, which caused the developers to migrate out
> to #git-devel, a new channel?

I certainly don't have the background to correct you, as that was before
my time, but I can say that this document isn't directing non-developer
traffic. This is a tutorial for aspiring Git developers to ask questions
about Git development.

 - Emily
