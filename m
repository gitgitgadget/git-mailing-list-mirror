Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F36EC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59AE42465B
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 22:20:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rHxSEVYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726338AbgA0WU0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 17:20:26 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40514 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgA0WU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 17:20:26 -0500
Received: by mail-pj1-f68.google.com with SMTP id 12so91968pjb.5
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 14:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lywxJUrCXIYFTOkhbgN0seF2fa5MH/yFZ15Iffnh4yg=;
        b=rHxSEVYLeGr3bs6r21qC7vXJ1Ga6vCiYVylaxy76K7wtau7Hy8lLKbxY5XwoIrelwR
         jUtzGx4a/bxy9Da4Z2udkdy4LXhEssOyEbX4S2DPr/PYThY8qY3DKox8Nu+878U/8UpA
         kNoc7ZfBFmqZLY+8YNIZnJqXtoZw+dvD7Acn1O6FlnlBXmVd0g19RJyB8iml5AlhoO0V
         iU2QVWuRLD7b5d4wlSVKKX5mll4MauuyOAIOPmbfQCuqpbsMF5R0fvKi8+D0pd8PGmVH
         q4iJiZsD1cTbcFVG8b9bibysoQxyX2DLBhhBr4EBiL2kIemL/sGH9XPbUAuq1rumFBzz
         DlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lywxJUrCXIYFTOkhbgN0seF2fa5MH/yFZ15Iffnh4yg=;
        b=JBB2fGZdV+e+SMRLJDr8eXx6IWOsV6WsmG7r5gdy7i8tG9xmuWdG15Ku9OcWOZ4Kmw
         38ijJMbCpgmE6wsfLPWguTpWOllvnFttmWSMy3ToRIqaP3czUYZGVUhJamL7wsx2XRPz
         asdc3qv0FGhLQTFIabiOfbezQZwxAMeRjCATXAP9UAPgDeWoHclpPYWUoHocAogtvYE1
         tqJ5Djl/zYnE/M8N2g3AFccXGL+mW1U2e7zA7R+CxA30KxpA7oyy7ZQGASQB/yXBwjZJ
         /0jedM2bEWfQCF0JaC8wgX8udaqrR0MBRm9pA266byc92DxjBPBdh57MHBzCXwh6qb3X
         EhOQ==
X-Gm-Message-State: APjAAAUnplJLhoGwzyVc0SUSxRAXdCf8KqaUGAstlnUK3I/VJmQ5OVsT
        r1N9zc/FftZVC38Y14hWnfQZPfmPp9k=
X-Google-Smtp-Source: APXvYqwhC+3zWA8cV4AjvdRaY+IqaFWNki4BOylsoucohvWVB955rDq4A1U2lsrq2uiS/8XSeA7EQA==
X-Received: by 2002:a17:90b:4004:: with SMTP id ie4mr955723pjb.49.1580163625048;
        Mon, 27 Jan 2020 14:20:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id 73sm17431133pgc.13.2020.01.27.14.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 14:20:24 -0800 (PST)
Date:   Mon, 27 Jan 2020 14:20:19 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] clone: teach --single-branch and --branch during
 --recurse
Message-ID: <20200127222019.GA233139@google.com>
References: <20200108231900.192476-1-emilyshaffer@google.com>
 <20200109081150.GC3978837@coredump.intra.peff.net>
 <20200116223800.GM181522@google.com>
 <20200117210319.GA15460@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117210319.GA15460@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 17, 2020 at 04:03:19PM -0500, Jeff King wrote:

> (like trying to replace the use of "repo" in Android)

Oops, you saw right through us ;)

> It would make more sense to me to either (or both):
> 
>   - make sure that .gitmodules has enough information about which branch
>     to use for each submodule

Hum. I don't work with them day to day, but aren't we already in that
state? Is that not what the 'branch' option for each submodule means?

> 
>   - offer an extra option for the default branch to use for any
>     submodules. This is still not general enough to cover all situations
>     (e.g., the bar/baz you showed above), but it at least makes it
>     relatively easy to cover the simple cases, without breaking any
>     existing ones.

Yeah, this is sort of the direction my mind went too - "not
--branch recursively, but --submodule-branch". But that breaks down when you've
got a nontrivial number of submodules, at which point you're gonna have
a hard time unless you've got the .gitmodules configured correctly.


Well, as for this patch, let me try it with just --single-branch and see
whether that works for the case the user reported. I can head back to
the drawing board if not.

 - Emily
