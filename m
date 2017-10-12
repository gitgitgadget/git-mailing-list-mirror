Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2106C20372
	for <e@80x24.org>; Thu, 12 Oct 2017 19:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbdJLTx0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Oct 2017 15:53:26 -0400
Received: from mail-vk0-f53.google.com ([209.85.213.53]:56219 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752065AbdJLTxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Oct 2017 15:53:25 -0400
Received: by mail-vk0-f53.google.com with SMTP id b5so3246860vkf.12
        for <git@vger.kernel.org>; Thu, 12 Oct 2017 12:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=BnAy2Dw4Jv6XQ9EugVW4tz3DOh07b01hzFubYQkZnvM=;
        b=dYJtgrlu7pIzQcQfdVsKTVjNg9BdVJ15kfu7U7yl8G6fSqw240mq2TBwKN7ItS+Ogj
         p4j74FQXV720xN5D6cKKol2bSuNoBQEmx4w/GJMfnHyQnYQikn+/M4bh5Bdsv8fbvSje
         SD60fcdeXIpV2VN26WwwHDE08R+UCW3RgTDXq3UQtNsCwRXKQZIe4LriW0fB/YJXvMja
         wthUXId4AfMem5tNZU1uph90sSqn0G6I+uLR47EWOg/3QdmdwMXG7DvzqLhBYxg7yyno
         Di60pZ7BM8L344F/XShY5IkgKBJ94ew2HLSa1bpBg6CPiHlYw2B7+lyy9Aeae9nTzQvC
         mOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=BnAy2Dw4Jv6XQ9EugVW4tz3DOh07b01hzFubYQkZnvM=;
        b=XnUDEORUzoAIXMuQBwel7IFi05mjRFKwF+h0f/FYZGNBN9Hfqe0x/3qTeaB8mtP1R/
         9u0dZ9zsCiWt4MoUoEvnR6+bDbCL1C/qEMhMFKP2v8O8xpm4l5BB7NBLlTo+/VsN83xL
         o/auDp4lmAuA0hcSH4B+GnbU3X2TKzVITx2h7baDO3uyM0oWUFFtHbqTPehT9nmaHo1r
         lI69obk40Ktf/I6kF7LQCDIckfpgt9EXkwDCqSsPz/Xkb9+AxT/1jVF17ea3jbW4WLwn
         GiRZ3BKoB0sUd/N+mVwyht2JrlQXxdvDK93zDX2Pj0wW4gJNz7NcjplaB5VpvGsdHkge
         QLeQ==
X-Gm-Message-State: AMCzsaUam+BxmcljHxHPWxCr9UYlHZF2fPZQqlNxqE+wn+ky/B+n3isk
        e5N1xJKUyKDmPhLCPRqYCm/ONHJfax7rC16OJXLvBA==
X-Google-Smtp-Source: AOwi7QC6Kvds9nUriNvns9LFoMLKQl4POcW9PKSPyWLmDL4IHdeVmhnt7y17O9gXFaJxlysiLBlKvYgsu1LYkjGv4dM=
X-Received: by 10.31.7.142 with SMTP id 136mr3243944vkh.10.1507838003715; Thu,
 12 Oct 2017 12:53:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.56.100 with HTTP; Thu, 12 Oct 2017 12:53:23 -0700 (PDT)
From:   Orgad Shaneh <orgads@gmail.com>
Date:   Thu, 12 Oct 2017 22:53:23 +0300
Message-ID: <CAGHpTBLQ8vi00e3Tt3KTrCfaAWhZKQX6u6Ca17t2ySVQdoGc5g@mail.gmail.com>
Subject: Out of memory with diff.colormoved enabled
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

git version 2.15.0.rc0 (from debian sid package)

There is an infinite loop when colormoved is used with --ignore-space-change:

git init
seq 20 > test
git add test
sed -i 's/9/42/' test
git -c diff.colormoved diff --ignore-space-change -- test

- Orgad
