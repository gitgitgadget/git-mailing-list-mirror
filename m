Return-Path: <SRS0=gJGs=AH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED482C433DF
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 08:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C65022080C
	for <git@archiver.kernel.org>; Fri, 26 Jun 2020 08:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B1LpeVVS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgFZInT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFZInT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jun 2020 04:43:19 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66662C08C5C1
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 01:43:19 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b16so4339759pfi.13
        for <git@vger.kernel.org>; Fri, 26 Jun 2020 01:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2pmP6JYJ2+bfR5Z6m5p9RlCShDKPszNXFCNg8J7ssYo=;
        b=B1LpeVVSJcfDUY62kYN3lhCJFCK6h0K5twKXl0xL5OyUFz7TaoiK5ZfyhTkh7e+jKZ
         FtFKINTYuwl0rdmaSDTQXcgQsEGfeXFLxDCLnGrAy0llWt4d+2Rh0zZ/bUef6XNQwc/X
         ODjH7yPfXp5p8EBCBOZhBH2kYHfomq0gpP/pHT9NLD5OnN1/shIOPzZPljxhtGM6YS9I
         Ryjai7munbL1YKD8IT62WnltldhfqWHaZTxWHJdawJWEo0h2v6lwdPOyXP9lng3SAdPi
         TxoYNYUyYWIxWkGkYdhdY0VgAIK/LfQbG8w0SzmtOZ629Lp81cJlyA3xX3jDS/8ZBWwk
         8Xng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2pmP6JYJ2+bfR5Z6m5p9RlCShDKPszNXFCNg8J7ssYo=;
        b=t5kJMxmIJLU3VIsjDgMrQPPb6BlFBx8gCIrsH34XvNMpMmPCut0tIGaAGfDb1tTr8i
         8J4opSnqOd2I2GlB3oSJjBW9JlD4B4ZXPFpB9CIorqoVRUSjFuhyL+ofKXwiZ663eFKZ
         g6jRLecCrY90NuKLp+LTifiyJOI+0f4e2isxr886TZ5RTjs9z3rqsGw0oFXuGXR1RBeV
         cjsw8dlgFQV6e66lArQPYKfSIhC1z7Tg4CqexRtEz4s64m/8eLgG3HDm9mouHyYTh5Gb
         tuulxkrrvLX5kCLbv6usoVcKDF+6bITL5T3pngdZbR8Dmc5APLotukjuDHlDyEPe3nAa
         KeEg==
X-Gm-Message-State: AOAM533GKXXPd6A0XoI5V5jjLZAIuqwk859CcfMnPr4tLWULlSu51Rlf
        TOUnig1sJ3qXdFXnIpOHRNM=
X-Google-Smtp-Source: ABdhPJyHSi/UsxgJ1bSHdfcVl53P0ANKSBNMeBgA4OWq7jSEd/5se6Ri75wHtMrYTvEIzwTfX7RRAA==
X-Received: by 2002:aa7:9525:: with SMTP id c5mr1857179pfp.79.1593160998870;
        Fri, 26 Jun 2020 01:43:18 -0700 (PDT)
Received: from Carlos-MBP (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id x24sm10493495pfo.12.2020.06.26.01.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 01:43:18 -0700 (PDT)
Date:   Fri, 26 Jun 2020 01:43:15 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #05; Thu, 25)
Message-ID: <20200626084315.GB84491@Carlos-MBP>
References: <xmqq1rm24ol3.fsf@gitster.c.googlers.com>
 <20200626070807.GA84491@Carlos-MBP>
 <xmqq1rm2i8qg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq1rm2i8qg.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 26, 2020 at 12:31:19AM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > On Thu, Jun 25, 2020 at 06:12:40PM -0700, Junio C Hamano wrote:
> >> 
> >> * cb/is-descendant-of (2020-06-23) 1 commit
> >>   (merged to 'next' on 2020-06-25 at ca0eaddf5e)
> >>  + commit-reach: avoid is_descendant_of() shim
> >> 
> >>  Code clean-up.
> >> 
> >>  Will merge to 'master'.
> >
> > apologize for the most likely unnecessary clarification (probably implied
> > by the merged comment indicating ca0eaddf5e), but this branch uses both
> > rs/pull-leakfix and rs/commit-reach-leakfix, that are currently merged
> > earlier into next and also scheduled for master.
> 
> Hmph, Does it break if it is merged alone to 'master' without these
> other two topics?  I somehow thought I disentangled the topic from
> unnecessary dependencies before queuing it, but it is possible that
> I misremember...

Doesn't break and applies perfectly on its own, or in any order with
rs/pull-leakfix, but will conflict with rs/commit-reach-leakfix with
the obvious conflict resolution needed:

--- >8 ---
diff --cc commit-reach.c
index 1761217663,2d85265a35..f846d30f22
--- a/commit-reach.c
+++ b/commit-reach.c
@@@ -433,9 -427,8 +428,10 @@@ int ref_newer(const struct object_id *n
  		return 0;
  
  	commit_list_insert(old_commit, &old_commit_list);
- 	ret = is_descendant_of(new_commit, old_commit_list);
 -	return repo_is_descendant_of(the_repository,
++	ret = repo_is_descendant_of(the_repository,
+ 				    new_commit, old_commit_list);
 +	free_commit_list(old_commit_list);
 +	return ret;
  }
  
  /*
