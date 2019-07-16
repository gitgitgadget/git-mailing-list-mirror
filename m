Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97C531F461
	for <e@80x24.org>; Tue, 16 Jul 2019 13:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728513AbfGPNfG (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 09:35:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40373 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbfGPNfG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 09:35:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id r1so20972243wrl.7
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 06:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UH46WMss14Zb1w2aPn868A7vwFkCCoG1BMfjR37iLw0=;
        b=uGsg+5f6GEGxYM/TC7lmoF/1Lat/PngSDexCtnz4xicxPeFNd0PE7ddNJkFj98Px9K
         yBqbGwbIr3F9a7CUwYLF6qxD5TH37M89xu4PASGCRPPeUWGZM1BDO52n11VWn8Y+03ae
         70vejzC8XUYxS8pU1tOYEtY1uPTi/+6j+W4vAn+25Hsdp71sTB062/oz9S8bW8ifgIQt
         mu9ruKtgCt+9F6bqzxFSVt1RBG/fBQJMOF46+MaW0qsycmNfQHhULI5TsV4FT8wtDssY
         U1YDjdARtQ+amIBZo9yvY/RXZTeE+WHylDbSAhyLubM6G3L4mJPNjGLEkxCW+L35oamm
         hlrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UH46WMss14Zb1w2aPn868A7vwFkCCoG1BMfjR37iLw0=;
        b=Ls89xKZoVBbEoZF9ZjwfZpHp8lp+Sg2U2YYcKRPMtjfaO5Y+ewSkC3GBKPWIzjWvAo
         bzk+MbefXfH2pb5HPTdeUssFJBGrtzbSxh3yjOvBDyIdN3N81UXtxcZFR8ZptxK7ZV3W
         Ynhu0lVoEpograHoq5s8fNkQLpvZBH3vjkk/b0vTeUD5+I42NDtr8mcVGeaVyUhd4uV3
         PXHxPFVXyLMR6rw3uAHEqjucxC87CWGAVf5AbD6FfrRvLmviJpR7yvDqABum2MA48+ki
         oeFV++CDl0YzHezSQ83DaGvFTErNh+JSCWtBwR5yUNA9PRsCAGfFbonknnyNO9ezQChE
         1/yA==
X-Gm-Message-State: APjAAAX5keG26OzZts+/sfJCCcVW5+M7+zdyaDe87Hyppmcv8mNhE+al
        fiyNqLJU9Z95E3T4qoeoOM0mr7164qktDA==
X-Google-Smtp-Source: APXvYqw83LzE/qWDvcSjrbfeVwTepcnWaV0V+jTCSoa6vB+YEBV9kCsyaIXq8KEFaFwv9ggLICXQAQ==
X-Received: by 2002:a5d:468a:: with SMTP id u10mr36691785wrq.177.1563284103639;
        Tue, 16 Jul 2019 06:35:03 -0700 (PDT)
Received: from localhost (host145-110-dynamic.14-87-r.retail.telecomitalia.it. [87.14.110.145])
        by smtp.gmail.com with ESMTPSA id s12sm18843034wmh.34.2019.07.16.06.35.01
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 06:35:02 -0700 (PDT)
Date:   Tue, 16 Jul 2019 14:35:01 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Martin Nicolay <m.nicolay@osm-ag.de>, git@vger.kernel.org
Subject: Re: [PATCH] stash: fix handling removed files with --keep-index
Message-ID: <20190716133501.GG15477@hank.intra.tgummerer.com>
References: <alpine.LSU.2.20.1907111452560.3570@cpza.bfz-tzou.qr>
 <20190711174828.GF15477@hank.intra.tgummerer.com>
 <xmqqims8qn8f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqims8qn8f.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/11, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > Fix that behaviour by using 'git restore' which can faithfully restore
> > the index and working tree.  This also simplifies the code.
> 
> Hmph.  I would have preferred to see we stayed away from 'restore'
> (and used 'checkout' instead, if you must use a Porcelain command),
> so that the "fix" can go to maintenance tracks, if distro packagers
> choose to backport it.

Fair enough.  I thought this wouldn't even go to 'maint', since the
bug exists since a while, so 'git restore' would be fine, but didn't
think of distro packagers.  I'm happy to use 'checkout' here instead.  

> Isn't the machinery for "git status" (in wt-status.c) mature enough
> to allow us to learn what got changed all in-core, without spawning
> an external process these days, though?

Maybe, I'm not all that familar with that machinery.  My longer term
hope was actually to libify the checkout machinery, and to use that
here and use that to do all this (and the 'add', 'diff-index' and
'apply' dance above) in core.  But maybe it's worth looking at the
"git status" machinery for that as well?

I probably won't have enough time to do that in the next few weeks
though, so my preference would be to just use checkout for this (I'll
send an updated patch) to fix the bug in the next release.  As we're
already spawning two external processes and would replace that with
just spawning one it wouldn't make anything worse at least.

Then we can try to do this all in-core at some point later, which I
think is a bit more work, and probably wouldn't be ready for the next
release (at least I won't have time to work on it).

> >  		if (keep_index == 1 && !is_null_oid(&info.i_tree)) {
> > -			struct child_process cp_ls = CHILD_PROCESS_INIT;
> > -			struct child_process cp_checkout = CHILD_PROCESS_INIT;
> > -			struct strbuf out = STRBUF_INIT;
> > -
> > -			if (reset_tree(&info.i_tree, 0, 1)) {
> > -				ret = -1;
> > -				goto done;
> > -			}
> > -
> > -			cp_ls.git_cmd = 1;
> > -			argv_array_pushl(&cp_ls.args, "ls-files", "-z",
> > -					 "--modified", "--", NULL);
> > -
> > -			add_pathspecs(&cp_ls.args, ps);
> > -			if (pipe_command(&cp_ls, NULL, 0, &out, 0, NULL, 0)) {
> > -				ret = -1;
> > -				goto done;
> > -			}
> > -
> > -			cp_checkout.git_cmd = 1;
> > -			argv_array_pushl(&cp_checkout.args, "checkout-index",
> > -					 "-z", "--force", "--stdin", NULL);
> > -			if (pipe_command(&cp_checkout, out.buf, out.len, NULL,
> > -					 0, NULL, 0)) {
> > +			struct child_process cp_restore = CHILD_PROCESS_INIT;
> > +
> > +			cp_restore.git_cmd = 1;
> > +			argv_array_pushl(&cp_restore.args, "restore", "--source", oid_to_hex(&info.i_tree),
> > +					 "--staged", "--worktree", NULL);
> > +			if (!ps->nr)
> > +				argv_array_push(&cp_restore.args, ".");
> > +			else
> > +				add_pathspecs(&cp_restore.args, ps);
> > +			if (run_command(&cp_restore)) {
> >  				ret = -1;
> >  				goto done;
> >  			}
> > diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
> > index b22e671608..b8e337893f 100755
> > --- a/t/t3903-stash.sh
> > +++ b/t/t3903-stash.sh
> > @@ -1234,4 +1234,11 @@ test_expect_success 'stash works when user.name and user.email are not set' '
> >  	)
> >  '
> >  
> > +test_expect_success 'stash --keep-index with file deleted in index does not resurrect it on disk' '
> > +	test_commit to-remove to-remove &&
> > +	git rm to-remove &&
> > +	git stash --keep-index &&
> > +	test_path_is_missing to-remove
> > +'
> > +
> >  test_done
