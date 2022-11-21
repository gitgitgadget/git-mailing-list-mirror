Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED69EC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 11:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKUL34 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:29:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiKUL3f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 06:29:35 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B1B4835
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 03:24:19 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id s12so15771845edd.5
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 03:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rdkqY+++JTbxqBUBdjc2vuR0YDfqkt0jM1iVry+aYtY=;
        b=mReZZ4Jaxl2joYiNYntdrJswK80j6/iJeMWyKfBybF9m7yHRGWFQil8jauMVfc8rxz
         BdLIIUyCz7lJ0WQlL2OzvVoJ5VOd9lQ8d9c3Mr5zKM1qERi9YtwtpCWF1NG1hJDIjYXQ
         VExpatrJlaPdTIdmrGfHqaiAZCsciyDMmBvecet0zzWZiI5qyiQUaM5lFytm+GA4NUl9
         42Qkix1pEWbD6zquR4aAi5EqYDY3vd3t81JliRsnQqMI2G88dp6wZAFC47EnI3446+Sz
         FvHtLimhOrDocT6zBCnyxT4zHQFS2Hrv4JGWIOd1miRaQvajBren8JCc8bjTApMRxKxc
         75jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdkqY+++JTbxqBUBdjc2vuR0YDfqkt0jM1iVry+aYtY=;
        b=241qxe1ObOcLl1mBKjLBEHkH1LG5zLfwvjVAQI5KSgUrIJoX+oVxiV0EfyvS+/mQUK
         1ikZlBYSRa3l3pTqcedbp+gKgEaRBIb9jhr5oCMIZpK8zVL5Z4tzh5arFC8imLy6e9os
         P7dKGEFV28uCu730wOal1+/Kweg5N4QEqF+kX2kWlQ2XyvE0uc5ROxxL5/FNuTFQUuKN
         H8Pohh9zLxCdwmoBmQHx8VcWUih2t34Weu164LSL3UJZv+A3oyVebVrxJYmSeN1621Uq
         38a74+5F7yqBKlNhftIi40BknXhrEROmySuXJv1rCe0BakOyCkUF+P7c+fUKIkNMOzyo
         BxFA==
X-Gm-Message-State: ANoB5pnTeM4XVAorqWVA78pONBWSs4hB0SP2bGvtott7eoIXv8mIHnji
        FJMfol9JFFc2camchZrACowhTsb44Bw=
X-Google-Smtp-Source: AA0mqf4Q/zQOV5GbhPN1fX8zSoq7Iiy25lC/dRFkCM6awLbdi/4RO7yDnDuxbg6Ej1pzErx3lYaOrQ==
X-Received: by 2002:a05:6402:28c9:b0:469:ba7c:bc75 with SMTP id ef9-20020a05640228c900b00469ba7cbc75mr1374560edb.286.1669029858106;
        Mon, 21 Nov 2022 03:24:18 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id e24-20020a170906315800b0078d793e7927sm4880994eje.4.2022.11.21.03.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 03:24:17 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ox4uP-0004Jd-0l;
        Mon, 21 Nov 2022 12:24:17 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: quiet ENOENT on missing directories
Date:   Mon, 21 Nov 2022 12:16:27 +0100
References: <20221119201213.2398081-1-e@80x24.org>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221119201213.2398081-1-e@80x24.org>
Message-ID: <221121.86bkp0czz2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 19 2022, Eric Wong wrote:

> $GIT_DIR/objects/pack may be removed to save inodes in shared
> repositories.  Quiet down prune in cases where either
> $GIT_DIR/objects or $GIT_DIR/objects/pack is non-existent,
> but emit the system error in other cases to help users diagnose
> permissions problems or resource constraints.
>
> Signed-off-by: Eric Wong <e@80x24.org>
> ---
>  builtin/prune.c  | 4 +++-
>  t/t5304-prune.sh | 8 ++++++++
>  2 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index df376b2ed1..2719220108 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -127,7 +127,9 @@ static void remove_temporary_files(const char *path)
>  
>  	dir = opendir(path);
>  	if (!dir) {
> -		fprintf(stderr, "Unable to open directory %s\n", path);
> +		if (errno != ENOENT)
> +			fprintf(stderr, "Unable to open directory %s: %s\n",
> +				path, strerror(errno));

We sometimes use fprintf() instead of "error" or "warning" for output
compatibility with an older version, or because it's written in an old
style.

But as you're changing the anyway let's not re-invent error_errno() or
warning_errno(), but just use those.

We could also s/^Unable/unable/ in the message while at it, per
CodingGuidelines.

>  		return;
>  	}
>  	while ((de = readdir(dir)) != NULL)
> diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
> index 8ae314af58..d65a5f94b4 100755
> --- a/t/t5304-prune.sh
> +++ b/t/t5304-prune.sh
> @@ -29,6 +29,14 @@ test_expect_success setup '
>  	git gc
>  '
>  
> +test_expect_success 'bare repo prune is quiet without $GIT_DIR/objects/pack' '
> +	git clone -q --shared --template= --bare . bare.git &&
> +	rmdir bare.git/objects/pack &&
> +	git --git-dir=bare.git prune --no-progress 2>prune.err &&
> +	test_must_be_empty prune.err &&
> +	rm -r bare.git prune.err
> +'
> +
>  test_expect_success 'prune stale packs' '
>  	orig_pack=$(echo .git/objects/pack/*.pack) &&
>  	>.git/objects/tmp_1.pack &&

This seems like a good isolated change, but FWIW I think what we really
should be doing here is using the "report_garbage" facility added in
543c5caa6c9 (count-objects: report garbage files in pack directory too,
2013-02-15) and 478f34d2b6e (gc: remove garbage .idx files from pack
dir, 2015-11-03) for "pack".

I.e. we have already iterated over "pack" and found all the files
therein, and in packfile.c error_errno() etc. That we're
re-opendir()-ing the "pack", walking it again etc. doesn't make much
sense, or does it?

Then the:

	remove_temporary_files(get_object_directory());

Also seems odd, just a few lines above we passed "prune_cruft" to
"for_each_loose_file_in_objdir()", haven't we already walked the loose
object dir & removed temporary cruft there?



