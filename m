Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65276201A7
	for <e@80x24.org>; Mon, 15 May 2017 15:20:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966080AbdEOPUb (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 11:20:31 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:34716 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966076AbdEOPU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 11:20:28 -0400
Received: by mail-io0-f175.google.com with SMTP id k91so75548516ioi.1
        for <git@vger.kernel.org>; Mon, 15 May 2017 08:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=l5pF3tXRCxtDIBn6sBVUg5jpWno5el0DtvrIJrVOR3Q=;
        b=VTLm6K3zYAv11376jbU4TEANSjOkgax0ixz/ipq6IPkbnDw+CN2/wWv6C0En5jk2IH
         kIid6Hxk5A0SRhYuafT/mYPh2OX3MZMfMnxmgzxNPbVMQQ56b/43zCLrZtqAHb+FBoGD
         t2T3gJ05eRTTYHvlv0ehfhxv7W2wrrMbZXf13zyBUrIJDjfCIn4eatjY3bQRfnQqQbtw
         Oh/AU3w1NPWEHzHW3i4kdO1R9r6G1Qktthd1HzLxbpr49ukXRxh7ccJYduBNQmfry2od
         FD3PAy0xbnFE51qx0SqiD4tW5g2VHCS9zhkayVQG+THKb7HynpkXxZfVqUMCGtLZUm6b
         fCnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=l5pF3tXRCxtDIBn6sBVUg5jpWno5el0DtvrIJrVOR3Q=;
        b=pxQHAdz0dPstwBcQlh4JijBRPbZ1CGE7a+t6imfKKaycocyjJuPigeJW6pT0C4sjf9
         e3B72hevADc9xKByLbYzni22C4ay2BAswTDDs9E+YNVMiBEn2cOTmhlu3tTWvcrjT+NB
         KmF5J/CLwFqmplvb/dh4y2kWxLLunkT45IRMFwoqZ8pbtT90GY+J4dP5VrKkfZN/yX6z
         2LSwaQK9/C2MfXYPScXYZ4n2qSWNr3XsUfZeRrPnsGrdSzIQ/i5buhlx+ZoKYN/lmVaW
         yQ87UgM75bzAQ9rUNm2poTSl3AMT/0zIBK4SwFEh5eHw+KkMGq8gadRsfWTbX4n9EQnv
         xwdg==
X-Gm-Message-State: AODbwcAQePhbJUN6EbFJ5qESp6pgqBWTKLaUwSJlE1fPrrGtRHI73C3I
        /EWcWiEeA1KIBz4yvo4TIbQawpaBSg==
X-Received: by 10.107.138.21 with SMTP id m21mr5855859iod.80.1494861622533;
 Mon, 15 May 2017 08:20:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.8.220 with HTTP; Mon, 15 May 2017 08:20:01 -0700 (PDT)
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Mon, 15 May 2017 17:20:01 +0200
Message-ID: <CACBZZX5d25UyGbb6=kPmzk_5-X0GMptN0kX_--aBADsDy-9kWw@mail.gmail.com>
Subject: [PATCH/RFC] The new IncludeIf facility doesn't DWIM when the repo is symlinked
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I have a ~/git_tree in my homedir that's symlinked to an external
drive, and doing "gitdir:~/git_tree/" doesn't work, because instead of
matching against ~/git_tree it's matched against
/mnt/some-other-storage/.

Here's a WIP patch that makes this work for me, any reason I shouldn't
finish this up & that we shouldn't be doing this? The doc don't say
"we'll only match gitdir against the absolute resolved path" or
anything like that, so until I checked out the implementation I didn't
realize what was going on:

diff --git a/config.c b/config.c
index b4a3205da3..606acaa3f1 100644
--- a/config.c
+++ b/config.c
@@ -214,6 +214,7 @@ static int include_by_gitdir(const struct
config_options *opts,
        struct strbuf pattern = STRBUF_INIT;
        int ret = 0, prefix;
        const char *git_dir;
+       int tried_absolute = 0;

        if (opts->git_dir)
                git_dir = opts->git_dir;
@@ -226,6 +227,7 @@ static int include_by_gitdir(const struct
config_options *opts,
        strbuf_add(&pattern, cond, cond_len);
        prefix = prepare_include_condition_pattern(&pattern);

+again:
        if (prefix < 0)
                goto done;

@@ -245,6 +247,12 @@ static int include_by_gitdir(const struct
config_options *opts,
        ret = !wildmatch(pattern.buf + prefix, text.buf + prefix,
                         icase ? WM_CASEFOLD : 0, NULL);

+       if (!ret && !tried_absolute) {
+               tried_absolute = 1;
+               strbuf_reset(&text);
+               strbuf_add_absolute_path(&text, git_dir);
+               goto again;
+       }
 done:
        strbuf_release(&pattern);
        strbuf_release(&text);
