Return-Path: <SRS0=Fhy4=6O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F92EC47247
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 15:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBB1D2076D
	for <git@archiver.kernel.org>; Thu, 30 Apr 2020 15:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Ou2JNbux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgD3P7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726515AbgD3P7H (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Apr 2020 11:59:07 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED73FC035494
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 08:59:06 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f7so3051924pfa.9
        for <git@vger.kernel.org>; Thu, 30 Apr 2020 08:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c8v42PmRPLp/1brM3y/OdOeNIT++nq4e+ovJeUeasjc=;
        b=Ou2JNbuxRjJ1ivGHwoG+3it8omaRCSOTiWVzh+owZZGencTmC+TZ4zSD+Mh/gdID+k
         hg1aWaaGzuD5EFDKHy8sUwjgocfZzrNCcttqlz98XpJhZNHCoHHZrRblw8eQ7tsPoPb6
         1CBA/rEAecf+hUyKt1o9S6w2zIcqM4CE4MxW8ronN1BcD5p2kepmaVq0ev6MbbNdkO4U
         a74lsnoYaLtDU6TRarJlzOK88lPVZBDD4kwgqKAQfxWOeAeQXkJdmwCq3IxAkMKR3TPS
         17InTtFtjLrKZGIrWlq3V1HJGepPUi+yOocuSBV3rYMlw6BBBua4Y1tF4+6t+LPfNLMK
         TdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c8v42PmRPLp/1brM3y/OdOeNIT++nq4e+ovJeUeasjc=;
        b=hra+xQi615krVmxJNYEig2Zw1Ltfm7Q7yOR1SkVrmg4ZjwEhJyyB88wHKHi6LBUkNS
         jKBh6Z7dYkF2Di3dKoY+izVRpGA8KtlCZhK6oX/kBXslIQpgks7JZPzKJ+4JVpr1LRR6
         MrQRNMZVysI5vmDnj2Uzcin0GChaqt/DBPcVh5BtRUXbUDrO5IgVVtptuqMVH+/fIsdQ
         pePGx78wNMNyoMD5lhCZpdAQ+pWjF1Lv76PXBT+4m9Mj/aMXU8v8WsCzDSGv1Hdb2Z0U
         qigo7+aVHJnY+SD4zIp500K4uWZS6xo08LW8AtKnzfmSsLW+V45la2GgMnla/NDptcmM
         Ixpw==
X-Gm-Message-State: AGi0Puam8SNp7AdlivVIa92xnjmJP6vOLLzYEZi9HqouRtJTwsZeIFAO
        uJvjIEBdwjvTLnAbomjWMW4QeuZGZCwB8p6M
X-Google-Smtp-Source: APiQypJUrBhS2KLCf899I/Dtx9HnsIkvOwgQhLHR2uPr2fMjZKhWpE95kkFuXTJezqM3fNWkGiGWkA==
X-Received: by 2002:aa7:9529:: with SMTP id c9mr4343540pfp.279.1588262346294;
        Thu, 30 Apr 2020 08:59:06 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id g43sm225520pje.22.2020.04.30.08.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:59:05 -0700 (PDT)
Date:   Thu, 30 Apr 2020 09:59:04 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Ivan Tham <pickfire@riseup.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] branch: add '-' to delete previous branch
Message-ID: <20200430155904.GA30682@syl.local>
References: <20200429130133.520981-1-pickfire@riseup.net>
 <20200429185851.GF83442@syl.local>
 <20200430145221.z3lpgjstybqztfqb@arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200430145221.z3lpgjstybqztfqb@arch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ivan,

On Thu, Apr 30, 2020 at 10:52:21PM +0800, Ivan Tham wrote:
> On Wed, Apr 29, 2020 at 12:58:51PM -0600, Taylor Blau wrote:
> > On Wed, Apr 29, 2020 at 09:01:33PM +0800, Ivan Tham wrote:
> > > Add support to delete previous branch from git checkout/switch to have
> > > feature parity with git switch -.
> > >
> > > Signed-off-by: Ivan Tham <pickfire@riseup.net>
> > > ---
> > >  Documentation/git-branch.txt | 10 ++++++++++
> > >  builtin/branch.c             |  6 +++++-
> > >  t/t3200-branch.sh            |  7 +++++++
> > >  3 files changed, 22 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> > > index 135206ff4a..37e7cbbc52 100644
> > > --- a/Documentation/git-branch.txt
> > > +++ b/Documentation/git-branch.txt
> > > @@ -265,6 +265,10 @@ start-point is either a local or remote-tracking branch.
> > >  	The new branch name must pass all checks defined by
> > >  	linkgit:git-check-ref-format[1].  Some of these checks
> > >  	may restrict the characters allowed in a branch name.
> > > ++
> > > +You can use the `@{-N}` syntax to refer to the N-th last branch checked out
> > > +using "git checkout" operation. You may also specify `-` which is synonymous to
> > > +`@{-1}`.
> >
> > Interesting; we're already using strbuf_branchname, so the first part of
> > this documentation was true even before this commit. Would you consider
> > splitting this into two patches?
> >
> > The first should include the first sentence of this documentation, an
> > additional test in t3200 exercising an explicit 'git branch -D @{-N}'
> > for some 'N', but no changes in builtin/branch.c. The second patch would
> > then make '-' a synonym for '@{-1}'.
>
> Is not this already true? Why do we need to split it? Currently using
> '@{-N}' to delete branch already works.

It is the case that 'git branch -D @{-N}' already works, which was
surprising to me. I am suggesting that you make documenting the existent
behavior a new first patch.

Of course, that might be the only patch that you end up sending in v2,
since it seems that consensus has formed around not supposing '-' as a
shorthand for '@{-1}' with 'git branch -D'.

Thanks,
Taylor
