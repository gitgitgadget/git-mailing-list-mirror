Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252C2C4332F
	for <git@archiver.kernel.org>; Tue, 18 Oct 2022 03:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiJRDRU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiJRDQp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Oct 2022 23:16:45 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3507320
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 20:15:08 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id i3so12850445pfc.11
        for <git@vger.kernel.org>; Mon, 17 Oct 2022 20:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R18IAzTdN9rGF5xSDWJfmcKb6D8p+Jsx1UVkbhUvyww=;
        b=FEIut+7Q+xJMtVPWYPTDHyMv+xH6bbYO7z1Ovo17yBMQrKe/M1eNBcXMMfsURMhl9i
         jvWofR1MVe76KqyVYs64paHWJmMKBWa8SscMe4AqmdQEyY5lg+HjTKbjiQqYkPqZFEgV
         BE6qU7Pod94BRTFSPSm9VhxtWCBv5fWF5RmvGQY6CYpNXaIuhiI4OBt78aCntZ2APuo9
         jbsNGVgGK1+dPXVTFb2R8e3GkdnU4/srDRAWF9bgRJ/vs4YtACdIS0nCt9Sm7qP705MO
         gTD74kY1jqEsAW8YhaNNRVB4pAasRMuSqLBqCwt1NobLyLFN7hCoboF5sz0X81uR2hQI
         gMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R18IAzTdN9rGF5xSDWJfmcKb6D8p+Jsx1UVkbhUvyww=;
        b=o6PVd9WoI6Jj3w7dwrR37eSxAgSTd8zv2/hL3mNyiuSqrg8dHAj5mF6PbDRiFI8AA4
         kdSPK4ELUTNqMUwKR1zRYFymYeYz8FcLh60zxpSTHDrmDuo60aciSvjWNpDjlhAaYcih
         CL3BXBBR9HctHFbgK7FyS9poTXQQO+CCJHRD7bdrhppujvrduUfxTStNbIW7RahRIx+2
         vKEGYaTUZwhfFtm52QnW8WEBIFr1imbqBB4XNtmyq89pSIY7Asul0y4Ak20pRiVrv7tZ
         iCa43zppzcGPFfjC2bSw1Mr+gXTtFmNCrxM8U8X9RjB+A4p3VBidEg+AL15sT2OzCI/c
         HDQQ==
X-Gm-Message-State: ACrzQf3tBnFz6kzk59SYGi1+R5srJ/hbAEkm8dRxsh8C8HgZkWC1HE6v
        P+KqfC2XHMml7vOenFTXm9wq0ybl+61Fmg==
X-Google-Smtp-Source: AMsMyM5G9KBoDFIjuT7+8oZB/DBSr0xBAdZlbwhat6UKxudkAdGwIvwGtJ08B67e/M3cio/I8dbivw==
X-Received: by 2002:a63:b4d:0:b0:454:d8b4:285 with SMTP id a13-20020a630b4d000000b00454d8b40285mr870084pgl.410.1666062712101;
        Mon, 17 Oct 2022 20:11:52 -0700 (PDT)
Received: from localhost.localdomain ([47.246.101.59])
        by smtp.gmail.com with ESMTPSA id s6-20020a170902a50600b001767f6f04efsm7341390plq.242.2022.10.17.20.11.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Oct 2022 20:11:51 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     avarab@gmail.com
Cc:     --cc=avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 2/2] notes.c: fixed tip when target and append note are both empty
Date:   Tue, 18 Oct 2022 11:11:44 +0800
Message-Id: <20221018031144.73730-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.0.rc0.2.gfaa0bb20b59.dirty
In-Reply-To: <221013.86wn94kqq1.gmgdl@evledraar.gmail.com>
References: <221013.86wn94kqq1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


"Ævar Arnfjörð Bjarmason" <avarab@gmail.com> writes:

> Hrm, interesting that (at least my) gcc doesn't catch if we don't
> NULL-initialize this, but -fanalyzer does (usually it's not needed for
> such trivial cases0. Anyawy...

On my local env the warnings shows , show I change the line (initialize with
NULL to "logmsg").

But it seems like different as the last time I built... However now "suggest
braces around initialization of subobject" appears, is it normal or we should
repair this?

builtin/merge-file.c:29:23: warning: suggest braces around initialization of subobject [-Wmissing-braces]
        mmfile_t mmfs[3] = { 0 };
                             ^
                             {}
builtin/merge-file.c:31:20: warning: suggest braces around initialization of subobject [-Wmissing-braces]
        xmparam_t xmp = { 0 };
                          ^
                          {}
2 warnings generated.
builtin/notes.c:641:13: warning: variable 'logmsg' is used uninitialized whenever 'if' condition is true [-Wsometimes-uninitialized]
        } else if (!cp.buf.len) {
                   ^~~~~~~~~~~
builtin/notes.c:653:7: note: uninitialized use occurs here
        free(logmsg);
             ^~~~~~
builtin/notes.c:641:9: note: remove the 'if' if its condition is always false
        } else if (!cp.buf.len) {
               ^~~~~~~~~~~~~~~~~~
builtin/notes.c:570:14: note: initialize the variable 'logmsg' to silence this warning
        char *logmsg;
                    ^
                     = NULL
1 warning generated.
builtin/submodule--helper.c:1749:56: warning: suggest braces around initialization of subobject [-Wmissing-braces]
        struct list_objects_filter_options filter_options = { 0 };
                                                              ^
                                                              {}
builtin/submodule--helper.c:2623:56: warning: suggest braces around initialization of subobject [-Wmissing-braces]
        struct list_objects_filter_options filter_options = { 0 };
                                                              ^
                                                              {}
builtin/unpack-objects.c:388:26: warning: suggest braces around initialization of subobject [-Wmissing-braces]
        git_zstream zstream = { 0 };
                                ^
                                {}


My gcc version:
   Apple clang version 11.0.0 (clang-1100.0.33.17)
   Target: x86_64-apple-darwin19.6.0
   Thread model: posix


> >  	const char * const *usage;
> >  	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
> > +	struct note_data cp = { 0, 0, NULL, STRBUF_INIT };
>
> This is probably better "fixed while at it" to set both to use "{ .buf =
> STRBUF_INIT }", rather than copying the pre-C99 pattern.


Thanks for figuring this out, will fix both.
