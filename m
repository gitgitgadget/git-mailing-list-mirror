Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A50C6FD1D
	for <git@archiver.kernel.org>; Mon, 20 Mar 2023 08:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjCTImZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Mar 2023 04:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjCTImW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2023 04:42:22 -0400
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAC4D31C
        for <git@vger.kernel.org>; Mon, 20 Mar 2023 01:42:20 -0700 (PDT)
Received: from [192.168.42.163] (8-99-142-46.pool.kielnet.net [46.142.99.8])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id D69A43C105B;
        Mon, 20 Mar 2023 09:42:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1679301739;
        bh=frPNYOufBGfL1uEFosAvbL2jJJ3k62FXl+NQTE3ssdw=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=Sq1fxsMob/dRvsdaPOkZV/v+tg33MEuXlmNyAdofjs+B0Jhz/pNnFIo4dAd+NKJJ+
         G5432WtJZQ5DONIqkwQMapRLTtJrlGZKEyCSxNKq6Qmj8iG7W4k9mRYCNWw6ewgQs0
         hWKVPSrPQmys0CrYKJpLk2WYXRNMBglw0jMenUGQbGlhzcQBp45S60u/iK6kv1SH8O
         fEbdSp/8AGR8GPkOeXMy2e/8epB7zTCVRDawi6sKilEFuK1WTTbf+Den5cw9Gb3C+u
         VcW4ngN1PQsQ6VrBJVQGtZ0HBDx5BSz4k7LP6QUDah4Q5Yc9jAYlj9bf6N+0/luPfe
         SBseOyxgWRH1w==
Message-ID: <66bcf561-b604-db2b-fa0c-fa9fbc379562@haller-berlin.de>
Date:   Mon, 20 Mar 2023 09:42:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
From:   Stefan Haller <lists@haller-berlin.de>
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
 <3ab454f1-2bb5-d990-4cc4-4e2fde2ba294@haller-berlin.de>
 <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
 <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
 <4d13d02a-ddaf-7b8f-7a27-c7a030816523@haller-berlin.de>
 <722659e9-02ac-a9d2-b0fd-b9a2a3d85753@dunelm.org.uk>
 <805626af-b147-d3cf-5257-a5b90b7cf1d9@haller-berlin.de>
 <f7577c57-f70d-cca3-3f25-18525d40d79b@dunelm.org.uk>
 <0eb3ed02-139a-b114-939a-d2ad286af743@dunelm.org.uk>
 <1e943dab-23c7-9eed-df4c-c89084d2387b@haller-berlin.de>
In-Reply-To: <1e943dab-23c7-9eed-df4c-c89084d2387b@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Bar: /
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20.03.23 08:29, Stefan Haller wrote:
> Ah, thanks for coming up with this tricky case. I'm leaning towards
> simply ignoring it, since (at least for my usage of git) it's very
> uncommon; if I use "-x make test" to check all commits, I almost always
> do that in place, so I won't get conflicts.

On the other hand, it seems easy enough to do it properly, so why not.
Something like this:

  num_done := len(done)
  is_rescheduled :=
     # for new versions of git:
     done[num_done - 1] == todo[0]
     # for older versions of git:
     || (num_done >= 3
         && done[num_done - 2] == todo[0]
         && done[num_done - 1] == done[num_done - 3])

Could I be missing any other cases with this logic?

-Stefan
