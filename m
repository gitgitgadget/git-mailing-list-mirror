Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BB9EC54FC9
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09B8A206D5
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 20:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvyDrHAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgDUUQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 16:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgDUUQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Apr 2020 16:16:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC7C0610D5
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 13:16:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z90so12688621qtd.10
        for <git@vger.kernel.org>; Tue, 21 Apr 2020 13:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yK+ilAWPC1Nj2ZOKZNqdD9A/qWSHeTHnZOEvjpBskyQ=;
        b=jvyDrHAYtfQvMurbI2cvtx1e3R4WVXauV35ErVkc0I8zojIM5ocHrsp8p6XFp8gbSr
         szMrVRv9/H0/QIv6qe3jPswdk1PDTkiRr+8aMDVc64FgY0VEgTQ+p4uKpp3c3kDW6PWc
         ayg2KsWmruUEiszR1zHc/Tq27fMIKxamDHahBd5QHbKAbmc2j4IENI4wWcgPC0JboMjV
         co2Emw/lMrXLUkXOgwBHZwyJI3FGzlpLldio2Ffbl4VoEjy0RwnpeAEM7g+w1bZ1xOMq
         GjxcIDcdjN5fej6BlheaSGHFkmKEUAuv66UAT0/LaVy8YEVEyURiVei+2w59Why21VlP
         I7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yK+ilAWPC1Nj2ZOKZNqdD9A/qWSHeTHnZOEvjpBskyQ=;
        b=TslFDAxoieyQwI+EfLacEgMOusGDjN1wuDVmO9BT3CMhSlxjT9RqtemaE7Wo09eqG/
         TJDdJacrO/hNSd97SCOywhI2P6Tz8xnqD8LfnuRR1HUVNy+Tg9Ov08h5/fBwehWFQz3+
         cH4r2dYmY0VA0Ytq9sZ+TZc5cdLHus53IdHjQoqD2+vnTq7jQ++2NKu8i53lCv7jlXHz
         mNXIaa0qPCdttowL3VxGYFgdsd4M/F4omNbxSguHeGJSknW2rjcHbCNT25mQyQg8c7mz
         NAgS1nF2f5gJuFx4HZOgsJSumjCGfojnRoti9ZI8VoSw/iUatlWX8WL9Ta08Ar+lwHDC
         fIWg==
X-Gm-Message-State: AGi0PubdQP+akE5esYrNX0z+z7UHqYK+4MA6m4bysrBlPyf/FXlBBemr
        Cr/DLNCRfwrO3LUE4PRrZOQ=
X-Google-Smtp-Source: APiQypLABPHL32uIkb4gtkT15pwRgJZ4Mu1eyyJ7JhcYfWfcOT//EJaQIL9v0OG9wbKp+UXcrBeVMw==
X-Received: by 2002:ac8:3707:: with SMTP id o7mr23561649qtb.172.1587500190358;
        Tue, 21 Apr 2020 13:16:30 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id o13sm2464823qke.77.2020.04.21.13.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 13:16:29 -0700 (PDT)
Date:   Tue, 21 Apr 2020 16:16:27 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] t9164: don't use `test_must_fail test_cmp`
Message-ID: <20200421201627.GA9357@generichostname>
References: <cover.1587372771.git.liu.denton@gmail.com>
 <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
 <CAPig+cQ6XS=ZDhAKGuDiGM4zcoxUhnghMY250qYLjuT8YZaoMg@mail.gmail.com>
 <xmqqr1whrkaa.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1whrkaa.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 20, 2020 at 01:09:49PM -0700, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > On Mon, Apr 20, 2020 at 4:55 AM Denton Liu <liu.denton@gmail.com> wrote:
> >> The test_must_fail function should only be used for git commands since
> >> we assume that external commands work sanely. Since test_cmp() just
> >> wraps an external command, replace `test_must_fail test_cmp` with
> >> `! test_cmp`.
> >>
> >> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> >> ---
> >> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
> >> @@ -103,7 +103,7 @@ test_expect_success 'check if pre-commit hook fails' '
> >> -               test_must_fail svn_cmd commit -m "this commit should fail" &&
> >> +               ! svn_cmd commit -m "this commit should fail" &&
> >
> > Hmm, this doesn't look like 'test_cmp' mentioned in the commit message.
> 
> Yeah, the other hunk is about test_cmp and this hunk is about
> svn_cmd.  The stated rationale applies to both wrappers, I think.
> 
>     Subject: [PATCH 6/8] t9164: use test_must_fail only on git
> 
>     The `test_must_fail` function should only be used for git commands;
>     we are not in the business of catching segmentation fault by external
>     commands.  Shell helper functions test_cmp and svn_cmd used in this
>     script are wrappers around external commands, so just use `! cmd`
>     instead of `test_must_fail cmd`
> 
> perhaps, without any change to the code?

Thanks, this looks good to me too.
