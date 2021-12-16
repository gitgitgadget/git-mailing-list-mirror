Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AB4C433EF
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 16:36:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbhLPQgF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 11:36:05 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:46136 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbhLPQgE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 11:36:04 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2021 11:36:04 EST
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.talktalk.net with SMTP
        id xtblmhEwgZPiSxtbmmp5s4; Thu, 16 Dec 2021 16:27:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1639672074;
        bh=+TSdMrWGlH1zY0u4VZtyrH4Q3RysxdMd/cz3+9e8nXw=;
        h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
        b=AxevQbnyydv50AkzRhmEjq9bCj9M+m0OPbd/vnPmN6JYxs2EMqzeD8SVjO791Ks0E
         nUzU4awHgz3pyz+9+ZfNJY8oLKgRo/Nd1D2k1ikFeAP+yqmCZTHWyj8iM4MSyXxWZn
         IIKXjIAUAyMN6aWQEcUCgFH0ovnhlfLzne4yU+f4=
X-Originating-IP: [31.185.185.186]
X-Spam: 0
X-OAuthority: v=2.3 cv=Ocnm8SbY c=1 sm=1 tr=0 a=cyf1aFqS4hLwOm3hvqIP/A==:117
 a=cyf1aFqS4hLwOm3hvqIP/A==:17 a=IkcTkHD0fZMA:10 a=uPZiAMpXAAAA:8
 a=JCK6tMZDO0qPIXyw1OsA:9 a=QEXdDO2ut3YA:10
Message-ID: <e6adaad6-f6ee-57d3-dc8f-d14a760c57c2@talktalk.net>
Date:   Thu, 16 Dec 2021 16:27:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: bug?: ORIG_HEAD incorrect after reset during git-rebase -i
Content-Language: en-GB-large
To:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
References: <CA+JQ7M-ynq1cLN-3ZodXae=x-H5k7Ab6uPBwUFhG+kgtOvCgtA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
In-Reply-To: <CA+JQ7M-ynq1cLN-3ZodXae=x-H5k7Ab6uPBwUFhG+kgtOvCgtA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfJBJt8PepKqE83EFp05p6maLGNxyZb86JjdqHy1azDKGjifzZtAatuwU/FJDpHU0DLR8EgdkiPP9Gv54ZZ3O0VjOdednv7V4gszKPh+R9qmXQ2awtCbm
 X+bbYH+sqDXacgrxjDPCGRssEnQcCfJnFEhTQo7CFGulIIukQM9NT+5tTZMdFqFx0vkFCQB0O4mE7iHuO2SFKv5HLBajOTIv77g=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erik

On 16/12/2021 14:30, Erik Cervin Edin wrote:
> Steps to reproduce:
> 1. git-rebase -i
> 2. edit XYZ
> 3. git-reset HEAD~

"git reset" will update ORIG_HEAD to the current HEAD before resetting 
so here ORIG_HEAD gets updated to point to XYZ

> 4. git-commit -C ORIG_HEAD -a
> 5. git-rebase --continue
> 6. git-show ORIG_HEAD
> 
> Expected behavior:
> ORIG_HEAD should point at the previous HEAD of the rebased branch
> 
> Actual behavior:
> ORIG_HEAD points to XYZ
> 
> My understanding from reading https://stackoverflow.com/a/64949884 is
> that this is incorrect behavior.
> 
> Perhaps this is as intended but I would at least personally prefer
> that ORIG_HEAD would point to the previous HEAD of the rebased branch.

You can use the reflog to get the previous HEAD of the rebased branch 
after rebasing. Immediately after the rebase branch-name@{1} will point 
to the pre-rebase HEAD.

Best Wishes

Phillip


> Seen in:
> git version 2.31.1.windows.1
> 
> Possibly related to
> e100bea481 - rebase -i: stop overwriting ORIG_HEAD buffer

