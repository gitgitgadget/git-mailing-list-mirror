Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB604C433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 16:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239193AbhLMQZV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbhLMQZU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 11:25:20 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322B6C061574
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:25:20 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id x15so54861501edv.1
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=R72Ayiq8cOI1tFuIWgXjd3qi25PCW8hI5OoKOOcatps=;
        b=AcutLNp5O9mW1cTXkfSTanxTfQfrbak88SYazOs2Ii2CSjnxlNOB85wG6YX7TEcvd4
         s8s6OUpIEYJMoWfUyffE4fi+AZfDc351/FwEpFu1FGezakr8pHuOTIjGZYK0TEc0e0IV
         Hst1RVKnxjPYBTicSsTQWLNXew3Dr9Vtg8yo3gB5fmHKrXtN2H/CCSwrhTjNcVrBG+xl
         mflI+uISgVeG2XVj72pid0R2tcXZUNGHcdwveAuijW0LNf1HPRSCIQN/I9QHFIEBVQyE
         UvsC/NpBHSLp/NxN+2EHC3pRy/KbwwUPS7gPlxgw/s2QCX6qSyMRJy8zZLGP7lrLlm50
         sRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=R72Ayiq8cOI1tFuIWgXjd3qi25PCW8hI5OoKOOcatps=;
        b=3pYo3HmbqzNQXnRbVRqg088K3jhzJmaYjcASH9nUXKlEn8vdzcrxdFHbOAAZKPyouO
         Wy7pQqJLAEdH6yipI14Ns7cuSACArnEghShJAIS01bgse9us/XARxhAfCqiGQbUuia4d
         iQzp/wL62Ulc57WL/fENMIuPIxeKEOHUNolr63vx/9XSRjzMmTV8iaylneLds71ivxtU
         geTfqq1ukkPgI8TqZ0m8CZNRtoept1xuEHEOLeFVGzSowGEHKVb+W+eIuTeLOZmAwCHz
         tT53R6uw3EIGzZvTDYTRHEF17JadjkP1ctqXGaErUDET0MGlx4khOIQ2tmO0j7HE3SY7
         OnPA==
X-Gm-Message-State: AOAM533V0v/Ow8SPVpP7lLgVvZWApfUby5c8u3K38DyGLy+1Qjwc1BO5
        HU7e/A4ZK/FkVPv/ySg9foy3VzFp76XyJQ==
X-Google-Smtp-Source: ABdhPJznIi3DUfvjAp5OAXG1wud6Gi5xiNy319j+D95rM8hQfS+bNWKXXHmQyAWVonF9B2T7Tv7DNw==
X-Received: by 2002:a05:6402:354e:: with SMTP id f14mr65060395edd.245.1639412718503;
        Mon, 13 Dec 2021 08:25:18 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id q26sm661223edr.51.2021.12.13.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 08:25:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwo8a-000u9g-K1;
        Mon, 13 Dec 2021 17:25:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 07/11] reftable: fix NULL derefs in error paths
Date:   Mon, 13 Dec 2021 17:24:54 +0100
References: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
 <pull.1152.v3.git.git.1639411309.gitgitgadget@gmail.com>
 <2939286924caa67e2cc57bf5ed4ce4287b9d571c.1639411309.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <2939286924caa67e2cc57bf5ed4ce4287b9d571c.1639411309.git.gitgitgadget@gmail.com>
Message-ID: <211213.86lf0o8ob7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 13 2021, Han-Wen Nienhuys via GitGitGadget wrote:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Spotted by Coverity.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/reader.c | 3 ++-
>  reftable/stack.c  | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/reftable/reader.c b/reftable/reader.c
> index 006709a645a..8d308d858f8 100644
> --- a/reftable/reader.c
> +++ b/reftable/reader.c
> @@ -796,6 +796,7 @@ int reftable_reader_print_file(const char *tablename)
>  	reftable_table_from_reader(&tab, r);
>  	err = reftable_table_print(&tab);
>  done:
> -	reftable_reader_free(r);
> +	if (r)
> +		reftable_reader_free(r);
>  	return err;
>  }
> diff --git a/reftable/stack.c b/reftable/stack.c
> index 10dfd370e8e..eb03b6c74f6 100644
> --- a/reftable/stack.c
> +++ b/reftable/stack.c
> @@ -707,7 +707,8 @@ done:
>  	strbuf_release(&temp_tab_file_name);
>  	strbuf_release(&tab_file_name);
>  	strbuf_release(&next_name);
> -	reftable_writer_free(wr);
> +	if (wr)
> +		reftable_writer_free(wr);
>  	return err;
>  }

I'd think this would be better:

diff --git a/reftable/reader.c b/reftable/reader.c
index 006709a645a..3eec915830d 100644
--- a/reftable/reader.c
+++ b/reftable/reader.c
@@ -641,7 +641,8 @@ int reftable_new_reader(struct reftable_reader **p,
 
 void reftable_reader_free(struct reftable_reader *r)
 {
-       reader_close(r);
+       if (r)
+               reader_close(r);
        reftable_free(r);
 }

No?
