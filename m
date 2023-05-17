Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C5C2C77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 16:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjEQQby (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 12:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjEQQbx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 12:31:53 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621E646BF
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:31:52 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-55a20a56a01so13873067b3.3
        for <git@vger.kernel.org>; Wed, 17 May 2023 09:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684341111; x=1686933111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2kRm5rrFuEV/WPPW43YG+hPZzS/1n6MLJQKwl0T2qo=;
        b=qW12UCYjAj7lmVl+icicn4rtMmI2aapjahpv2HFutSA605p8hdEJb583FH/t0Btn17
         /0gMAp+ybVEwg7ThK4Lk7gepjh2IbfNNCI91vo7qb+qbFb6irysq4wx/bBNfzsbCvvkw
         Uc+6Hqar5+5YbWqVAbvePRW7kUyPsLK2RirvXlByMQMYefChOgVjch3LxhukOzVj3x69
         TfEzaCVrlKeWiXDVHteTZlJo00pjy5Hdb5pG2nQxj5tovjZ0zcKM0pJ3c5wJJFHBb/1E
         VB3EXXhuuwMP3zo2OY1pn5NZfINsSDXBm3mWDLQWQt7ZrEcGTb3KxmIGm3oTyIwBFwlq
         NZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341111; x=1686933111;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2kRm5rrFuEV/WPPW43YG+hPZzS/1n6MLJQKwl0T2qo=;
        b=keWqqzUJc3X7Ay9uUx9aRJj6r2W1Y6InwuAlJqPOmqbXy+Kl7KEExIHVyq7UU0hDCN
         DTl92RKu1WESEpU67ZKPPz4PznntWi6RvZU6jdb2a7ql1I8NBpPNZau8S1LimIJS1Ixu
         2SzIPw8uJg4UEfK6e+USzqxPBGMC6s7xz9xZtW208OCFA2Jfft6fNrw4QFe/DwIubmJl
         DZfxW+awPtfknQSZDQiWu7Gsx5ZyWsHSo6oRjHoQRbvTQnmcAZoReJTpR9MJ2qzad7qL
         gEjFcFsqmj1PUZyhlgQxxDsnJ+EVj76XIOkn7+4jXw/+vk8S1XdDDcrTgdMLP2PEKPPu
         E5tg==
X-Gm-Message-State: AC+VfDzGMXz01suNQ7A3ZJvza9ES4MPB8DxIoA14SeXyVH7DYh20Ikt8
        7N+hX4Dtc7/B8JaMQn72LzbZjw==
X-Google-Smtp-Source: ACHHUZ7sHFVA27THriU5uYBg3lOnj4NXDVQHhfxNtmNpohKXOvuV6YMNfVmxl/S1cf3m2dr2fqfl8A==
X-Received: by 2002:a0d:f545:0:b0:55a:ab98:a2ef with SMTP id e66-20020a0df545000000b0055aab98a2efmr38094479ywf.40.1684341111569;
        Wed, 17 May 2023 09:31:51 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d196-20020a0ddbcd000000b0056183cdb2d9sm755475ywe.60.2023.05.17.09.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:31:51 -0700 (PDT)
Date:   Wed, 17 May 2023 12:31:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <ZGUBdoLeiqTQYQ9Z@nand.local>
References: <20230517070632.71884-1-list@eworm.de>
 <xmqqwn17q7ou.fsf@gitster.g>
 <ZGT6fEZFumAsZnxu@nand.local>
 <xmqqilcrq6a9.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqilcrq6a9.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 09:19:58AM -0700, Junio C Hamano wrote:
> OK, so the fix seems to make sense, but the justification for the
> change needs to be rewritten, I think.
>
>     We make liberal use of the strbuf API functions and types, but
>     the inclusion of <strbuf.h> comes indirectly by including
>     <http.h>, which does not happen if you build with NO_CURL.
>
> or something like that?

Agreed. Here's a patch that summarizes my investigation. Thanks again,
Christian, for reporting!

--- 8< ---

Subject: [PATCH] imap-send.c: fix compilation under NO_CURL and ancient
 versions

When building imap-send.c with an ancient (pre-7.34.0, which was
released in 2013) version of curl, or with `NO_CURL` defined, Git
2.41.0-rc0 fails to compile imap-send.c, i.e.

    $ make NO_CURL=1 imap-send.o

This is similar to 52c0f3318d (run-command.c: fix missing include under
`NO_PTHREADS`, 2023-05-16), but the bisection points at ba3d1c73da
(treewide: remove unnecessary cache.h includes, 2023-02-24) instead.

The trivial fix is to include "strbuf.h" unconditionally, which is a
noop for most builds, and saves us otherwise.

To check for other *.c files that might suffer from the same issue, we
can run:

    git grep -l -e '[^_]xstrdup(' -e 'strbuf_[a-z0-9A-Z_]*(' \*.c |
    while read f
    do
        if ! gcc -I $(pwd) -E $f | grep -q 'struct strbuf {'
        then
            echo "==> $f NOT OK";
        fi
    done

...which runs the preprocessor on (roughly) all C source files that call
`xstrdup()` or use the strbuf API. The resulting list looks (on my
machine) lile:

    ==> compat/fsmonitor/fsm-listen-darwin.c NOT OK
    ==> compat/mingw.c NOT OK
    ==> contrib/credential/osxkeychain/git-credential-osxkeychain.c NOT OK
    ==> pager.c NOT OK
    ==> refs/iterator.c NOT OK
    ==> refs/ref-cache.c NOT OK
    ==> string-list.c NOT OK
    ==> t/helper/test-mktemp.c NOT OK

The ones in compat are OK to ignore since they both fail to compile on
my non-Windows machine (I am missing the `<dispatch/dispatch.h>` and
`<windows.h>` headers, respectively).

The one in contrib is fine to ignore, since it has its own definition of
xstrdup().

pager.c is OK, since it only needs xstrdup(), not any other parts of the
strbuf API. It gets a declaration of xstrdup() from git-compat-util.h
refs/iterator.c, refs/ref-cache.c, string-list.c, and
t/helper/test-mktemp.c are all OK for the same reason.

So this is the only spot that needs fixing.

Reported-by: Christian Hesse <mail@eworm.de>
Original-fix-by: Christian Hesse <mail@eworm.de>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 imap-send.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/imap-send.c b/imap-send.c
index a62424e90a..7f5426177a 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -29,6 +29,7 @@
 #include "run-command.h"
 #include "parse-options.h"
 #include "setup.h"
+#include "strbuf.h"
 #include "wrapper.h"
 #if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
 typedef void *SSL;
--
2.41.0.rc0.1.g01bd045298

