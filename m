Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8B3C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 23:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AC33206F1
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 23:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MVI8YHbO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgCLXJf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 19:09:35 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:42868 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgCLXJf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 19:09:35 -0400
Received: by mail-pf1-f176.google.com with SMTP id x2so3650281pfn.9
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 16:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uRNsO8YWe67C/rjgisB/Vdjhg8RHQyfUHTQKm5g4EbE=;
        b=MVI8YHbOR5yKrm9K1H9GhX/qYufcgkC9NKeGTcbmbv5YqzVhoOiZsBEZs8rlhldir3
         eAiwGe8KHgdi0VaSiu+lxazwiIaovMALgHUJp4X9UUZVhVXVV/DvS+RP5x4KSXbS0iy5
         B/ybLvcAgS6CMDGfKnZFFNspFCs14+4axL/VBAxCJv1rNJTPu7PlPoBy3S8M+lD1HBl9
         2xE+Ng+peKvWnCo7mUWXG/g9xSnCAaQ5pUPIplZQ3as7gZDvuzNAhQ+Jc5vIbE0c4TYC
         i70Tz269HY8Ppa97/0YrtHRhbK9WMkmGqGet5bkdER/bg6dF7gxtC/6Ke3c+Psxqy9SD
         FT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uRNsO8YWe67C/rjgisB/Vdjhg8RHQyfUHTQKm5g4EbE=;
        b=huDSH9nS3cYFrwUDO5hKwrGVR+DUPgJ9qfkTyx55/ZBPMD2Rd2Ib+mEyU85Eei28Qv
         7Q4DtkmU5y4tba+RRiaQ18oC5/tRM1Jdkht/VMkSU1w1595Pt6v9+q1kOQXzQisTf+vn
         qd/QcbdTXptJLdxPwAubNMsVc27475K5NEiL0AVR5qfyCcCXqQe6uhWx5zVzsVlPdKJ2
         2mRvYTF8oYC+tJp761V0BXR7gWkMXm+FQyVW5S76tvCC3RtZ8iPLloKVyX5VxCAKVGk+
         5BTciowiPx2mgnOppAQAPlyb0YuTq/+qm0BS01c/cIwnjdGGAPWaHnlWBNHSiEdQxPsM
         G4xA==
X-Gm-Message-State: ANhLgQ24s8EYfKSOBORmbalcnjw4Ax9jG9u2nqkve4Jb2Rf90KXk7qSl
        hYYhDi5iAldr9M7R1W/xU0kxzRx9
X-Google-Smtp-Source: ADFU+vsr4p3sb4wslPp/WTelJGIc6D99rb9GiqJNhbFSGOIBpfjTAhNoIFOLZLcqb25vmss0LOZbcA==
X-Received: by 2002:a63:f20d:: with SMTP id v13mr9984651pgh.34.1584054573794;
        Thu, 12 Mar 2020 16:09:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id f19sm46810219pgf.33.2020.03.12.16.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 16:09:33 -0700 (PDT)
Date:   Thu, 12 Mar 2020 16:09:31 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [Question] Is extensions.partialClone defunct?
Message-ID: <20200312230931.GF120942@google.com>
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
 <20200312170714.180996-1-jonathantanmy@google.com>
 <20200312175151.GB120942@google.com>
 <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD0+fyz=S_VN=EzPOOxNSNkge0uB84kEqQD_mudsFtR8Lg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Christian Couder wrote:
>> Jonathan Tan wrote:

>>> Hmm...besides giving the name of the promisor remote, the
>>> extensions.partialClone setting is there to prevent old versions of Git
>>> (that do not know this extension) from manipulating the repo.
>
> That could be true of "remote.<name>.promisor = true".

To be clear, Jonathan is referring to a specific feature of the
extensions.* settings.  See
Documentation/technical/repository-version.txt for details:

  2. If a version-1 repository specifies any `extensions.*` keys that
     the running git has not implemented, the operation MUST NOT
     proceed. Similarly, if the value of any known key is not understood
     by the implementation, the operation MUST NOT proceed.

No other config key has that property.

[...]
> On Thu, Mar 12, 2020 at 6:51 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Christian, what would your prefered way be to fix this?  Should
>> extensions.partialclone specify a particular "default" promisor
>> remote, or should we use a new repository extension for multiple
>> promisors?
[...]
> So I'd rather obsolete "extensions.partialClone = <remote>" and to
> find other ways.

I *think* that means "new repository extension".

That suggests something like

	[extensions]
		multiplePromisors = true

[...]
>                                                              or maybe
> we could have another extension alltogether like
> "[extensions]\npromisorremotes=<bool>" and over time obsolete
> "extensions.partialClone" altogether. I prefer the later.

I think we're going to have to continue to support
extensions.partialClone=<remote> for a long time anyway (breaking the
ability to work with existing repositories is expensive), so I'm
reasonably comfortable with multiplePromisors being a separate
extension.  Some faraway day, we can introduce
"repositoryFormatVersion = 2" that mandates support for these
extensions by default, allowing us to clean up and simplify.

I can start writing a proposed patch to send this evening or tomorrow.
This behavior has been around for a few releases so it would want to
cook until the 2.27 cycle.

Thanks,
Jonathan
