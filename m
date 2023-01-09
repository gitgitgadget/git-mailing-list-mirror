Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37FF2C54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 20:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbjAIUHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 15:07:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237301AbjAIUHs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 15:07:48 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B2141AD88
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 12:07:48 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 93D75CA1248;
        Mon,  9 Jan 2023 15:07:47 -0500 (EST)
Received: from [IPV6:2600:1700:840:e768:8902:4d8e:1b37:eec2] (unknown [IPv6:2600:1700:840:e768:8902:4d8e:1b37:eec2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6730DCC83BE;
        Mon,  9 Jan 2023 15:07:47 -0500 (EST)
Message-ID: <18a11fc5-ab72-a66a-6bef-7e460c762a9c@jeffhostetler.com>
Date:   Mon, 9 Jan 2023 15:07:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: How to debug "fatal: external diff died, stopping at ..."?
Content-Language: en-US
To:     Sebastian Schuberth <sschuberth@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <CAHGBnuOcNb0niPThM9gtmoJui+bz1mmhKXjUn71P3Q53aM-HLA@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
In-Reply-To: <CAHGBnuOcNb0niPThM9gtmoJui+bz1mmhKXjUn71P3Q53aM-HLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: mailmunge 3.10 on 209.68.5.199
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/9/23 8:35 AM, Sebastian Schuberth wrote:
> Hi,
> 
> similar to this [1] question on StackOverflow, ever since a
> distribution upgrade of my Fedora Linux box (KDE spin, now on release
> 37), my configured diff / merge tool (Beyond Compare 4) crashes with
> "fatal: external diff died, stopping at ..." after displaying the diff
> for the first file, for every operation I've tried so far (including
> resolving merge conflicts). I've also posted to the Beyond Compare
> forums [2], but the people from Scooter Software seem to be clueless
> as well.
> 
> Would anyone have an idea how to debug this?
> 
> PS: I also tried to use an X11 instead of a Wayland session with KDE /
> Plasma, but that did not help.
> 
> [1]: https://askubuntu.com/questions/1437667/git-difftool-with-meld-broken-after-update-to-22-04-fatal-external-diff-died
> [2]: https://forum.scootersoftware.com/forum/beyond-compare-4-discussion/linux-aa/88824-bc4-as-a-git-merge-tool-says-fatal-external-diff-died
> 

You might try turning on Trace2 in Git and see if there is
any extra info there on the child processes.

$ GIT_TRACE2_PERF=1 git difftool ...

or

$ export GIT_TRACE2_PERF=/absolute/path/to/logfile
$ git difftool ...

There you'll be able to see all of the "child_start" and
"child_exit" events for each process that Git starts (at
the "d1" level (and grandchildren at the "d2" level)).

Maybe that'll reveal something.

https://devblogs.microsoft.com/devops/a-deep-dive-into-git-performance-using-trace2/


Hope this helps,
Jeff
