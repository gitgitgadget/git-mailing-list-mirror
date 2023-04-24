Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2B0C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 20:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjDXUFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 16:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbjDXUFm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 16:05:42 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BAD1FE6
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 13:05:39 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <admin@game-point.net>)
        id 1pr2RL-00EcLm-CU; Mon, 24 Apr 2023 22:05:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=game-point.net; s=selector2; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject;
        bh=k+Y+NO+lMTI4ksZIOltFf+LC0rFo5YOUE8FWnoMO4i8=; b=IRFiyvLKSkvx71ORxpwMjk9PKB
        4C6GdzVAGcpPDeJKusQYgj85zbOXX2j1m8+ujq7Kh7sOWpQAtAMi5fsUSZlvVd4xAw3yhkmpAsHog
        Cv8zGatjX8v/TwAVZjf6QRx5P1gk/Akb3jWjV9ppx2BS5RzOYqpu8kSY9wK7nzvQ1uEXaxEhvkYAL
        mnHYxuT/5EfWt3MxEg3YXiAGCfOosIOTBwaUM+n4rvOwQnjsboh8zSntONVrPF3NgJ+1juNmb6CCl
        pr0mWSsiHMzvOaSbIiZY/bRVyBH0kXyPstPZ9gSkriZZIxp2eCmsllzPPFgjrSX2XfEyrpciI8/XV
        ihnGMq6g==;
Received: from [10.9.9.73] (helo=submission02.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <admin@game-point.net>)
        id 1pr2RK-0004dj-S3; Mon, 24 Apr 2023 22:05:35 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (956903)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1pr2RH-0004cB-9q; Mon, 24 Apr 2023 22:05:31 +0200
Subject: Re: Proposal: tell git a file has been renamed
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <8fe188a9-c01f-9fb5-5877-8ff508094b22@game-point.net>
 <xmqq8rehdq4m.fsf@gitster.g>
From:   Jeremy Morton <admin@game-point.net>
Message-ID: <f5d21df1-2f52-8d19-4d2d-fa25ce9efbdc@game-point.net>
Date:   Mon, 24 Apr 2023 21:05:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:60.0) Gecko/20100101
 Firefox/60.0 SeaMonkey/2.53.1
MIME-Version: 1.0
In-Reply-To: <xmqq8rehdq4m.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

But if you were doing, say, a git blame for a file, you'd be able to 
see the commits where its lines were actually last modified even 
through the rename, rather than a bunch of them being stopped at the 
"added this file (because it wasn't detected as a rename)" commit, no?

-- 
Best regards,
Jeremy Morton (Jez)

On 24/04/2023 20:41, Junio C Hamano wrote:
> Jeremy Morton <admin@game-point.net> writes:
> 
>> The standard answer for this is to rename the file in one commit, then
>> make the changes.
> 
> Oh, by the way, this is a pure myth that would unlikely be helpful
> in the bigger picture.
> 
> When you rename and heavily modify the resulting new path because
> you have to solve something, such a work would likely be done on the
> same topic branch.  One step of it may be a pure rename, and other
> steps may involve heavily changing the renamed result, or you may
> update the contents in the original and the do a rename at the end,
> but either way, when you integrate the end result of the whole topic
> branch into the master history, what such a merge will see is that
> the original file has disappeared and a new file with contents not
> at all similar to the disappeared file has appeared.  "pure rename
> with changes in separate commits" would have no effect when showing
> such a history with "git log --first-parent -p" for a birds-eye
> view.
> 
> 
