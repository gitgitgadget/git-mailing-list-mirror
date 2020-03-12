Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA5C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2747820674
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="sKMLIGji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgCLVJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:09:58 -0400
Received: from mail-pg1-f174.google.com ([209.85.215.174]:37774 "EHLO
        mail-pg1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgCLVJ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:09:58 -0400
Received: by mail-pg1-f174.google.com with SMTP id a32so2825516pga.4
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BNLYU3zviBPmsHqBvO9tHJ7xso7RvnRC+BLe3MJ0vNA=;
        b=sKMLIGjiPr5hN5y+A43BdtJmf7Nzwo2AuHen/pEuxw3x8wHmf58RbRSlY+z+uEP6kl
         zf5tmf7mJhuQ9J8hGFWt2yRdffRycRPry4jEK0AvBKkL6BfAxlYeNzXd8Rz9h9LbNZ5a
         Vpoaovep9xaO2rxxfg5ENJYAK/Ce92F97UYvSXVVVgsQWzXCt6fEegASJa3WEH4MxmCW
         llA6F3l2djTrErKO6t8vCwAd/LbLNtZ3U/yY9eZ8r65YWwdw0SnMPFkwAakVdor3qz2C
         mTJ5o2kaEjefETp1tK4tB/9w/a7s1xlvZRjMmO3m78v3pr/RmliQWbyOS0IGkpqPu4mE
         llMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BNLYU3zviBPmsHqBvO9tHJ7xso7RvnRC+BLe3MJ0vNA=;
        b=eqRNQQejGpyMCAaSthLnEp3qNStxKRUx8hC17eCdCNE6lRGve1f0GfV6Tq9PEOuevn
         z9MQRdIaRbkJ2orzFTPwpyOnJRGNX6NdNdEH6xEMWB56nB068pTBy5vXU8VF7aKt8dLP
         FUZnJpdUw8jSE2ZquhJ8Em9J5QXAzaw53a0qn327uWI6YOIcxqU/nxqU/9qEVVCqdGd+
         6/ed0SGBFWty1NzlALx/kk2dyGcS2nQ9GRjjjqW07UxyNJ3yfY3te9QM7hOews2sM/Nt
         aUhXMh6cvevRDHMcX8tpFtNbv290n5hlx7Yp7M9LtCVDMWow1WRM/R+DgPoekIAtQNPx
         Kahw==
X-Gm-Message-State: ANhLgQ2lVPNrzA4IIt1qL6kjMOjmMCKEh/8VyDy+T9oMFE4KVY1XrTP5
        nP8AR2AUyfMZPHhG26GXs+wI1A==
X-Google-Smtp-Source: ADFU+vuzhOnl46SeehhW91UrD1ygXv2OVmFOwqlwWcR7OBSagHZ3NlXV2+7CRy5NE0kHKmBq/ByN+w==
X-Received: by 2002:a62:8144:: with SMTP id t65mr10523076pfd.188.1584047396679;
        Thu, 12 Mar 2020 14:09:56 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id z15sm20902189pfg.152.2020.03.12.14.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 14:09:56 -0700 (PDT)
Date:   Thu, 12 Mar 2020 15:09:54 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        git@vger.kernel.org, me@ttaylorr.com, christian.couder@gmail.com
Subject: Re: [Question] Is extensions.partialClone defunct?
Message-ID: <20200312210954.GA13644@syl.local>
References: <5981c317-4b39-de15-810b-a781aa79189d@gmail.com>
 <20200312170714.180996-1-jonathantanmy@google.com>
 <20200312175151.GB120942@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312175151.GB120942@google.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 10:51:51AM -0700, Jonathan Nieder wrote:
> Jonathan Tan wrote:
> > Derrick Stolee wrote:
>
> >> but it appears that we rely on the "remote.<name>.promisor = true"
> >> setting instead of this extension.
> >
> > Hmm...besides giving the name of the promisor remote, the
> > extensions.partialClone setting is there to prevent old versions of Git
> > (that do not know this extension) from manipulating the repo.

Manipulating it how?

> Yes, so the lack of setting is a bug.
>
> Christian, what would your prefered way be to fix this?  Should
> extensions.partialclone specify a particular "default" promisor
> remote, or should we use a new repository extension for multiple
> promisors?

This ambiguity makes me think that 'extensions.partialClone' is an
awkward fit for repositories that have multiple promisor remotes.

> [...]
> > I cloned and indeed it is as Stolee describes. Git still works as
> > expected if I remove "promisor = true" and add
> > "[extensions]\npartialclone=origin", so at least extensions.partialClone
> > is still supported, even if not written by default.
>
> Thanks for investigating.
>
> Sincerely,
> Jonathan

Thanks,
Taylor
