Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3ADD1F597
	for <e@80x24.org>; Sun,  5 Aug 2018 08:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbeHEKPC (ORCPT <rfc822;e@80x24.org>);
        Sun, 5 Aug 2018 06:15:02 -0400
Received: from mail-pl0-f45.google.com ([209.85.160.45]:45638 "EHLO
        mail-pl0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbeHEKPC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Aug 2018 06:15:02 -0400
Received: by mail-pl0-f45.google.com with SMTP id j8-v6so4324743pll.12
        for <git@vger.kernel.org>; Sun, 05 Aug 2018 01:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E9lefGobe62cP7AY6Wgxt+rXZRfQNadehG98Vn5JJ4A=;
        b=vcHqR1p4jbVk5qgR5S91ljWezUObYR7sHpH7boWjVBMivvQUWDjSLv2ST0Kap1xtmQ
         e1Aggvwio2AHNyeMXKMN0hzZM0iGtOyEQMazDIXnowUrFcv4FvVnDcFXp6vhivnWlH/v
         oBOHLCVE4HT/s/NEVg+FbM6TaIl99A5yoJCWpEhyZFfBLVbSJQh7IMf+i0FtugMyLQP7
         dS+wrahQt0YNZ8SHS5NtMb9d814WsYdHJ6K5fzpfWxboAU5xztH6tmQUbJVTGsXsN5GO
         ZW8JSulTnvolrXOte4nAe6LHhw80gzCCX7FodyeBOEflZsR6Yg0He0Tmcb9VbxJYaLnV
         tH8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E9lefGobe62cP7AY6Wgxt+rXZRfQNadehG98Vn5JJ4A=;
        b=HhpRGQVjRRn3Y8IG3iyV1Uy9qEHJj0tbxoqug/MOr4bbvai7BXjR8ml0b3HVYZOUW0
         UIYPLwjpmrz49U2hBsj7aXsmCUcVGrH5GqMBtGh41dEvzWb4CwAaR8x1CCbI4BOrmLyp
         UOilhuTaQnrHim4nq4RRJ2uxoBWBfgTYKQmNRT/Oy9W4uUeR6nRSwtl85aF0+rcTR1Gv
         1IjQpQCb1uD50xhb58AcY0HeO387URrbOMAG1Cx9YVEw9rKDiwvRHFz0QGIP7Yw423aH
         v3OiRUvLn8yb6ZE18X6XB7nQAsdTUFjkeiCm2lKm6PpAfefmB/M3pf/VgedPuMdqZE8K
         J5fw==
X-Gm-Message-State: AOUpUlFHLUy02jL6GFSP7+s9xQnFFtOusO2VKLikGDAEnlfTQ6Igxjou
        BbMLTMTFIL4lt3kNiegIRgNPGsdu
X-Google-Smtp-Source: AAOMgpfIflMWXIwlKJ3cDlojhRxT+umaVUIp8cgN/Y+T67ehI/GAmExiV68xmCoRtnd4CJbf46HAjA==
X-Received: by 2002:a17:902:3225:: with SMTP id y34-v6mr9776166plb.206.1533456678956;
        Sun, 05 Aug 2018 01:11:18 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id x65-v6sm14478422pfk.140.2018.08.05.01.11.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Aug 2018 01:11:18 -0700 (PDT)
Date:   Sun, 5 Aug 2018 01:11:16 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: concurrent access to multiple local git repos is error prone
Message-ID: <20180805081116.GG44140@aiede.svl.corp.google.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
 <20180805014631.GD258270@aiede.svl.corp.google.com>
 <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
 <20180805061312.GA44140@aiede.svl.corp.google.com>
 <CA+KyZp4Yc4_Xaw3v+BPwxi_PW75=GXmj=Re7EpsurXi2_hMc9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KyZp4Yc4_Xaw3v+BPwxi_PW75=GXmj=Re7EpsurXi2_hMc9w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alexander Mills wrote:

> Yeah in this case what appeared to be happening is that if `git status` was
> called concurrently, frequently I wouldnt get any stdout..

Thanks for reporting.  A few questions:

What platform are you on?  What version of Git are you running?  What
is the output of "git version --build-options"?

What is the exit status from these "git status" invocations that
didn't write output?  What options are you passing to "git status"?
Are there any other interesting symptoms?

Is this part of a larger tool or script?  Are there other operations
going on (e.g. something sending signals to these git processes)?

Does the repository pass "git fsck"?  Any other symptoms or hints that
could help in tracking this down?

Can you paste a transcript of the commands or script you ran and what
output it produced?  Is this something I should be able to reproduce?

Thanks and hope that helps,
Jonathan
