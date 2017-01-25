Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8643E1F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 23:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751930AbdAYXj6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 18:39:58 -0500
Received: from mail-pf0-f170.google.com ([209.85.192.170]:35772 "EHLO
        mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbdAYXj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 18:39:57 -0500
Received: by mail-pf0-f170.google.com with SMTP id f144so61451662pfa.2
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 15:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FW2jRXDq9g1/B3EFh2gFtnTEGxCegoyA7to4tvuWe4w=;
        b=Flo5ys+clt3Siar/t3meVJU8F0GqEEd/p+dNuzsVAP2EYd1TMLHYReI1IlxRIrMwTz
         4cc/ZLmsKziBQ7GWy18RDuydI6u5Y/ZBCgtIxu8HmA1WcHFiTT5p+4KS6KuDACgRHG02
         dysd08aQgUlZTJYkKJN7KRK2oUW5/SVrt0sCoXVp1OSkmVHae9++cxrOjChrkprSB9R5
         8CW+GfCDqSVhnUC6SvcjS2LlaP8GwUmehEghbPtPQRpT2at9VLivZRFjjBOWUWdOaM3T
         8+HEXJZuX6x/MXIr8cxkgAdME76dLyBAPynTO/F/dzGHBzb69zDyeX/ihmOeSukl+8YS
         Et7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FW2jRXDq9g1/B3EFh2gFtnTEGxCegoyA7to4tvuWe4w=;
        b=k2p5uedEJ36mOSe8xfKw9ZwGk2hLMqSgOZQW2YJC/k6nZ5agiqI8CcnT1AwRLEx+Mn
         WNGR/M+WzRCz600BGpA4BexSBpoXUKicY2VV7XiD0h3YnFzZHw+0fQZ3jk5AHHndT8W9
         EjeT4KiVllSVQoe9hbid6UhFsD1gMCjKIqDxvGrruJyvlgcJK6iDXp2i0PbtMFmWeSMQ
         Afsb9d/SckA190tc9SOv0U7WU8NcltKR+3eI195xzkuJLIt+20pA1K3JZ5T87C9WwLeQ
         RvXBEf7H0/YbH83sokd+499qcCEbVviHTtdbOJev3boJcDpeDBZjh5Gbl/sr6Yfup9UU
         0aXQ==
X-Gm-Message-State: AIkVDXI7B9LgIzjl5Z962AaFV/Dud9FpXxVX5qmsn2pK+Y/xQUcDP7dUhXF3ey+eoZfGq0Ah
X-Received: by 10.99.112.6 with SMTP id l6mr2077320pgc.33.1485387597113;
        Wed, 25 Jan 2017 15:39:57 -0800 (PST)
Received: from google.com ([2620:0:1000:5b10:d901:f11e:e93:985])
        by smtp.gmail.com with ESMTPSA id u124sm3601304pgb.6.2017.01.25.15.39.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 15:39:55 -0800 (PST)
Date:   Wed, 25 Jan 2017 15:39:54 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCHv3 3/3] submodule absorbing: fix worktree/gitdir pointers
 recursively for non-moves
Message-ID: <20170125233954.GD83343@google.com>
References: <xmqq37g692da.fsf@gitster.mtv.corp.google.com>
 <20170125230450.4393-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170125230450.4393-1-sbeller@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/25, Stefan Beller wrote:
> Consider having a submodule 'sub' and a nested submodule at 'sub/nested'.
> When nested is already absorbed into sub, but sub is not absorbed into
> its superproject, then we need to fixup the gitfile and core.worktree
> setting for 'nested' when absorbing 'sub', but we do not need to move
> its git dir around.
> 
> Previously 'nested's gitfile contained "gitdir: ../.git/modules/nested";
> it has to be corrected to "gitdir: ../../.git/modules/sub1/modules/nested".
> 
> An alternative I considered to do this work lazily, i.e. when resolving
> "../.git/modules/nested", we would notice the ".git" being a gitfile
> linking to another path.  That seemed to be robuster by design, but harder
> to get the implementation right.  Maybe we have to do that anyway once we
> try to have submodules and worktrees working nicely together, but for now
> just produce 'correct' (i.e. direct) pointers.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>

Looks good to me!

-- 
Brandon Williams
