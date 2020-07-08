Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750D4C433E2
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7E320720
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMxNy+5t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730730AbgGHPm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730717AbgGHPmX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 11:42:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC40C061A0B
        for <git@vger.kernel.org>; Wed,  8 Jul 2020 08:42:22 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id ch3so1381337pjb.5
        for <git@vger.kernel.org>; Wed, 08 Jul 2020 08:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2XPw23l6Ffq+S2raUWS8pXFTvwMXPyQA0QUi+TTIstU=;
        b=dMxNy+5tUzgPYpsCbI2uuAQJ9Q/2wTCDhmgIT7ZjYoNIRSht5R08dER+GSeQLg4aAk
         kBxq1qKvCIevXLDtMiUFEJ4Gtg3EjWL/tPpMFhSih+KqWgw3N4B8JgzOVN0yZE3e5kAk
         24XQjkJYMn3xJIR/MkS1zXzbKEIQ2c6H8raIKCjZo/D79amggqG8AW62yRy4kto3V9to
         Ab429KroJnTypP9z3AA3M6MQewXSSI+JdVE01YhBhoeQDNXhOwjv+WoX9binN7klQIDP
         PK63+FffFc1GEql6lyoS1uzTNnKZ0OAhiU9qeNN6YknwhlJVEb1HPpyDpSKJZ46eAlCF
         i9Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2XPw23l6Ffq+S2raUWS8pXFTvwMXPyQA0QUi+TTIstU=;
        b=QIP85G7f5KFMaAQSV0wq5SuOCel7EXvU+nmi7TNKlzwgM7k7J3V22SqZNsUP/gZeCu
         S87+6EG7Oz2X6yIfr3dA0m4mKJnzX6pG6yrMy6RYY0hrDpfoYgYxHQ+KkqLazP7PCFT9
         eFD3LtskcP3Xs5B9yBUfXIOq2bprfNHwbPvkGWt6SB4f1h8VsG8PyYKkxJGWYhMpDOEp
         OWLPbxl0jTnekIzuw7iYAn22/IvgZXAaMT6aKaK1oArsH2/AKgR5152TBScjyjw6quJ1
         xflYNMllrbbg2tLEW1ZKy2lV9h8mxRJri4Z6KesU8fD20UMUtDMXLfSMgdPd8zu9FXW1
         BbGA==
X-Gm-Message-State: AOAM531JXOUydkdMsZsu9hpmWAnbqf3jVl5BTODsH2XhsaPim8b5SlEn
        oKIEkS5VI3FcC64QcYd+cC8=
X-Google-Smtp-Source: ABdhPJzQ7hKlXBwxz5CI3Z2NNo7qDK0g/CLcyFQFQNtHB1LrKhgFPv7SGjScDyVua/Yw/WkIEpp9ng==
X-Received: by 2002:a17:90a:32cb:: with SMTP id l69mr9168424pjb.205.1594222942264;
        Wed, 08 Jul 2020 08:42:22 -0700 (PDT)
Received: from localhost ([2402:800:6375:9968:2644:616c:71ad:c7e6])
        by smtp.gmail.com with ESMTPSA id g3sm253099pfq.19.2020.07.08.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 08:42:21 -0700 (PDT)
Date:   Wed, 8 Jul 2020 22:42:18 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sunlin <sunlin7@yahoo.com>,
        Lin Sun <lin.sun@zoom.us>
Subject: Re: [PATCH v12] Support auto-merge for meld to follow the vim-diff
 behavior
Message-ID: <20200708154218.GB18432@danh.dev>
References: <pull.781.v11.git.git.1594106024078.gitgitgadget@gmail.com>
 <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.781.v12.git.git.1594178716840.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-07-08 03:25:16+0000, sunlin via GitGitGadget <gitgitgadget@gmail.com> wrote:
> +	# Check whether we should use 'meld --auto-merge ...'
> +	if test -z "$meld_use_auto_merge_option"
>  	then
> -		: old ones mention --output and new ones just say OPTION...
> -		meld_has_output_option=true
> -	else
> -		meld_has_output_option=false
> +		meld_use_auto_merge_option=$(git config mergetool.meld.useAutoMerge)
> +		case "$meld_use_auto_merge_option" in
> +		true|false)
> +			: use well formatted boolean value
> +			;;
> +		auto)
> +			# testing the "--auto-merge" option only if config is "auto"
> +			init_meld_help_msg
> +
> +			case "$meld_help_msg" in
> +			*"--auto-merge"*|*'[OPTION...]')

The "*'[OPTION...]'*" part sneaks into here in v11,
And this version drops the last "*",
which makes it:

- less correct if all versions that has "[OPTION...]" supports
  --auto-merge, which is unlikely; and
- less incorrect (still not correct enough) if some versions
  that has "[OPTION...]" doesn't support --auto-merge,
  which is more likely.

If we could trace all versions of meld and confirms the former
condition, I think it's better to add back the missing "*"

Otherwise, it's safer choice to remove "|*'[OPTION...]" here.

I'm not using meld, so, if someone asked me, I would go with the latter.


-- 
Danh
