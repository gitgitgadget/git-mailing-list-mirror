Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187B7C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4F9206D7
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 15:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TawYE3gL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfLPPUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 10:20:53 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44029 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbfLPPUw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 10:20:52 -0500
Received: by mail-wr1-f48.google.com with SMTP id d16so7737073wre.10
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 07:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qDkyZwIn3YfzlY7qxlwaDh6x+k5C89la4ghc/NEdXsY=;
        b=TawYE3gLDGx/r/nbE2Po/21a/NPMwV9F2GP/TC8Fr+/Q28aZm7+6+829tgrhNNBOx9
         V7quvsURaPLZ3Gj6dNin/dK2OGXYD8B4SZO329bLz+2gDiyuAmVRUtllPqQM+tl4cXT/
         M+7OEG1cy26YQ8aPGL9UMTy4JOP66jNr/rhIaDqMSplocJFtDHOkxAqu7dGO8HyV1ml0
         eaN+6nGyGxjbbyud9/VzlWpfAxEHXj31awoJR5UOmBiPiYojZhfwFpBPSLv9Utw4MgMR
         A+lPWDf+4jc5UTAu5Dc1+ZqxK2sHVnyyW+1t7Kp5fDfwB+o39gowrTfpbNr/GaPidHq1
         38lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qDkyZwIn3YfzlY7qxlwaDh6x+k5C89la4ghc/NEdXsY=;
        b=DWarqxzSmm+K1ju8gAU5fnE1DppD39NR46fNRwQOBXVxhAtRHrtBjo4GyrmCBp/ZbF
         pcO7JE8JxeQV71cvUTxvqjFHAZ8fwXM9cfB3UZtHXIKEhF2BF7wH2VzVaHoJ+N5iXxei
         L9SXQK3mhM2kk9Iq0UDKpalbiUJ2b5wC/lavmzMoY/qauyjw4uOkVOKISqf4zCEJsbRZ
         Os152syW9EOcnhD95kg4UkfTXJvudV4HSuNneEA9vyBC++dvMVZhgX3mAl9/eC7/+E99
         Ikg7vvmyq8/OSbGmGXrTMGEMAAPEUNSwXTesU+bZG+DRymLai2f6f14yBi3X29AKruHQ
         VjYg==
X-Gm-Message-State: APjAAAUuyVN4J+30srrGGodCJADmRJOXygp8h0cTSWPQ9BnIkEIATE4G
        CmMDFvtJkd67D16Qom/Evts=
X-Google-Smtp-Source: APXvYqyHgVl9XG+u6FFr+fiYURyachqRoWvlCL3Cs0w7KDOITWEVdTSOmBaAb7sBsiOc6R3BaiYtEA==
X-Received: by 2002:adf:f508:: with SMTP id q8mr31072082wro.334.1576509650925;
        Mon, 16 Dec 2019 07:20:50 -0800 (PST)
Received: from szeder.dev (x4dbe5d6c.dyn.telefonica.de. [77.190.93.108])
        by smtp.gmail.com with ESMTPSA id o1sm22536215wrn.84.2019.12.16.07.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 07:20:50 -0800 (PST)
Date:   Mon, 16 Dec 2019 16:20:47 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.24.0
Message-ID: <20191216152047.GQ6527@szeder.dev>
References: <xmqq7e4gyzgt.fsf@gitster-ct.c.googlers.com>
 <20191104054924.GA47418@syl.local>
 <xmqqo8xsxiyv.fsf@gitster-ct.c.googlers.com>
 <20191104062334.GA49488@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191104062334.GA49488@syl.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 03, 2019 at 10:23:34PM -0800, Taylor Blau wrote:
> On Mon, Nov 04, 2019 at 03:18:32PM +0900, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > Thanks for a great release. As always, your release notes were
> > > very helpful in putting together GitHub's release highlights [1].
> >
> > Well, thanks for writing a version readable from humans ;-)

> Please do let me know if you find any other such typos :-).

The commit-graphs section contains a list, with one of the items
linking to "lots of bug fixes".  The last of those links points to
2e09c01232 (name-rev: avoid cutoff timestamp underflow, 2019-09-24),
which isn't in any way related to commit-graphs.

Better late than never, huh? :)

