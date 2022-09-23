Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D32ECAAD8
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 07:47:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiIWHrC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiIWHqj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 03:46:39 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0F783070
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 00:46:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hy2so22471485ejc.8
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 00:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=5bBlFTB+p7nG/4X9KL6HVfobrFxi/a1m3M5z1frFMbw=;
        b=f5qpjEc97Ne25bc0e1Vq8YF9ZxUDPWc+lXoO7NBEqTrMuJ+NvIOIIc0lRgkKNNr1VU
         jDfVDgCtY1Z/dvoqqp4UP++wGaj2DLTA4WNssdc1W+DbWiOa/Tmy9HUMgOOIKUAyPzKJ
         2i0eeAn0BQSsdkmJmhAW9AhUgCk97Z9KIUsTM8+cJI9VJA0LFxXV9Mo8puMrD9IyUKBW
         pUlAexxFj2s0/RzJ8Va9DbRBEh+iJRwDesi7NfIht0HcV3uuhVixXdRDCyboLtftRu6f
         ifnBttZVe1nZNoWi4zrS7ThDmQq4xyLFmXNCAor+JzoqJMd9zkGbdTDHrfVJrL0YdqpC
         HyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=5bBlFTB+p7nG/4X9KL6HVfobrFxi/a1m3M5z1frFMbw=;
        b=3OQ+VTIsybZh29krRZzNjTrl3cED9O1SfhcjpYciDZ21QAbrnpGtttu2hZDiuu3nCV
         aqHsLPaTwQSR3nAoB7gaxnJnl4uMLll7Mtxa+6TiFmoeNVq5WRVfjaEljEm5KdJ0tXEk
         kSaioppj5U7q0yytzCu/0hzoBLvDki7PYS05WH4x0IuEnwBVXZMcWt4bEvc5BkQFg9zM
         rsYDle/bS8FqaM1PwJUPXMGZtS89NrXcgS7/R38apj2k71eVK6hjRGKMss5i090Ez3xi
         TggcESJCBeuc6lDIW+s/L2WWk17HpMjdKc4v6bWUXCIWRk4Agqn1wPRt2hi9GlxON41w
         hPRg==
X-Gm-Message-State: ACrzQf3myt7THc/K+Mz+9qypcp7fHgVlHD4UpXV02tXi5siRxCOS26Th
        MTdkbcZH/I+VxcTS06Ktbd7uSc+pBJE=
X-Google-Smtp-Source: AMsMyM4mOCJ0gq5d8k+H/PGV841SZyXxkz57DzZ11dWZzVAptBhviMmcYH/Ah4ZL9JzsCltDGVYNrw==
X-Received: by 2002:a17:907:749:b0:782:3e85:97c4 with SMTP id xc9-20020a170907074900b007823e8597c4mr6001914ejb.446.1663919193186;
        Fri, 23 Sep 2022 00:46:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id b11-20020a170906194b00b0072ed9efc9dfsm3668867eje.48.2022.09.23.00.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 00:46:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1obdOJ-003FCe-2s;
        Fri, 23 Sep 2022 09:46:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH] cmd-list.perl: fix identifying man sections
Date:   Fri, 23 Sep 2022 09:38:12 +0200
References: <20220923070334.1970213-1-martin.agren@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220923070334.1970213-1-martin.agren@gmail.com>
Message-ID: <220923.86wn9u4joo.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 23 2022, Martin =C3=85gren wrote:

> We attribute each documentation text file to a man section by finding a
> line in the file that looks like "gitfoo(<digit>)". Commit cc75e556a9
> ("scalar: add to 'git help -a' command list", 2022-09-02) updated this
> logic to look not only for "gitfoo" but also "scalarfoo". In doing so,
> it forgot to account for the fact that after the updated regex has found
> a match, the man section is no longer to be found in `$1` but now lives
> in `$2`.
>
> This makes our git(1) manpage look as follows:
>
>   Main porcelain commands
>        git-add(git)
>            Add file contents to the index.
>
>   [...]
>
>        gitk(git)
>            The Git repository browser.
>
>        scalar(scalar)
>            A tool for managing large Git repositories.
>
> Restore the man sections by grabbing the correct value out of the regex
> match.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  This is a v2.38.0-rc1 regression.
>
>  Documentation/cmd-list.perl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/cmd-list.perl b/Documentation/cmd-list.perl
> index 9515a499a3..16451d81b8 100755
> --- a/Documentation/cmd-list.perl
> +++ b/Documentation/cmd-list.perl
> @@ -11,7 +11,7 @@ sub format_one {
>  	open I, '<', "$name.txt" or die "No such file $name.txt";
>  	while (<I>) {
>  		if (/^(git|scalar)[a-z0-9-]*\(([0-9])\)$/) {
> -			$mansection =3D $1;
> +			$mansection =3D $2;
>  			next;
>  		}
>  		if (/^NAME$/) {

Ouch, good catch!

In the v1 review for scalar[1] I pointed out that I had a local patch
where this is instead:

	if (/^[a-z0-9-]*\(([0-9])\)$/) {
		$mansection =3D $1;

The v2 at [2] which I didn't get around to reviewing (sorry!) then
introduced this logic error.

Victoria: Did you find some reason to not just take the version I had?
The doc-diff with Martin's above is empty, i.e. it's the same in
practice, but if we don't need to hard-code our top-level commands for
no reason I don't see why we'd maintain this list of them here.

On the proposed rc patch: FWIW we can also just use (?:) groupings
instead of a capture:

	if (/^(?:git|scalar)[a-z0-9-]*\(([0-9])\)$/) {

It has the same effect, but arguably makes more sense. I.e. if we don't
care about $1 let's not capture the thing we don't care about into $1 in
the first place.

1. https://lore.kernel.org/git/220831.86y1v48h2x.gmgdl@evledraar.gmail.com/
2. https://lore.kernel.org/git/070f195f027e5601b88ca6a0d4c9991b472ad9ab.166=
2134210.git.gitgitgadget@gmail.com/
