Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD7C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 07:29:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BCAA2078C
	for <git@archiver.kernel.org>; Thu,  7 May 2020 07:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV8C1VHQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725903AbgEGH33 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 03:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725802AbgEGH32 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 03:29:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B77C061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 00:29:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id g13so5039159wrb.8
        for <git@vger.kernel.org>; Thu, 07 May 2020 00:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dBFGCpwiwD2+Ysr7uvTsxobhDhfq6iBvdn9rs6mCJSA=;
        b=iV8C1VHQVKH5COFEfThj6QfP3n7EKp+e3l8mBgnQiqEvtoapl2UAkhSa9nqPrPjPl0
         nFXMy8xhV9jPSJqUxXfQURqo9UNk30DbyMqbIPBF2CN77yV/FdJ6ZuAjQ6k/ZbOl8edr
         C2Mh6z+fI4hNYS76c4Q9vRE8u+a4wLDUO/oXEi5Dw2BOyxIZbaMNnG3R8NbX5usiOvko
         9/LU8i0n5x6S37TJt5miajR8YGE5e9l4X68GSvPdtgofmzKmNodoPcB4PWMt+2gMe+Jb
         oXnaSdZ4s6g0jk4TtwI860wogDpKiQwb2jqdQgrOc0Alyn4Z+OGD+AkU5W83v/tIt9Xx
         aoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=dBFGCpwiwD2+Ysr7uvTsxobhDhfq6iBvdn9rs6mCJSA=;
        b=Kwb5CpupCfpV0rF9CFs6+SgDYBAhiOv4z2vRPvpVYU8nPMi/x71QvxZ5P1dmwIgjOP
         FpiNB29CfCGTWjNeEz/IarCZfXNoeiJzemN5E/Gh8YYilTSnAYlHGrmXXb9P/8EESJJ1
         PQss5KSTA1b2n4sL6vJ5ERB5LhWQPO+LW7UiSOuxsf/urBOu/ujRN82r6GzOXrP3FufI
         ZEBvMY0iMB3GRaZb1nzDipbjJQvrk418lW25NKHcdD0/aLXn3j8DOYpDfmxHgczDKX1m
         kUlPqPP0MIdOK0iJIYO6YOf/g3WzC+ia7kK09D8dFUGK0p5hwnA6LmeGu+9jYoE2SVSr
         /rqA==
X-Gm-Message-State: AGi0Pua4QGjzTeyRpbC5W2wq/ijgNLSxy8RDoyRQpsgHZ4H3iq3tUWia
        asvQevEs6Yg7MpCK+tkNqHEHX3hZPUM=
X-Google-Smtp-Source: APiQypJh2dH6vzahbs/ue2Xn/XoCxYOHrAnZUGfAHuKVbJf0CGrS74gTmv5mdwKsLOTM2ojGlOQ32Q==
X-Received: by 2002:adf:e44b:: with SMTP id t11mr14807100wrm.188.1588836566175;
        Thu, 07 May 2020 00:29:26 -0700 (PDT)
Received: from ?IPv6:2a02:a210:ca2:9c00:4c05:518a:3ad9:8dba? ([2a02:a210:ca2:9c00:4c05:518a:3ad9:8dba])
        by smtp.gmail.com with ESMTPSA id x7sm6080843wmi.17.2020.05.07.00.29.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 May 2020 00:29:25 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/2] midx: apply gitconfig to midx repack
From:   Son Luong Ngoc <sluongng@gmail.com>
In-Reply-To: <xmqqy2q56lo7.fsf@gitster.c.googlers.com>
Date:   Thu, 7 May 2020 09:29:24 +0200
Cc:     Son Luong Ngoc via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <dstolee@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <696D63FD-5AE2-41DB-8CF8-D81AB834EA45@gmail.com>
References: <pull.626.git.1588684003766.gitgitgadget@gmail.com>
 <pull.626.v2.git.1588758194.gitgitgadget@gmail.com>
 <21c648cc486cf1abee51076d21e55649b1464516.1588758194.git.gitgitgadget@gmail.com>
 <xmqqy2q56lo7.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Thanks for the feedbacks

> On May 6, 2020, at 19:03, Junio C Hamano <gitster@pobox.com> wrote:

...
> We write this part in imperative mood, as if
> we are giving an order to the codebase to "become like so".  We do
> not say "I do X, I do Y".

This is a great feedback.
I will try to include all of your suggestions and edit the message
before submitting V3.

>> Note:
>> - `repack.packKeptObjects` will be addressed by Derrick Stolee in
>> the following patch
>=20
> This definitely does not belong to the commit log message.  It would
> make a helpful note meant for the reviewers if written below the
> three-dash line, though.

Duly noted.

> Do we need to worry about the configuration variables understood by
> the "git pack-objects" command to get in the way, by the way?
> "pack.packsizelimit" may cause "git repack" to produce more than one
> packfile, and if this codepath wants to avoid it (I do not know if
> that is the case), it may have to override it from the command line,
> for example.

I dont think we want to avoid the packsizelimit here.
The point of repacking with midx is to help
end users consolidate multiple packfile in a non-disruptive way.

If you wish to put a constraint (i.e. packsizelimit, packKeptObjects) on =
this process,
you should be able to.

>> Signed-off-by: Son Luong Ngoc <sluongng@gmail.com>
>> ---
>> midx.c | 10 ++++++++++
>> 1 file changed, 10 insertions(+)
>>=20
>> diff --git a/midx.c b/midx.c
>> index 9a61d3b37d9..3348f8e569b 100644
>> --- a/midx.c
>> +++ b/midx.c
>> @@ -1369,6 +1369,8 @@ int midx_repack(struct repository *r, const =
char *object_dir, size_t batch_size,
>> 	struct child_process cmd =3D CHILD_PROCESS_INIT;
>> 	struct strbuf base_name =3D STRBUF_INIT;
>> 	struct multi_pack_index *m =3D load_multi_pack_index(object_dir, =
1);
>> +	int delta_base_offset =3D 1;
>=20
> By default we use delta-base-offset, so if repo_config_get_bool()
> did not see the repack.usedeltabaseoffset configuration defined in
> any configuration file, we still want to see 1 after it returns.
>=20
>> +	int use_delta_islands;
>=20
> What is the reason why it is safe to leave this uninitialized?  Did
> you mean=20
>=20
> 	int use_delta_islands =3D 0;
>=20
> here?

I think I totally misread how repo_config_get_bool() supposed to work
Your comment here made me re-read it and things got a lot clearer.

Will set the default value to 0 in next version.

> Thanks.

Much appreciate,
Son Luong.=
