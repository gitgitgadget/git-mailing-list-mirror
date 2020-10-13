Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07349C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83ED8206DD
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 09:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="IUvT9CC8";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="IUvT9CC8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgJNJZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 05:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbgJNJTj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:39 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92273C08EBB2
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 16:45:21 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id 0F7D9110AD48; Wed, 14 Oct 2020 01:45:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602632720; bh=6hQET4n6q06RnTQVv5sBZ9O8KTh9+SdZ2yx00xNTBoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUvT9CC8fw3AFQ0/4oj5wY7AqxjzPwq7YvPRjgJYsM/TMPlrbPqr9lGcvZM80Loko
         da2RJVIjqtES67/QbzO+KkFvAVFQQNieRcyTL9A/juqyHBEs7sdxX7GczTctcP5Xi3
         5f3T9kerG5g5D/Rgu95XOIP4o+QqdTayX6vc2/gg=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id BDB08110AD45;
        Wed, 14 Oct 2020 01:45:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602632720; bh=6hQET4n6q06RnTQVv5sBZ9O8KTh9+SdZ2yx00xNTBoM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IUvT9CC8fw3AFQ0/4oj5wY7AqxjzPwq7YvPRjgJYsM/TMPlrbPqr9lGcvZM80Loko
         da2RJVIjqtES67/QbzO+KkFvAVFQQNieRcyTL9A/juqyHBEs7sdxX7GczTctcP5Xi3
         5f3T9kerG5g5D/Rgu95XOIP4o+QqdTayX6vc2/gg=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id A5C291420A8F; Wed, 14 Oct 2020 01:45:19 +0200 (CEST)
Date:   Wed, 14 Oct 2020 01:45:19 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
Message-ID: <20201013234519.73grqc2kkybccryf@fastboi.localdomain>
References: <20201012234901.1356948-1-samuel@cavoj.net>
 <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
 <xmqqy2k9ixvz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2k9ixvz.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On 13.10.2020 15:06, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> >>   +test_expect_success 'rebase -r, GPG and merge strategies' '
> >> +	git reset --hard merged &&
> >> +	git rebase -fr --gpg-sign -s resolve --root &&
> >> +	git verify-commit HEAD
> >> +'
> >
> > Unfortunately I've just noticed that the test above runs
> >
> > 	git config commit.gpgsign true
> >
> > So this test would pass anyway if merge picks up that config
> > setting. The previous test needs to be changed to
> >
> > 	test_config commit.gpgsign true
> >
> > so that the config setting is cleared when that test finishes.
> 
> Thanks for a review, but I do not think that is a right way to go.
> 
> test_config has an inherent assumption that not having the config at
> all is somehow the "natural" state, and if that holds true, that
> would be OK.  But what is "natural" is subjective X-<.
> 
> The way each test is run by calling test_rebase_gpg_sign repeatedly
> uses a different and more robust approach to ensure that previous
> test does not affect the current one.  Each invocation of test
> explicitly sets the configuration to the state the test wants to,
> cancelling what the previous test did.
> 
> To blend in better with existing tests and match their robustness
> expectations, the right fix is for this new test to explicitly use
> "git config --set" or "git config --unset" to make the variable into
> the desired state, regardless of what the previous tests did.  

This is more or less what I did in v3, although not completely
comprehensively. Of course, the test_rebase_gpg_sign function could be
either duplicated or modified to be more generic in order to accommodate
all combinations for the new tests, though I considered this not worth
doing. I am open to it, however.

I'm unfamiliar with the git codebase and the testing practices, so a
little hand-holding might be needed, I hope that's not a bother for you.

In addition, I have replaced `git config` usages with `test_config`, not
sure if that should be reverted -- I see no harm in using it, and I
guess it is slightly more explicit.

Speaking of v3, I pulled the trigger a little too fast on that one,
should have waited a little longer for feedback. Sorry about that.

Though, I am not sure what has happened to it. I sent it out in the
usual manner, but it hasn't appeared in any of the mailing list
archives. Can you please confirm (or deny) that you have received it?
In case not, should I just send it again, with the same Message-Id's?
All the recipient mail servers responded with a 250 Ok from my postfix
logs.

Thank you for all the help.

Regards,
Samuel

> 
> If the test quoted at the beginning of this message wants to make
> sure that --gpg-sign from the command line takes effect without
> commit.gpgsign set, it should unset the variable explicitly.
> Another combination worth testing is to ensure that --gpg-sign takes
> effect when commit.gpgsign is explicitly set to false (not "left
> unset").
> 
> Thanks.
> 
