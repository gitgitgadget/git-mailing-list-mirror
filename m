Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F84DC433F5
	for <git@archiver.kernel.org>; Tue, 15 Feb 2022 21:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241076AbiBOViV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 16:38:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234203AbiBOViU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 16:38:20 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070309548F
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 13:38:10 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id b14so472081ede.9
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 13:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MaZVBfibmi6JpodQlagZWz2YidjCrSEPJW0w2hZl9Qg=;
        b=qV6ZYph+Tk84OPPTqt0SvlEl3pghDYgPF71G9oRmNLr57j083Fz93kAw2cbCxQr0Kz
         nCuwA2kctse7D2f2uv3KzcgK8ECNfRHT8Q2VtMKk1HxpI6/LpXT7PgBsknL/bZbmFNDT
         YBvQdgVAe2MfHQ53yBIXZLMFrfBI7G2qEYqEAJqFLf9qWIUB1wkAbWEnFmBaiuXJtzc7
         Bl8azrBYsHqNs8RpprzPTVaREKEAouoq96T6AWFtmr1k/iFyAej5juWcyqMjZbMLE8bf
         wGm15rLw2yabH7Fw70+EvHfxtSXBh71Rm7v+fbaoeN4CE1k2FOfJGVis4XS+AL5b4g6j
         CFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MaZVBfibmi6JpodQlagZWz2YidjCrSEPJW0w2hZl9Qg=;
        b=ICCekoFaQ1iODq0AFyknc4gaj5ug8+T0ndihcBELw+llyuyjwg29GXgtM3TGcvQYJX
         4EJUf6R7i8ejFDnHVsGZI9EMFhjfvLzYGOBZAJc9DGsa4dp+7ZiVGaNKI0VgocDV/MeN
         ahCWZe8u1sl58JFWAJ1062NxBHX8lg05eXzIxQVUBf4HQ+3WLMdFlDoe9Y23pdHQmLHV
         Qnws4BTVQ4AZv4iCSLF4eQU4QR4sF4QL8zelGWtQwQcmfEHLGbCRsoLPYXeOBr+C2s90
         ckgC5pXdOej5hMSWIm/VqphXQF8GjBS3sw47djJ/yKGQtwFgkx9Na/19xcBUopggDni0
         ankQ==
X-Gm-Message-State: AOAM532fTXQaOIjCxqcOCq+3iQX97C0N5xfDigx0xu6E4e9XDcLKWOVh
        o6b0ItNgXkDBz/zmx+7xdxppygqrU8M=
X-Google-Smtp-Source: ABdhPJylxUqw2MXm0XnOGR1bptrmM6UMAGFHYDjLqbvXpq9FguY5Rm0ZI0KQit5pHKmr0+MWM6UtsA==
X-Received: by 2002:a05:6402:f2a:: with SMTP id i42mr949514eda.99.1644961088244;
        Tue, 15 Feb 2022 13:38:08 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d25sm12036319eje.41.2022.02.15.13.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 13:38:07 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nK5WR-002s5e-8l;
        Tue, 15 Feb 2022 22:38:07 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/9] t5526: introduce test helper to assert on fetches
Date:   Tue, 15 Feb 2022 22:37:06 +0100
References: <20220210044152.78352-1-chooglen@google.com>
 <20220215172318.73533-1-chooglen@google.com>
 <20220215172318.73533-2-chooglen@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220215172318.73533-2-chooglen@google.com>
Message-ID: <220215.86v8xfx134.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 16 2022, Glen Choo wrote:

> +verify_fetch_result() {
> +	ACTUAL_ERR=$1 &&
> +	rm -f expect.err.combined &&
> +	if [ -f expect.err.super ]; then
> +		cat expect.err.super >>expect.err.combined
> +	fi &&
> +	if [ -f expect.err.sub ]; then
> +		cat expect.err.sub >>expect.err.combined
> +	fi &&
> +	if [ -f expect.err.deep ]; then
> +		cat expect.err.deep >>expect.err.combined
> +	fi &&
> +	test_cmp expect.err.combined $ACTUAL_ERR
> +}

I see this will get further modified in this series, but I wondered why
not just something like:

diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
index 5d55f14ed42..4d8e06dea52 100755
--- a/t/t5526-fetch-submodules.sh
+++ b/t/t5526-fetch-submodules.sh
@@ -49,16 +49,12 @@ add_upstream_commit() {
 # expect.err file should be rm-ed.
 verify_fetch_result() {
 	ACTUAL_ERR=$1 &&
-	rm -f expect.err.combined &&
-	if [ -f expect.err.super ]; then
-		cat expect.err.super >>expect.err.combined
-	fi &&
-	if [ -f expect.err.sub ]; then
-		cat expect.err.sub >>expect.err.combined
-	fi &&
-	if [ -f expect.err.deep ]; then
-		cat expect.err.deep >>expect.err.combined
-	fi &&
+
+	{
+		cat expect.err.super
+		cat expect.err.sub
+		cat expect.err.deep
+	} >expect.err.combined
 	test_cmp expect.err.combined $ACTUAL_ERR
 }
 
I.e. there's no law that we've got to avoid non-zero on every exit
code. In this case we can avoid the existence checks and just "cat" them
together, and if it fails we'll presumably fail on the test_cmp
anyway...
