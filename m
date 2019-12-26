Return-Path: <SRS0=68ZU=2Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A480C2D0C0
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CF20206CB
	for <git@archiver.kernel.org>; Thu, 26 Dec 2019 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoXUBu2c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfLZTyB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Dec 2019 14:54:01 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41337 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfLZTyA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Dec 2019 14:54:00 -0500
Received: by mail-pg1-f194.google.com with SMTP id x8so13310005pgk.8
        for <git@vger.kernel.org>; Thu, 26 Dec 2019 11:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/Kfzl9/OEKpWSCi/oVH9a3R12M7fBKQL0P4Gtdb4hmg=;
        b=JoXUBu2cIJdf7ch+26kjXdwW8GY/iRLerRKeI3Wte2XZ5QTs0OMKvPjJrZTACDez8Q
         0s6j+ug+jW77tw1PEteoG6zhSGrwZGPa75XTdOyMeSg+52ExiGJZvzsI6yqUq0EnjPIP
         sjDjas+3k4Bx+RsHk0xcWUpf0mfqN7G8++o0XPanu32YsKDpfqBFWKUbkZLt2AREfE+j
         ZdFG3S8+cRdJXLxM4gr/0ihaueQRQOzJVmk/WeCUmAb1gk5EXpOpUfD0lcpe3mFv8cTL
         ZmHjkgQVXe4EkUm6HFxl1eYk2/O2qhpzHDOC5H1RN+j1r7EJOuhirZwQjNBXT1cec9js
         WFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/Kfzl9/OEKpWSCi/oVH9a3R12M7fBKQL0P4Gtdb4hmg=;
        b=HzpTOxb9SRAM+MTapZDjTatBL2wz4Zxf089rrU8/4MSktgYrb1P2FQkhg3UXN3frgt
         5GhchEDLU27li11NOehSrDKxYwkC4bMcdu7B9Qgj0irRZo8/kjSD6hByDiuIbbwZQzex
         Yq3F7qGdga6Mzzr4LG0hGbeTj8cBUMr0DG29XLT0VEu2wqqwsYwHDWBaOPUQQBLp7ruB
         WoP/SwNKyU3jzvXwZtzGcBj//LWd9OMM//9P7oRvIjbv1TSqutWmE7wQtXtRw1BBKmze
         is7UEhrPJZVO4ZcRW11SgqZCQPc1etkep126vS4iWwSOFcHBz6wGAMpz3IEfbVDi0huk
         a9+w==
X-Gm-Message-State: APjAAAVMZyoHr0PS/Z0DAxSDRHFnoogpi5AHKBh/jK+fyehIMigXUjDl
        5bjnNS21KNvkHOJ04BtCIiA=
X-Google-Smtp-Source: APXvYqyy8BxEd5M6HPxomEw+KeqzI6aMiAAYNATo9et5vxxQaJ4hUx6aexi9E6Q3NCG8QFGzWXlcKw==
X-Received: by 2002:a63:31d1:: with SMTP id x200mr47148693pgx.405.1577390039900;
        Thu, 26 Dec 2019 11:53:59 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id d3sm8396040pjx.16.2019.12.26.11.53.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Dec 2019 11:53:59 -0800 (PST)
Date:   Thu, 26 Dec 2019 11:53:57 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 0/2] avoid use of "VAR= cmd" with a shell function (Re:
 [PATCH 3/5] test: request GIT_TEST_PROTOCOL_VERSION=0 when appropriate)
Message-ID: <20191226195357.GA170890@google.com>
References: <20191224005816.GC38316@google.com>
 <20191224010110.GF38316@google.com>
 <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfth6lwgl.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> diff --git a/t/t5552-skipping-fetch-negotiator.sh b/t/t5552-skipping-fetch-negotiator.sh
>> index f70cbcc9ca..a2a5e0743f 100755
>> --- a/t/t5552-skipping-fetch-negotiator.sh
>> +++ b/t/t5552-skipping-fetch-negotiator.sh
>> @@ -107,7 +107,7 @@ test_expect_success 'use ref advertisement to filter out commits' '
>>  
>>  	# The ref advertisement itself is filtered when protocol v2 is used, so
>>  	# use v0.
>> -	GIT_TEST_PROTOCOL_VERSION= trace_fetch client origin to_fetch &&
>> +	GIT_TEST_PROTOCOL_VERSION=0 trace_fetch client origin to_fetch &&
>
> Didn't this trigger "FOO=bar shell_func" test lint for you?

It does indeed.  Here are some preparatory patches to handle that.

Jonathan Nieder (2):
  fetch test: avoid use of "VAR= cmd" with a shell function
  t/check-non-portable-shell: detect "FOO= shell_func", too

 t/check-non-portable-shell.pl        | 2 +-
 t/t5552-skipping-fetch-negotiator.sh | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

base-commit: 99c33bed562b41de6ce9bd3fd561303d39645048
