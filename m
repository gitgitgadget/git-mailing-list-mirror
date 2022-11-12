Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD95EC4332F
	for <git@archiver.kernel.org>; Sat, 12 Nov 2022 11:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234948AbiKLLo6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Nov 2022 06:44:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbiKLLo5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Nov 2022 06:44:57 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3086A1B5
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 03:44:56 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ud5so17971389ejc.4
        for <git@vger.kernel.org>; Sat, 12 Nov 2022 03:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aqYuG3CIoMRNjGPaynvWxxBfeY3Ogvkdf0porraHxBQ=;
        b=N0B99VYZD5DxfxH8ZB9wy1CnK5w+iTCigiJt2s2UAZajBxL9PiMJZi6cby1goxZdQ4
         dvpWQ5TuOlvLAYfuSx5LvENzRIbhVG2k4AP0BvBgN4ivmNAVPGxafhJDEZDWi1hZHx7w
         c5THaUNs48FDJugHxb80gf96VZTXS7f6CQFn4kgAs1wluD5xi0hlgAVWyWbcMnLSxdxh
         y9e02cxIXVoAHwizHp3oRQyj2CyXDmYCoNduWpuEK/eqfs2y3zy8lP8djy/IRJkr92yo
         FvGD2iBVEaO2eHPNZVmdyZeoJSJ6ko2NGuNDCsR6VfyeiFxEglc8szd1hfmpah8tnKbC
         nqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqYuG3CIoMRNjGPaynvWxxBfeY3Ogvkdf0porraHxBQ=;
        b=Bp0yzWZkRe2rrhXwnmT8gR6SjoQJ/fyE/rSe+OqvZzMhN1RMgApLG0wHJGS+iH3WnQ
         03kTVYcQlj5swhVToIpBfXcC9VxDNP83+7ytw67spHF0Jx4A7YbnJxNPZp5lRTT25hY+
         cKbkPx0vGQKd/owxCDPgA3F/0+pa3uPPD5yhEgAh6fdWyp+tfx0Lur2aVBjSV6KKn8/r
         oqdVhu5cdSGI7VwGlg+KK3b4LmniGg8QtRllv6qSFHhIaCEwug8MfrQBDlf797+vcjED
         U/PEKfZTvnhBnfFmNsR5mAZDJwG/CRDhvSbQjCEdYF99xRhNyUQj18Tjg1JJBxScZNfd
         EpUg==
X-Gm-Message-State: ANoB5pmAKMUzC3/olm9SaqpKTo3TrFTgGpiKwEKn2ItZ4yzTcL9irFkv
        5LzdlXYVeT1iPczCen0CWrg=
X-Google-Smtp-Source: AA0mqf4qwIVRkjtebU+x3nMyPuDwD7aHq9kfgFeD1HFe2slau+vEfqY4cVsou3TVH1O5hz+5NAcL6A==
X-Received: by 2002:a17:907:1398:b0:78b:a8d:e76a with SMTP id vs24-20020a170907139800b0078b0a8de76amr4937381ejb.725.1668253495146;
        Sat, 12 Nov 2022 03:44:55 -0800 (PST)
Received: from gmgdl ([109.38.148.58])
        by smtp.gmail.com with ESMTPSA id rh16-20020a17090720f000b0073d7bef38e3sm1452181ejb.45.2022.11.12.03.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 03:44:54 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otowP-0029z9-0Q;
        Sat, 12 Nov 2022 12:44:53 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/3] pack-objects: fix handling of multiple --filter
 options
Date:   Sat, 12 Nov 2022 12:41:13 +0100
References: <c64e4fa5-62c2-2a93-a4ef-bd84407ea570@web.de>
 <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <53bffbf4-8308-0dd7-bca5-7c85b8334e05@web.de>
Message-ID: <221112.86bkpcmm6i.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 12 2022, Ren=C3=A9 Scharfe wrote:

> Since 5cb28270a1 (pack-objects: lazily set up "struct rev_info", don't
> leak, 2022-03-28) --filter options given to git pack-objects overrule
> earlier ones, letting only the leftmost win and leaking the memory
> allocated for earlier ones.  Fix that by only initializing the rev_info
> struct once.

If I do e.g. this with SANITIZE=3Dleak:

	echo e83c5163316f89bfbde7d9ab23ca2e25604af290 | ./git pack-objects --revs =
--filter=3Dblob:limit=3D1001 --filter=3Dobject:type=3Dblob --stdout  >/dev/=
null

I see one leak that wasn't there, but two that are gone now. I haven't
looked into it, but I think the commit message should discuss what leaks
are fixed, which remain/are new etc.

> @@ -4158,7 +4158,8 @@ static struct list_objects_filter_options *po_filte=
r_revs_init(void *value)
>  {
>  	struct po_filter_data *data =3D value;
>
> -	repo_init_revisions(the_repository, &data->revs, NULL);
> +	if (!data->have_revs)
> +		repo_init_revisions(the_repository, &data->revs, NULL);
>  	data->have_revs =3D 1;
>
>  	return &data->revs.filter;

FWIW as this goes away in your 2/3 I think just squashing the two with a
leak fix would be nice, if...

> diff --git a/t/t5317-pack-objects-filter-objects.sh b/t/t5317-pack-object=
s-filter-objects.sh
> index bb633c9b09..bd8983bb56 100755
> --- a/t/t5317-pack-objects-filter-objects.sh
> +++ b/t/t5317-pack-objects-filter-objects.sh
> @@ -178,6 +178,25 @@ test_expect_success 'verify blob:limit=3D1001' '
>  	test_cmp expected observed
>  '
>
> +test_expect_success 'verify blob:limit=3D1001+object:type=3Dblob' '
> +	git -C r2 ls-files -s large.1000 |

Aside: Should do "git >tmp && test_parse... <tmp", we lose the exit code
of "ls-files" here.

> +	test_parse_ls_files_stage_oids |
> +	sort >expected &&
> +
> +	git -C r2 pack-objects --revs --stdout --filter=3Dblob:limit=3D1001 \
> +		--filter=3Dobject:type=3Dblob >filter.pack <<-EOF &&
> +	HEAD
> +	EOF
> +	git -C r2 index-pack ../filter.pack &&
> +
> +	git -C r2 verify-pack -v ../filter.pack >verify_result &&
> +	grep blob verify_result |
> +	parse_verify_pack_blob_oid |

Whereas this one's not a problem, no "git".

> +	sort >observed &&
> +
> +	test_cmp expected observed

Aside: It would be nice if we had a "test_cmp_sort", but some other day...

> +'
> +
>  test_expect_success 'verify blob:limit=3D10001' '
>  	git -C r2 ls-files -s large.1000 large.10000 |
>  	test_parse_ls_files_stage_oids |

...we can test it, but this test is in a file that's not part of "linux-lea=
ks".

If that one leak I mentioned above can be fixed (or maybe it's not new?)
this could be tested if we put it in a file of its own with
TEST_PASSES_SANITIZE_LEAK=3Dtrue.
