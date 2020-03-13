Return-Path: <SRS0=VWjS=46=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E218C10DCE
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E6C220773
	for <git@archiver.kernel.org>; Fri, 13 Mar 2020 17:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xq1Fmv1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgCMRMz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:12:55 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34590 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMRMz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Mar 2020 13:12:55 -0400
Received: by mail-wr1-f68.google.com with SMTP id z15so13062129wrl.1
        for <git@vger.kernel.org>; Fri, 13 Mar 2020 10:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JUxjuundxVYTjKbZQMr38HmobdCgCtStPfgC02iS7ww=;
        b=Xq1Fmv1S2DDJloubJUMDYdQB3is9dy6OP72tfe6FCJMntxO2aIZ/OUUpqqHCoXJNTq
         56P6xXzZOTXrpOrZrD9v3jQxTDdfSQ4tTkhm2A+9SPWlM/+1XT6ZHk5D332QDn2Thjoo
         UKaX4DvUHpsBU0KnBv9Ekh2ceC9lc9KHFvDh5eiHT2MUsJlocH6BLJU1mJXIaQ2kUMk3
         AWcQ/1zwiZgr0h21hpK8842Kd9bNwT8fLGAj8K/OoIn3N6+ua+gW2YRrr85D5CLqmkxX
         jKwTZHMCKkLZXKZ3SamT1DNzYW9a7Vzu1H55TirjIa+l32XvDAMDQ94J3ignzH/Mewgr
         ij1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JUxjuundxVYTjKbZQMr38HmobdCgCtStPfgC02iS7ww=;
        b=rOb6CbYgysUcUYPrK/2JTvDzFzDwCR2KEOgJdhs+ARoY6pMkYx5IKwAgO+AphnX/Jr
         FToA7WY1LFD1Nnp+DmqAYEJiMeKekwfRyLAV0mmm/t1GFPFl6jTjSKBMw4SPS/qTsR/x
         rePPoY9JEHe0GxvSi9hoDQd5arb2fOXxL6RBHcuSSxWt/R0KlbJxu3cpFuVY97YDs3tU
         qfgyPlq48LtHmdKF648oXLBb8rI+nD0DzlPeKqyMK+pkTPpEFnd6el8phGvo9xeXpxGN
         Os0kPw53aiYIHN6Cw1MtYIjYQJgQZsgQpDnwFYrQwLxM2snYCNxBEYF0AJkCx5oIV+HB
         PPbQ==
X-Gm-Message-State: ANhLgQ13Un0UsPfCjgRw1qj04w8EXo+joLtaQF11Vn4i0N2E0RBVoat1
        WaP3dkdR09qi+h9F2ei4rw0=
X-Google-Smtp-Source: ADFU+vtr6955UYtx4ys0MRRhr0QHe3U9sCs0bKu7K4l2SnqXeq1mDqVU/J6tv6DuSIiJWPxeiNMsUg==
X-Received: by 2002:a5d:42c8:: with SMTP id t8mr18974111wrr.415.1584119573419;
        Fri, 13 Mar 2020 10:12:53 -0700 (PDT)
Received: from szeder.dev (94-21-29-150.pool.digikabel.hu. [94.21.29.150])
        by smtp.gmail.com with ESMTPSA id k126sm17665482wme.4.2020.03.13.10.12.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Mar 2020 10:12:52 -0700 (PDT)
Date:   Fri, 13 Mar 2020 18:12:48 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] t6022, t6046: test expected behavior instead of
 testing a proxy for it
Message-ID: <20200313171248.GA613@szeder.dev>
References: <pull.716.git.git.1582762465.gitgitgadget@gmail.com>
 <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <26d0c34cd1d4a54dab28d0c9c2242336244e8a3c.1582762465.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 27, 2020 at 12:14:23AM +0000, Elijah Newren via GitGitGadget wrote:
> diff --git a/t/t6022-merge-rename.sh b/t/t6022-merge-rename.sh
> index 6f196aaf276..d97cf48495b 100755
> --- a/t/t6022-merge-rename.sh
> +++ b/t/t6022-merge-rename.sh
> @@ -242,12 +242,23 @@ test_expect_success 'merge of identical changes in a renamed file' '
>  	rm -f A M N &&
>  	git reset --hard &&
>  	git checkout change+rename &&
> +
> +	test-tool chmtime =31337 B &&
> +	test-tool chmtime --get B >old-mtime &&

Here you compare the mtime of 'B' before ...

>  	GIT_MERGE_VERBOSITY=3 git merge change >out &&
> -	test_i18ngrep "^Skipped B" out &&
> +
> +	test-tool chmtime --get B >new-mtime &&
> +	test_cmp old-mtime new-mtime &&

... and after the merge.

> +
>  	git reset --hard HEAD^ &&
>  	git checkout change &&
> +
> +	test-tool chmtime =-1 M &&
> +	test-tool chmtime --get M >old-mtime &&

Here, however, you compare the mtime of 'M' before the merge ...

>  	GIT_MERGE_VERBOSITY=3 git merge change+rename >out &&
> -	test_i18ngrep ! "^Skipped B" out
> +
> +	test-tool chmtime --get B >new-mtime &&
> +	test $(cat old-mtime) -lt $(cat new-mtime)

... with the mtime of 'B' after the merge, i.e. the mtimes of two
different files.

Is that right?

