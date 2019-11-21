Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD23C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:36:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 409EA2070E
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 13:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SLa67dnZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfKUNgf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 08:36:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37625 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbfKUNgf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 08:36:35 -0500
Received: by mail-wm1-f67.google.com with SMTP id f129so2384401wmf.2
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 05:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=shKhsYsFZbQ4QPScUJxKaNKKpPtl00hhzgMzeuwoQUw=;
        b=SLa67dnZyB3Oc9+5bw5ypFh9l1xK7SW6r+VEPKY8NFiIye8Patq9BdD4sJuLNOw3ht
         unPbyvDLdNZ5flsK8kwNE7bjxHzcJeUvT7MS7MQUBqq9l14NHmv7xHULw1yu9FU4QdlK
         35X0f605ekZNiSDa5iowCSQkl++WPhgZ8Z6UOAoPx94jUZMRDI8M/Iz5zRRJgQBuTbj5
         2U2Xtm7dImrPyaQtE9m5DPhC1EQupQ2BtAOqolIgzdv4aoe39MbCKXa36cWUEnBwSZjx
         sBMMLAFbnAe9BiUkFFOynDw1211kpCP8vm6SdNqFlimnxx6CTKJT1Asx9M8tJUYOfXE1
         DrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=shKhsYsFZbQ4QPScUJxKaNKKpPtl00hhzgMzeuwoQUw=;
        b=BgP23bqjOHwEu6SJLKTuGZiGt3/4Wm2jUd0DEOhIkqqarg3UVYzH/pJDfqwk6VBvxc
         Z3VWVXQ4SSkq/++4EWNVIIPt9YBkCNkzdpPZqdeqzMcdGjFyHXhGjpTYCkOrhj8SdmSd
         883d/YAIn4nV4kAOYYUUmI4Sc/xqbHQEgQR5cQIJ5FBPDUh3dfjdH8Xa6LII64RUOC6D
         qbQwCOOmL447B8xVgVcQX106+JZ1ipv8uE+SIRBPyE5fIOSqc+uFl1natumeo3HMMdQT
         vKyjBFKrzWisIVvGtWWWmOp1FuDlkMsqr02feIyC6W7PvFKTFirkYuh+uZfnfLj9uYq8
         532w==
X-Gm-Message-State: APjAAAV/TdmBWxETdyzlpVKWlclAqLuutFOA1y21K82Z+GEOmJUF11Gj
        j5cPBLvOuLKrHXO4gbz9ryk=
X-Google-Smtp-Source: APXvYqxNbzTG/O/CEA/zRVAZnm8FLJmiggMketLVcjbgFOe2fD7mHTwHqRZxOFfCrNkFuioAAUmOQg==
X-Received: by 2002:a1c:a556:: with SMTP id o83mr9795395wme.165.1574343392765;
        Thu, 21 Nov 2019 05:36:32 -0800 (PST)
Received: from szeder.dev (x4db6680d.dyn.telefonica.de. [77.182.104.13])
        by smtp.gmail.com with ESMTPSA id p25sm2810721wma.20.2019.11.21.05.36.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 05:36:31 -0800 (PST)
Date:   Thu, 21 Nov 2019 14:36:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, newren@gmail.com, jon@jonsimons.org,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 04/17] sparse-checkout: 'set' subcommand
Message-ID: <20191121133628.GT23183@szeder.dev>
References: <pull.316.v4.git.1571147764.gitgitgadget@gmail.com>
 <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
 <7d9d66a89f473244af3601e13caa713d929a202d.1571666186.git.gitgitgadget@gmail.com>
 <20191119154640.GG23183@szeder.dev>
 <64b230d4-d36f-5d92-7570-6d965db471a5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b230d4-d36f-5d92-7570-6d965db471a5@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 21, 2019 at 08:04:35AM -0500, Derrick Stolee wrote:
> On 11/19/2019 10:46 AM, SZEDER Gábor wrote:
> > On Mon, Oct 21, 2019 at 01:56:13PM +0000, Derrick Stolee via GitGitGadget wrote:
> >> From: Derrick Stolee <dstolee@microsoft.com>
> >>
> >> The 'git sparse-checkout set' subcommand takes a list of patterns
> >> as arguments and writes them to the sparse-checkout file. Then, it
> >> updates the working directory using 'git read-tree -mu HEAD'.
> >>
> >> The 'set' subcommand will replace the entire contents of the
> >> sparse-checkout file. The write_patterns_and_update() method is
> >> extracted from cmd_sparse_checkout() to make it easier to implement
> >> 'add' and/or 'remove' subcommands in the future.
> > 
> > Yeah, an 'add' subcommand would be great, because 'set' throwing away
> > all the existing patterns can lead to some frustration:
> 
> I plan to extend this feature when this series lands.
> 
> > Having said that, being forced to use 'git sparse-checkout set' and
> > specify all patterns at once does have its own benefits: I needed like
> > 6 subdirectories to build that subset of a big project that I was
> > interested in, and now all the necessary patterns are saved in my Bash
> > history, and I will be able to easily dig out the complete command in
> > the future.  That wouldn't work with using the 'add' subcommand to add
> > one pattern at a time.
> 
> In general, this "set" command is created first because tools can interact
> with it more easily than "add" and "remove". Users would probably prefer the
> "add" and "remove" way to interact.

Makes sense.

However, I'd like to add that in the meantime I got to like the 'set'
subcommand more and more.  I enabled-disabled sparse checkout a lot of
times while testing and trying to poke holes, and to be able to set up
everything with only one single command that I can easily recall from
the shell's history was a great help.

> >> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
> >> index cb74715ca6..bf2dc55bb1 100755
> >> --- a/t/t1091-sparse-checkout-builtin.sh
> >> +++ b/t/t1091-sparse-checkout-builtin.sh
> >> @@ -96,4 +96,36 @@ test_expect_success 'clone --sparse' '
> >>  	test_cmp expect dir
> >>  '
> >>  
> >> +test_expect_success 'set enables config' '
> >> +	git init empty-config &&
> >> +	(
> >> +		cd empty-config &&
> >> +		test_commit test file &&
> >> +		test_path_is_missing .git/config.worktree &&
> >> +		test_must_fail git sparse-checkout set nothing &&
> > 
> > This command prints the same error message twice:
> > 
> >   + test_must_fail git sparse-checkout set nothing
> >   error: Sparse checkout leaves no entry on working directory
> >   error: Sparse checkout leaves no entry on working directory
> 
> At this commit, I do not see two identical lines, but instead the second
> line says
> 
> 	error: failed to update index with new sparse-checkout paths

You're right, I must have looked at and copied the results from a test
run of the full patch series or even from 'next'.  The error message
changes with commit efd9c53b6d (sparse-checkout: update working
directory in-process, 2019-10-21) to what I shown above.

Interestingly, at one point in my testing I managed to get a different
error three times:

  $ ~/src/git/git sparse-checkout set foo
  error: Entry 'dir/bar' not uptodate. Cannot update sparse checkout.
  error: Entry 'dir/bar' not uptodate. Cannot update sparse checkout.
  error: Entry 'dir/bar' not uptodate. Cannot update sparse checkout.

However, when I later re-run the same sequence of commands that lead
to that three errors I got that error only twice, and couldn't
reproduce it since.

Style nit, seeing "error: Sparse..." and "error: Entry...": error
messages should start with a lower-case letter.

> (that "paths" should probably be "patterns")

That would be better indeed, but that error message goes away by the
end of the series anyway...

