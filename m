Return-Path: <SRS0=XO6Y=EJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6EBC2D0A3
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 10:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D33206F8
	for <git@archiver.kernel.org>; Tue,  3 Nov 2020 10:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5Axxxiv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727979AbgKCKXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Nov 2020 05:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCKXL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Nov 2020 05:23:11 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45E3C0617A6
        for <git@vger.kernel.org>; Tue,  3 Nov 2020 02:23:10 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 33so7098488wrl.7
        for <git@vger.kernel.org>; Tue, 03 Nov 2020 02:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9HcfpX/qo1QY9Oiq+crhRS+EUHryW/RofM/q42KbuMg=;
        b=I5AxxxivZ7tKOTVd5o8wxAGn3QQClhClh9xhnhrJtAdLsEqU13YcDb23EB7N7cqBnZ
         xiE7CTlUbc+2eNM3abUi4ieDumiZzpMNMaiJsjaJtUq69PrH314mmxHHdRbjIClAfu3q
         0iABJAdIghSsYEFn3cjJzk2dARRXltCfPSO2WJQYTOhgdmY20HJnQCQvByN2DcjQS5lD
         dIEzW/QUKbG4Yt2IRECZJI3IxJo+ek1t79JlZrLVPBIrzXJG7d0DvM/G342xfAhOxN80
         Zzwb3yHRDHw0YBImjYkTChJU3/Qy93dAxvwYR1rWAFBi5wRKRPTScX1UiiRlucb2fV+J
         J0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9HcfpX/qo1QY9Oiq+crhRS+EUHryW/RofM/q42KbuMg=;
        b=NvSZDZT7d5Ajuy/aXrqKvc7v9/5rszVJuJzDMit/ZatVUrKETt3GnK/wcNLPT8SZZu
         qave0H6apil8nnLV0SXy9GHEyz0uz+ltrUiOSUKulhl/B1+12X51c7EVpO8VRx81dC7e
         J4usIpiAZpw6KYBYjCEOkIxNgU2+0tgEBXETyGn6Sg/VtN1CRNDomaGE3IQ0RJ2aArSS
         Vo6SQCBHGu24U21eSMjHMcI8TuL6RMgxzh+ZDJxVIp3zGxsiCxIvWN6pXKDxQJ5G9ovQ
         3O299a/xXMZmOaeOJBWk4jZGSQDfAZIWJaVn5rbFD7zyakMS3aM5jJ5uECk3OAuH//J2
         sSJg==
X-Gm-Message-State: AOAM531dEPNiMU1r2la5cM5XPZPISGNKeltywZ6YwmRZD9NakzWlYMPD
        Quz7byJnesvmN/CTQlwKGcA=
X-Google-Smtp-Source: ABdhPJw7+pZwwEvIxLxEJnT4Ii6FpZS3IA46f2VDsHernCqJJFCSkTL3sjxVdHHSb4mVUv9opHjPnQ==
X-Received: by 2002:a5d:5387:: with SMTP id d7mr25016914wrv.224.1604398989503;
        Tue, 03 Nov 2020 02:23:09 -0800 (PST)
Received: from szeder.dev (94-21-29-156.pool.digikabel.hu. [94.21.29.156])
        by smtp.gmail.com with ESMTPSA id 30sm25413093wrs.84.2020.11.03.02.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2020 02:23:09 -0800 (PST)
Date:   Tue, 3 Nov 2020 11:23:07 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/4] push: teach --base for ssh:// and file://
Message-ID: <20201103102307.GI24813@szeder.dev>
References: <cover.1604362701.git.jonathantanmy@google.com>
 <148e39960a2185d2355cdfe34f8856e708fb1b80.1604362701.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <148e39960a2185d2355cdfe34f8856e708fb1b80.1604362701.git.jonathantanmy@google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 02, 2020 at 04:26:11PM -0800, Jonathan Tan wrote:
> diff --git a/t/t5700-protocol-v1.sh b/t/t5700-protocol-v1.sh
> index 022901b9eb..22459d37f5 100755
> --- a/t/t5700-protocol-v1.sh
> +++ b/t/t5700-protocol-v1.sh
> @@ -146,6 +146,56 @@ test_expect_success 'push with file:// using protocol v1' '
>  	grep "push< version 1" log
>  '
>  
> +test_expect_success 'push with file:// using protocol v1 and --base' '
> +	test_commit -C file_child four &&
> +	COMMON_HASH=$(git -C file_child rev-parse three) &&
> +
> +	# Push to another branch, as the target repository has the
> +	# master branch checked out and we cannot push into it.
> +	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=1 \
> +		push --base=three origin HEAD:client_branch_four 2>log &&
> +
> +	# Server responded using protocol v1
> +	grep "push< version 1" log &&
> +	# Server advertised only the expected object
> +	grep "$COMMON_HASH .have" log
> +'
> +
> +test_expect_success 'push with file:// using protocol v0 and --base' '
> +	test_commit -C file_child five &&
> +	COMMON_HASH=$(git -C file_child rev-parse four) &&
> +
> +	# Push to another branch, as the target repository has the
> +	# master branch checked out and we cannot push into it.
> +	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=0 \
> +		push --base=four origin HEAD:client_branch_five 2>log &&
> +
> +	# Server did not respond with any version
> +	! grep "push< version" log &&
> +	# Server advertised only the expected object
> +	grep "$COMMON_HASH .have" log
> +'
> +
> +test_expect_success 'push with invalid --base' '
> +	test_commit -C file_child six &&
> +
> +	# Server does not have "six".
> +	test_must_fail git -C file_child -c protocol.version=0 \
> +		push --base=an_invalid_object origin HEAD:client_branch_six 2>log &&
> +	grep "is not a valid object" log

This should rather use 'test_i18ngrep' ...

> +'
> +
> +test_expect_success 'push with --base that does not exist on server' '
> +	COMMON_HASH=$(git -C file_child rev-parse six) &&
> +
> +	# The push still succeeds.
> +	GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=0 \
> +		push --base=six origin HEAD:client_branch_six 2>log &&
> +
> +	# Server did not advertise "six", since it does not know it
> +	! grep "$COMMON_HASH .have" log
> +'
> +
>  # Test protocol v1 with 'ssh://' transport
>  #
>  test_expect_success 'setup ssh wrapper' '


> diff --git a/transport.c b/transport.c
> index ffe2115845..531ca0a834 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -236,6 +236,10 @@ static int set_git_option(struct git_transport_options *opts,
>  		list_objects_filter_die_if_populated(&opts->filter_options);
>  		parse_list_objects_filter(&opts->filter_options, value);
>  		return 0;
> +	} else if (!strcmp(name, TRANS_OPT_PUSH_BASE)) {
> +		if (get_oid(value, &opts->push_base))
> +			die(_("transport: '%s' is not a valid object"), value);

... because the error message here is translated.

> +		return 0;
>  	}
>  	return 1;
>  }
