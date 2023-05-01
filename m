Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0017DC77B73
	for <git@archiver.kernel.org>; Mon,  1 May 2023 17:23:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjEARXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 May 2023 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbjEARXB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2023 13:23:01 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4014A1707
        for <git@vger.kernel.org>; Mon,  1 May 2023 10:23:00 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-63b67a26069so3199492b3a.0
        for <git@vger.kernel.org>; Mon, 01 May 2023 10:23:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682961779; x=1685553779;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reP+cKquapPkwRzNTcAISjSVenFoDZjoNqCkGopjbcY=;
        b=rVuBZBAYjc/tIFRM+bUW5WNbsGRgeHYfuF4vRZCJDMwkLELYYaKubaduDBih27yeLW
         PUTLQChGgj+0kBH/O+EjUL/v61ME9dxRiGumsOI1pdM68RyTzkc3yY7N59X6ssTbGy2H
         54Dks0c3GimssjeRffxTMAFD+QQFG+x/LYgxDzwZsaZSSKZQnBHZ6Op8XaVawOaZ9k31
         GFc6u0FIjPAXTTF+lVXstgRFG3UWmlMBCH/On59l6RpC9mdFsG6RhU3/s9tBqg6JBj9X
         Cw/+jM2HKM7BsHCkoyedez5VzUSgS8qFFMC0oZ7ueK2uyyNWkw48KkM6Yn75zsBL5I7L
         kc8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682961779; x=1685553779;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=reP+cKquapPkwRzNTcAISjSVenFoDZjoNqCkGopjbcY=;
        b=Jz48SDK5wolwS71SlccxG7B+5easHivEQb9pB98dAKzFutPigkzSOfYeL+33VJol5t
         6ifzewlhmDJonNYMPsFRcgzSsgNw3silWYdzTACiSCK07vOtvBewY2xMEm1N9mZpOu2+
         aFHYvIQviXPDijY0UNaHcAKMJQKY6td07M3/6ENscalB4fU3TrXecLhODTe/LR/FdE5G
         BG3pO+JrVc5IRHkD15aLBTMRVXQJjDBkDi86lx1p5e84Jqv6l2KrF64QtbpovGHJoXK7
         FvrDFbnXWge6vXyYEImQUukH715b4V3rGSwNBmS+SvO6qNp8n4vHKTOYevKUVJi7H7fP
         8f+w==
X-Gm-Message-State: AC+VfDwm+REH5wYE/3VN+FZA1b3LbM2iym6tlWQYoFvok2qmn9g/Y5pr
        2IzTWkRmBYMxar+VxuI1wI4xlA==
X-Google-Smtp-Source: ACHHUZ5RAKV1PTVvCLUaMRFjbIGBZO28xb2htCQDjO9QiWyX6rbZgxhCchKBu/pZz5r2u2ENcYws5w==
X-Received: by 2002:a05:6a21:6d87:b0:ed:1d7a:3339 with SMTP id wl7-20020a056a216d8700b000ed1d7a3339mr7381189pzb.57.1682961779442;
        Mon, 01 May 2023 10:22:59 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:38fe:5256:e952:c2a3])
        by smtp.gmail.com with ESMTPSA id o15-20020a655bcf000000b0050bc4ca9024sm16642933pgr.65.2023.05.01.10.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 10:22:58 -0700 (PDT)
Date:   Mon, 1 May 2023 10:22:53 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2] setup: trace bare repository setups
Message-ID: <ZE/1bRh+pisYWBrV@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>, git@vger.kernel.org,
        gitster@pobox.com
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
 <b548d96db7052dc2cb664922fa2003fe068843cf.1682702058.git.steadmon@google.com>
 <kl6lbkj73laf.fsf@chooglen-macbookpro.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl6lbkj73laf.fsf@chooglen-macbookpro.roam.corp.google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.04.28 11:37, Glen Choo wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
> > index 11c15a48aa..993f5bdc7d 100755
> > --- a/t/t0035-safe-bare-repository.sh
> > +++ b/t/t0035-safe-bare-repository.sh
> > @@ -7,13 +7,24 @@ TEST_PASSES_SANITIZE_LEAK=true
> >  
> >  pwd="$(pwd)"
> >  
> > -expect_accepted () {
> > -	git "$@" rev-parse --git-dir
> > +expect_accepted_implicit () {
> > +	test_when_finished 'rm "$pwd/trace.perf"' &&
> > +	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
> > +	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
> > +}
> > +
> > +expect_accepted_explicit () {
> > +	test_when_finished 'rm "$pwd/trace.perf"' &&
> > +	GIT_DIR="$1" GIT_TRACE2_PERF="$pwd/trace.perf" git rev-parse --git-dir &&
> > +	! grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
> >  }
> 
> (Not new in v2) This wasn't obvious to me at first, but
> 
>   grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
> 
> looks like it's asserting that we trace that the bare repository is
> $pwd, but it's actually only asserting that is starts with $pwd. If it
> might trip up other reasers, a comment here would be helpful.

Added a note in V3.


> > @@ -21,13 +32,9 @@ test_expect_success 'setup bare repo in worktree' '
> >  	git init --bare outer-repo/bare-repo
> >  '
> >  
> > -test_expect_success 'safe.bareRepository unset' '
> > -	expect_accepted -C outer-repo/bare-repo
> > -'
> > -
> 
> I found this surprising; I thought it was quite valuable to test the
> default behavior. I'd prefer to keep this test.
> 
> Perhaps there was a miscommunication? You mentioned:
> 
>   Actually, explicitly setting the variable here is equivalent to the
>   following test case, so I'll just remove this one.
> 
> which is true, but I think Junio meant _un_setting the variable,
> something like:
> 
>   test_expect_success 'safe.bareRepository unset' '
> +   test_unconfig --global safe.bareRepository &&
>     expect_accepted -C outer-repo/bare-repo
>   '

Yeah, misunderstood. However, see my reply to Junio about this being a
"change detector" test.
