Return-Path: <SRS0=AWh0=66=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E7F3C433E1
	for <git@archiver.kernel.org>; Sat, 16 May 2020 05:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554402075F
	for <git@archiver.kernel.org>; Sat, 16 May 2020 05:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DU8GbQFw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgEPFu1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 May 2020 01:50:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725807AbgEPFu1 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 16 May 2020 01:50:27 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0A7C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 22:50:26 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id t7so1822215plr.0
        for <git@vger.kernel.org>; Fri, 15 May 2020 22:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1dUlISOBeIfAeZGzN2EGomlQFHDU1eUaL/WE3u9rO8E=;
        b=DU8GbQFwaX8k+kqyE5pNBUxxINxQnPpxVdlwlqL3MjOUVuELHyGhZ2SmIzTsCdXceW
         j7YDwytvibeTVARgyOK3DG8TKHOs9pSr58IfyqJkRAl/HakvCpyPzuGdstCbcDlSCojs
         WI47xR/SHKNV2beoGOXwzOQLJzrf+HVYDZrVMFfS1u+WiMAvI+xWC8fw+jAGnX+O144a
         MI3Ws8TssF1/la0eYxKrN4Q77BeAj5QnuiQwciROx0NBVuCo4lwvEbTFR3NRBIQ7Bi9s
         +i+x1LqjWQf0Pp865t47z4wXfo43eI14HrnYh24qfQizN6z6WOay4RG++dJS5HiaqDUc
         X0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1dUlISOBeIfAeZGzN2EGomlQFHDU1eUaL/WE3u9rO8E=;
        b=JmzbIaety+1wP/DmkEe3gp+jrKLawavLdJVtpTa7h4To1O22f1sU37/Vp+q3Ayb4lk
         I5b1eOiQPu67nSEopbV+eDElGBysSshPD1XoPRFb1sZesOLtW5D+yKpMQs6Nf3gGbKMc
         Mps/pGEXbxcz0XjetZq7TSE5526ME9/QH0X4obBKnpOr/flbM0dF8K0zaBuViF83HDkh
         O6IUKMSOBUAh39EXnhJKkYoCmsPix/od39USxH5OXViXU6TULRRmt2S2vxqRWUjdPAma
         Krg4hmcdo/G+j2gGAUBzyR9DhcLEVWf+q4Jbqhdaq1a995rstPvj+NPrSWrx+CKHNkgJ
         FxPg==
X-Gm-Message-State: AOAM533TcsoFsk4sqmeXs4uaSuEYCQqER1ryRgofxSQVSnoncjXrYMm5
        h2bZYBuM7M6GsFEREDef1Eh4Pz8uIdjrng==
X-Google-Smtp-Source: ABdhPJytC0iYo/Oast7XCeO7raI0RcNG1fRn5N58yqqjCE2RhKHX+n9D4iWyegACDxpJMggYH1sCEQ==
X-Received: by 2002:a17:90b:1482:: with SMTP id js2mr3523165pjb.54.1589608226202;
        Fri, 15 May 2020 22:50:26 -0700 (PDT)
Received: from konoha ([103.37.201.175])
        by smtp.gmail.com with ESMTPSA id 25sm2927266pjk.50.2020.05.15.22.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 22:50:25 -0700 (PDT)
Date:   Sat, 16 May 2020 11:20:16 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 2/2] submodule: Add 'quiet' option in subcommand
 'set-branch'
Message-ID: <20200516055016.GB3296@konoha>
References: <20200513201737.55778-1-shouryashukla.oo@gmail.com>
 <20200513201737.55778-2-shouryashukla.oo@gmail.com>
 <20200514101534.GB28018@generichostname>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514101534.GB28018@generichostname>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/05 06:15, Denton Liu wrote:
> Hi Shourya,
> 
> I'm not really sure if we should have this patch at all since I don't
> think that set-branch should be printing anything at all.

I thought that the Documentation has the mention of the `quiet` and it
wouldn't harm printing something when the branch is set. Is this not the
right way to tackle this?

> But I'll give some comments anyway. Hopefully they'll be enlightening.
> 
> On Thu, May 14, 2020 at 01:47:37AM +0530, Shourya Shukla wrote:
> > The subcommand 'set-branch' had the 'quiet' option which was
> > introduced in b57e8119e6 by Denton Liu but was never utilised due to
> 
> We typically refer to commits by the "reference" format. You can get
> that as follows:
> 
> 	$ git show --pretty=ref -s b57e8119e6
> 	b57e8119e6 (submodule: teach set-branch subcommand, 2019-02-08)
> 
> In addition, I don't think it's necessary to mention me by name in this
> case.

Okay, I did not know that, will change in the next version.

> > -		printf(_("Default tracking branch set to '%s' successfully\n"), newbranch);
> > +		if (!(quiet ? OPT_QUIET : 0))
> 
> This is needlessly complicated... Can't this just be written as
> 
> 	if (!quiet)

Okay, will do.
