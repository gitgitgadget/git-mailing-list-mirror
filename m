Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5634CC55189
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 08:54:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B44F206A2
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 08:54:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="unpnI85w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726068AbgDVIya (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVIy3 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 04:54:29 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D394C03C1A6
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 01:54:27 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id k12so1073364qtm.4
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 01:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=spmf+qZxw4UKEzHSt6Aa+gHLcQhaqvRjyj1CZmuX298=;
        b=unpnI85wkJmdHlXgJWsRRPOc6VLfrer6+dS4U73e+GSMBTA/55kskTEGc67L2K9j5B
         /fswcPUTeWvEUOkDu5STX8+VPhOlQKkn0G4AXRih/K+56MzhdaPBjkHNcTqIr7aK7oEX
         4tTJ+PvnnPhHKiy/8Tbwrjh07OCToN3JKq2jpuqJtDOoBIpfuPtbW4+QNluFXcV/PWd4
         2SK5adobLvl5ekhaTCi5HMw7cbcVd8q4DWNrV5Ft9Ve++VruNLvzkBajW7dFBDg97HNk
         77HdrNRStMLeTrDdvNwkfVa/0S2OQneJwiBsjgspbOlxfIqEKJS5QWIoft05HdmpFRVz
         VMGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=spmf+qZxw4UKEzHSt6Aa+gHLcQhaqvRjyj1CZmuX298=;
        b=VK3N0SFtx15Xb8+8bivBsM+/WMo+6A6Rmdz2dL8XGJvAQVklVMqT0vWabtwBnd5MyG
         DautSBonVkGCqXWALrV1uhfgamHa6CWGmwKomybow4asjKs3OieLi1aHWWzNs/DMRkg2
         NlnyEfixBh88kG6CbTWhaaswm6nH+qLSoZUmh+/4zTSjPwXFK5p80mUzKF4Q6F9RLdbU
         okgzXNe1c8IB/uLFnK5SQxyE9juCtMjlT/OapBma2l9Rsbh4oTK5U904AahVqviskr5i
         dgsG5dsXZOfD2sP3V26yPSgP5AOHdlj8i+HY+26jO+VPQUjmhXLn0smLNoiRdIb0vuaI
         AxXw==
X-Gm-Message-State: AGi0PuZXFiXM2TYVsk2Y4S0Q4xiLwfJl/x+RSQiTyzFeioopYvm1VO+K
        KOxRLgixVH7qm3GaPEJOFKE=
X-Google-Smtp-Source: APiQypLqhOuVOJzX6Bp/uOOEybf3vDukMI0bhZj6XXdzFxgUCpqxjm5f1zYRXhlGTdbWfH6BRvACNQ==
X-Received: by 2002:ac8:23e3:: with SMTP id r32mr25798832qtr.268.1587545666654;
        Wed, 22 Apr 2020 01:54:26 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id w42sm3637188qtj.63.2020.04.22.01.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 01:54:26 -0700 (PDT)
Date:   Wed, 22 Apr 2020 04:54:24 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 6/8] t9164: don't use `test_must_fail test_cmp`
Message-ID: <20200422085424.GA25366@generichostname>
References: <cover.1587372771.git.liu.denton@gmail.com>
 <dfccb04e2d03656e18286bcca2c558e19d748ffd.1587372771.git.liu.denton@gmail.com>
 <CAPig+cQ6XS=ZDhAKGuDiGM4zcoxUhnghMY250qYLjuT8YZaoMg@mail.gmail.com>
 <xmqqr1whrkaa.fsf@gitster.c.googlers.com>
 <20200421201627.GA9357@generichostname>
 <xmqqa734muw7.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqa734muw7.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, Apr 21, 2020 at 01:44:08PM -0700, Junio C Hamano wrote:
> Denton Liu <liu.denton@gmail.com> writes:
> 
> > On Mon, Apr 20, 2020 at 01:09:49PM -0700, Junio C Hamano wrote:
> >> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> 
> >> > On Mon, Apr 20, 2020 at 4:55 AM Denton Liu <liu.denton@gmail.com> wrote:
> >> >> The test_must_fail function should only be used for git commands since
> >> >> we assume that external commands work sanely. Since test_cmp() just
> >> >> wraps an external command, replace `test_must_fail test_cmp` with
> >> >> `! test_cmp`.
> >> >>
> >> >> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> >> >> ---
> >> >> diff --git a/t/t9164-git-svn-dcommit-concurrent.sh b/t/t9164-git-svn-dcommit-concurrent.sh
> >> >> @@ -103,7 +103,7 @@ test_expect_success 'check if pre-commit hook fails' '
> >> >> -               test_must_fail svn_cmd commit -m "this commit should fail" &&
> >> >> +               ! svn_cmd commit -m "this commit should fail" &&
> >> >
> >> > Hmm, this doesn't look like 'test_cmp' mentioned in the commit message.
> >> 
> >> Yeah, the other hunk is about test_cmp and this hunk is about
> >> svn_cmd.  The stated rationale applies to both wrappers, I think.
> >> 
> >>     Subject: [PATCH 6/8] t9164: use test_must_fail only on git
> >> 
> >>     The `test_must_fail` function should only be used for git commands;
> >>     we are not in the business of catching segmentation fault by external
> >>     commands.  Shell helper functions test_cmp and svn_cmd used in this
> >>     script are wrappers around external commands, so just use `! cmd`
> >>     instead of `test_must_fail cmd`
> >> 
> >> perhaps, without any change to the code?
> >
> > Thanks, this looks good to me too.
> 
> Thanks.  
> 
> So the 4-patch test-must-fail-fix series is now complete?  Whee.

Hannes suggested that we should drop the tip commit of this series[1]
and I tend to agree with him. Aside from that, though, the series is
ready to go.

(I could improve 3/8 as suggested here[2] but I'll throw it in the next
series instead since I'm trying to get into the habit of not adding in
unrelated patches.)

[1]: https://lore.kernel.org/git/6cfa2c447e1196d6c4325aff9fac52434d10fda8.1587372771.git.liu.denton@gmail.com/
[2]: https://lore.kernel.org/git/90faeb7a-1c6a-3fc6-6410-5e264c9340e8@kdbg.org/
