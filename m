Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C437C41604
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 08:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3491206F4
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 08:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlrt5pzT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgJFIHf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 04:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgJFIHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 04:07:35 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41EFEC061755
        for <git@vger.kernel.org>; Tue,  6 Oct 2020 01:07:35 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gm14so1183550pjb.2
        for <git@vger.kernel.org>; Tue, 06 Oct 2020 01:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q9dZyLu9fEUV8fsDjz4s88nWQJsSLITk+x9/Q0/wB84=;
        b=jlrt5pzTJFJw2rJwGLZA3PplqVseoX/owUx777hiNxCtT6NnfJuVPhFydUjb3FFP+9
         sHKzBD2xvLPOsZMf5ExnRy8FBKgdm1kz14sGTQ9VOr1LvK1Am4jk8ZD+CqExnvgKnhXq
         UENfbejgrHSIdHIfZtDmHJYyMcm3u26j7OWXAMEf4He/jT75grDp/TlQb1lFMABhUowO
         nizVIn1oURfyJMVDzMbE++3f3IoChhTksayonjoRlbSgX0aeMgzzbGdAemKysZ0Zc8z0
         hE/HFCxy4wxqVAkWfbru63l7udgmp1xVMKZ0az6duFoLyq6HwzKb0SLrbgNbK+1kIqW/
         JunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q9dZyLu9fEUV8fsDjz4s88nWQJsSLITk+x9/Q0/wB84=;
        b=hi3b7cr4+Pbv+EIW8WZVRVkdv8T65PXd6jO/3U3dyiPe+PdoDkufeKpSPFtWhjbNfP
         tDHvIMVP+W5iu8WqKh/pt/wOXAjT40QcpJM05c5D87oXIodK/fHkClxdEHHrs+yeTpSc
         LjEryI8G9UeLjqOdGzJ0wGLRg34/kghTY8z335x26Vt+Z5lDhtCBD2HfrZhEsXaCW4Ea
         CtmJYzrYXOXunpRp2cnyW2F/RmLtmYJP5KOw6aO1SgOGfzy5HyLAw0Wno6k2Bb2IKOi2
         5hW6OTMMvwUY7mphk+xxZ61aAjvOE/uwGONtt/2l16cp8i+S+egcnhY7s/B9I5lCcZV/
         MNEQ==
X-Gm-Message-State: AOAM530e7VQ3IXslaz5tDNLYqosRdl9lp64ypolxT5P2G+Z9RBWfiBjO
        3YTWUe/9SkBpM8gx8cSGfsM=
X-Google-Smtp-Source: ABdhPJzXyihCiHNmog4om7OK4BOaIhNbpNtqxJpym2wM1dedTzwuyTBKVRjtcNtFf0zeYaDJjio+SA==
X-Received: by 2002:a17:902:b601:b029:d3:e6c5:5112 with SMTP id b1-20020a170902b601b02900d3e6c55112mr2231271pls.65.1601971654632;
        Tue, 06 Oct 2020 01:07:34 -0700 (PDT)
Received: from generichostname (c-67-188-114-10.hsd1.ca.comcast.net. [67.188.114.10])
        by smtp.gmail.com with ESMTPSA id t3sm2123961pgm.42.2020.10.06.01.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 01:07:32 -0700 (PDT)
Date:   Tue, 6 Oct 2020 01:07:30 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] checkout: learn to respect checkout.guess
Message-ID: <20201006080730.GA2419589@generichostname>
References: <cover.1601810233.git.liu.denton@gmail.com>
 <8172602f6f1bbdfe39c8a1219dd3b9a222eb65fa.1601810233.git.liu.denton@gmail.com>
 <xmqqwo057ul5.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwo057ul5.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, Oct 04, 2020 at 10:46:14AM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > The current behavior of git checkout/switch is that --guess is currently
> > enabled by default. However, some users may not wish for this to happen
> > automatically. Instead of forcing users to specify --no-guess manually
> > each time, teach these commands the checkout.guess configuration
> > variable that gives users the option to set a default behavior.
> >
> > Teach the completion script to recognize the new config variable and
> > disable DWIM logic if it is set to false.
> >
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> 
> Asking for input from Dscho on how to futureproof the tests along
> the same line as js/default-branch-name-part-2 topic.

Perhaps we could extract lists that are repeated often into common files
so that they only need to be changed in one place? Something like this:

-- >8 --
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7b7bc6e4bd..86da44231d 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1240,8 +1240,8 @@ test_expect_success '__git_complete_fetch_refspecs - fully qualified & prefix' '
 	test_cmp expected out
 '
 
-test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
-	test_completion "git switch " <<-\EOF
+test_expect_success 'prepare expect files for DWIM tests' '
+	cat >local-and-unique-remote <<-\EOF &&
 	branch-in-other Z
 	master Z
 	master-in-other Z
@@ -1249,6 +1249,10 @@ test_expect_success 'git switch - with no options, complete local branches and u
 	EOF
 '
 
+test_expect_success 'git switch - with no options, complete local branches and unique remote branch names for DWIM logic' '
+	test_completion "git switch " <local-and-unique-remote
+'
+
 test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
 	test_completion "git checkout " <<-\EOF
 	HEAD Z
