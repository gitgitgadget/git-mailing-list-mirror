Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0EBC433FE
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 13:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380887AbhLCNbB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 08:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbhLCNbA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 08:31:00 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10AC06174A
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 05:27:36 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id r25so11446116edq.7
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 05:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=U/+AySR/Vm5v3IpWuhvMZaWDvNVSdUs8E7F3Qhx/6sY=;
        b=oCJ4x+zEmnAsq1NBp03h57iMBwmvEPZ9TGNScp1T5NSpUU4YnvJslgFoMCvec42qWJ
         k786/2z5OtRqa06aDRz2TblPgrU+rm+mYMZiH77klXnRIlfvoEedYOr8mzKPH87hVVZQ
         ancrQ+bqv73Xcp6/mxFwKAC2q0kw3BC6DdOtqfOtAn8MM4ZMexgvjoifzbEQH2NI9QGQ
         RZg2m4VSq6NI+lvw91bFSRpVGrbmq/oS98ZiIme3o3UlR+u+MCQi6PUE4jiirjtmoDmx
         hx6YLEkc5ZBYGRphucO/KVy8pdcHVosPmagu9QxIhyQOkz1hgbBUrNOwax2asq5R98bb
         AyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=U/+AySR/Vm5v3IpWuhvMZaWDvNVSdUs8E7F3Qhx/6sY=;
        b=bchyFMvVXD4i8dM4U81rd7KKwb12hwd+VopX6g6zz+ieLGUAycADln02CabEF6nQWy
         /1wAiZ4LdgwdjVBcUxpVGlnzf/7kvGZZOKs7OilyyJcBHMpDS3Ja+J8AFKn0DCERLpHn
         FpySbGjCnSQA2zVLZHTgoUSOkTyIpN4P+WCAVZe/M4kWwRgzcJEN9gqY8I+EiUQQc4Eu
         oRYzWTLJoqjS6N1uI2mN1HctB5J3VQPgfAfsnpa0n7RNDlabZiJBdS08Dm9hz9j0wNYR
         1C0EcY37occkcYlDF99lcF2of45UPKTzE1di114ZwTQBiUrlX4HYFgs9t0ZXDlZv1xxb
         rOEQ==
X-Gm-Message-State: AOAM533HoBRn09d0LW4i1/9UoDAjzZPqoPri1tXob8wFZ/sOEbwOKqd4
        NXociKJIBGmVIZ8oQf31h3E=
X-Google-Smtp-Source: ABdhPJyDw3/oKtiQEkaf8EkwYr7oE+hG/lH7Q2/Md8kdnKl72uT2SAyV4aPhhiyWWiGlM9EiN19C/g==
X-Received: by 2002:a50:e18e:: with SMTP id k14mr26815614edl.147.1638538054921;
        Fri, 03 Dec 2021 05:27:34 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id e26sm2014859edr.82.2021.12.03.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:27:34 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mt8b7-0008ip-G1;
        Fri, 03 Dec 2021 14:27:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v4 2/5] object-file.c: handle undetermined oid in
 write_loose_object()
Date:   Fri, 03 Dec 2021 14:21:08 +0100
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
 <20211203093530.93589-3-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211203093530.93589-3-chiyutianyi@gmail.com>
Message-ID: <211203.86v905stru.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 03 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> When streaming a large blob object to "write_loose_object()", we have no
> chance to run "write_object_file_prepare()" to calculate the oid in
> advance. So we need to handle undetermined oid in function
> "write_loose_object()".
>
> In the original implementation, we know the oid and we can write the
> temporary file in the same directory as the final object, but for an
> object with an undetermined oid, we don't know the exact directory for
> the object, so we have to save the temporary file in ".git/objects/"
> directory instead.
>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 30 ++++++++++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 82656f7428..1c41587bfb 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1892,7 +1892,14 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  	const void *buf;
>  	unsigned long len;
>  
> -	loose_object_path(the_repository, &filename, oid);
> +	if (is_null_oid(oid)) {
> +		/* When oid is not determined, save tmp file to odb path. */
> +		strbuf_reset(&filename);
> +		strbuf_addstr(&filename, the_repository->objects->odb->path);
> +		strbuf_addch(&filename, '/');
> +	} else {
> +		loose_object_path(the_repository, &filename, oid);
> +	}
>  
>  	fd = create_tmpfile(&tmp_file, filename.buf);
>  	if (fd < 0) {
> @@ -1939,12 +1946,31 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
>  		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
>  		    ret);
>  	the_hash_algo->final_oid_fn(&parano_oid, &c);
> -	if (!oideq(oid, &parano_oid))
> +	if (!is_null_oid(oid) && !oideq(oid, &parano_oid))
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));
>  
>  	close_loose_object(fd);
>  
> +	if (is_null_oid(oid)) {
> +		int dirlen;
> +
> +		oidcpy((struct object_id *)oid, &parano_oid);
> +		loose_object_path(the_repository, &filename, oid);

Why are we breaking the promise that "oid" is constant here? I tested
locally with the below on top, and it seems to work (at least no tests
broke). Isn't it preferrable to the cast & the caller having its "oid"
changed?

diff --git a/object-file.c b/object-file.c
index 71d510614b9..d014e6942ea 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1958,10 +1958,11 @@ int write_loose_object(const struct object_id *oid, char *hdr,
 	close_loose_object(fd);
 
 	if (is_null_oid(oid)) {
+		struct object_id oid2;
 		int dirlen;
 
-		oidcpy((struct object_id *)oid, &parano_oid);
-		loose_object_path(the_repository, &filename, oid);
+		oidcpy(&oid2, &parano_oid);
+		loose_object_path(the_repository, &filename, &oid2);
 
 		/* We finally know the object path, and create the missing dir. */
 		dirlen = directory_size(filename.buf);
