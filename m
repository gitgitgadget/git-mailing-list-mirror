Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25A3B20960
	for <e@80x24.org>; Thu, 13 Apr 2017 19:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755304AbdDMTOs (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Apr 2017 15:14:48 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36616 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751626AbdDMTOq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2017 15:14:46 -0400
Received: by mail-pf0-f171.google.com with SMTP id o126so32463942pfb.3
        for <git@vger.kernel.org>; Thu, 13 Apr 2017 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8LdA1TEnRIIZPvD/wQ6PMaIdRy9lCoitC+7eUlKXYVM=;
        b=GoXpRCsxHRhNrCEDha/IZL6aEun0eaTfEdSWZGsZKc/VisqMy4FpiPbf0FJWeDtNxe
         JovxBPvgk6ylQjQqMTgxUcE2mme6pUHy+HZUoXegof2cQ8Wc6iW1D+AYLi0yZvq1iXnd
         eiB6nfdoh8sk+7ywqqUx350iK4luFEOdWQNPfLqlvAsq90HrhCSvUgMsHVkaCT/cFK5w
         pp0y4cwULCmbHtO+cid57MBCff6AyvE9gWCzQaH2St2hHwD7DFeda3E5AiaRPZJDuPLC
         cqhFLF6yc1294KZy3P5pa3+O5u/3luA/Sl4fIYNoc43NHWd3JAASbOxHKgPGsa3od3GZ
         Kvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8LdA1TEnRIIZPvD/wQ6PMaIdRy9lCoitC+7eUlKXYVM=;
        b=ekcmFTOy59P9XVSCK1DFTifEbu80FrxcbFqBa8oPti/2WaYs7+t6VV/I2BHyyMHQh4
         ZmOdVV98sfjfubvw6sJDB/KVD97ESira38Q7byXerM/J5cZGPWiO5VNzGK0xtFSflX4F
         kz/cOMucRoTovykOXvVyoKu/nrMm05znQiPOGpsr4MZwHoGYuOZrobU2o7c+3ihQjQVN
         9ZuZvG1c9Sc4+/WO/RohgLrlVbd23nfE9q3mnhxTjTepe1MbyJtrETDUl0iv3DE3qhOX
         QY1SJtD+KaUCX0orF/k0tKUFeomfc3wTfKYfK4hgA5h4xMA2cyu1WVhtkfqSTlh3SITq
         Pa1g==
X-Gm-Message-State: AN3rC/5zmNMfzF7G7tpa3Vy2V6r7mK7omfO6NMgHTR+6nG6fJtb9DUgB
        g4OzQcNfoyCtih+z
X-Received: by 10.98.97.7 with SMTP id v7mr4083411pfb.161.1492110885777;
        Thu, 13 Apr 2017 12:14:45 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b10:1426:66e2:260b:9db9])
        by smtp.gmail.com with ESMTPSA id y28sm7880522pfk.16.2017.04.13.12.14.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 13 Apr 2017 12:14:44 -0700 (PDT)
Date:   Thu, 13 Apr 2017 12:14:43 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] submodule.c: uninitialized submodules are ignored in
 recursive commands
Message-ID: <20170413191443.GF96917@google.com>
References: <20170411234923.1860-1-sbeller@google.com>
 <20170411234923.1860-3-sbeller@google.com>
 <20170413190541.GD96917@google.com>
 <CAGZ79kZybFNPPAuw4GmVUSmQVBcCG402uCur8M9hSoY3CbhbXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kZybFNPPAuw4GmVUSmQVBcCG402uCur8M9hSoY3CbhbXw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/13, Stefan Beller wrote:
> On Thu, Apr 13, 2017 at 12:05 PM, Brandon Williams <bmwill@google.com> wrote:
> > On 04/11, Stefan Beller wrote:
> >> This was an oversight when working on the working tree modifying commands
> >> recursing into submodules.
> >>
> >> To test for uninitialized submodules, introduce another submodule, that is
> >> uninitialized in the actual tests. By adding it to the branch "add_sub1",
> >> which is the starting point of all other branches, we have wide coverage.
> >>
> 
> ...
> 
> >
> > The 'submodule add' command will make the submodule active, so you'll
> > need to add in a line to subsequently make the submodule inactive for
> > this to work, unless you do in at a later point in time.
> 
> Yes, it will make it active, but that doesn't matter here, because at this
> point (in create_lib_submodule_repo) we prepare an upstream
> in submodule_update_repo
> 
> Any later test follows the structure of
> 
>     prolog &&
>     reset_work_tree_to no_submodule &&
>     (
>         cd submodule_update &&
>         # do actual test here, in submodule_update
>     )
> 
> Note that 'prolog' performs a clone of submodule_update_repo
> to submodule_update, manually setting 'sub1' to active.
> 
> 'uninitialized_sub' is not active.
> 
> I tried to explain it via
>     To test for uninitialized submodules, introduce another submodule,
>     that is uninitialized in the actual tests.
> in the commit message, but that is too concise apparently.
> So the resend will explain that a bit more.

Thanks!  I just wanted to be sure as you're more familiar with these
tests.

-- 
Brandon Williams
