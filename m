Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 873A6C636D3
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 21:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBIVpO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 16:45:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBIVpN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 16:45:13 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B315EF9F
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 13:45:12 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id s8so2462421pgg.11
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 13:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nchmfCfn0+IQYkFnBxNRLNIqwbOaqiUIoabzvYRtTcI=;
        b=Skk2Nfq6mlaJ6tlXvQBKO4SwGX46ITVQCV2dCcoD5P3Ax4gwv9EneqxnyTIHk77HtC
         8j2j6WyzTS0l1dBAzutYJbYGPiZLpeC8L+4K/3sOs+MN7xqY52xUR/VwBoCiP6cjzllR
         pOLUop6F4VFJDj5+aT6SpIfQG+oarJjfXtmGuHxywPFZ5bLCXA1+P0vD8Z+POMTpXSyN
         N50BldOf2kMeDk3aprt+MQ8MHe1zLayG8unY3PmljrmKKP5a36y4AgMblt6kvJLKvqsB
         lJ9Bdo2z0P8U94UWQVHg3yeXdHVVgJ8ZxXmASmJqSIn7I5q9Brpm4y/Espd/eLP+jSfh
         u39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nchmfCfn0+IQYkFnBxNRLNIqwbOaqiUIoabzvYRtTcI=;
        b=2emIaft3ESwrsT51ZXcPU6BbvTZrDTGiwLAB3aCkla/ETvcjfkuNLhSw6gzIHeogjW
         xmlDIuQAkwwJlrwWfRkWESoRCSrgHLbIq8+eNvDkwE4b4HUX2e423Jeo7CXU5+uU4uXm
         hRbGVklWYPGDQK4vMU7dCv+sgZS8NVXwPJs4wp3262qyA2Roi5nohVBXOIGQJHtiJKen
         DqcttNM7kWfmv46xJRsVSjZeZKFq573XByiNmiNwEU0qRhYm+dYzYcHMHAvFbSzaA9Ly
         ouHwwUbU5ciFkg563tT+jjibVd5cpxv1q+EGONSkur+2mO+Zw18Z+VGYiwg/jsadKjzz
         ddyA==
X-Gm-Message-State: AO0yUKXLIF2qTlQWIpRTh+74ynrz34bsQLDIFIYH0QgSqLRDkB8iFUFU
        Dy8drb7jKbwXVz+DapDb900=
X-Google-Smtp-Source: AK7set/H5OjXipizoOPAvk4z7Ey/i7k4oqWSIx7keB5T/aahC81kgv3954wi0aRlU1g+x7+l74q1Tw==
X-Received: by 2002:aa7:96d1:0:b0:592:6313:20fb with SMTP id h17-20020aa796d1000000b00592631320fbmr10960874pfq.30.1675979111662;
        Thu, 09 Feb 2023 13:45:11 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id x7-20020aa79187000000b005a84ef49c63sm1884256pfa.214.2023.02.09.13.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 13:45:11 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Todd Zullinger <tmz@pobox.com>, git@vger.kernel.org
Subject: Re: t5559 breaks with apache 2.4.55
References: <Y8ztIqYgVCPILJlO@coredump.intra.peff.net>
        <Y81lQwG85+Skujja@pobox.com>
        <Y9Jmfg/jlSszVep4@coredump.intra.peff.net>
        <Y9YTsF4a8lL7uHm+@coredump.intra.peff.net>
Date:   Thu, 09 Feb 2023 13:45:10 -0800
In-Reply-To: <Y9YTsF4a8lL7uHm+@coredump.intra.peff.net> (Jeff King's message
        of "Sun, 29 Jan 2023 01:35:28 -0500")
Message-ID: <xmqq357ems2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> But that does at least give me more confidence that the bug is in
> mod_http2, and isn't, say, some intentional behavior change there that
> happens to trigger a bug in curl.
>
> I opened an issue here: https://github.com/icing/mod_h2/issues/243
>
> So we'll see if that helps.

Thanks.  I've seen that the above issue may have redirected the
investigation to cURL, and over time, I expect taht this will start
to trigger in more environments (as Apache 2.4.55 and mod_h2 2.0.10
propagates) before it fixes itself (as fixed versions of these
things we use in our tests percolates down).

In the meantime, perhaps we should punt with a patch like this?


------------ >8 ------------
Subject: [PATCH] t5559: skip a known-to-be-broken test

t5559 runs the same set of tests as t5551 under HTTP/2 but one of
them started failing with Apache 2.4.55 and mod_h2 2.0.10 (but not
with HTTP/1.1).  Newer mod_h2 is known to have fixed the issue.

In the meantime, skip the test.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5551-http-fetch-smart.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git c/t/t5551-http-fetch-smart.sh w/t/t5551-http-fetch-smart.sh
index bc0719a4fc..52159e8b6f 100755
--- c/t/t5551-http-fetch-smart.sh
+++ w/t/t5551-http-fetch-smart.sh
@@ -350,7 +350,8 @@ test_expect_success CMDLINE_LIMIT \
 	)
 '
 
-test_expect_success 'large fetch-pack requests can be sent using chunked encoding' '
+# https://github.com/icing/mod_h2/issues/243
+test_expect_success !HTTP2 'large fetch-pack requests can be sent using chunked encoding' '
 	GIT_TRACE_CURL=true git -c http.postbuffer=65536 \
 		clone --bare "$HTTPD_URL/smart/repo.git" split.git 2>err &&
 	{

