Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A20C433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:38:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955C16103D
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 10:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhIKKjY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 06:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIKKjX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 06:39:23 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C25BC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:38:11 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id c22so4947654edn.12
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 03:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=SxhugJkFKZ7dk29rW3Aw5bC/ONSIJmSqqwb4RtFngwM=;
        b=JCPgm2mfhHPNtnmIrDo8a8JEvH/S9KAhE+C5I7AcTJbtsPy+NzEgOlBYPBkUEwP0hC
         1wD1gxfqHswexHi7N2CLdqYarmJol4KbGa0wv3/loGxmv7jmwbvIh49M3712GFmzXUPo
         mDbktaE7QG1ZPq8DnAkWK2p0/Wtoh1EdwMqmmLtU4Mvg/6cZ9rlKFrogc7bDIZX++yWy
         zqvFTaEK1W2jMkvNPrYanK03lbXhQrU+ydcX27pONSNrYugueSsMv0MHoUyDSDOWsEXa
         liytsx36Fqg1agFMBA3kjbJQ7OueSVVH+oieQuwkpMX6upCevWSrF1hA0n0u0l9RVjTv
         9//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=SxhugJkFKZ7dk29rW3Aw5bC/ONSIJmSqqwb4RtFngwM=;
        b=gDFjSJqMLPeWkollzPJyZ8u+ApDqSzKjGZTuXalaaNyguLYtaUGWQjMgSG6p8od5Au
         Rucl9fpq8QrSqD1DF4vDr1pvhhYkxr6EdgpUd75ububWeuEAzJVIvw0LVpu4iZQQKs2e
         oSaB0JNCqAJzokGHThYE9/AMN1zyxSVNDc7gjQcm70vXWjwTB6mCVvnGXW3f8Ag2l8j1
         Mu+8Av57oYs0POe1E6edn1Fm87fs+LSPgcBZ4BWycf1sY2IjnJGpWUJ2Ab0USUo06AAP
         Kkfd+lq30DsApGJNQl8RfrgYsWhDxzEU9aBAoBQiO7I2833wN77E7q0RI1c+lAFJPzU2
         guFQ==
X-Gm-Message-State: AOAM533F4ECk1L81PEcMBS4CGQ+t6wH3lrb5U8LbM4SW8b1GpM1dODIp
        hdx4Vx8uae3gu74ABwX7cv8=
X-Google-Smtp-Source: ABdhPJzbI5DD1AYF0HMwxFGEGsJalU32JX5SHgmt5A8L+8RHDNsBFsyLVgffMePq+lRFmTbZAy67qw==
X-Received: by 2002:a50:ff0b:: with SMTP id a11mr2604441edu.373.1631356689938;
        Sat, 11 Sep 2021 03:38:09 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bs13sm604657ejb.98.2021.09.11.03.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 03:38:09 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 8/8] builtin/repack.c: pass `--refs-snapshot` when
 writing bitmaps
Date:   Sat, 11 Sep 2021 12:27:39 +0200
References: <cover.1631331139.git.me@ttaylorr.com>
 <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <6a1c52181e8c8c9fe2f0e2d7fbeb1057f68c1f3d.1631331139.git.me@ttaylorr.com>
Message-ID: <871r5v9z3i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Taylor Blau wrote:

> +struct midx_snapshot_ref_data {
> +	struct tempfile *f;

Style/readability: Spare more than one byte for a variable name in a
struct, maybe file, or tmpfile?

> +	fprintf(data->f->fp, "%s%s\n", data->preferred ? "+" : "",
> +		oid_to_hex(oid));

Just an idea: Maybe the file could be lines of "+\tOID\n" instead of
"+OID\n"? Lends itself more naturally to extension, use with the likes
of string_list_split() etc.

> +		for_each_string_list_item(item, preferred) {
> +			for_each_ref_in(item->string, midx_snapshot_ref_one, &data);
> +		}

Cheap style commenst I know, but throughout this series there's an odd
mixture of sometimes adding braces for one-lines, sometimes not, or in
the case of that "else ;" I commented on not for something *much* bigger
:)

> +		if (midx_snapshot_refs(refs_snapshot) < 0)
> +			die(_("could not take a snapshot of references"));

Seems like this die() should be moved into the midx_snapshot_refs()
function and that function should use die_errno(), not die(), also it
uses close_tempfile_gently(), shouldn't save the errno on failure there,
clean up the tempfile, and then die?
