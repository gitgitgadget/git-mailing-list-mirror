Return-Path: <SRS0=qAd/=CI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25ABAC433E6
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 19:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CA120757
	for <git@archiver.kernel.org>; Sun, 30 Aug 2020 19:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+MKH/pS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbgH3T7I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgH3T7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Aug 2020 15:59:07 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B1FC061573
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 12:59:06 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mt12so1991834pjb.4
        for <git@vger.kernel.org>; Sun, 30 Aug 2020 12:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=uXYkUIbtYRcK6cPKhy4g3K6swMALfoTYGP/3ZdRI5DM=;
        b=V+MKH/pSh56tV/qhN9zj1NNnakXZ6a2yxKOK3RwwHSSpDRS3WuHDJK2DjNNB2rOh7H
         KQaOgutNbhN+e6u6DjrgfesCYiGv+dMu/EwYzCNiI2et/MT10AFQboCO68ATMfHqg3dC
         /QvidaUhXDOwaprBpCpPoOt06alofOwZ1BXltVPLAnwyV3ad6IzsXYrh5a0DAWAFxnsH
         5kV6SZYtJz/n6e6/UnyHF2dwjqhuGNws/iiwuDzMex7n0DNkK+8ewK19f6huInGr1NJN
         bUP1ynDcnVlIHlmX4FHoSPD6GBeTzJjKczKOVxqnxBuaFYwJYWxBo+fb25rQee1sJ+CC
         8AOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=uXYkUIbtYRcK6cPKhy4g3K6swMALfoTYGP/3ZdRI5DM=;
        b=M3Kz1SdesenpJRaEeyf+c7Q/x94B5E/AhVlD3swR8IaTmuMak31e+NMvlVm8G6PFna
         kWAzbyK9nFvrb69IVaM+1+Hg38lKLSDTsmlawid1mx/c4aQh7+MvhstjKUmEO0d7rYnS
         kZoL30nr48Bc6qEHeIypNz4jj9dhzlM66mE7u7w94yq7IVh5zkMaoFOAQGP3ikf7VpD0
         OtZCmt3bnnMJvVbKBojgU2GwpHaQr0xFU2zWzyHJGaSbyVymoLPQFD2SDrDYNnoqm7Db
         PtpaJcOvOkjaxPTRjyxz++q4QpRLRKgt6brDewjPvbZbuzGBGu3pToezsgKJLuTw80pD
         jeAg==
X-Gm-Message-State: AOAM531IVI1A2w2+iGMyOtrcVJcUhgAzlfJv6LV03wIOBmNL9uasX9lU
        6Zdnlx1boA43VoEymg/xiQ0=
X-Google-Smtp-Source: ABdhPJwmYi7fD7sU+UArgOSkz0YBC8m1uro9lEC2+mekcBxbVxBzpm/UXmWAhHyP5ERRJVMnxQE9NA==
X-Received: by 2002:a17:90a:bc94:: with SMTP id x20mr7338566pjr.45.1598817546046;
        Sun, 30 Aug 2020 12:59:06 -0700 (PDT)
Received: from lwitch-pc ([183.83.155.71])
        by smtp.gmail.com with ESMTPSA id u3sm4810736pjn.29.2020.08.30.12.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 12:59:05 -0700 (PDT)
Message-ID: <ce151a1408291bb0991ce89459e36ee13ccdfa52.camel@gmail.com>
Subject: Re: [GSoC][PATCH] submodule: port submodule subcommand 'add' from
 shell to C
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        christian.couder@gmail.com, johannes.schindelin@gmx.de,
        liu.denton@gmail.com
Date:   Mon, 31 Aug 2020 01:28:53 +0530
In-Reply-To: <20200826091502.GA29471@konoha>
References: <20200824090359.403944-1-shouryashukla.oo@gmail.com>
         <xmqq8se36gev.fsf@gitster.c.googlers.com> <20200826091502.GA29471@konoha>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2020-08-26 at 14:45 +0530, Shourya Shukla wrote:
> On 24/08 11:35, Junio C Hamano wrote:
> > Shourya Shukla <shouryashukla.oo@gmail.com> writes:
> > 
> > The shell version would error out with anything in the index, so I'd
> > expect that a faithful conversion would not call is_directory() nor
> > submodule_from_path() at all---it would just look path up in the_index
> > and complains if anything is found.  For example, the quoted part in
> > the original above is what gives the error message when I do
> > 
> > 	$ git submodule add ./Makefile
> > 	'Makefile' already exists in the index.
> > 
> > I think.  And the above code won't trigger the "already exists" at
> > all because 'path' is not a directory.
> 
> Alright. That is correct. I tried to use a multitude of functions but
> did not find luck with any of them. The functions I tried:
> 

It would've been nice to see the actual code you tried so that it's
easier for others to more easily identify if you're using the wrong
function or using the correct function in the wrong way.

>     - index_path() to check if the path is in the index. For some
>       reason, it switched to the 'default' case and return the
>       'unsupported file type' error.
> 
>     - A combination of doing an OR with index_file_exists() and
>       index_dir_exists(). Still no luck. t7406.43 fails.
> 
>     - Using index_name_pos() along with the above two functions. Again a
>       failure in the same test.
> 
> I feel that index_name_pos() should suffice this task but it fails in
> t7406.43. The SM is in index since 'git ls-files --error-unmatch s1'
> does return 's1' (s1 is the submodule). What am I missing here?
> 

You're likely missing the fact that you should call `read_cache` before
using `index_name_pos` or the likes of it.

For instance, the following works without issues for most cases (more
on that below):

        if (read_cache() < 0)
                die(_("index file corrupt"));

        cache_pos = cache_name_pos(path, strlen(path));
        if (cache_pos >= 0) {
                if (!force) {
                        die(_("'%s' already exists in the index"),
path);
                }
                else {
                        struct cache_entry *ce = the_index.cache[cache_pos];

                        if (!S_ISGITLINK(ce->ce_mode))
                                die(_("'%s' already exists in the index and is not a "
                                      "submodule"), path);
                }
        }

This is more close to what the shell version did but misses one case
which might or might not be covered by the test suite[1]. The case when
path is a directory that has tracked contents. In the shell version we
would get:

   $ git submodule add ../git-crypt/ builtin
   'builtin' already exists in the index
   $ git submodule add --force ../git-crypt/ builtin
   'builtin' already exists in the index and is not a submodule

   In the C version with the above snippet we get:

   $ git submodule add --force ../git-crypt/ builtin
   fatal: 'builtin' does not have a commit checked out
   $ git submodule add ../git-crypt/ builtin
   fatal: 'builtin' does not have a commit checked out

   That's not appropriate and should be fixed. I believe we could do
   something with `cache_dir_exists` to fix this.


   Footnote
   ===

   [1]: If it's not covered already, it might be a good idea to add a test
   for the above case.

   --
   Sivaraam


