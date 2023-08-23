Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43916EE49B0
	for <git@archiver.kernel.org>; Wed, 23 Aug 2023 09:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233227AbjHWJ6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 05:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbjHWJ6V (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 05:58:21 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A2C593
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 02:58:19 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id B998823E25;
        Wed, 23 Aug 2023 05:58:17 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qYkcz-v7q-00; Wed, 23 Aug 2023 11:58:17 +0200
Date:   Wed, 23 Aug 2023 11:58:17 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 2/3] setup: add discover_git_directory_reason()
Message-ID: <ZOXYOWf/Vqfslmv4@ugly>
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
 <pull.1569.v2.git.1692725056.gitgitgadget@gmail.com>
 <787af0f9744e2f18c9ab680886650278a9d2f8d0.1692725056.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <787af0f9744e2f18c9ab680886650278a9d2f8d0.1692725056.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 22, 2023 at 05:24:14PM +0000, Derrick Stolee via GitGitGadget wrote:
>From: Derrick Stolee <derrickstolee@github.com>
>
>There are many reasons why discovering a Git directory may fail. In
>particular, 8959555cee7 (setup_git_directory(): add an owner check for
>the top-level directory, 2022-03-02) added ownership checks as a
>security precaution.
>
>Callers attempting to set up a Git directory may want to inform the user
>about the reason for the failure. For that, expose the enum
>discovery_result from within setup.c

>and
>
"by moving it"

>into cache.h where
>discover_git_directory() is defined.
>
>I initially wanted to change the return type of discover_git_directory()
>to be this enum, but several callers rely upon the "zero means success".
>The two problems with this are:
>
>1. The zero value of the enum is actually GIT_DIR_NONE, so nonpositive
>   results are errors.
>
>2. There are multiple successful states; positive results are
>   successful.
>
>It is worth noting that GIT_DIR_NONE is not returned, so we remove this
>option from the enum. We must be careful to keep the successful reasons
>as positive values, so they are given explicit positive values.

>Further, a use in scalar.c was previously impossible, so it is removed.
>
i have no clue wha this means. what is "it"?

>Instead of updating all callers immediately, add a new method,
>discover_git_directory_reason(), and convert discover_git_directory() to
>be a thin shim on top of it.
>
is this really worth it, given that there are just two callers, and the 
adjustment is trivial?
if you insist, note that the function name can be easily misread as 
"discover_git_(directory_reason)", which is unhelpful. i typically use 
an _impl suffix in such "thin wrapper" scenarios.

regards

