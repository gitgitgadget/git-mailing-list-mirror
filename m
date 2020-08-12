Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF04C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 116BB2080C
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Br4SEEWX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHLPxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgHLPxP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 11:53:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC82C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 08:53:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id jp10so2828733ejb.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 08:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JUQCQuWn9CJ0kRdLuDGhjsO/XtgvAeB70VCLnx8pt94=;
        b=Br4SEEWX/ZFJYHe14134I4wkbWEXSRzhTEzQTCbGdomKoIfUnZhoWPpDYPfG6g2O9S
         XNOSRkbf8szH8NtHVhS9shgiU3iqAnbdY/ZkFaEiEpNAbNUMiweHxAohXvU6wKHAI7cT
         E5FauWrsWkO7867KJvSqSagsht9wHMjFUHZcFxNvSLa9qNKdIuA0VNAtMUGmHxib1h9M
         F2bS0FuMpZUPb0o6mjOUVgOVnHXMYKaL/VJ+fH8eOzjfni4E77eu85yAFRHsz4/BvWLW
         m4gH9V5T6AjHWHiuRoeTZg44leG3ofdH6S2CAnDdgMQZafV1MkdG7Kfhf5Y45+woQg6o
         +NTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JUQCQuWn9CJ0kRdLuDGhjsO/XtgvAeB70VCLnx8pt94=;
        b=hRg33Qjwq6PG+Myt2WZf89zRbQOTgtRVE5BMOyCWze+HK2KmYxOjvbqvPI34L2sRP3
         iOZ+jEN5yjwuryTGcfst8tqaHW8ZmUsAFXnoX4Rnf07E/V7qL51MZB93B8PiS3bx2LNM
         cUksX3aiZ2PJX6l0bMccGqwFdKiAP4bNvb+MnyGJcycPAO94tolxjpI4IinRKLMRZDVV
         T+mXDDwZAmp3FBIW8u7DPZqIGwV2pq1mjFvfpZ29ajxmVGRcXHXzYWO3XkxhwPAuSLl+
         U86E1/KuaTf7wQWirYrRwHfv8wSnHgXtiSV44ona108/BsUWvj0CeiVLG5idBrrkbV1S
         CfNg==
X-Gm-Message-State: AOAM533ZuvgKQXVnLcchpWzg3rQWP5fQzXWXvBPs8GPNQCzZhqAEd8Fo
        SHM67lwtK2MgqSN3YFi7EsWZ5g8S
X-Google-Smtp-Source: ABdhPJzwDFVkSpj7hopAynSQQZuIzNoJhWOwDaygrQZK3ssyyFBh51+56g4JPm87UWFBjvqH06+3mw==
X-Received: by 2002:a17:907:104a:: with SMTP id oy10mr408850ejb.267.1597247593794;
        Wed, 12 Aug 2020 08:53:13 -0700 (PDT)
Received: from szeder.dev (62-165-238-100.pool.digikabel.hu. [62.165.238.100])
        by smtp.gmail.com with ESMTPSA id h18sm1670506edw.56.2020.08.12.08.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 08:53:13 -0700 (PDT)
Date:   Wed, 12 Aug 2020 17:53:06 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v13 2/5] bugreport: add tool to generate debugging info
Message-ID: <20200812155306.GA23524@szeder.dev>
References: <20200416211807.60811-1-emilyshaffer@google.com>
 <20200416211807.60811-3-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200416211807.60811-3-emilyshaffer@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 02:18:04PM -0700, Emily Shaffer wrote:
> Teach Git how to prompt the user for a good bug report: reproduction
> steps, expected behavior, and actual behavior. Later, Git can learn how
> to collect some diagnostic information from the repository.
> 
> If users can send us a well-written bug report which contains diagnostic
> information we would otherwise need to ask the user for, we can reduce
> the number of question-and-answer round trips between the reporter and
> the Git contributor.
> 
> Users may also wish to send a report like this to their local "Git
> expert" if they have put their repository into a state they are confused
> by.
> 
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---

> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> new file mode 100755
> index 0000000000..2e73658a5c
> --- /dev/null
> +++ b/t/t0091-bugreport.sh
> @@ -0,0 +1,61 @@
> +#!/bin/sh
> +
> +test_description='git bugreport'
> +
> +. ./test-lib.sh
> +
> +# Headers "[System Info]" will be followed by a non-empty line if we put some
> +# information there; we can make sure all our headers were followed by some
> +# information to check if the command was successful.
> +HEADER_PATTERN="^\[.*\]$"
> +
> +check_all_headers_populated () {

I'm afraid that this helper function doesn't do what it was supposed
to.

> +	while read -r line

It iterates through each line of stdin, which is a file written by
'git bugreport'.

> +	do
> +		if test "$(grep "$HEADER_PATTERN" "$line")"

This first tries to find a match in the _file_ called "$line", which never
exists, resulting in trace output:

  + check_all_headers_populated
  + read -r line
  + grep ^\[.*\]$ Thank you for filling out a Git bug report!
  grep: Thank you for filling out a Git bug report!: No such file or directory
  + test 
  + read -r line
  + grep ^\[.*\]$ Please answer the following questions to help us understand your issue.
  grep: Please answer the following questions to help us understand your issue.: No such file or directory
  + test
  + read -r line
  + grep ^\[.*\]$
  grep: : No such file or directory
  [...]

Then, since 'grep' doesn't print any matches to its stdout, it invokes

  test ""

which always returns non-zero, so that if condition is never fulfilled.

On first sight I thought that simply changing that 'grep' invocation
to something like:

  $(printf "%s\n" "$line" | grep "$HEADER_PATTERN")

would be sufficient to fix it, but then the first test failed... and
I'm not sure that I understand what this was supposed to check in the
first place.

> +		then
> +			echo "$line"
> +			read -r nextline
> +			if test -z "$nextline"; then
> +				return 1;
> +			fi
> +		fi
> +	done
> +}
> +
> +test_expect_success 'creates a report with content in the right places' '
> +	test_when_finished rm git-bugreport-check-headers.txt &&
> +	git bugreport -s check-headers &&
> +	check_all_headers_populated <git-bugreport-check-headers.txt
> +'
