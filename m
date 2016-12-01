Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B99ED1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 22:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754661AbcLAWxf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 17:53:35 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:34167 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752715AbcLAWxe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 17:53:34 -0500
Received: by mail-pg0-f46.google.com with SMTP id x23so99813323pgx.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 14:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=52JjF212JktgkbKq8KBUX4DEp2GodVxsnEMyeF9smR0=;
        b=kN6uitLxZsMeIC8OQsK/IIiaLdGVWcJb9txK6jUBd5IXM4nuVunGCxFBOFBBdAQ/b7
         0g0bpFbY5XETDn8Fj85OskmJUFp1vLxLkARcdOLpr/Z3h2JA5nhhnS0Ampm6ixhbtLWD
         r8C1iDdqJpT8ag6ML9Pg7joRhVTm47/HvglhllnTmcJB6srifN67Hq0kYLRBqAjm3AMk
         WUEry86uBxJaO7L/j3J+O7H1oGO/E0zSUIzSaCov23NENUdtJJFCoq3BfceIi3XQ154/
         LiJBU+ltTBkyW1fXzQE0QnL+JOkf6y7cQmK6so8px4vAnIG/9mboGefxAO4+WcYmU2eL
         tRzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=52JjF212JktgkbKq8KBUX4DEp2GodVxsnEMyeF9smR0=;
        b=cdXYGKQq7X1hrqmJbgSuGjO17A8sjG4xCN+YhI1q3EGOLhe4FDDRETlvGNfcyXinNz
         dcCOHetd31E0T8kLRgxiPAs2UhOwMenYgfXh45uyCr7lceTu/YGziuQy1FoL31tszH6U
         DM5VrpPMmdmr/FBrgywnZPx9g1xf622v3BeLka1MBy+fdqTvIYZrF/F6LuOXOSnsGXLT
         dxzIthHlfj4mGJXjwT4t+D8UmTmtWwOULVGXqeSNm8PBuz3QFeUFw7rkEUzRLhkmBID7
         Qc0zOxu3hejGAL/G9yCBn/6FjH+9n2hUG1MdQD0mQWkz260IMVIm8oAAXkmIgE10osdQ
         DZfA==
X-Gm-Message-State: AKaTC03tlSc067RA8vAqU9FrfPECZxEzavxL/mJi3Fi2SgRPuXsRRSLUleIyXChfdqmdBSwl
X-Received: by 10.84.216.24 with SMTP id m24mr17768636pli.26.1480632813864;
        Thu, 01 Dec 2016 14:53:33 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id 13sm2506386pfz.30.2016.12.01.14.53.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 14:53:32 -0800 (PST)
Date:   Thu, 1 Dec 2016 14:53:31 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 2/6] http: always update the base URL for redirects
Message-ID: <20161201225331.GH54082@google.com>
References: <20161201090336.xjbb47bublfcpglo@sigill.intra.peff.net>
 <20161201090414.zgz7pimgpctghbwu@sigill.intra.peff.net>
 <331124b5-aa2b-773c-23ac-975ad3f50dbf@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <331124b5-aa2b-773c-23ac-975ad3f50dbf@ramsayjones.plus.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Ramsay Jones wrote:
> 
> 
> On 01/12/16 09:04, Jeff King wrote:
> > If a malicious server redirects the initial ref
> > advertisement, it may be able to leak sha1s from other,
> > unrelated servers that the client has access to. For
> > example, imagine that Alice is a git user, she has access to
> > a private repository on a server hosted by Bob, and Mallory
> > runs a malicious server and wants to find out about Bob's
> > private repository.
> > 
> > Mallory asks Alice to clone an unrelated repository from her
> -----------------------------------------------------------^^^
> ... from _him_ ? (ie Mallory)
> 
> > over HTTP. When Alice's client contacts Mallory's server for
> > the initial ref advertisement, the server issues an HTTP
> > redirect for Bob's server. Alice contacts Bob's server and
> > gets the ref advertisement for the private repository. If
> > there is anything to fetch, she then follows up by asking
> > the server for one or more sha1 objects. But who is the
> > server?
> > 
> > If it is still Mallory's server, then Alice will leak the
> > existence of those sha1s to her.
> ------------------------------^^^
> ... to _him_ ? (again Mallory)
> 
> ATB,
> Ramsay Jones

Depends, I only know Mallorys who are women so her seems appropriate.

-- 
Brandon Williams
