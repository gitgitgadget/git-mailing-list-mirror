Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A86DC433E7
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 22:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7EE207BC
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 22:04:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="NjeFgm7i";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="NjeFgm7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439624AbgJQWEU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 18:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439595AbgJQWEU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 18:04:20 -0400
X-Greylist: delayed 112 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 17 Oct 2020 15:04:20 PDT
Received: from lithium.sammserver.com (lithium.sammserver.com [IPv6:2a01:4f8:c2c:b7df::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38635C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 15:04:20 -0700 (PDT)
Received: from mail.sammserver.com (sammserver.wg [10.32.40.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by lithium.sammserver.com (Postfix) with ESMTPS id E4118312B5AC;
        Sun, 18 Oct 2020 00:02:24 +0200 (CEST)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id A34DE112049F; Sun, 18 Oct 2020 00:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602972144; bh=/DrZDLK/2NbCVrXza45wQnzHZFXeKWwjt2sI8jtfGbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjeFgm7iw9T305FRPdu6oNVRhKHCEHUFQ2S0X4neF9xxE1IR46OVeLbKm19ZXUCpK
         MzBJeugwn08YzLdGE+Fj8v93JnZSHSR2oUi0OjHOLn538V7XbERnLqM/uazGuqGFKj
         GwcNtK1Ofe3L5snym4DaWBM91RyMvvDUbhox/Jts=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 56104112049C;
        Sun, 18 Oct 2020 00:02:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602972144; bh=/DrZDLK/2NbCVrXza45wQnzHZFXeKWwjt2sI8jtfGbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NjeFgm7iw9T305FRPdu6oNVRhKHCEHUFQ2S0X4neF9xxE1IR46OVeLbKm19ZXUCpK
         MzBJeugwn08YzLdGE+Fj8v93JnZSHSR2oUi0OjHOLn538V7XbERnLqM/uazGuqGFKj
         GwcNtK1Ofe3L5snym4DaWBM91RyMvvDUbhox/Jts=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 4455F1420A90; Sun, 18 Oct 2020 00:02:24 +0200 (CEST)
Date:   Sun, 18 Oct 2020 00:02:24 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/3] sequencer: pass explicit --no-gpg-sign to merge
Message-ID: <20201017220224.o6fs5ukwqq7sqgrb@fastboi.localdomain>
References: <20201013213021.3671432-1-samuel@cavoj.net>
 <20201013213021.3671432-3-samuel@cavoj.net>
 <xmqqd01jh17n.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqd01jh17n.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 15.10.2020 10:02, Junio C Hamano wrote:
> Samuel Čavoj <samuel@cavoj.net> writes:
> 
> > The merge subcommand launched for merges with non-default strategy would
> > use its own default behaviour to decide how to sign commits, regardless
> > of what opts->gpg_sign was set to. For example the --no-gpg-sign flag
> > given to rebase explicitly would get ignored, if commit.gpgsign was set
> > to true.
> >
> > Fix the issue and add a test case excercising this behaviour.
> >
> > Signed-off-by: Samuel Čavoj <samuel@cavoj.net>
> > ---
> > v2 -> v3:
> >     - added test case
> > ---
> >  sequencer.c                | 2 ++
> >  t/t3435-rebase-gpg-sign.sh | 7 +++++++
> >  2 files changed, 9 insertions(+)
> >
> > diff --git a/sequencer.c b/sequencer.c
> > index 88ccff4838..043d606829 100644
> > --- a/sequencer.c
> > +++ b/sequencer.c
> > @@ -3678,6 +3678,8 @@ static int do_merge(struct repository *r,
> >  		strvec_push(&cmd.args, git_path_merge_msg(r));
> >  		if (opts->gpg_sign)
> >  			strvec_pushf(&cmd.args, "-S%s", opts->gpg_sign);
> > +		else
> > +			strvec_push(&cmd.args, "--no-gpg-sign");
> 
> Makes sense, I guess.  As long as opts->gpg_sign reflects not just
> the command line but also the configuration.  Otherwise, an
> invocation of "git rebase" with no gpg-sign related command line
> options would say "ah, opts->gpg_sign is false, we must have been
> told from the command line not to sign, so pass --no-gpg-sign here"
> and that is not correct.
> 
> > diff --git a/t/t3435-rebase-gpg-sign.sh b/t/t3435-rebase-gpg-sign.sh
> > index 9d2faffa03..773c2a1d72 100755
> > --- a/t/t3435-rebase-gpg-sign.sh
> > +++ b/t/t3435-rebase-gpg-sign.sh
> > @@ -81,4 +81,11 @@ test_expect_success 'rebase -r, GPG config and merge strategies' '
> >  	git verify-commit HEAD
> >  '
> >  
> > +test_expect_success 'rebase -r, --no-gpg-sign and merge strategies' '
> > +	git reset --hard merged &&
> > +	test_config commit.gpgsign true &&
> > +	git rebase -fr --no-gpg-sign -s resolve --root &&
> > +	test_must_fail git verify-commit HEAD
> > +'
> 
> I think that before this patch, we've tested the "no command line
> option, but configuration tells us to sign" combination already to
> make sure the result is signed, so this new test is sufficient.
> 
> I briefly wondered if "test_must_fail git verify-commit" sufficient
> to make sure that the rebased commits are not signed (i.e. verify
> may fail for reasons other than the commit lacks signature, like the
> commit is signed but with a wrong key, etc.), but I think it is OK
> at least for now.  Others might have clever ideas to cleanly and
> cheaply reject other kinds of failures, in which case we may want to
> adopt such a solution.
> 
> Now that we know that the root cause of the bug you fixed was
> because rebase rebase with the default merge strategy for two-head
> merges use separate codepaths from and all other rebases, I wonder
> if it is prudent to also test the same cases this series adds
> without giving "-s resolve".  That would exercise the other codepath

I will leave that for someone else to tackle eventually.

> that handles the default merge strategy for two-head merges.  Yes,
> we know that other codepath has been working even before this fix,
> but tests are not about showing off what we fixed, but are about
> making sure similar breakage won't be introduced by mistake in the
> future.
> 
> Thanks.

As the number of very similar test is slowly growing, do you think it is
worth copying (or making more generic) the test_rebase_gpg_sign for this
situation as well? We currently have 4 almost identical tests (counting
the new one you suggested for v4). Just a thought, as it is simpler to
just add it at this point. Thanks for the feedback.

Regards,
Samuel
