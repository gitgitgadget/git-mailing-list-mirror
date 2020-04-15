Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3C4BC3815B
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80DD7208E4
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:49:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="SB1WVZAB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404236AbgDOPt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2394205AbgDOPtr (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 11:49:47 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57282C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 08:49:47 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id h69so90553pgc.8
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 08:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XBO85Sgs19xdj6xEwtQD7ywAGqa01voccDaN8ekAS2g=;
        b=SB1WVZABd6KoYnJJHCA4thbBinQvDXJprjmuV7EB1jwnS8WMfEcbiPO4GUuArW9qm+
         8Dgr03Yxr8FHYadalIhiXlOXXzsRGDL9UMv0jnpiJF5qZ6EC+TvIn3iIllSFF85b2Rom
         dID3iDu4n4KvMMtwhfNPUXJvffm+BZnWWaW72ofi/zdC+aYrdUJqEw+ejbqqY5jkoBNs
         quXIg+Lcpx9s3eYWm9Y5tuUKh1XuH96dt6/S1O/0tj/aOvuHemsBNKqWnUBT92e/D1/8
         2pNjPJW1m2sRgY5XOIQeoRGmDQKmyTaxn06yMgc+/dJHsWseicE+oNQYeooo0wYX+PmE
         zfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XBO85Sgs19xdj6xEwtQD7ywAGqa01voccDaN8ekAS2g=;
        b=B/SjIa7z2uLMEC9v2BWbXW/X4G2fBZ+YbIX/6wbo+tRupQx8nGq+8ruFle1wVW8s5u
         Ul/MQ2rsFgNrWYp8LFgxJ8Id7SrIH8hlqKxcsU45BbXDuUmzAbV8hfvSaERL9eDnx0dr
         nZ7orKDTKpBCEqzm/RnotoLahIFQ8vRedmnGLgLciT+PAKvFFR+aA3VHQX0zwel264+z
         ww9e+pvzIBJgiiaTqqf1cH/zGF5HzBwnvGLafvpDvQeHiX0JmJ716FW1pfEnjReVdHJa
         SfdJ5saIHYtxVD4f1MByGdA6rbRLQc1CPTJK6UNRViAurIDCZYlbTBVRX9eyc9CI1729
         +blQ==
X-Gm-Message-State: AGi0PuZh5u2DSHtdCOugJGtROiFoVVhN1I/DvipSBdMX92bGmT5tRQ1S
        VvQE4mh/F8oDFiiuIDfeq9u6vg==
X-Google-Smtp-Source: APiQypKv13lkPWTCqUaWBI+eKMkL34aPqSdx9RxsD1ZPPkN+rkbuhON9gfNCUGCfVdxggI6muSRFoQ==
X-Received: by 2002:a62:6dc6:: with SMTP id i189mr29076326pfc.30.1586965786350;
        Wed, 15 Apr 2020 08:49:46 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id j10sm3033844pfa.57.2020.04.15.08.49.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 08:49:45 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Wed, 15 Apr 2020 09:49:44 -0600
To:     Jeff King <peff@peff.net>
Cc:     "Kerry, Richard" <richard.kerry@atos.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>, newren@gmail.com
Subject: Re: Move some files, with all history, from one project into a new
 one
Message-ID: <20200415154944.GA22823@syl.local>
References: <AM0PR02MB3715F9566BD9FEFAF832F0749CDB0@AM0PR02MB3715.eurprd02.prod.outlook.com>
 <20200415151128.GA2464307@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200415151128.GA2464307@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 11:11:28AM -0400, Jeff King wrote:
> On Wed, Apr 15, 2020 at 08:31:35AM +0000, Kerry, Richard wrote:
>
> > I would like to move some files, from the project in which they have
> > always resided into  a new project.  I would like to keep all their
> > history.  I don't want to waste space by also moving the rest of the
> > old project's history, or historical file contents.
>
> Try git-filter-branch's --subdirectory repository, which is designed to
> do exactly this.
>
> Or the much newer (and faster) git-filter-repo:
>
>   https://github.com/newren/git-filter-repo

For what it's worth, Elijah has provided some excellent documentation on
how to use git-filter-repo to do exactly this here:

  https://github.com/newren/git-filter-repo#solving-this-with-filter-repo

Thanks,
Taylor
