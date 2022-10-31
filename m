Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3765FA3741
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 20:17:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiJaURW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbiJaURU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 16:17:20 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A2EE0D
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:17:19 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id q9so32359828ejd.0
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 13:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WCCMH1FwquNCUEBN+1jZ1BKLmryV4R8WKdITkmxbLoQ=;
        b=El8XK5EFJjmhkM0zF7LetzbreIc7K5rTffCBt7KMePo2GFlioPv01oV5DGxldIltZa
         zBOObE62n200t/GH0FOrRHHS+oluh2vOg4nFZZHPVt8hF7wY1AOPTAMkvAdZuddcCoec
         WguSVy3W9qwZjYYxXIbwONxYOK2clZfC1seDoSKf/6v4GSfrDxKMRL3Uuz+3g2hsXNf2
         79TfscrSyrZIwSt3u0EsBAxkv3T6pkkjYkAc+q/6IMSOqE4sLsOYKG/q61Uy0xudRMam
         8jWaWU4HMAtN6ZTg8PRTlWumjPZA4+ATQKBRKqQLradeWn2ToeVm8FOs1a41VKbabc6V
         A5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WCCMH1FwquNCUEBN+1jZ1BKLmryV4R8WKdITkmxbLoQ=;
        b=EULkSnIGXjE9nQlQoVyMWHnZTYeO5+RDtIYNQxE30iqBJSiY2JlCbCqGWZcfpaaZB7
         saIqpR/FhRqeeBbr/szuugipx1gW6Cikk0MFjFumGmzllZYmLgKycMnrO7ALXXswS5xN
         ULEBh6512GaPUUeY4MA5vhdQqeDPVMk57WdSOCjlXQTJkLD8g+7Hmc8zJaxtnY3SN2gz
         pISxOJVkfEZcTgSAHPVbGpx10xyMZ1n3HsQxa3kgitlOVwh0d9ywes+tmd+x601Ft9M3
         naUb1FRW5leU3cBB+FDz+p3SPd0i0XXjo0N1kVBAMgLaXf/+ibxx4q+gSzEdU3iU+Qz8
         5/3Q==
X-Gm-Message-State: ACrzQf1ixhhiZWK7kvbkZb6/zet9OrRmHP/Fpfp9q1dIY5U0YiCkPyUX
        IKgZdd2hSmj/G11/AbU8VwN/5Wf6L34=
X-Google-Smtp-Source: AMsMyM6mEdg4GmtuJ4zdAgYr0tgqEIrxqf+KRER5S06NlO7azif5HdAF4W4RPvJf020b2pN7xK6znw==
X-Received: by 2002:a17:906:3607:b0:7ad:a798:cdc0 with SMTP id q7-20020a170906360700b007ada798cdc0mr14538893ejb.357.1667247437820;
        Mon, 31 Oct 2022 13:17:17 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id kz12-20020a17090777cc00b00772061034dbsm3323543ejc.182.2022.10.31.13.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 13:17:17 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opbDg-00ApAv-2z;
        Mon, 31 Oct 2022 21:17:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test-lib-functions: drop redundant diagnostic print
Date:   Mon, 31 Oct 2022 21:16:07 +0100
References: <20221031180048.5766-1-martin.agren@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221031180048.5766-1-martin.agren@gmail.com>
Message-ID: <221031.864jvj7noz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Martin =C3=85gren wrote:

> `test_path_is_missing` was introduced back in 2caf20c52b ("test-lib:
> user-friendly alternatives to test [-d|-f|-e]", 2010-08-10). It took the
> path that was supposed to be missing, as well as an optional "diagnosis"
> that would be echoed if the path was found to be alive.
>
> Commit 45a2686441 ("test-lib-functions: remove bug-inducing
> "diagnostics" helper param", 2021-02-12) dropped this diagnostic
> functionality from several `test_path_is_foo` helpers, but note how it
> tweaked the README entry on `test_path_is_missing` without actually
> adjusting its implementation.
>
> Commit e7884b353b ("test-lib-functions: assert correct parameter count",
> 2021-02-12) then followed up by asserting that we get just a single
> argument.
>
> This history leaves us in a state where we assert that we have exactly
> one argument, then go on to anyway check for arguments, echoing them
> all. It's clear that we can simplify this code. We should also note that
> we run `ls -ld "$1"`, so printing the filename a second time doesn't
> really buy us anything. Thus, we can drop the whole `if` block as
> redundant.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  t/test-lib-functions.sh | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index 29d914a12b..796093a7b3 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -921,10 +921,6 @@ test_path_is_missing () {
>  	then
>  		echo "Path exists:"
>  		ls -ld "$1"
> -		if test $# -ge 1
> -		then
> -			echo "$*"
> -		fi
>  		false
>  	fi
>  }

Thanks, this is an obviously good change, sorry about leaving that loose
end.
