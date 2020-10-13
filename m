Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6988DC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 10:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87C220E65
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 10:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="l/KCGOAn";
	dkim=pass (1024-bit key) header.d=cavoj.net header.i=@cavoj.net header.b="l/KCGOAn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729361AbgJMKnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 06:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgJMKns (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 06:43:48 -0400
Received: from mail.sammserver.com (sammserver.com [IPv6:2001:470:5a5b:1::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F817C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 03:43:48 -0700 (PDT)
Received: by mail.sammserver.com (Postfix, from userid 5011)
        id C96D11107F4D; Tue, 13 Oct 2020 12:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602585826; bh=YaHlTjrubzZJuMTE8QZMdeLg662nCYDe3+oHrLfEn84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/KCGOAnr+EJ10e9OACRZCs8OZQ7B7Un7Phrk5NVDIR7y+JZGpXyQj4GB7+SjAT39
         UhDSelqUQLO6m+F02tbnC3wzHr5wnVZ+SgWjmfyZ2Zimlvd1HFSeXEH0dRgWKz12Fk
         bIg40Vw6Y/TWlZ2HhIwbHaArEc9MrJ2CopF/2JXg=
Received: from fastboi.localdomain (fastboi.wg [10.32.40.5])
        by mail.sammserver.com (Postfix) with ESMTP id 73F991107F4A;
        Tue, 13 Oct 2020 12:43:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cavoj.net; s=email;
        t=1602585826; bh=YaHlTjrubzZJuMTE8QZMdeLg662nCYDe3+oHrLfEn84=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=l/KCGOAnr+EJ10e9OACRZCs8OZQ7B7Un7Phrk5NVDIR7y+JZGpXyQj4GB7+SjAT39
         UhDSelqUQLO6m+F02tbnC3wzHr5wnVZ+SgWjmfyZ2Zimlvd1HFSeXEH0dRgWKz12Fk
         bIg40Vw6Y/TWlZ2HhIwbHaArEc9MrJ2CopF/2JXg=
Received: by fastboi.localdomain (Postfix, from userid 1000)
        id 5AF961420A8F; Tue, 13 Oct 2020 12:43:46 +0200 (CEST)
Date:   Tue, 13 Oct 2020 12:43:46 +0200
From:   Samuel =?utf-8?B?xIxhdm9q?= <samuel@cavoj.net>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
Message-ID: <20201013104346.oyjvlcnqhuuzkpzh@fastboi.localdomain>
References: <20201012234901.1356948-1-samuel@cavoj.net>
 <92b32c0a-68ef-f0f2-48d4-ddb3e1cc7245@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <92b32c0a-68ef-f0f2-48d4-ddb3e1cc7245@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 13.10.2020 10:55, Phillip Wood wrote:
> Hi Samuel
> 
> Thanks for re-rolling this
> 
> On 13/10/2020 00:49, Samuel Čavoj wrote:
> > From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > 
> > When performing a rebase with --rebase-merges using either a custom
> > strategy specified with -s or an octopus merge, and at the same time
> > having gpgsign enabled (either rebase -S or config commit.gpgsign), the
> > operation would fail on making the merge commit.
> 
> Small nit-pick: I think it worked fine with if commit.gpgsign was set and
> the user did not pass -S or --no-gpg-sign because merge would sign the
> commits as commit.gpgsign was set, it was only if the user passed a gpg
> signing option to rebase that we had problems. I'm not sure it's worth a
> re-roll just for that though

This is not the case. That's how I encountered the problem initially, I
have commit.gpgsign set to true globally. I ran a rebase -ir, over an
octopus merge and then it would fail with an error in the lines of 'not
something we can merge'. I later found out it didn't happen on my
laptop, where gpgsign is not set, so that's what gave it away. In either
case, I did not pass neither -S nor --no-gpg-sign to rebase.

Yes, _if_ the merge command went through, it would have choosen the
correct signing behaviour (i.e. the default), but the merge died,
because an empty string was being passed to it as one of the commits to
merge.

off-topic p.s.:
My mail server does not currently have a proper rDNS record (yeah yeah,
I know) and for this reason, gmx.net drops my emails unconditionally. As
such, I am unable to send emails directly to Johannes.Schindelin@gmx.de,
without major hackery, anyway. I am dropping him from Cc, as to prevent
sad mailservers. I hope these messages reach him via the mailing list.

Regards,
Samuel

> 
> Best Wishes
> 
> Phillip
> 
> > Instead of "-S%s" with
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
> > +
> >   test_done
> > 
> 
