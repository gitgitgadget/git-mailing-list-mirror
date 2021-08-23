Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9510C432BE
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 08:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEF16103D
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 08:21:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbhHWIVr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235473AbhHWIVr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 04:21:47 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6FAC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 01:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=syFJmaFdhShb9ATCCLwXuF7ZM5bx3fMA54ANQKe+IgA=;
        t=1629706864; x=1630916464; b=qLFYNd501l6uWHagcJlzUzlSNlkvFd+yURx/YhBZUgEgKYs
        1TGMV/pD/j8vF39xZqMrmtkKXXTOl3pZ/h8X83QS0Iz5oXPaVQmMNYQaYYmJBKkkKduKFs272KVba
        bGvjeX+MsYI8LCyVFazv5CZjLriU77E5Rl/BjiCuhiDhq5O9E87HqpqatNDDuBLcWUYGjQ8Uuu3gM
        ymsD27/lvDQd3D97uBkdH451h03wF4WnE9xliuUgu5bzl3GqaKtEo3gTn2ED1m3f2qJsSG7DjEC1n
        V0UizkUN698axOJJrYj3zF2y8NscBWiiZZNcuGbNSMj40fY/85b4NXu2wUofSJqw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mI5CY-00ElY8-Cy; Mon, 23 Aug 2021 10:21:02 +0200
Message-ID: <dc146642f6aa9ac49d02cca47779071258e7541e.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] multi-pack-index: allow operating without pack files
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Martin Fick <mfick@codeaurora.org>,
        Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, bup-list@googlegroups.com
Date:   Mon, 23 Aug 2021 10:21:00 +0200
In-Reply-To: <3649958.14eQuSAvaI@mfick-lnx>
References: <20210820195558.44275-1-johannes@sipsolutions.net>
         <edb9c412-70c8-4fc6-04ab-417eca05ee15@gmail.com>
         <3649958.14eQuSAvaI@mfick-lnx>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 2021-08-22 at 19:11 -0600, Martin Fick wrote:
> On Sunday, August 22, 2021 8:34:43 PM MDT Derrick Stolee wrote:
> > On 8/20/2021 3:55 PM, Johannes Berg wrote:
> > > Technically, multi-pack-index doesn't need pack files to exist,
> > > but add_packed_git() today checks whether it exists or not.
> > 
> > Having a multi-pack-index is supposed to indicate that we have
> > these objects in the objects/pack directory within the specified
> > pack-files.
> 
> Hmm, isn't it a normal supported use case for repacking to potentially delete 
> packfiles which are in the MIDX (I'm specifically thinking about when someone 
> runs git gc with an older git version which knows nothing about MIDX files)?

Yeah, the multi-pack-index contains all the pack names that are there
(and then which one the object is in), and when git tries to use it,
then it doesn't really seem to have any issues?

You can "git repack -a -d" with an old version, or save the multi-pack-
index temporarily elsewhere and copy it back after repack, and things
work just fine, except of course "git multi-pack-index verify" will
complain loudly.

johannes

