Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315E4C433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 03:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AC7060FED
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 03:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234119AbhIPDe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 23:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbhIPDe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 23:34:59 -0400
Received: from tilde.club (ipv6two.tilde.club [IPv6:2607:5300:61:c67::196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6262C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 20:33:39 -0700 (PDT)
Received: from tilde.club (unknown [185.31.175.220])
        by tilde.club (Postfix) with ESMTPSA id 181EB22115B59;
        Thu, 16 Sep 2021 03:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 181EB22115B59
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1631763216; bh=EVxxGVfG+Vi8vUatfEd7T1s4C9OutLCaVQTfDAJOkAg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C0J8uhQTfR3IZ19v+0EMvy58oTQFtuAzH4PlGh1L9tP5z23osn9WgL8SI6ofErf/S
         iOWXxf4lvMeWk/cfmyXW4qxGFn4Bjj3zHKCLDZFs6wiiGBNTrnthr4P6knTbm5ZXNB
         fzHBu0lgtcKhBsjP9BEy76XleFb4dPr+0gDEIx0A=
Date:   Thu, 16 Sep 2021 03:33:26 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/2] (experimental) diff --quote-path-with-sp
Message-ID: <YUK7Bl9uzNE1YErg@tilde.club>
References: <20210915223316.1653443-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210915223316.1653443-1-gitster@pobox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-09-15 15:33:14-0700, Junio C Hamano wrote:
> Long time ago, we had a discussion with GNU patch/diff maintainer
> and agreed that pathnames with certain "difficult" bytes needs to be
> quoted to ensure the resulting patch is machine parseable in an
> unambiguous way [*1*].  Recently, we saw a report that found that
> GNU patch is unhappy with our diff output for a path with SP in it
> [*2*].
> 
> With this experimental option, the beginning part of the patch
> output will have pathnames with SP in them enclosed inside a pair of
> double quotes, like so:
> 
> 	diff --git "a/A Name" "b/A Name"
> 	--- "a/A Name"
> 	+++ "b/A Name"

I believe GNU patch is fine with unquoted spaces in the "--- a/path"
and "+++ b/path", and only has an issue with unquoted spaces in the
"diff --git" line. busybox patch does seem to have an issue with quoted
filenames in the "---" and "+++" lines but is fine if those lines are
unquoted. Maybe we could leave spaces unquoted in those lines, only
quoted if there's some other character that needs it.
