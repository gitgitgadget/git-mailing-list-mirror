Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52BF3C433FE
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 14:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbiKGOpl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 09:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiKGOpg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 09:45:36 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72DF7BC06
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 06:45:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id 13so30786190ejn.3
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 06:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KzO2oS5JDcPOQl7yomfeh2gVXXFYRIJhmZjlBaW4A0I=;
        b=o3BM/YRKU6eqOL6+nby3lT0WJuXT3PvkypapM48MUyuRliOuAVoo121AsIbJGHvsaQ
         zM3WOL3ajzE4YsBigyaqBwaC/8hzlZKIgm5SdS3jmdN2ni/z1WXVodyrvS0JSuM3V6IX
         1YUrJWhEYstW3/o92vOLidYghFPcogCj3+aAPL96HQWxdLmO+8mePEaKpoh55wsEkQrv
         IhndLWYUWHS3T2KJ8dl7okhacDBk7b/hEXJasgRSafKcmBg5h3XYk93997I10ECSt4Jc
         B7xX94wGWMX5GOtsNCLAAXXRBoQ2KWen5CZOTttuwvYgOKFNLEx2fKL82Fvak4GZhSwQ
         ejdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KzO2oS5JDcPOQl7yomfeh2gVXXFYRIJhmZjlBaW4A0I=;
        b=Ywz61xHvh2iVMi5/9UlUSiR5fP9ifvbYAb3KpZxXz1KQbuYpO9Tio9DYBhj6gftOHQ
         WUzTapv+axfkGaPAkwfxLiLk6y8/2FLjv24Gwyw5b8gMs5GziTul7UK2jDiFxt7J9xGj
         RBo3J9zXQ7qli4nC2rdVOgvJM6VlR+I1TFOp+IFc7DLIjJag2uKdMHr4cbL3T2Q/ZhhM
         dxErQ/8uLD/CZ407EFI4ocJlpY1rqZTnetOCuxuSqEqO2EUMiHKM3D2GdoQTqUDgjcIt
         6xhlVAS1njXq+e93a7HhnlpcuZItfuyvZeZjZDGARv6CveD0G2WBxhOyGfSHFT8nHTTt
         RUVQ==
X-Gm-Message-State: ACrzQf377h5c4kiDiBIWmrDob+U8qQVa36wRd0VQXB7vr/9uQMgcn1sQ
        xusTSXSyUipUOqD4vI5G0Is=
X-Google-Smtp-Source: AMsMyM6c32T0aBGv8eIXtXSmFMaFnkDmVO7BoG9+cfBQFfsSyWSIK9OWiLlXl2mDIIhCNYXq6epBjg==
X-Received: by 2002:a17:906:9bc2:b0:7ad:975f:b567 with SMTP id de2-20020a1709069bc200b007ad975fb567mr49128661ejc.107.1667832333952;
        Mon, 07 Nov 2022 06:45:33 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709066d8300b0074136cac2e7sm3480248ejt.81.2022.11.07.06.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 06:45:33 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os3NV-0007uB-0G;
        Mon, 07 Nov 2022 15:45:33 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 3/3] notes.c: drop unreachable code in "append_edit()"
Date:   Mon, 07 Nov 2022 15:41:57 +0100
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <2475ea0c04d7b5e2812f13d0c8701a0056b305b8.1667828335.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2475ea0c04d7b5e2812f13d0c8701a0056b305b8.1667828335.git.dyroneteng@gmail.com>
Message-ID: <221107.868rkmx1pu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>
>
> Situation of removing note shouldn't happen in "append_edit()",
> unless it's a bug. So, let's drop the unreachable "else" code
> in "append_edit()".
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  builtin/notes.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/notes.c b/builtin/notes.c
> index 02b88e54d8..6d42592c79 100644
> --- a/builtin/notes.c
> +++ b/builtin/notes.c
> @@ -10,6 +10,7 @@
>  #include "cache.h"
>  #include "config.h"
>  #include "builtin.h"
> +#include "git-compat-util.h"

Huh? cache.h includes this already, why are we doing it again?

>  #include "notes.h"
>  #include "object-store.h"
>  #include "repository.h"
> @@ -646,11 +647,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  			_("Both original and appended notes are empty in %s, do nothing\n"),
>  			oid_to_hex(&object));
>  	} else {
> -		fprintf(stderr, _("Removing note for object %s\n"),
> -			oid_to_hex(&object));
> -		remove_note(t, object.hash);
> -		logmsg = xstrfmt("Notes removed by 'git notes %s'", argv[0]);
> -		commit_notes(the_repository, t, logmsg);
> +		BUG("compute_notes failed");
>  	}

Let's squash this into 2/3. So you were adding to it then, but we didn't
need to add this commit_notes() at all?

Also, there you did:

	-	char *logmsg;
	+	char *logmsg = NULL;

But here we see that it's only used in the initial "if" arm, so the
reason to have it declared earlier has disappeared in this 3/3. Instead
just have 2/3 do:

	if (...) {
		char *logmsg;
		[...]

		logmsg = xstrfmt(...);
	        commit_notes(....);
		free(logmsg);
	} else if (...) {
		...
	}

This commit also shows that there wasn't any reason for your "struct
note_data d" cleanup, i.e. we weren't adding a field or anything...
