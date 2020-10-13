Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007B3C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 10:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F228208D5
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 10:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="BYFFF/yk";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="BYFFF/yk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgJMKwD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 06:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJMKwD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 06:52:03 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDEBC0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 03:52:02 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id A1BDB1107FE6; Tue, 13 Oct 2020 12:52:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602586321; bh=r/ckRP/BoloxlfYV0ns5Vj7uhWqK4fvr31U7PrPJj+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYFFF/ykDhVklkjxSdkOvoLTQLc/gs7XOSl6bQ5O/mNuRKBnGRMqsp/wo+agCZOmr
         ciRGomXQwgazAo/2YXJa2zmSobtk8aYtRefXFW/2hwdIkfwHh0h7qFdH5WFgJ6ThWw
         6fPQQ1+6rNbcHslJ5kC43oi/TSoUuwf/wAAa+jJY=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 25FBF1107FDC;
        Tue, 13 Oct 2020 12:51:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602586321; bh=r/ckRP/BoloxlfYV0ns5Vj7uhWqK4fvr31U7PrPJj+Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYFFF/ykDhVklkjxSdkOvoLTQLc/gs7XOSl6bQ5O/mNuRKBnGRMqsp/wo+agCZOmr
         ciRGomXQwgazAo/2YXJa2zmSobtk8aYtRefXFW/2hwdIkfwHh0h7qFdH5WFgJ6ThWw
         6fPQQ1+6rNbcHslJ5kC43oi/TSoUuwf/wAAa+jJY=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 0EC801420A8F; Tue, 13 Oct 2020 12:51:59 +0200 (CEST)
Date:   Tue, 13 Oct 2020 12:51:59 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
Message-ID: <20201013105159.rfpczn563agvih5y@fastboi.localdomain>
References: <20201012234901.1356948-1-samuel@cavoj.net>
 <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

thank you very much for the feedback.

On 13.10.2020 11:02, Phillip Wood wrote:
> Hi Samuel
> 
> On 13/10/2020 00:49, Samuel Čavoj wrote:
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > 
> > When performing a rebase with --rebase-merges using either a custom
> > strategy specified with -s or an octopus merge, and at the same time
> > having gpgsign enabled (either rebase -S or config commit.gpgsign), the
> > operation would fail on making the merge commit. Instead of "-S%s" with
> > the key id substituted, only the bare key id would get passed to the
> > underlying merge command, which tried to interpret it as a ref.
> > 
> > Fix the issue and add a test case as suggested by Johannes Schindelin.
> > 
> > Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
> > ---
> > changed v1 -> v2:
> >      added test case
> > ---
> >   sequencer.c                | 2 +-
> >   t/t3435-rebase-gpg-sign.sh | 6 ++++++
> >   2 files changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/sequencer.c b/sequencer.c
> > index 00acb12496..88ccff4838 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3677,7 +3677,7 @@ static int do_merge(struct repository *r,
> >   		strvec_push(&cmd.args, "-F");
> >   		strvec_push(&cmd.args, git_path_merge_msg(r));
> >   		if (opts->gpg_sign)
> > -			strvec_push(&cmd.args, opts->gpg_sign);
> > +			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> >   		/* Add the tips to be merged */
> >   		for (j = to_merge; j; j = j->next)
> > diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
> > index b47c59c190..f70b280f5c 100755
> > --- a/t/t3435-rebase-gpg-sign.sh
> > +++ b/t/t3435-rebase-gpg-sign.sh
> > @@ -68,4 +68,10 @@ test_expect_failure 'rebase -p --no-gpg-sign override commit.gpgsign' '
> >   	test_must_fail git verify-commit HEAD
> >   '
> > +test_expect_success 'rebase -r, GPG and merge strategies' '
> > +	git reset --hard merged &&
> > +	git rebase -fr --gpg-sign -s resolve --root &&
> > +	git verify-commit HEAD
> > +'
> 
> Unfortunately I've just noticed that the test above runs
> 
> 	git config commit.gpgsign true
> 
> So this test would pass anyway if merge picks up that config setting. The
> previous test needs to be changed to
> 
> 	test_config commit.gpgsign true

Should I do that now, maybe as a separate part of the patch series? Or
just override the config with a `test_config commit.gpgsign false` in
the test I added?

There is another usage of `git config` in the file, in the
test_rebase_gpg_sign function. 

> 
> so that the config setting is cleared when that test finishes. That previous
> test would then be a good template for testing `rebase -r --no-gpg-sign` if
> you wanted to add a test for that to the next patch as Junio suggested.

Yes, I will definitely do that in v3. Also, the previous test is expect_failure,
that means its a known bug?

Regards,
Samuel

> 
> Best Wishes
> 
> Phillip
> 
> >   test_done
> > 
> 
