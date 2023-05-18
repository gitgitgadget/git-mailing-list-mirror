Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C7BC77B7A
	for <git@archiver.kernel.org>; Thu, 18 May 2023 21:29:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjERV33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 May 2023 17:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjERV3P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2023 17:29:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E221BF8
        for <git@vger.kernel.org>; Thu, 18 May 2023 14:28:40 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-25374c9be49so509194a91.3
        for <git@vger.kernel.org>; Thu, 18 May 2023 14:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684445303; x=1687037303;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhnTNt0EJ+V8R/Ljibsn9rRMELj4OOmLKnJbvRM5STI=;
        b=lV9SOCu55R+5wdTBGG5Uhd5ld1BD2t8nOASw/j73g+bL+wOxth/1aeRQIm7p3k8HOA
         oiNfAAVqIcm6Mn+9eZkpa3wdLWP9wL2EgzZ63p9k/oAbBV4aad14HsbU3vs/ZYXgSMM4
         /A4H4Fid1uO1byTuMm+4zjc7r7tZxycSpHFxwablLBT/rIYL/93L7FqA1We8o4RINyPm
         lSNjtQ74EgSfgS1pQzyEUcmAFP0Abcmnx4kWDv4B7sYdqpEULbthvHsNIa5mbATxPkon
         yYd/dRLsy3BvB2FHg0kCt7JBuYTmLs7tM/1009bV24JBdX/4VQ1QNiSCnAidMuhhiBZG
         a5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684445303; x=1687037303;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qhnTNt0EJ+V8R/Ljibsn9rRMELj4OOmLKnJbvRM5STI=;
        b=TTQHBfGfRc2ledKXosKGgnj+MIHj7lB1kdiX3XZxOkgAHLIAKdXmB8qKo/GBG6Xn5G
         VoczUGqC5RjJ6Jh+++yGLMFPGH1HaH93Q+bZPbYoDmjJerEfunW8cm21trIFgWiF8+y+
         fbf3SvQGtivUqnp9Q0qgVzo4Pa2AKHxXg2VNnjznUCANIY93zNwgbPF62qb+OLCV8dyT
         I2YCsXyo5erdyPGi44S8kP1/Oipc7J6iDRr4G2fzLN/iXUfRdAR5F1H+VI9byfLy3UF2
         LS75DYDOyMnlCn1LBeXseL14MXbIStWwzHTONH5rhZFWgMpL/pa/Mzk1+r3jH/2lC1B7
         xW7w==
X-Gm-Message-State: AC+VfDzW4Af93hcibuTgnqf0586PPobngq59Uwb8GNohLWnUrORJ0Ewh
        wOLMdyNPcaQLor3iXe+4sN8=
X-Google-Smtp-Source: ACHHUZ7PiFtjU7a0PxkBKVwyi11nFjCntWYYCYgq8VjAlKJLaz72FxzJO8t0TOdGDvBCmWNP4Wj3nA==
X-Received: by 2002:a17:90a:1bcf:b0:253:2ee7:bbd with SMTP id r15-20020a17090a1bcf00b002532ee70bbdmr4048416pjr.11.1684445302966;
        Thu, 18 May 2023 14:28:22 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090a9b0600b0024dfb8271a4sm128635pjp.21.2023.05.18.14.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 14:28:22 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org,
        Matthew John Cheetham <mjcheetham@outlook.com>
Subject: Re: [BUG 2.41.0] t/lib-httpd/apache.conf incompatible with
 RHEL/CentOS 7
References: <ZGUlqu7sP7yxbaTI@pobox.com>
        <20230518184532.GC557383@coredump.intra.peff.net>
        <20230518192102.GA1514485@coredump.intra.peff.net>
Date:   Thu, 18 May 2023 14:28:22 -0700
In-Reply-To: <20230518192102.GA1514485@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 18 May 2023 15:21:02 -0400")
Message-ID: <xmqqpm6xs51l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, May 18, 2023 at 02:45:32PM -0400, Jeff King wrote:
>
>>   2. We do some kind of version check in enable_cgipassauth(),
>>      and skip tests manually if it doesn't pass.
>> [...]
>> Obviously (1) and (3) are the least work for us upstream, but I don't
>> think (2) would be too hard to do.
>
> It indeed was pretty easy. So here's a patch. I'm adding Junio to the cc
> before any review, as this is a change in the v2.41 cycle. So I think
> we'd want to address this before the release.

Thanks for being considerate, as always ;-)  Very much appreciated.

> -- >8 --
> Subject: [PATCH] t/lib-httpd: make CGIPassAuth support conditional
>
> Commit 988aad99b4 (t5563: add tests for basic and anoymous HTTP access,
> 2023-02-27) added tests that require Apache to support the CGIPassAuth
> directive, which was added in Apache 2.4.13. This is fairly old (~8
> years), but recent enough that we still encounter it in the wild (e.g.,
> RHEL/CentOS 7, which is not EOL until June 2024).

nitpick: we are fine to encountering 2.4.13 in the wild---encountering
something a bit older than that is problematic.  A quick internet
search tells me that CentOS 7 ships Apache 2.4.6, so if we trust that...

    ... fairly old (~8 years), but recent enough that we still
    encounter versions older than that in the wild (e.g.  CentOS 7,
    which is not EOL until June 2024, comes with Apache 2.4.6 from
    2014 plus security fixes).

or something?

> I tested this manually by mutilating the config directive to "FooBar",
> which would fail even on recent versions. And then tweaking the "13"
> in the version check up to "60" to make sure it properly skips even with
> recent Apache. But testing on real CentOS 7 would be very much
> appreciated.

Indeed, we'd love to see tests on a real thing, especially if we
were to fast-track this.  FWIW, the manual test you outlined above
sounds like a very sensible way to "emulate" under the condition
that there is no access to the real thing.

> +enable_cgipassauth () {
> +	# We are looking for 2.4.13 or more recent. Since we only support
> +	# 2.4 and up, no need to check for older major/minor.
> +	if test "$HTTPD_VERSION_MAJOR" = 2 &&
> +	   test "$HTTPD_VERSION_MINOR" = 4 &&
> +	   test "$(echo $HTTPD_VERSION | cut -d. -f3)" -lt 13

As HTTPD_VERSION comes from 

	$LIB_HTTPD_PATH -v | sed -n 's|^Server version: Apache/\([0-9.]*\).*|p'

and parses a line like "Server version: Apache/2.4.6 (CentOS)",
unless somebody ships 2.4 without any digit after it, the above
should be safe ;-)

> +	then
> +		echo >&4 "apache $HTTPD_VERSION too old for CGIPassAuth"
> +		return
> +	fi
> +	HTTPD_PARA="$HTTPD_PARA -DUSE_CGIPASSAUTH"
> +	test_set_prereq CGIPASSAUTH
> +}

OK.

> diff --git a/t/lib-httpd/apache.conf b/t/lib-httpd/apache.conf
> index 9e6892970d..a22d138605 100644
> --- a/t/lib-httpd/apache.conf
> +++ b/t/lib-httpd/apache.conf
> @@ -146,7 +146,9 @@ SetEnv PERL_PATH ${PERL_PATH}
>  <LocationMatch /custom_auth/>
>  	SetEnv GIT_EXEC_PATH ${GIT_EXEC_PATH}
>  	SetEnv GIT_HTTP_EXPORT_ALL
> +	<IfDefine USE_CGIPASSAUTH>
>  	CGIPassAuth on
> +	</IfDefine>
>  </LocationMatch>
>  ScriptAlias /smart/incomplete_length/git-upload-pack incomplete-length-upload-pack-v2-http.sh/
>  ScriptAlias /smart/incomplete_body/git-upload-pack incomplete-body-upload-pack-v2-http.sh/
> diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
> index f45a43b4b5..ab8a721ccc 100755
> --- a/t/t5563-simple-http-auth.sh
> +++ b/t/t5563-simple-http-auth.sh
> @@ -5,6 +5,12 @@ test_description='test http auth header and credential helper interop'
>  . ./test-lib.sh
>  . "$TEST_DIRECTORY"/lib-httpd.sh
>  
> +enable_cgipassauth
> +if ! test_have_prereq CGIPASSAUTH
> +then
> +	skip_all="no CGIPassAuth support"
> +	test_done
> +fi
>  start_httpd
>  
>  test_expect_success 'setup_credential_helper' '

Yup, very cleanly done.

Thanks.
