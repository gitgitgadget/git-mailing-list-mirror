Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3301FC2D0DB
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 19:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 046F024679
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 19:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580154043;
	bh=PEJybVy/knIp/6jSD6UmLxTKcFhWvbSqNettMDq1gRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=E5aO5BC1a8XemXAHYZ1H81cuuV4PZu55MBX0bq3NXGydvtx0Ro5swR0Nq+Yu3G+UF
	 Kp3fIZaIQ8um8ue9mKI63FRJKDoDsrqf9cT8UWutHASLyYVzHFpwlIy80KSIhWEw/n
	 m9K70cSQsTeO+kDdCwm45fwMvyPALD88bqKl0+rs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgA0Tkm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 14:40:42 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]:38528 "EHLO
        mail-qt1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgA0Tkm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 14:40:42 -0500
Received: by mail-qt1-f179.google.com with SMTP id c24so8351355qtp.5
        for <git@vger.kernel.org>; Mon, 27 Jan 2020 11:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=PBcM3t2+MfJHUzuPoaQkrkzczRkgCYGJl9QIAiKFRLg=;
        b=b8mF9dWXRquU92BkGjTRfwh6O9PvYWlseiahN3FE/VuRbhgausV7ypLBVGCtCEIVq+
         lQ7buXzpmjqmctkoaCcMNNHLSgGVRrjhkor+NA6GlVPqjc8YXUf7XWDFSD3GYfPNPZyW
         K8Ylx72CW5baSDXXstNsObYdD3YdRsCw6N4QM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=PBcM3t2+MfJHUzuPoaQkrkzczRkgCYGJl9QIAiKFRLg=;
        b=Gk5ZKqWu+kE9ncOOq7Jz29tivNc45IPxwBOftYzZF2ytlZx8S++mLCKtLSGQQKuP1a
         DeFRwCaiNixFUWTRP69C8rKjbIqeXuHMfvU5LmBwmCxTwlbJD/0wXjIospHFVhz0y8jm
         HjbkJ4Wm8q8Q4H3qsHzmRvTCisWTmCRBbXHOvqLspElDDGmIgofbkGPd/XrWd71gk5qH
         gP6DsWrov27bQZZ3YAOyvl5yz/6NNWp7U5hPa9Rr1MtRGXsIbBmaABLCp/KXUXZbghpi
         Jj9nu5LGw2jKtdqdP3NmkpXY0PjS9SMh1BklBBdkgs+yeOmLOscJ8Rh0Nis8phG4xDtH
         GJtg==
X-Gm-Message-State: APjAAAU3NgXxvBkz5naY9f9tn/e7hxK9LgllHqFyqo/NP4P1OJWSACKa
        EDe9W9wKARvZCseE/WffoFPGSTOxe2T4OA==
X-Google-Smtp-Source: APXvYqyHhIbuJ/pBEniMFMFAtS1ByUt45FyDCmO/WRWJlPtB4qkeejDBqDeFOKSHOv90sWefLNW5og==
X-Received: by 2002:ac8:5205:: with SMTP id r5mr17622915qtn.230.1580154039993;
        Mon, 27 Jan 2020 11:40:39 -0800 (PST)
Received: from chatter.i7.local (107-179-243-71.cpe.teksavvy.com. [107.179.243.71])
        by smtp.gmail.com with ESMTPSA id v55sm8559762qtc.1.2020.01.27.11.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 11:40:39 -0800 (PST)
Date:   Mon, 27 Jan 2020 14:40:37 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     "Jones, Amy E CTR USARMY ATEC (USA)" <amy.e.jones49.ctr@mail.mil>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cyber Security questions (UNCLASSIFIED)
Message-ID: <20200127194037.asum4555fjop5i2n@chatter.i7.local>
Mail-Followup-To: "Jones, Amy E CTR USARMY ATEC (USA)" <amy.e.jones49.ctr@mail.mil>,
        "git@vger.kernel.org" <git@vger.kernel.org>
References: <3DDB5EB393DC7E4A810C3651CC0B08101780A52F@ugunhu4m.easf.csd.disa.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3DDB5EB393DC7E4A810C3651CC0B08101780A52F@ugunhu4m.easf.csd.disa.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amy:

If you haven't received any responses, this is because git is 
open-source software without any single company or entity behind it -- 
so there is nobody in a position to provide authoritative answers that 
you are probably looking for.

There are vendors who repackage git as part of their commercial offering 
(e.g. Red Hat), so a better course of action for you may be to approach 
the companies who supply commercial support for git as part of the 
overall OS contract.

Best regards,
-- 
Konstantin Ryabitsev
Director, Core Projects IT
The Linux Foundation


On Wed, Jan 08, 2020 at 11:58:57PM +0000, Jones, Amy E CTR USARMY ATEC (USA) wrote:
> CLASSIFICATION: UNCLASSIFIED
> 
> We've had a request at this company to acquire GIT software, but all new software has to be approved by our cyber security team. I have a list of questions that need to be answered before we can start the approval process, and some of those questions are very technical, is there someone who could fill out the question form?
> 
> Amy Jones
> Team SURVICE
> 435-831-7168
> amy.e.jones49.ctr@mail.mil
> 
> 
> 
> CLASSIFICATION: UNCLASSIFIED
