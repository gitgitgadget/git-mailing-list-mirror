Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72FA8C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 036A0251FA
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 15:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="lRmKTTPk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgJMPoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727830AbgJMPon (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 11:44:43 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2746C0613D0
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 08:44:43 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id q202so13872016iod.9
        for <git@vger.kernel.org>; Tue, 13 Oct 2020 08:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CjfB8ksP1nK46UnSktzjr99sCiYrErFtt6HD+8p4f1E=;
        b=lRmKTTPkyXpd1Tja9ugUpqPlCy1OB/AiqX0kpLgfpQ2auojTv26TbopZvTb3qFGGtu
         NnDG3soT07Fd48dp0yTZG3856+jPDjGeeKm7DUL5C/N1z9yplld/NIUNuDcrr8IRLmjD
         yQM+sFJcve8sKXkTGEeqe2CX938NQreIKFNuAzjvsp3yjufIdCvQ745P4JDgOW+tA3Jf
         XVu48lYfQRG33ZGH+c3vUULih1mGycUx/ioHKMNDaAmK/NLIHTFLghQXyJ991um0X+tA
         73V8VtWF2SA5thd2wbGMhUtwmsF5limC4R1XFCYAOKYuIXd1QzHVdmxZVckk+mPk3r48
         keAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CjfB8ksP1nK46UnSktzjr99sCiYrErFtt6HD+8p4f1E=;
        b=FXfsCJRjy0bn53hv63QkwlPHRmdbqhg78xRnLnZWOfKN1Xmsq33htcqFGKKrspIha+
         jiLCikrDm5AQNl27ip+zPa3eWsSbKfd9Ly4a5HhQEtOFgLS+KvwcvGCCLmsPBYmkE1v7
         7KXfD5CAThuv8bbbKl+gQWR5hPgT5jDpY4Rn1WrcQ0qGxTO5CJLbvPPXIHrUiznfgvEO
         Tp9Ey3wcQbJnewPLs0+YyMqtSgCoBplR/dOmcf+/6f5VfCcIHTceNKcueZ0U32iidXIS
         VVvCHNeYTLWKKw6wvKsQ0jHyXfkkW8D9mt0soyYwdDBShwjrjs1XYNImOYLeOXvsS2a7
         5QNA==
X-Gm-Message-State: AOAM530Am1HfNQ0g8N+T9R0ea7hgbBpGVFqT6O8ILMNd1jTKN2Mk2xKK
        M3w2POb7NFLJ8eXeMn4dPj7Uog==
X-Google-Smtp-Source: ABdhPJyA3znCdnWQN5/Dx4GJpMYk3ekad+R0/LG7UwdBDwG9A9/NNOZAFwYbWoAoBT5Ul0omWGyIEA==
X-Received: by 2002:a6b:2b07:: with SMTP id r7mr20536401ior.181.1602603883022;
        Tue, 13 Oct 2020 08:44:43 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a4a8:cfa:3aeb:51fa])
        by smtp.gmail.com with ESMTPSA id n77sm182940ild.10.2020.10.13.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2020 08:44:42 -0700 (PDT)
Date:   Tue, 13 Oct 2020 11:44:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/3] test-lib: reduce verbosity of skipped tests
Message-ID: <20201013154439.GB1913367@nand.local>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <bb2317972a8faf0358aaad1247fdfd2af2ea142d.1602545164.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bb2317972a8faf0358aaad1247fdfd2af2ea142d.1602545164.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 12, 2020 at 11:26:04PM +0000, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
>
> When using the --run flag to run just two or three tests from a test
> file which contains several dozen tests, having every skipped test print
> out dozens of lines of output for the test code for that skipped test
> adds up to hundreds or thousands of lines of irrelevant output that make
> it very hard to fish out the relevant results you were looking for.
> Simplify the output for skipped tests down to just showing the one-line
> descriptions.
>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 2aca398e1e..7602bbe9e9 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1059,7 +1059,7 @@ test_skip () {
>  				"      <skipped message=\"$message\" />"
>  		fi
>
> -		say_color skip >&3 "skipping test: $@"
> +		say_color skip >&3 "skipping test: $1"

I would be comfortable going further than this and removing this line
entirely. We need the "ok $test_count # skip" below since it's part of
our TAP output, but now the output looks somewhat redundant.

With this patch running a test that I'm working on with `--run=...`, I
get output that looks like:

  skipping test: writing bitmaps via command-line can duplicate .keep objects
  ok 2 # skip writing bitmaps via command-line can duplicate .keep objects (--run)

  skipping test: writing bitmaps via config can duplicate .keep objects
  ok 3 # skip writing bitmaps via config can duplicate .keep objects (--run)

Scanning over the same test description twice per skipped test makes the
output difficult (but still much easier than before) to scan. What do
you think about either of the following:

  skipping test: writing bitmaps via command-line can duplicate .keep objects
  ok 2 # skip (--run)

or:

  ok 2 # skip writing bitmaps via command-line can duplicate .keep objects (--run)

I have a slight preference towards the latter, since it keeps more of
the information in the TAP line, and it cuts the total line count of
output from skipped tests in half.

For what it's worth, I'd also be fine with the patch as-is.

Thanks,
Taylor
