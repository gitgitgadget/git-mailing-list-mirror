Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53113C77B7E
	for <git@archiver.kernel.org>; Sun, 30 Apr 2023 02:22:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjD3CWh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Apr 2023 22:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjD3CWg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Apr 2023 22:22:36 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6419A6
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 19:22:33 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-5ef6cd8d50bso2745946d6.1
        for <git@vger.kernel.org>; Sat, 29 Apr 2023 19:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682821352; x=1685413352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gEWW3fEqOoesLsuCbRkez9CoRvjPNb+TIxEAt6tqMWY=;
        b=YVoatts7oFKpUmsqp9np8eQfIegkoS2QdVbV0hSzKGxFpkwJboBMrftjBwkQ8EozLn
         mZnMtxsgkZoc9GygeWje8NhH8eBeCtA3BCNDsRGUP7B87nnCO3gC2yl1DW46P0bMNnpQ
         2N0KAHpbUSHzXexLKrMuZ/2WzeiaEGhzyDPKhw0M3xljfAJKBXrWC12ynHt4U36FGnGS
         pFqrT1AwKrZpChC+r5MNCSEZVrcl1hpod5OlJPRCii0ea4lEgbpx2gL6xYCOqAqEBix7
         UXdrkOQ8ZobUawUsHzv/2IIWz+lDBUY2NccF+Z7OLQJ2aQtRg7KB42NxGuaHPDnNDWI8
         t2iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682821352; x=1685413352;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gEWW3fEqOoesLsuCbRkez9CoRvjPNb+TIxEAt6tqMWY=;
        b=fU+h6ZOy+OEuI2g/K1aN/fdowcghchgG9oyuoukqjB/3RwU3WC9HoyOmVSENbyWY2A
         XcqabKkNQUCOIlueNIEux8ilniOFd5c8Qnzhot1OnAWeBb4kFLCk83iHTeZKERqziapa
         GXAC7e7O/b6OCfIkJxIMDR33oSBCezpMP06gW8W+W3FA2eZbEB3rR45B1dx1vsxxGph2
         TGAbD7dRkPpTC2t5ZldyryaAVxhvgVwdOXq5IaSZEupUp2oqQQ0vHWhESAz5/Q2XCFM8
         +mS2lDc2kxdTF/BzgbfubgB7s/hXEOutg12yUMfJTFStpe4xx8L7F8ipkb+KK6mWVssu
         iYnQ==
X-Gm-Message-State: AC+VfDxvo/0WxL3RRxoSzErpCPZ74Mh36oMfUEhHGKyeSIWkbXsXLR9b
        dGAuJXTVeQ6sPMFgoZfT4aVzy84yUx+ghA==
X-Google-Smtp-Source: ACHHUZ4h0/Pd73yS5n9mPlG6lONZ02Q9/vS0az0zMAc2FXB3oPL/03TO8GWuPlDPhR+Hf0L8nkiPUQ==
X-Received: by 2002:a05:6214:4001:b0:5ed:c96e:ca4a with SMTP id kd1-20020a056214400100b005edc96eca4amr11305723qvb.1.1682821352163;
        Sat, 29 Apr 2023 19:22:32 -0700 (PDT)
Received: from [192.168.1.211] ([2600:4041:454d:2100:c9d7:5476:985c:74a2])
        by smtp.gmail.com with ESMTPSA id or6-20020a05620a618600b0074e1ee027c2sm7854201qkn.87.2023.04.29.19.22.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Apr 2023 19:22:31 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] attr: teach "--attr-source=<tree>" global option to "git"
Date:   Sat, 29 Apr 2023 22:22:31 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <5E890414-C174-4495-8BAD-7017E8E82764@gmail.com>
In-Reply-To: <CAP8UFD0mfb1HSUGT3Bz1gHhH3fMpGDnMHVf2pT0CjirL0C5zuA@mail.gmail.com>
References: <pull.1470.v2.git.git.1679936543320.gitgitgadget@gmail.com>
 <pull.1470.v3.git.git.1682707848916.gitgitgadget@gmail.com>
 <CAP8UFD0mfb1HSUGT3Bz1gHhH3fMpGDnMHVf2pT0CjirL0C5zuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian

On 28 Apr 2023, at 16:22, Christian Couder wrote:

>>       +--attr-source=3D<tree-ish>::
>>      -+ Read gitattributes from <tree-ish> instead of the worktree.
>>      ++ Read gitattributes from <tree-ish> instead of the worktree. Se=
e
>>      ++ linkgit:gitrevisions[7].
>
> I think it's more sensible to link to gitattributes(5) instead of
> gitrevisions(7)

oops, I forgot to push up the version with this fix. Thanks for catching =
it.

>
>> +static const char *default_attr_source_tree_object_name;
>> +
>> +void set_git_attr_source(const char *tree_object_name)
>> +{
>> +       default_attr_source_tree_object_name =3D xstrdup(tree_object_n=
ame);
>> +}
>> +
>> +
>
> One empty line is enough here.

noted.

>
>> +static void compute_default_attr_source(struct object_id *attr_source=
)
>> +{
>> +       int from_env =3D 0;
>> +
>> +       if (!default_attr_source_tree_object_name) {
>> +               default_attr_source_tree_object_name =3D getenv(GIT_AT=
TR_SOURCE);
>> +               from_env =3D 1;
>> +       }
>> +
>> +       if (!default_attr_source_tree_object_name || !is_null_oid(attr=
_source))
>> +               return;
>> +
>> +       if (repo_get_oid_treeish(the_repository, default_attr_source_t=
ree_object_name, attr_source)) {
>> +               if (from_env)
>> +                       die(_("bad --attr-source object"));
>> +               else
>> +                       die(_("bad GIT_ATTR_SOURCE"));
>
> I think it would be better to have just the following instead of the 4
> lines above:
>
> die(_("invalid tree object from --attr-source flag or GIT_ATTR_SOURCE
> env variable"));
>
> as a bad GIT_ATTR_SOURCE in a subprocess could come from a bad
> --attr-source in the main process.
>
> And this way the from_env variable is not needed.

sounds good
>
>> +       }
>> +}
>
> The rest looks good to me, thanks!

thanks,
John
