Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F37BC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:34:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344306AbjD0We1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:34:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344315AbjD0WeX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:34:23 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F4C40C8
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:33:59 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id EA93F24151;
        Thu, 27 Apr 2023 18:33:56 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1psABY-5cK-00; Fri, 28 Apr 2023 00:33:56 +0200
Date:   Fri, 28 Apr 2023 00:33:56 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sequencer: rectify empty hint in call of
 require_clean_work_tree()
Message-ID: <ZEr4VKMPSYZZxgIM@ugly>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren <newren@gmail.com>
References: <20230323162234.995514-1-oswald.buddenhagen@gmx.de>
 <ZEorMhPZRL/w4yKM@ugly>
 <xmqqmt2thvuu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqmt2thvuu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 27, 2023 at 02:13:29PM -0700, Junio C Hamano wrote:
>I think the right fix would be more like the attached patch, which
>will fix any other callsites that pass "" at the same time.  Of
>course, you can fix the callers on top, but that is secondary.
>
there is only that one incorrect (in-tree) call.
i don't think that making the behavior more compliant with the shell 
implementation is particularly elegant or even useful.
if i wanted to be super-pedantic about it, i'd assert that non-null 
strings are non-empty. but that would only help if all error paths 
actually have test coverage.

>--- i/wt-status.c
>+++ w/wt-status.c
>@@ -2650,7 +2650,7 @@ int require_clean_work_tree(struct repository *r,
> 
>-		if (hint)
>+		if (hint && *hint)
> 			error("%s", hint);

-- ossi

