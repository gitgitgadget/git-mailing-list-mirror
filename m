Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F261AC4332F
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAEEA61214
	for <git@archiver.kernel.org>; Thu, 23 Sep 2021 17:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242237AbhIWRJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242190AbhIWRJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 13:09:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59A0C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:08:04 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id hx25so632893ejc.6
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 10:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=o+EJBC48nfh78dIkfebXnjWN/Fe3IUC1DOAmqT1tQVM=;
        b=IVwy9NH76XL9mJwIMt/IH9SEdYEYRyFzlz4n70GoYKXA6vsb46HxflgW8VMLWZ5QG8
         ut/fQk+RgvA4VO+tQrvx5NkkStxrqmH+QiK2Zh6QVk5mH0Ev/PgChwVUrLahkaJ+qJ/e
         A0FoRY3YZSJtyt6o0YVW64gP+BC20+otrTdgrWV/tIgn2R8U7HWPRIote5bjqj3uH7AN
         56Ee6w78F8zy7k9tfBwff8ppl8vIh34SUH01OLw6a9pFWGWRVrb5CMjfyWjxW6SX9Rvz
         ZPiTIjMFiaj53DArI2LuN72TFyaBLLWDt4IlRoX2QpIaojytb+3Y8XXN19NJtmlQUQGq
         xNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=o+EJBC48nfh78dIkfebXnjWN/Fe3IUC1DOAmqT1tQVM=;
        b=sMkn1xQ9/sSCx+ByGCCWidLMM7qxrgpP0gfnkWD1aqw9/zB7FxLLTjKg50dse3X/dG
         7rXbg8twGwKZpOauSdJU2zLh1zHd9gh1yuBMf3WXfcON86y3dyXMgNbx8g/00cSBuWOL
         XpRHbzQjyXVw7zNDiONNnox/8NdkzJAHqSDPpLVDn1CXDcwnXm/ZVJl3b5DrjgguPT5U
         xRNZgX02VCiV0Jk6u8H3wp4dYnvxPhjfuAkOi8wEmHypxMj2W5GVMp4X98ON1RA8H2MN
         Q1l+FMtbzmMrwQX8J8FtrFmuiERJmHBFBoMrMblYHMv0z0f1r7SziUDNbG7KRiQ5lTpJ
         R3zg==
X-Gm-Message-State: AOAM531xvmc38fpESAD8whosq2GyUj8eRKRtqH0PMB42xyrzzoc0Jak/
        TFde/g5HXvDwdt9egxrt2eE=
X-Google-Smtp-Source: ABdhPJzWymRn2fuf6KZ5XGJVt9f/YU5RaNa/0nl+P46IbyPNl/6+3kU5jmbyepgdLpgIbXu0Ed4d2w==
X-Received: by 2002:a17:906:2345:: with SMTP id m5mr6172426eja.557.1632416883139;
        Thu, 23 Sep 2021 10:08:03 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a12sm3428155eje.27.2021.09.23.10.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 10:08:02 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2] Makefile: make the "sparse" target non-.PHONY
Date:   Thu, 23 Sep 2021 19:06:02 +0200
References: <cover-0.3-00000000000-20210921T224944Z-avarab@gmail.com>
 <patch-v2-1.1-059829f2195-20210923T000654Z-avarab@gmail.com>
 <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YUyqIpOLFDqG/kEJ@coredump.intra.peff.net>
Message-ID: <87ilyr43v2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 23 2021, Jeff King wrote:

> On Thu, Sep 23, 2021 at 02:07:16AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> We ensure that the recursive dependencies are correct by depending on
>> the *.o file, which in turn will have correct dependencies by either
>> depending on all header files, or under
>> "COMPUTE_HEADER_DEPENDENCIES=3Dyes" the headers it needs.
>>=20
>> This means that a plain "make sparse" is much slower, as we'll now
>> need to make the *.o files just to create the *.sp files, but
>> incrementally creating the *.sp files is *much* faster and less
>> verbose, it thus becomes viable to run "sparse" along with "all" as
>> e.g. "git rebase --exec 'make all sparse'".
>
> OK. I think this solves the dependency issues sufficiently. It is a
> tradeoff that you must do the normal build in order to do the sparse
> check now. That is certainly fine for my workflow (I am building Git all
> the time, and only occasionally run "make sparse"). I don't know if
> others would like it less (e.g., if Ramsay is frequently running sparse
> checks without having just built).
>
> (I'd say "I do not care that much either way", but then I do not care
> all that much either way about incremental sparse checks either, so I'm
> not sure my opinion really matters).

Aside: As I recall you make a lot of use of ccache (as I do), so is the
"meh" on incremental builds synonymous with it not being piped through
$(CC) in this case?
