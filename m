Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AEDB1F403
	for <e@80x24.org>; Thu, 14 Jun 2018 20:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754833AbeFNU26 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 16:28:58 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:47324 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754749AbeFNU25 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 16:28:57 -0400
X-Greylist: delayed 349 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jun 2018 16:28:57 EDT
Received: from [88.130.56.254] (helo=book.hvoigt.net)
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <hvoigt@hvoigt.net>)
        id 1fTYmw-0007MV-SH; Thu, 14 Jun 2018 22:24:10 +0200
Date:   Thu, 14 Jun 2018 22:24:09 +0200
From:   Heiko Voigt <hvoigt@hvoigt.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     pclouds@gmail.com, git@vger.kernel.org, kaartic.sivaraam@gmail.com
Subject: Re: [PATCH] submodule: fix NULL correctness in renamed broken
 submodules
Message-ID: <20180614202409.GC2686@book.hvoigt.net>
References: <CACsJy8Ab3HoVWSWOtCBRYcsnnHnpO-2oEfV60f=H15RuzwpWwQ@mail.gmail.com>
 <20180614173107.201885-1-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180614173107.201885-1-sbeller@google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jun 14, 2018 at 10:31:07AM -0700, Stefan Beller wrote:
> When fetching with recursing into submodules, the fetch logic inspects
> the superproject which submodules actually need to be fetched. This is
> tricky for submodules that were renamed in the fetched range of commits.
> This was implemented in c68f8375760 (implement fetching of moved
> submodules, 2017-10-16), and this patch fixes a mistake in the logic
> there.
> 
> When the warning is printed, the `name` might be NULL as
> default_name_or_path can return NULL, so fix the warning to use the path
> as obtained from the diff machinery, as that is not NULL.
> 
> While at it, make sure we only attempt to load the submodule if a git
> directory of the submodule is found as default_name_or_path will return
> NULL in case the git directory cannot be found. Note that passing NULL
> to submodule_from_name is just a semantic error, as submodule_from_name
> accepts NULL as a value, but then the return value is not the submodule
> that was asked for, but some arbitrary other submodule. (Cf. 'config_from'
> in submodule-config.c: "If any parameter except the cache is a NULL
> pointer just return the first submodule. Can be used to check whether
> there are any submodules parsed.")
> 
> Reported-by: Duy Nguyen <pclouds@gmail.com>
> Helped-by: Duy Nguyen <pclouds@gmail.com>
> Helped-by: Heiko Voigt <hvoigt@hvoigt.net>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---

Looks good to me.

Cheers Heiko
