Return-Path: <SRS0=BEVv=2T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E414C2D0CE
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 16:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4D682071E
	for <git@archiver.kernel.org>; Sun, 29 Dec 2019 16:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kaarsemaker-net.20150623.gappssmtp.com header.i=@kaarsemaker-net.20150623.gappssmtp.com header.b="t+Ibt8H5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbfL2QCC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Dec 2019 11:02:02 -0500
Received: from mail-wm1-f53.google.com ([209.85.128.53]:38119 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfL2QCC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Dec 2019 11:02:02 -0500
Received: by mail-wm1-f53.google.com with SMTP id u2so12381440wmc.3
        for <git@vger.kernel.org>; Sun, 29 Dec 2019 08:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:user-agent
         :mime-version:content-transfer-encoding;
        bh=rcpE+EJidz+zdDnuI/lBwoxfhO9NhMPjSo0Z8+r0TWw=;
        b=t+Ibt8H5Vt1EDk5mC6h9gRvbnd8iVpEt9+BQ33ROyq3HKuF0fZeh2b1sKSpdLgpasE
         Hae/jXlaVAKdStIb8nSlaj5QUhqORk0tHcFsF1GzNE+LpEtIcQQnk1M062SDfWHco7uz
         OrwhoTAsWgOApuFLgESwzlTOUQSYVE4aG+l9l+MnuDD/Y2rl3LMQ/YiVysZH4pAEQEQN
         2odi2m0aA1P9UN+SigcUI++EqgCezN0KchXBmsZIWztLs3PkZCJ7tBnrw506b6nT7mGW
         0oq7KZqPTt0rhmyDtkD66SK1UBY/cl5zXg2K19ELyVgICcFyWxv1Eu6T+8j3RduMxtaT
         D1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=rcpE+EJidz+zdDnuI/lBwoxfhO9NhMPjSo0Z8+r0TWw=;
        b=GoORQxouhN0tevN3D4R+cqWu07GWI1Ip/AcF3rO6KfiSOaskfFNk0BbfyeShVLb0Nh
         qu1YTpPWsz7EeQruh8y3FiUZgXsr54mc7OgHh5abXLCXiRrQZOuZUeaLVrWm+RxssA/x
         ZpMfJFl1WChUyL/aFlZu2C0E3YK+/id4/IrTWyLNtTCK2ewKymq2JOuf0/5eISpyqzuJ
         8zHezyIK2T0fWflM8hBF+8tM42FZHPTiMx+/mg0htbSoN0Ji+6C+ap9/IUkKKaBAL2lJ
         cVyigHIBouvtr7+skyT6k25SsD+6GktPTbGgJrXX5tJMGxj2DtgX46L2yUF2Yv0W4y5p
         Bgvw==
X-Gm-Message-State: APjAAAVlX+XxEag9FKQmkeA79M1NRNihRe6VlzVUYcyq196Z8sHtDtdh
        /WEdag2SKG/iTvO5niQ8taH9lDc38z9L
X-Google-Smtp-Source: APXvYqzHsj6SUlK/etIluzXrh1YWBee6EJhBQknI8EpBQxdnt0OjgrduuVGfTvpE1y57l0ZfRdLnkQ==
X-Received: by 2002:a1c:4b0a:: with SMTP id y10mr31100298wma.78.1577635319561;
        Sun, 29 Dec 2019 08:01:59 -0800 (PST)
Received: from starfire (4dafbc34.ftth.telfortglasvezel.nl. [77.175.188.52])
        by smtp.gmail.com with ESMTPSA id c9sm17320000wmc.47.2019.12.29.08.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Dec 2019 08:01:58 -0800 (PST)
Message-ID: <ea322b4c06dce0332ead3521e45514d10f2a76b8.camel@kaarsemaker.net>
Subject: Re: git filters don't get applied to dotfiles
From:   Dennis Kaarsemaker <dennis@kaarsemaker.net>
To:     Adrien LEMAIRE <lemaire.adrien@gmail.com>, git@vger.kernel.org
Date:   Sun, 29 Dec 2019 17:01:58 +0100
In-Reply-To: <CALqn52MbeiCrEzphMkcjeU6bPbLLaQOa-vzht2156uqVw1wL_g@mail.gmail.com>
References: <CALqn52MbeiCrEzphMkcjeU6bPbLLaQOa-vzht2156uqVw1wL_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 2019-12-27 at 16:51 +0900, Adrien LEMAIRE wrote:
> I'd like to report a bug regarding git filters not being applied to
> files beginning with a dot character "."
> Using git version 2.24.1
> Please let me know if there is a better way to report bugs. The github
> page only mentions this email.

<snip reproduction recipe>

I was not able to reproduce this in the git test suite with a quick
patch (see below). Your output does not show any git add command, is it
possible that you added the changes before configuring the filter?

If you set GIT_TRACE=2 in your environment before doing the git add of
the .mailrc file, you should see it run the filter command. It should
look something like:

+ git add test test.t test.i .mailrc
trace: built-in: git add test test.t test.i .mailrc
trace: run_command: ./rot13.sh
trace: run_command: ./rot13.sh

(which is a part of the output of GIT_TRACE=2 ./t0021-conversion.sh -x
-v -i)


diff --git t/t0021-conversion.sh t/t0021-conversion.sh
index 6c6d77b51a..32c27d513b 100755
--- t/t0021-conversion.sh
+++ t/t0021-conversion.sh
@@ -77,6 +77,7 @@ test_expect_success setup '
 
        {
            echo "*.t filter=rot13"
+           echo ".mailrc filter=rot13"
            echo "*.i ident"
        } >.gitattributes &&
 
@@ -88,9 +89,10 @@ test_expect_success setup '
        cat test >test.t &&
        cat test >test.o &&
        cat test >test.i &&
-       git add test test.t test.i &&
+       cat test >.mailrc &&
+       git add test test.t test.i .mailrc &&
        rm -f test test.t test.i &&
-       git checkout -- test test.t test.i &&
+       git checkout -- test test.t test.i .mailrc &&
 
        echo "content-test2" >test2.o &&
        echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x=.o"
@@ -102,6 +104,7 @@ test_expect_success check '
 
        test_cmp test.o test &&
        test_cmp test.o test.t &&
+       test_cmp test.o .mailrc &&
 
        # ident should be stripped in the repository
        git diff --raw --exit-code :test :test.i &&
@@ -110,9 +113,12 @@ test_expect_success check '
        test "z$id" = "z$embedded" &&
 
        git cat-file blob :test.t >test.r &&
+       git cat-file blob :.mailrc >.mailrc.r &&
 
        ./rot13.sh <test.o >test.t &&
-       test_cmp test.r test.t
+       ./rot13.sh <test.o >.mailrc &&
+       test_cmp test.r test.t &&
+       test_cmp .mailrc.r .mailrc
 '
 
 # If an expanded ident ever gets into the repository, we want to make sure that

