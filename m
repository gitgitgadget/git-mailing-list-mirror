Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2587B1F454
	for <e@80x24.org>; Mon, 22 Oct 2018 05:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJVOEm (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 10:04:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39191 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbeJVOEm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 10:04:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id y144-v6so8898491wmd.4
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kgdE2nKZTrYjfM2lSQiV8/smXLGoQPng/2jNjRKbJbU=;
        b=tJvgpF6/J2zvvzmKsjRyXCaQVn1BXLNEAt8CgnDoxcgyw5ThXRJCQMouQipCDKGlgB
         XwAhIPP7sM4BdIXts/Q9xCwxBtjKAanJOUVzKsV5uye3+lKC4zv4M7z3Pjg6srEZyuI4
         BB5da8qN7/turHyfC2uqZejWzvMrjcoDCjDP+ZnKbktIHKmik6Esau3WDQevl0STsKvk
         eAbl0kUTFHoboBGuVem3PeJEDP+il2Z+wNEgog0/9khpA7dlhd5ZpF71cpDlMrZrWAMM
         l4e3Judty4pBmVe+kCdMc0DCS0gpK9UbfkkiVy7kFLiWjSYHy66GwGyuCTW+iwuZv7Z9
         L1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kgdE2nKZTrYjfM2lSQiV8/smXLGoQPng/2jNjRKbJbU=;
        b=d8d9vHfFrlqvWpvLZECt1+WiDznfrUr0YHHfZ6O7NrUcMrYK+rH32Po0yiOmgJhseK
         BghYZw5gf1sANmTMohIyi0Jnfk4zZ0Eou7n37Tc3EiEBI/gsd1cskj6ITLlAt1n+sIA4
         1203oEu+5udA6BbhwN1HzgIltMXnOTYp9NHFLQ03Rg65MM0Re92ZDAJ4oxnnURvGU24K
         0VEPyaGTpiPuA12AiYpnWo9S1G/+s+hizR53RiM0LAnNkI9UvHbhh5FsKcbSoWqvIrdl
         1h08V9dZFf03/e0QEhZUPxHVBlOJBdFH/Ci5ZSL1KzDL5cgmHDCJt/CIqX9/L4WANUQV
         C78Q==
X-Gm-Message-State: ABuFfogthlLMXrNE2EUYR4gwHcH8e9E+Co1c2JpMHgYaHDYmSqY4xTXP
        Z2KZXcYDW8sJHhosLDq6rAY=
X-Google-Smtp-Source: ACcGV60VXtI+YVFatQ+r6LuzN7vm3O3qEaHENyQAQ9vMrSGDubQxeVnRP68gDDObaIiMLmivxv7VIw==
X-Received: by 2002:a1c:5d8c:: with SMTP id r134-v6mr13695814wmb.147.1540187259584;
        Sun, 21 Oct 2018 22:47:39 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l67-v6sm29747024wma.20.2018.10.21.22.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 22:47:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] fetch-pack: be more precise in parsing v2 response
References: <20181019225404.34496-1-jonathantanmy@google.com>
Date:   Mon, 22 Oct 2018 14:47:37 +0900
In-Reply-To: <20181019225404.34496-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 19 Oct 2018 15:54:04 -0700")
Message-ID: <xmqqwoqav8g6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> +	GIT_TRACE_PACKET="$(pwd)/log" test_must_fail git -C http_child \
> +		-c protocol.version=2 \
> +		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&

Because test_must_fail is a shell function, the above is not a
correct way to say "I want GIT_TRACE_PACKET exported only while this
thing runs".

I'll squash the following in.

 t/t5702-protocol-v2.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 51009ca391..d58fbfa9e5 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -555,7 +555,7 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	printf "/acknowledgments/,$ s/0000/0001/" \
 		>"$HTTPD_ROOT_PATH/one-time-sed" &&
 
-	GIT_TRACE_PACKET="$(pwd)/log" test_must_fail git -C http_child \
+	test_must_fail env GIT_TRACE_PACKET="$(pwd)/log" git -C http_child \
 		-c protocol.version=2 \
 		fetch "$HTTPD_URL/one_time_sed/http_parent" 2> err &&
 	grep "fetch< acknowledgments" log &&
