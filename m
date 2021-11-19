Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41516C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D05761AA3
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 13:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235505AbhKSNna (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 08:43:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235424AbhKSNn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 08:43:27 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D74C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 05:40:25 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id w1so42770624edd.10
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 05:40:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KUfSzxHCe91T1OGkxz7e1LMVP1/WmEWxK2Clsr1oV4Q=;
        b=LwMWqxFY7nXyWJe+rhxbr112YhGZhf/qKgAXNwW9zNI/EgSqwMWuYeALXwp/0qLfGS
         W1YoYeiUqoxOfmDYBgQ83K8UoTl3T4qXeQ4AnEd88ek+sCxy/sWweV0q89OB8YKx8JH7
         v1Sn/PK9bG+s8P+6efexhSugXYWGxwAccHLcdmGGUy5KksU6h67QutcnHI0s6+U8s66c
         MjQN2kdqL+8GoLY9AHk28B5JZgzRMMx0Ih1TQn2PfZiK2nFY1W1vmzeDxWxpS+4qABgY
         a1NKejaU5CN59hMQdnx8+EXNkyKbIWbriWcabtDPCP/1ErAuS6/XVFnckLTaJ/N5VYql
         PKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KUfSzxHCe91T1OGkxz7e1LMVP1/WmEWxK2Clsr1oV4Q=;
        b=JZDKgIYow9/bku00uVnX77Gds7YhvC8OIPtE5ELwtz9pkCcjRIavNwX7PSZFGXkRMB
         JEWCglJh/e3l1MMLMCqN/ze3qzA/SLMxeT0xawj2KJPiKxqBmfaeG4sLDygc8uZkvjGe
         zg7xaKnb1iR08Ebt0xdlf6R1/p1CgREOCsn8RUb3HCdmYpFKQvlK2yaHl5gORCzPwqz3
         UkJn5sT6oPe1KgpygiGh8PlvKtfaK6VSo6+vQ4z+nHhzjXyHqRyOYsJmUCcPzmigLugI
         LxXjuJwoqnOOrexju8B5zcsgtP3jkM8uQ776UFyiqObJoGEhs1mwz66CK8o0VNYbTtvL
         zZtQ==
X-Gm-Message-State: AOAM531PbFCF6mUSW3aRVlW+vV5oQKZxVspo8fpIkmw9E35JFRMSDQQr
        ov2cC6bg7b8NqZ7aDFSo1jEVCzYmLWmchg==
X-Google-Smtp-Source: ABdhPJy2BoERE3nxjEPkTOt6QBxiaP7/m6yL59kM5SrU+Ead3LXdxhclz6eSv6g1DVnibSkirLw2Mg==
X-Received: by 2002:a17:907:a0d4:: with SMTP id hw20mr8128426ejc.16.1637329222303;
        Fri, 19 Nov 2021 05:40:22 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id f22sm898104edf.93.2021.11.19.05.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:40:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mo47p-000jPg-AH;
        Fri, 19 Nov 2021 14:40:21 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        congdanhqx@gmail.com
Subject: Re: [PATCH v2 1/1] ls-tree.c: support `--oid-only` option for
 "git-ls-tree"
Date:   Fri, 19 Nov 2021 14:30:52 +0100
References: <cover.1637321601.git.dyroneteng@gmail.com>
 <8b68568d6cbe379d40c61c48bf446eaa88221df5.1637321601.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <8b68568d6cbe379d40c61c48bf446eaa88221df5.1637321601.git.dyroneteng@gmail.com>
Message-ID: <211119.86wnl42ri2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Nov 19 2021, Teng Long wrote:

> Reviewed-by: Jeff King <peff@peff.net>
> Reviewed-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Reviewed-by: =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh <congdanhqx@gmail=
.com>

Please don't add the Reviewed-by headers yourself, either Junio
accumulates them, or if someone explicitly mentions that you can add it
with their name it's OK.

It doesn't just mean this person reviewed this series in some ML thread,
but "this person is 100% OK with this in its current form".

>  	List only filenames (instead of the "long" output), one per line.
> -
> +	Cannot be used with `--oid-only` together.

Better: "Cannot be combined with OPT."

> +--oid-only::
> +	List only OIDs of the objects, one per line. Cannot be used with
> +	`--name-only` or `--name-status` together.

Better: "Cannot be combined with OPT or OPT2."

> +enum {
> +	MODE_UNSPECIFIED =3D 0,
> +	MODE_NAME_ONLY,
> +	MODE_OID_ONLY
> +};
> +
> +static int cmdmode =3D MODE_UNSPECIFIED;

Better:

static enum {
	MODE_NAME_ONLY =3D 1,
        ...
} cmdmode =3D MODE_NAME_ONLY;

I.e. no need for the MODE_UNSPECIFIED just to skip past "0".

> @@ -135,10 +147,9 @@ int cmd_ls_tree(int argc, const char **argv, const c=
har *prefix)
>  			    N_("terminate entries with NUL byte"), 0),
>  		OPT_BIT('l', "long", &ls_options, N_("include object size"),
>  			LS_SHOW_SIZE),
> -		OPT_BIT(0, "name-only", &ls_options, N_("list only filenames"),
> -			LS_NAME_ONLY),
> -		OPT_BIT(0, "name-status", &ls_options, N_("list only filenames"),
> -			LS_NAME_ONLY),
> +		OPT_CMDMODE('n', "name-only", &cmdmode, N_("list only filenames"), MOD=
E_NAME_ONLY),
> +		OPT_CMDMODE('s', "name-status", &cmdmode, N_("list only filenames"), M=
ODE_NAME_ONLY),
> +		OPT_CMDMODE('o', "oid-only", &cmdmode, N_("list only oids"), MODE_OID_=
ONLY),

Better to preserve the wrapping here, to stay within 79 columns.

> +test_expect_success 'setup' '
> +	echo 111 >1.txt &&
> +	echo 222 >2.txt &&

Just use:

    test_commit A &&
    test_commit B

etc?

> +	mkdir -p path0/a/b/c &&
> +	echo 333 >path0/a/b/c/3.txt &&
> +	find *.txt path* \( -type f -o -type l \) -print |
> +	xargs git update-index --add &&
> +	tree=3D$(git write-tree) &&
> +	echo $tree

Stray echo? Unclear why this test setup is so complex, shouldn't this just =
be (continued from above):

    mkdir -p C &&
    test_commit C/D.txt

To test nested dirs?

> +'
> +
> +test_expect_success 'usage: --oid-only' '
> +	git ls-tree --oid-only $tree >current &&
> +	git ls-tree $tree | awk "{print \$3}" >expected &&


just cut -f1 instead of awk? Also don't put "git" on the LHS of a pipe,
it might hide segfaults. Also applies to the below.

> +	test_cmp current expected
> +'
> +
> +test_expect_success 'usage: --oid-only with -r' '
> +	git ls-tree --oid-only -r $tree >current &&
> +	git ls-tree -r $tree | awk "{print \$3}" >expected &&
> +	test_cmp current expected
> +'
> +
> +test_expect_success 'usage: --oid-only with --abbrev' '
> +	git ls-tree --oid-only --abbrev=3D6 $tree >current &&
> +	git ls-tree --abbrev=3D6 $tree | awk "{print \$3}" > expected &&
> +	test_cmp current expected
> +'
> +
> +test_expect_failure 'usage: incompatible options: --name-only with --oid=
-only' '
> +	test_incompatible_usage git ls-tree --oid-only --name-only
> +'

Hrm, did you copy this use of test_incompatible_usage from
t1006-cat-file.sh without providing the function?

More data for:
https://lore.kernel.org/git/87tuhmk19c.fsf@evledraar.gmail.com/ :)

Better to use:

    test_expect_code 128 ... # (or was it 129?)
