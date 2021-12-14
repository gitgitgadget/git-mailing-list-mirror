Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E413DC433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 22:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234117AbhLNWgH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 17:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhLNWgG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 17:36:06 -0500
Received: from adoakley.name (adoakley.name [IPv6:2a01:4f8:c17:1310::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB8AC061574
        for <git@vger.kernel.org>; Tue, 14 Dec 2021 14:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=adoakley.name; s=2018; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6WzDUVhDP2O0csniSCz7y8chk6DWhQ8LTKhu60sUWAw=; b=jGvOzPUtikXbcMuKywrWkn/Flj
        1iWCK2o6yBmm93O3NueKovzJPVsDruL0oD+KM8YGIcp/GAA0JlBa6ROR4xw/FSxAOS+tzcCf0h3NI
        MwP7TLqqMyuEG60EyDkxHDaI+7kwnNR/0rZwgCuXSkx9DmFNPfe2E3EJkcIUN9Q27N0Q=;
Received: from [2001:8b0:14bb:e93a:fd4f:6f72:643:f027] (helo=ado-tr.dyn.home.arpa)
        by adoakley.name with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93.0.4)
        (envelope-from <andrew@adoakley.name>)
        id 1mxGOy-00019m-3y; Tue, 14 Dec 2021 22:36:04 +0000
Date:   Tue, 14 Dec 2021 22:36:01 +0000
From:   Andrew Oakley <andrew@adoakley.name>
To:     Joel Holdsworth <jholdsworth@nvidia.com>
Cc:     git@vger.kernel.org,
        Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>,
        Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH 0/4] git-p4: fix RCS keyword processing encoding errors
Message-ID: <20211214223601.420d8b54@ado-tr.dyn.home.arpa>
In-Reply-To: <20211213225441.1865782-1-jholdsworth@nvidia.com>
References: <20211213225441.1865782-1-jholdsworth@nvidia.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Dec 2021 22:54:37 +0000
Joel Holdsworth <jholdsworth@nvidia.com> wrote:

> This patch-set fixes a family of issues with git-p4's handling of
> incoming text data that contains RCS keywords, when those files
> contain bytes which are invalid UTF-8 codes.
> 
> Among the patches is a fix for the issue, as well as some peripheral
> tidy-ups and improvements to the existing code.

FWIW, these patches look good to me.

I spent a while trying to understand exactly how perforce handles the
keyword expansion stuff a few years ago.  Other quirks which I can
remember are:
- Files with a filetype of "utf16" files get expanded before we see
  them.  If we want to support that in git-p4 then I think some special
  handling will be required.
- Lines longer than lbr.rcs.maxlen at time of commit are not considered
  to be keyword expansions.  I don't think there is any way to handle
  this, but hopefully it won't ever occur in practice.

I'm not suggesting that these issues need to be solved as part of this
set of patches, just thought that you might want to be aware that there
are some more unsolved issues here.

Thanks
