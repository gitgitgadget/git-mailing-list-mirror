Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00ABC2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:57:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87EBE206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWu18yFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbfLZT5u (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:57:50 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39571 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZT5u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 14:57:50 -0500
Received: by mail-pj1-f68.google.com with SMTP id t101so3874535pjb.4
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 11:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dEzClB9lou0GQQouXEKqSUeY88Cu5sBKrW9yaizm5uM=;
        b=cWu18yFazWGbGv2Yub1sDJ8ZtEeB/xpgCcO3ouOGegP2dg/sbM7ZoxpCnZn1/c5QAn
         1Iey+pIwK5AL895isLwHsHEB84I0lZxPLdHPAEjtCSdqbTmoxXw+lal4UG2ocno1r9Fs
         3ud9cJ31OgxnCugqyOy1N95lcUuKAH2blhQSRObOrBWaOAK4JXn5Zj9jTo4TDDuMNzoE
         FcGQmCNgvGnzLCiA2yLcbuPloBiS/qB+1mj+0XSzNpobKYB8J2c8+aXfPzrLRpTOQJ/8
         e/KRwdA2UxbmHdNsBJ7MDSlXn697Ed3yg7NDzdj7Nvda6pf4SwscmhnxhvwQwYtqovsv
         FWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dEzClB9lou0GQQouXEKqSUeY88Cu5sBKrW9yaizm5uM=;
        b=OPkkkMRSnSlDLzTxdMoEiOSXpx7anfSCqdfsRpRh4SCw3/Quu6mWJW699VD4uaFnr8
         4a0DYkqacc0ilUHiNVyGP1FcS1x4t4vtO/LxV5XlWd6SfBHmstGXQLkw47hKztzCGdRE
         SP81pX77WwDilREcSkRsRw2lr9dRB++27SR/du32LMdN8SDhZ/oZH3swdah+C7d6UJt7
         5mWOVSHOi6g8OMRRl0w8raSPHtHky6+/oWfE/3hdTY4pZ03tFsG3Q6h2DE8Y1CWEsREp
         x1KmGBHlqAz99oZJJfy9sg/0zs0XQH9+tkzHwwiuROr8AWE2YAUMuVKTXRsH3LkLNbyQ
         xqyA==
X-Gm-Message-State: APjAAAV+tWB2JQyCU81T+jD8TGNN08b9aUGn9VDXY8V1W3eu6m0dYadI
        7Z3JndyUyH8QKP22ogKbsdRo/MX0
X-Google-Smtp-Source: APXvYqwxi7RY75t9Tqu3hphk2rKO+S6JqD+ldFhN51eZ21ojP6yeXo7CEKQ0h0ilA7uNu9MZEIzLAA==
X-Received: by 2002:a17:902:8d88:: with SMTP id v8mr35010931plo.66.1577390269474;
        Thu, 26 Dec 2019 11:57:49 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i3sm36961013pfg.94.2019.12.26.11.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 11:57:49 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:57:47 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/2] t/check-non-portable-shell: detect "FOO= shell_func", too
Message-ID: <20191226195747.GC170890@google.com>
References: <20191224005816.GC38316@google.com>
 <20191224010110.GF38316@google.com>
 <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
 <20191226195357.GA170890@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191226195357.GA170890@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Just like assigning a nonempty value, assigning an empty value to a
shell variable when calling a function produces non-portable behavior:
in some shells, the assignment lasts for the duration of the function
invocation, and in others, it persists after the function returns.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
If it would be useful for me to send a copy of the "Enable protocol v2
by default" series rebased on top of this, let me know.

Thanks again for catching it.

Sincerely,
Jonathan

 t/check-non-portable-shell.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 38bfeebd88..fd3303552b 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -46,7 +46,7 @@ sub err {
 	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
 	/\bgrep\b.*--file\b/ and err 'grep --file FILE is not portable (use grep -f FILE)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (use FOO=bar && export FOO)';
-	/^\s*([A-Z0-9_]+=(\w+|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
+	/^\s*([A-Z0-9_]+=(\w*|(["']).*?\3)\s+)+(\w+)/ and exists($func{$4}) and
 		err '"FOO=bar shell_func" assignment extends beyond "shell_func"';
 	$line = '';
 	# this resets our $. for each file
-- 
2.24.1.735.g03f4e72817

