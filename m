Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFD9C35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 22:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE4FA20659
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 22:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZeWKdEFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbgBKWk1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 17:40:27 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43504 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgBKWk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 17:40:26 -0500
Received: by mail-pl1-f196.google.com with SMTP id p11so126805plq.10
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 14:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6+ZigYEZxLnXKmsmgDvakjGc7KrTAjH3X64k93zss6c=;
        b=ZeWKdEFB2fjKFE71jiMwbQYkFFwD0HsiY4xt7nb7LLWk/qpYtNB8JnNDwQtuCdubom
         AWUK9Ry3/Dn1+cID4qkf1V5x86rok3MnSzKbvc9QG7LIBob2STM6md4hB7VM5T9psAHp
         S23FksQb0zLVDFPVAh6vKqFUVRihnjRgV3jUoUE6LhnvGYqghM14TYxOjOkwWmqLpYmR
         1UDR7QkuCZbiffjUSyTgQwrB8Jt8hnI9aPzi+NrkV1pVFxN9yCvL10xrB8IUaNhlFI4j
         mx/tzQEOWcWydQ+YvQDxR366KvkTuHYtyjP170OFfLYy0kv3b7ftgoJGjXhoLzN8h4qp
         AcVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6+ZigYEZxLnXKmsmgDvakjGc7KrTAjH3X64k93zss6c=;
        b=Ec2Q9F4dsxCujIJ8GZXlPFUHs+hi+VJDbvqxJi+lBmX5LBWCifaS82B8apAcette4G
         YxmeTwjzk2fs9i4yINL7/e/Xal/6GaGhAhLab44lo5yVK21IfXEjSBnnoG3WyKHshfGN
         GDHHD55h1Y4P73dHGR/G6XTL5ITQ30cwT9vYDnDAYvm2DZg4v1KxXjpt/ztlmGo+qHdv
         uX0SMq1Cd3FxwH4+WpTcqhmTEf7LDU212IeNN2XB0JrDBGn+OVm3OGIIr6kXkuZQEj5v
         K2nWHaWUX/f2R++rVqlr2W3ViAaPgLU6jKttLC97tWV5JgR62gE4EtbrOTSvx54XCu1m
         +vig==
X-Gm-Message-State: APjAAAVW1k/6MX4uKM8VJkgtmn+z705/nXIIKr4rU901gCR0AD0rtNos
        YjG6xI5Ci//D0+5bFdhjwKIuGw==
X-Google-Smtp-Source: APXvYqzEpF3Hz4cXzhSTvCWsqI4cnEHSoqHWAkcQ5Rb/cUla7UG5ZUK03M6pSVMI2QX/mmcSKrWhKw==
X-Received: by 2002:a17:90b:3109:: with SMTP id gc9mr6237311pjb.30.1581460825895;
        Tue, 11 Feb 2020 14:40:25 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id o14sm4920094pgm.67.2020.02.11.14.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 14:40:25 -0800 (PST)
Date:   Tue, 11 Feb 2020 14:40:21 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v6 03/15] bugreport: add tool to generate debugging info
Message-ID: <20200211224021.GF190927@google.com>
References: <20200206004108.261317-1-emilyshaffer@google.com>
 <20200206004108.261317-4-emilyshaffer@google.com>
 <20200207141802.GE2868@szeder.dev>
 <xmqq5zgi44em.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqq5zgi44em.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 07, 2020 at 10:51:29AM -0800, Junio C Hamano wrote:
> SZEDER Gábor <szeder.dev@gmail.com> writes:
> 
> > On Wed, Feb 05, 2020 at 04:40:56PM -0800, Emily Shaffer wrote:
> >> diff --git a/t/t0091-bugreport.sh b/t/t0091-bugreport.sh
> >> new file mode 100755
> >> index 0000000000..451badff0c
> >> --- /dev/null
> >> +++ b/t/t0091-bugreport.sh
> >> @@ -0,0 +1,49 @@
> >> +#!/bin/sh
> >> +
> >> +test_description='git bugreport'
> >> +
> >> +. ./test-lib.sh
> >> +
> >> +# Headers "[System Info]" will be followed by a non-empty line if we put some
> >> +# information there; we can make sure all our headers were followed by some
> >> +# information to check if the command was successful.
> >> +HEADER_PATTERN="^\[.*\]$"
> >> +check_all_headers_populated() {
> >> +	while read -r line; do
> >> +		if test "$(grep "$HEADER_PATTERN" "$line")"; then
> >> +			echo "$line"
> >> +			read -r nextline
> >> +			if test -z "$nextline"; then
> >> +				return 1;
> >> +			fi
> >> +		fi
> >> +	done
> >> +}
> >> +
> >> +test_expect_success 'creates a report with content in the right places' '
> >> +	git bugreport &&
> >> +	REPORT="$(ls git-bugreport-*)" &&
> >
> > What if the globbing were to match more than one file?
> 
> An often-useful pattern is to make the command report the output
> filename, i.e.
> 
> 	REPORT=$(git butreport) &&
> 
> if the design insists that "git bugreport" should allocate a
> filename in order to make it easy to guarantee uniqueness.
> 
> Of course, we can make the invoker supply filename, e.g.
> 
> 	REPORT=$(generate-output-filename) &&
> 	git bugreport -o "$REPORT" ;# or git bugreport >"$REPORT"

Yeah, this is an option and I've changed the offending test - which
captures a variable based on globbing - to use --suffix and force a
filename.
