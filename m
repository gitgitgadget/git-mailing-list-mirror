Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70B0C43334
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 00:33:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381343AbiFHA3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jun 2022 20:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443962AbiFGXBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jun 2022 19:01:31 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1D229633
        for <git@vger.kernel.org>; Tue,  7 Jun 2022 13:09:55 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s14so15740196plk.8
        for <git@vger.kernel.org>; Tue, 07 Jun 2022 13:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0UXjm5tcphEexlM+rT7FlpDYSGwS6NV8eLATAmKtkZs=;
        b=KtSgTRHAzWKQMNZmh03kflulLcHQO8xjqGor3DTUVyxGE/22FAycK42CK6NraqhdQU
         hGJ27/ts+wsyCTrt+y+PgwdGIa09sp9111wFxueHjEf+9SVGTdkHDJR+9hsCSnynQr9J
         uef7csvYusETPbAS5XN/Kad7IeVX2WaVVCjhUWmEcsoMKiGpTsWWzY4zt0vmQlonMiA2
         DxozazsXZrkDdzNcIcp/hwOSMklScrcy+ZjadX+h3SCKki5iFK6McmpNS7/RYX7L1pUF
         0cjIkP3ntRZPtgpBHqROVBnWq5fyR1BTzhV8/Cw2UnuZEnjj03WYID8KWY306VXBLjBi
         sG3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=0UXjm5tcphEexlM+rT7FlpDYSGwS6NV8eLATAmKtkZs=;
        b=PdtuYO24ffbhbCr+xYeutHjTx75ZL/yEYpT7q1AayrUB0tx5W4qFBgQWpllj7osfLm
         Zyr5c48fcmAsVCw9lbrDFI+4lN3cKhOCFhdddUrqPZOmi8L0e0GV3q23mknA3hMDufOB
         42VSlHqz/X0nklq81xBb42BmpqhEAGzH5c8aX7emQoh3T+j9yuY1qWkiOcnX+V5c/xLy
         BXGgBUO89X08hrO57rVSeSriQsqTHQqbBSmfCLZUZMuG0zXOLscmFM7RWTt8lUVvcyAu
         n8vFO5IkNg1zsZrWgmr603HHcqGiaNNR5tF0dWfSvur0NIp2htaZO4N6Zf3y+OIX/QSm
         e/dg==
X-Gm-Message-State: AOAM5328JwwcSShz7rRw7yYiiarG8v32mRmBuDVl8RMiZxtKsFbu8Zeb
        FTxAo8G4rvZp0jNPu92l1EKbEw==
X-Google-Smtp-Source: ABdhPJxzCtBzXTiXOPak4XsqrOfPzSTI7qnVU9K57wX/FECXWWJXPHNtupfXsvTHgYWmjKHKWN97Lw==
X-Received: by 2002:a17:902:d044:b0:166:4d45:2b0c with SMTP id l4-20020a170902d04400b001664d452b0cmr26203763pll.99.1654632593738;
        Tue, 07 Jun 2022 13:09:53 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:f2b8:26fd:5644:ff19])
        by smtp.gmail.com with ESMTPSA id h28-20020a056a00001c00b0051b9a2d639dsm13342211pfk.43.2022.06.07.13.09.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 13:09:53 -0700 (PDT)
Date:   Tue, 7 Jun 2022 13:09:48 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v3 1/6] common-main.o: move non-trace2 exit() behavior
 out of trace2.c
Message-ID: <Yp+wjCPhqieTku3X@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Glen Choo <chooglen@google.com>, Andrei Rybak <rybak.a.v@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <cover-v2-0.6-00000000000-20220531T164806Z-avarab@gmail.com>
 <cover-v3-0.6-00000000000-20220602T122106Z-avarab@gmail.com>
 <patch-v3-1.6-9c4f8d840e9-20220602T122106Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-1.6-9c4f8d840e9-20220602T122106Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.06.02 14:25, Ævar Arnfjörð Bjarmason wrote:
> Change the exit() wrapper added in ee4512ed481 (trace2: create new
> combined trace facility, 2019-02-22) so that we'll split up the trace2
> logging concerns from wanting to wrap the "exit()" function itself for
> other purposes.
> 
> This makes more sense structurally, as we won't seem to conflate
> non-trace2 behavior with the trace2 code. I'd previously added an
> explanation for this in 368b5843158 (common-main.c: call exit(), don't
> return, 2021-12-07), that comment is being adjusted here.
> 
> Now the only thing we'll do if we're not using trace2 is to truncate
> the "code" argument to the lowest 8 bits.
> 
> We only need to do that truncation on non-POSIX systems, but in
> ee4512ed481 that "if defined(__MINGW32__)" code added in
> 47e3de0e796 (MinGW: truncate exit()'s argument to lowest 8 bits,
> 2009-07-05) was made to run everywhere. It might be good for clarify
> to narrow that down by an "ifdef" again, but I'm not certain that in
> the interim we haven't had some other non-POSIX systems rely the
> behavior. On a POSIX system taking the lowest 8 bits is implicit, see
> exit(3)[1] and wait(2)[2]. Let's leave a comment about that instead.
> 
> 1. https://man7.org/linux/man-pages/man3/exit.3.html
> 2. https://man7.org/linux/man-pages/man2/wait.2.html
> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  common-main.c     | 20 ++++++++++++++++----
>  git-compat-util.h |  4 ++--
>  trace2.c          |  8 ++------
>  trace2.h          |  8 +-------
>  4 files changed, 21 insertions(+), 19 deletions(-)

Just realized that this unexpectedly breaks the fuzzer builds:

$ git checkout ab/bug-if-bug
$ make CC=clang CXX=clang++ \
   CFLAGS="-fsanitize=fuzzer-no-link,address" \
   LIB_FUZZING_ENGINE="-fsanitize=fuzzer" \
   fuzz-all

[...]
    LINK fuzz-pack-headers
    LINK fuzz-pack-idx
/usr/bin/ld: archive.o: in function `parse_archive_args':
archive.c:(.text.parse_archive_args[parse_archive_args]+0x2cb8): undefined reference to `common_exit'
[...]


The issue is that we don't link the fuzzers against common-main.o
because the fuzzing engine provides its own main(). Would it be too much
of a pain to move this out to a new common-exit.c file?
