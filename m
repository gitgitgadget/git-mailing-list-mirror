Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E736E9271C
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 17:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjJERwd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 13:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjJERw3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 13:52:29 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6C898
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 10:52:27 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-59b5484fbe6so15047407b3.1
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 10:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1696528346; x=1697133146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gZKXkQf/ITJr8cKRRLHG3sxFX+7ahXZvz2atw/uvfTk=;
        b=AHNUzss+lza7zHHWGVfPv13BywcWxq4GR17AaBkflvzVxIqUVx7mUHXwT5ESdJgyH8
         Jvy2qwAVpQL2xKwRIikWWXoITSO9HRlwhgVGlh9vCfCUsXrlCOZ5MBhu9782K9TOu13l
         xO+0xeRUuRinvGEq3m89w9f72/Ofr+IZVWlgqFl72zZ0jYDlbkDuGPPzhgyOJXmxbcWo
         pT/JpOQNypnx3S3CiATexxZ04MisDmF8NLSPAl/lJv3+raepaUzMvOT0CYOuaWUuSyHX
         b8QZqvMkVnTqUUS3xenR0KMCF7mcfjiOL3KfJpwvI6oY+QVIOlKe6BfA4l7u2cGl1Ni0
         fpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696528346; x=1697133146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gZKXkQf/ITJr8cKRRLHG3sxFX+7ahXZvz2atw/uvfTk=;
        b=KQZhy+trEWW+zgNBx+nj2rLx0j/EwwUtG8O1wRvx+lZ8nCftrnuUJ6UKIprlLgjW1U
         uzBAChmaBz6GfG8WpeR2Ih1hGdWx9NHFN049ByRBhifK3U3RcKveGk7vjMZaN8nJubLC
         8Id8q62xpa4tJB7f8YAj7m+LuvLXKYFV3UXBHfUxZXhs7SDNaSZxbwP9qjr8pV6xfgm3
         DDP9bwPqPUbYcWxifKG92o4oVmjZ8alX2eLhCwFBNXMHhYQ7Q6mVflUM/5rtJi5dVZMh
         EsvPUw6wFKLlMAt1tymj4dCBqVpUJfNemJJdvVEGasRJ5hBFHrwrQLF8+duxd49jtThb
         Zjnw==
X-Gm-Message-State: AOJu0YzwUUyWmGAk9ujH/HduMNuCXt/ZT0v6/3Lr4lSdry6DjMCJik0/
        TBSWsI+YcS1DMV9L9cuhUDytH8BTlN55y6StfdI8qg==
X-Google-Smtp-Source: AGHT+IGdtNufYPtZNxKYdMDvtEicMAuzYC+/ZAr/uJVPG8GZ8/nhsdYdylNWJ32LgpagsFokzw5/Yg==
X-Received: by 2002:a05:690c:3608:b0:5a5:575:b1cd with SMTP id ft8-20020a05690c360800b005a50575b1cdmr4010385ywb.13.1696528346404;
        Thu, 05 Oct 2023 10:52:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85648000000b00419792c1be7sm642906qtt.30.2023.10.05.10.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 10:52:26 -0700 (PDT)
Date:   Thu, 5 Oct 2023 13:52:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/10] some commit-graph leak fixes
Message-ID: <ZR732biF718ju9QU@nand.local>
References: <20231003202504.GA7697@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2023 at 04:25:04PM -0400, Jeff King wrote:
> I noticed while working on the jk/commit-graph-verify-fix topic that
> free_commit_graph() leaks any slices of a commit-graph-chain except for
> the first. I naively hoped that fixing that would make t5324 leak-free,
> but it turns out there were a number of other leaks, so I fixed those,
> too. A couple of them were in the merge code, which in turn means a
> bunch of new test scripts are now leak-free.
>
> Even though I saw the problem on that other topic, there's no dependency
> here; this series can be applied directly to master (or possibly even
> maint, though I didn't try).

Thanks for carefully finding and explaining these various leaks. The
series is a definite improvement, and after reviewing closely I couldn't
find anything worth changing. LGTM!

Thanks,
Taylor
