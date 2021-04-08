Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD1DBC433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A69D561001
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:36:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbhDHVhB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhDHVhB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 17:37:01 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6396CC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 14:36:49 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id a6so3589580wrw.8
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 14:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DjqQ/ZSdLdK/6FvrGtVmyV3dYhb7pjn5YXYFm7+c7qI=;
        b=b046eIy9iQQXOiGX7GG5QpqUnZu9apafYOeT/Y9GyzbN06Vny0eUyWpUBVF2N/tIrM
         yGayYiWoGLSIjrG0j9sQf8/fSPWYHZlisVj/hlW6v5Qb2+EAbFtJulco8nw41QVXoqoM
         fgCqICfwqECyhbmNBk7tGmHRMBlGqOwzcLKBnksWzf+Oe/VG7BX2Lqz7Y6Cj0JALDc9O
         q5NiQKlP+Vqd0b2gU5yjN0hxkQiwxymMRoLqX64gE+tVFJrUuM9qX8j3lXDjpEb5YA01
         dD0d45KRiiPCP1gSs2iJAF2dB5qQ1Yz0TeN9cSK7EX558/TiFyWcL6cdj+dXwcCtMYd1
         45xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DjqQ/ZSdLdK/6FvrGtVmyV3dYhb7pjn5YXYFm7+c7qI=;
        b=GtZ4k9VijIHxr0A31yPEAYeamsRlh1MxjccmPXa6PVxTn4N5Rs+GFpvs0WoZHncLUZ
         1iozKDo2NUvPdU5BN4AIq+cLcLOmt4+l5Z65AWxWA8cq8/rgq9B5cuWAI5qzrBwHXBYD
         aakSYXa0JGRYotmjz7vvy+j5bMmALjHO8Nr3qKJU/TSN2r+3rvVYuM53t5jIiyq/csRD
         3MCpcL2ntc0Mwb6s1fq/qHbA+eBWxMtP/TJ9l/thD7zsj6JS2tkDdsm3yxwdZojZOllC
         OuCAv7Hqq4/7KKOzdOv5KosfjdqNrcL3uT+Z4r+GG5sBfFjj7PebeB5xC95V1M/t5yp0
         khjA==
X-Gm-Message-State: AOAM531a2XiC4y2BnPdaBBT8eU2WgU1XZVox8qANoHhbetBNiPvbnUKL
        h07FNrgub++pAUYOHQoWVQI=
X-Google-Smtp-Source: ABdhPJzLA6nxgq4oir5FZSRKG/7a9B4IdBcfHOhPE35rrV/v9urQi5n35EisNVrW0PYXCo85pAHEcg==
X-Received: by 2002:adf:9d48:: with SMTP id o8mr14339814wre.183.1617917808167;
        Thu, 08 Apr 2021 14:36:48 -0700 (PDT)
Received: from szeder.dev (94-21-58-238.pool.digikabel.hu. [94.21.58.238])
        by smtp.gmail.com with ESMTPSA id p10sm780160wmi.0.2021.04.08.14.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:36:47 -0700 (PDT)
Date:   Thu, 8 Apr 2021 23:36:43 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 2/5] bugreport: add tool to generate debugging info
Message-ID: <20210408213643.GA2947267@szeder.dev>
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-3-emilyshaffer@google.com>
 <20200812155306.GA23524@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200812155306.GA23524@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 12, 2020 at 05:53:06PM +0200, SZEDER Gábor wrote:
> On Thu, Apr 16, 2020 at 02:18:04PM -0700, Emily Shaffer wrote:
> > Teach Git how to prompt the user for a good bug report: reproduction
> > steps, expected behavior, and actual behavior. Later, Git can learn how
> > to collect some diagnostic information from the repository.
> > 
> > If users can send us a well-written bug report which contains diagnostic
> > information we would otherwise need to ask the user for, we can reduce
> > the number of question-and-answer round trips between the reporter and
> > the Git contributor.
> > 
> > Users may also wish to send a report like this to their local "Git
> > expert" if they have put their repository into a state they are confused
> > by.
> > 
> > Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> > ---
> 
> > diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> > new file mode 100755
> > index 0000000000..2e73658a5c
> > --- /dev/null
> > +++ b/t/t0091-bugreport.sh
> > @@ -0,0 +1,61 @@
> > +#!/bin/sh
> > +
> > +test_description='git bugreport'
> > +
> > +. ./test-lib.sh
> > +
> > +# Headers "[System Info]" will be followed by a non-empty line if we put some
> > +# information there; we can make sure all our headers were followed by some
> > +# information to check if the command was successful.
> > +HEADER_PATTERN="^\[.*\]$"
> > +
> > +check_all_headers_populated () {
> 
> I'm afraid that this helper function doesn't do what it was supposed
> to.
> 
> > +	while read -r line
> 
> It iterates through each line of stdin, which is a file written by
> 'git bugreport'.
> 
> > +	do
> > +		if test "$(grep "$HEADER_PATTERN" "$line")"
> 
> This first tries to find a match in the _file_ called "$line", which never
> exists, resulting in trace output:
> 
>   + check_all_headers_populated
>   + read -r line
>   + grep ^\[.*\]$ Thank you for filling out a Git bug report!
>   grep: Thank you for filling out a Git bug report!: No such file or directory
>   + test 
>   + read -r line
>   + grep ^\[.*\]$ Please answer the following questions to help us understand your issue.
>   grep: Please answer the following questions to help us understand your issue.: No such file or directory
>   + test
>   + read -r line
>   + grep ^\[.*\]$
>   grep: : No such file or directory
>   [...]
> 
> Then, since 'grep' doesn't print any matches to its stdout, it invokes
> 
>   test ""
> 
> which always returns non-zero, so that if condition is never fulfilled.

Just a reminder that this test is still broken...

> On first sight I thought that simply changing that 'grep' invocation
> to something like:
> 
>   $(printf "%s\n" "$line" | grep "$HEADER_PATTERN")
> 
> would be sufficient to fix it, but then the first test failed... and
> I'm not sure that I understand what this was supposed to check in the
> first place.
> 
> > +		then
> > +			echo "$line"
> > +			read -r nextline
> > +			if test -z "$nextline"; then
> > +				return 1;
> > +			fi
> > +		fi
> > +	done
> > +}
> > +
> > +test_expect_success 'creates a report with content in the right places' '
> > +	test_when_finished rm git-bugreport-check-headers.txt &&
> > +	git bugreport -s check-headers &&
> > +	check_all_headers_populated <git-bugreport-check-headers.txt
> > +'
