Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 898D9C636D3
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 23:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBHXV6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:21:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjBHXVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 18:21:54 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6660EB753
        for <git@vger.kernel.org>; Wed,  8 Feb 2023 15:21:51 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id qw12so1550215ejc.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2023 15:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EiXtcTkDSetD4di5V2o/HTqnwoFck64/dmvB+I345Fo=;
        b=j2PX5Cbp4rCsOLZ0fdkZ2ti50y+LtGmo7Li/MpCavR2nNOi735mEHPxYgbggr5O/8n
         Fj/HVN2hiJnPgRmUOrDdpAK6yiKOvqotEbG4gz1WnugX2doP3dn9JYWAiadXcVe4mbHG
         HHDoa3eCEgj3ofVOdKl7vQXHIgoFJiygn3IrGR1BQxIV8ouCHewf2qVfioalsvn1/MBW
         FbA5c7BGrxQbgNZtKIPiwklrWexsc7eZGKIMnxGXkayR1jwDxqxxZQ435Wqx6xJ+KZLN
         wGy8OarAvlB2kmre7ITBOCVghQmEIUlUpjyYf9xia99qKMhur6JUBQGYiv9jP8aqAwsn
         tEaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiXtcTkDSetD4di5V2o/HTqnwoFck64/dmvB+I345Fo=;
        b=61SMNGRi221UikbZD/Kqs25NyqZKEoQ6TUGX0+Jr4he0uulj9+bXIMZAZ3wfxZDsZn
         U3MF0RQ6thLk5K4yPoN6GmYGomBlL/UPYoJXJTdhMJclsPxfP49glLh2/9wqxoaoagUi
         SKnOVzGVZeHyRs4RjmH17h57TtM0ghQxs5qHoDpr0nHljbKViP+vR1JqZxI87oYpQMlh
         7hZE8YVcj8FdwvoMWDMvPw6UuouWacCXDXOMc2HqlVug1u9QubgJrfn7GrUpuwEqRFKn
         UFZA9V7nV35u0qM8OnIPIknXzwJX6UBzAeNKLlyEouT51lMU5+Q0eLHg7SCzDaKq0Vou
         RAsQ==
X-Gm-Message-State: AO0yUKXJm76LQYFngVrk2CWwBWpTlwKIrEZBXkBLbeKDzpYY15N+Kh3h
        xc/+8FDbZEYVW3uI1VVt83cmyy86cb5S9jK0
X-Google-Smtp-Source: AK7set+SA3/uKO74/Z7q0yOHm65Q0/caFSnlyEoxnnY+ug9VM9kM9oxaMd38uFvw4iCoLge6JZ9hzQ==
X-Received: by 2002:a17:907:7e9f:b0:8aa:c35a:fb23 with SMTP id qb31-20020a1709077e9f00b008aac35afb23mr7428681ejc.47.1675898509789;
        Wed, 08 Feb 2023 15:21:49 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id gh3-20020a170906e08300b0084d34eec68esm68978ejb.213.2023.02.08.15.21.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 15:21:49 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPtl6-001Who-1q;
        Thu, 09 Feb 2023 00:21:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] test: make SYMLINKS prerequisite more robust
Date:   Thu, 09 Feb 2023 00:09:46 +0100
References: <xmqqwn4sq73f.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqqwn4sq73f.fsf@gitster.g>
Message-ID: <230209.86k00rzqsz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Junio C Hamano wrote:

> I see many failures around SYMLINKS prerequisite in Windows tests.
> There are too many to point at, but the pattern seems to be the
> same.  Here is one example:
>
>   https://github.com/git/git/actions/runs/4127147009/jobs/7130175639#step:5:502
>
> where "ln -s x y && test -h y" succeeds and declares SYMLINKS
> lazy prerequisite is satisfied, but then it fails to run
>
> 	"ln -s unrelated DS && git update-index --add DS"
>
> with:
>
> 	error: readlink("DS"): Function not implemented
>
> I wonder if something like this is in order?

I don't have much to contribute on that front, but this is really
missing some "why", this worked before, why is it failing now? Do we
have any idea.

We use "windows-latest", at first I suspected that this was the
2019->2022 migration, which seems to be happening around now:
https://github.blog/changelog/2022-01-11-github-actions-jobs-running-on-windows-latest-are-now-running-on-windows-server-2022/

But looking at a previous successful run on master:
https://github.com/git/git/actions/runs/4089369223/jobs/7052074004

V.s. this current failure:
https://github.com/git/git/actions/runs/4127146869/jobs/7130173444

Shows that both run 2022, and seem to be running the same software,
except that in "set up job" this is different, it was:

	Download action repository
	'git-for-windows/setup-git-for-windows-sdk@v1'
	(SHA:cbe017cd7ae39629bf4e34fce8b1ccd211fec009)

Now:

	Download action repository
	'git-for-windows/setup-git-for-windows-sdk@v1'
	(SHA:848609620edfa4c2fc64838b85fbe19e534236ee)

I have no idea if that's related though...

> diff --git a/t/helper/test-readlink.c b/t/helper/test-readlink.c
> new file mode 100644
> index 0000000000..c300dc8a1a
> --- /dev/null
> +++ b/t/helper/test-readlink.c
> @@ -0,0 +1,19 @@
> +#include "test-tool.h"
> +#include "strbuf.h"
> +
> +static const char *usage_msg = "test-tool readlink file";
> +
> +int cmd__readlink(int ac, const char **av)
> +{
> +	struct strbuf buf;

You're leaving the strbuf uninitialized here, use STRBUF_INIT...

> +	int ret;
> +
> +	if (ac != 2 || !av[1])
> +		usage(usage_msg);
> +
> +	ret = strbuf_readlink(&buf, av[1], 0);

...it's used here, and there's no implicit strbuf_init() on
strbuf_readlink(). The first thing it does is inspect sb->alloc.

> +	if (!ret)
> +		printf("%s\n", buf.buf);

Nit: puts(buf.buf);

All in all a simple helper, but isn't this redundant to "test_readlink"?

That requires perl, and once we have this we could just replace it, but
then let's do that here, no?

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 01e88781dd..c8094f643b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1773,7 +1773,8 @@ test_lazy_prereq PIPE '
>  
>  test_lazy_prereq SYMLINKS '
>  	# test whether the filesystem supports symbolic links
> -	ln -s x y && test -h y
> +	ln -s x y && test -h y && test-tool readlink y >/dev/null &&
> +	test "$(test-tool readlink y)" = x

Why get the exit code, and then proceed to hide the exit code with the
test "$()" pattern, we can just (untested):

	echo x >expect &&
	test-tool readlink y >actual &&
	test_cmp expect actual

If you're trying to avoid leaving litter or cleaning up that's not
needed anymore with these lazy prereqs for a while now (they get their
throw-away temporary directory).
