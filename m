Return-Path: <SRS0=24D7=6H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F828C55185
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56F6F20704
	for <git@archiver.kernel.org>; Thu, 23 Apr 2020 00:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="2MkbENTR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbgDWAOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 20:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbgDWAOm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 20:14:42 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAC7C03C1AA
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:14:41 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n24so1602783plp.13
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 17:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+lMTc8CS3N0GjBqASHdC+rv8oLmMYvsaeSj1C/l617Q=;
        b=2MkbENTRzEgNcy6lJi43QJ5/sPVc5MdKVY+1VEGi3FXIBtQrNac2rruid/x4MuICnB
         ujUdJH3IGV9p+XlY4448Y1qY0cZ9yX8klAarM8YFYenwxiiZX1ORzqeLZJrmaZdWrgPL
         /9gBMF9/yjtA0kdToqpJYTTGJoogLq/5/7E5ZYofi9bSf1vNWL2XQi/vUqgHibEIUPln
         wAB7P24poaJ6O0uclZrvG0DsDF4B8Z4KBjt/n7+VKzgHazrm4iqRp9iBNaQKgD40X39G
         SclBo1W2yUv6DFuXyDhG9vTv3bq4WO1pyDOF1opOvexebhlKpeX8Xcy/oMImb4m+YN7C
         qpIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+lMTc8CS3N0GjBqASHdC+rv8oLmMYvsaeSj1C/l617Q=;
        b=f46IO+3yubHg3fYTBYf+T4ii9nGaUW6pcZTm1lC4YJoSoRbsE5PyFS9IkGqeCHuXXC
         ZWWanh8cYm9oubLBPYjOFfZm9yFtJFI4Sd9nhmLqC8FVchy/8BLsaTgU2MEat+HCkZeJ
         ucuEoXCTxIi5dcm2wtItQCV/8yT1iVQMXOXUI+zsTTjjcxeE2jKlWDOb32KaKSUIcmPJ
         IcJWJ5FpO4lyDiWPWSMTgr3GL3IB7nFfdWUKlXzHKW/AwBDYvewha9zAx7eteV8rwphJ
         p+fcWfKqDqLAZi5DXOCKPvn3+jHdwFUbYGt7AuqWOAb3CFNXiIMB5+5MHn5nEuqwZLk5
         JTVQ==
X-Gm-Message-State: AGi0PuYIe1AAKbsMQ4B8Nh0t/Le/Xa80SHrtHa0gVIl94Et6FEag7oK3
        VUEsjsQPHvARRqa++izQ2DHNbw==
X-Google-Smtp-Source: APiQypLua3MeSOjVEskxXJmrICsBJcET2SvdzkSJQFnVY5O2ip2nXRg8LRe6wdo7wdG1FMTCO0GDlg==
X-Received: by 2002:a17:90a:a484:: with SMTP id z4mr1374225pjp.40.1587600881276;
        Wed, 22 Apr 2020 17:14:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id q2sm647898pfl.174.2020.04.22.17.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 17:14:40 -0700 (PDT)
Date:   Wed, 22 Apr 2020 18:14:38 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, me@ttaylorr.com,
        git@vger.kernel.org, newren@gmail.com, jrnieder@gmail.com,
        dstolee@microsoft.com
Subject: Re: [PATCH] shallow.c: use 'reset_repository_shallow' when
 appropriate
Message-ID: <20200423001438.GC19100@syl.local>
References: <8d295389ea43c6b7e008514067b7af6eacba64a5.1587492422.git.me@ttaylorr.com>
 <20200422180245.196132-1-jonathantanmy@google.com>
 <xmqqy2qnidyy.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2qnidyy.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 11:15:33AM -0700, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
> >> @@ -414,6 +414,7 @@ void prune_shallow(unsigned options)
> >>  	} else {
> >>  		unlink(git_path_shallow(the_repository));
> >>  		rollback_lock_file(&shallow_lock);
> >> +		reset_repository_shallow(the_repository);
> >>  	}
> >>  	strbuf_release(&sb);
> >>  }
> >
> > The "if" part (not quoted here) commits the shallow lock file, and thus
> > possibly modifies (or creates) the shallow file, so I think we need to
> > put reset_repository_shallow() outside the whole "if" block. I have done
> > that in the patch after the scissors.
>
> Is there any rollback_lock_file() or commit_lock_file() call on the
> shallow lock file in the files involved in this patch that does not
> need a call to reset_repository_shallow() left after your work?
>
> What I am trying to get at is if it would be safer to have a pair of
> thin wrapper for rolling back or committing a new version of new
> shallow file, e.g. rollback_shallow_file() + commit_shallow_file(),
> and replace calls to {rollback,commit}_lock_file() with calls to
> them.

Very elegant. Thanks for an excellent suggestion. v2 incoming just as
soon as 'make test' finishes...

Thanks,
Taylor
