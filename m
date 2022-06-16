Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA057C433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 10:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiFPKUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 06:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiFPKUO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 06:20:14 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 03:20:12 PDT
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F42453E08
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 03:20:12 -0700 (PDT)
X-KPN-MessageId: c16c72d4-ed5d-11ec-92d5-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.40])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id c16c72d4-ed5d-11ec-92d5-005056abbe64;
        Thu, 16 Jun 2022 12:19:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xs4all.nl; s=xs4all01;
        h=content-type:subject:from:to:mime-version:date:message-id;
        bh=eTDWnShJarnPcgrimZKUWy1T+lCoYe4NXA7Rs0IT6Ts=;
        b=FxzB7Rp83T4JiKB1wAP/40HJFtuY9Btb9SAY01T11aijfYXeGIOpv3ef9mmp9jZfTNHW2s5zBYXtC
         h4yKs5k7qo6E9CvEwuiQSR5zZMlTpJGlgHlY+gHSQz2tEW8S+IuA5uVNH+C9UXUBbD7xdmpIjes+nr
         TuNcXLhA6e/cErUTgIxQZUHS1/EpKghZcCodfGIZMaOMUvGxB21UhgJOxNt/GsIVkaXDG8tWdskdad
         jWpMozmPKSivR2I9wqtj3vno4fv0AwIF7MBJcZ8XHnf7SOLHZ8ij7bdKW9+iGqIrMRfbDwBGIX8iyo
         pTf5VyQGBfo/0VvUay4fkrRwdO9gnMA==
X-KPN-MID: 33|1qpYul8kLcQJ8URnPVWRSJueapo+4HVURYDVdQl90Rkpe1jABDpZWXlR6CdaPZc
 5saWbWyCzG0z3XOKHXrOuCU19UherNc/4b3vbxF9dBUY=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|XuJisk4uRdYu9Htp547fmvLXxthDdWM5MIrlEZygH5PxuCgtqMh6NJY3bd1qlX4
 JApZCTr0nksvACYd/6nizlQ==
X-Originating-IP: 77.172.39.203
Received: from [192.168.178.31] (77-172-39-203.fixed.kpn.net [77.172.39.203])
        by smtp.xs4all.nl (Halon) with ESMTPSA
        id c1e7f446-ed5d-11ec-9eb8-005056ab7584;
        Thu, 16 Jun 2022 12:19:08 +0200 (CEST)
Message-ID: <da79cc66-42a0-2563-d09b-fbc0ad5b28bd@xs4all.nl>
Date:   Thu, 16 Jun 2022 12:19:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
To:     git@vger.kernel.org
Content-Language: en-US
From:   Dennis van Gerwen <dvg@xs4all.nl>
Subject: Feature Request: Custom split location for `git add --patch`
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

L.S.

Please consider this feature request for interactive staging in patch 
mode, using [`git add --patch`][1].

## Problem

If a hunk cannot be split automatically, the `s` (split) option 
disappears from the list of options, and we get:

 > (1/6) Stage this hunk [y,n,q,a,d,j,J,g,/,e,?]? s
 > Sorry, cannot split this hunk


See for example these questions on StackOverflow: [2], [3]

I am aware that this problem can be solved by using the [`--edit` 
option][4] to edit the hunk, as explained in the docs under [editing 
patches][5].

However, if we have a large contiguous hunk, and we only want to split 
at one specific location, using `--edit` can be quite cumbersome, 
because (as far as I know) we need to edit all the lines that we do not 
want to stage.

## Feature request

Would it be possible to add a "custom split location" feature, allowing 
the user to specify where a contiguous hunk should be split?

Some options:

- Always show the `s` (split hunk) option, and let the user specify a 
line number if an automatic split cannot be made.

- Add a new [patch option][6], in addition to `s` (split hunk), to split 
any hunk at a custom location.

- Add a new operation for editing patches, for example "s" (in addition 
to "+", "-", and " "), indicating where to split (e.g. "split after this 
line"). This way the user only needs to modify a single line in edit mode.

I'm sure there are a lot of nasty details to consider, but I do think 
such a feature would be very convenient.

Thanks for your help,

Dennis

[1]: https://git-scm.com/docs/git-add#Documentation/git-add.txt---patch
[2]: https://stackoverflow.com/q/6276752
[3]: https://stackoverflow.com/q/56892981
[4]: https://git-scm.com/docs/git-add#Documentation/git-add.txt---edit
[5]: https://git-scm.com/docs/git-add#_editing_patches
[6]: https://git-scm.com/docs/git-add#Documentation/git-add.txt-patch

