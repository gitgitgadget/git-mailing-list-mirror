Return-Path: <SRS0=KYeX=53=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8A4C2BBC7
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6891820936
	for <git@archiver.kernel.org>; Sat, 11 Apr 2020 21:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgDKVkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Apr 2020 17:40:19 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:16846 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgDKVkS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Apr 2020 17:40:18 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4907b51Hkfz5tlB;
        Sat, 11 Apr 2020 23:40:17 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 545662817;
        Sat, 11 Apr 2020 23:40:16 +0200 (CEST)
Subject: Re: configure remote/local as mine/theirs
To:     rupert THURNER <rupert.thurner@gmail.com>
References: <CAJs9aZ-iXUtZoumnMzTFPrc=mtz2+s4EDUKhxw_KQp42h3mxBw@mail.gmail.com>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Message-ID: <facf8152-00ce-4878-a13b-3fe72c13fa25@kdbg.org>
Date:   Sat, 11 Apr 2020 23:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAJs9aZ-iXUtZoumnMzTFPrc=mtz2+s4EDUKhxw_KQp42h3mxBw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.04.20 um 14:51 schrieb rupert THURNER:
> the git documentation is so clear withcalling changes "mine" or
> "theirs". when configuring a mergetool e.g. kdiff3, and doing a
> rebase, these names are not used. instead it is "local", which
> is theirs in the rebase case, and remote, which is mine. not
> that this is rocket science, and i understand the technical
> reason why the names are like this. but anyway i get a nod in
> my brain about it sometimes. can i somehow configure git so it
> would use "mine" and "theirs" only?

The words "mine" (actually "ours") and "theirs" have a very precise
meaning in Git. If you were to use these meanings during a rebase, you
would not like the result: it would call "ours" what you intend to call
"theirs", and vice versa.

Consider this history:


--a--b--c--d   <-- upstream ("theirs" from your point of view)
   \
    x--y--z    <-- branch to rebase ("mine/ours" from your POV)

During a rebase, Git is "positioned" on the history following commit d,
i.e. on "their" branch. Then it cherry-picks commits x, y, and z. In
that situation, the change that you consider "theirs" is actually "ours"
from Git's point of view, and your own change (those introduced by x, y,
and z) are "theirs" from Git's point of view.

I suggest you live with "local" and "remote" for a bit less confusion.

-- Hannes
