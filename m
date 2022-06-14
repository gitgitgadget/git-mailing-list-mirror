Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A039EC43334
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 07:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354313AbiFNHZa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 03:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351788AbiFNHZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 03:25:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585CD3DA5B
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 00:25:26 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id n10so15418740ejk.5
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 00:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=qQ6kQ9LI+JVsODUR/EFKkGJezBzEQeE3ml0H7ik+wdU=;
        b=NSWt8Lzp6b+SPueI9j23y3MpC8dP+dfPo6VW1+xSyq8fP2/0ZRzMYBSLQ7oO9P1Izn
         GB97qvtwn61hxyOo271VpibnQreUksuoQKS0FRgSDePVqRnyvw+29sUZ5py4Y6bQpATd
         ta6fpcsEVCjGHZmSn/ETivtTsq8I8ORTLAgVpgOBMrCfPCcPuo1EuFFlJyiMyrSnW+Pf
         xwDrRnWy/ZOcbJv2jAqIFMmXilOKebiQms1/XexhycAXL7gmBKJtREmcOPqVbef/cF1s
         9DVjfzX0LNIRir5O85szyx2VI4uGHuXTHHUdEWRbphF0P2e6WF8xgNn8/Iz/WLfIMOVx
         wGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=qQ6kQ9LI+JVsODUR/EFKkGJezBzEQeE3ml0H7ik+wdU=;
        b=bE550hOiJm8a01wDRoGSzMkW6ugcJsdJVt+Pp9lx/4gbDoC+Ya1cjHvz7xzH3A5fRg
         APmuf+yLa/+Xh5Vnivx0C7ONIv7EDDqJCu/K03VDlMktJvLCZ7uxW3nrXKvjbvZZawA/
         JpGhHUCIOw4ecBOpsqtz5/bVBOob0W7reH4JxmBMZIN9TlHPo4lSH36NaWgU0g9De7/0
         blb6YyFMGD6+Kl1J2jowAKBfQcDhGLttKp+bywHigvDW9t9OcplhSJj99l7/a8pMUdy1
         r7NONBbIFHaa26CBY5NBScy3PeijBEq4zFuFL7XIXXjwnChRP2MuZPRNmSzUGdJ//RX0
         H0TQ==
X-Gm-Message-State: AJIora9Koe0V2RGhNdGHVE3td/cQ26p9jdgwN6Y2CRQ6ArDLLsaM4eL8
        V1E8rr1z3Dw+L/jIKxn2K1RgGVtlWwNApxd7Aoy+KmR1aJoYYdJPu2Qfvg==
X-Google-Smtp-Source: ABdhPJz1Z+ED66SIqKyj9GrO4Azl2MVcCJ/DUgyvS15LhH4jex3a4q+dPE2CmOi/Z7pSUE8lmXdQjPmYUFRTL+gtD2Q=
X-Received: by 2002:a17:906:c155:b0:708:21b1:dcf6 with SMTP id
 dp21-20020a170906c15500b0070821b1dcf6mr3030824ejc.661.1655191524570; Tue, 14
 Jun 2022 00:25:24 -0700 (PDT)
MIME-Version: 1.0
From:   Haiyng Tan <haiyangtand@gmail.com>
Date:   Tue, 14 Jun 2022 15:25:13 +0800
Message-ID: <CANe9W27GVn-w1WSZNTxh5SKEMzHGEZQCF48vmbvMi4AUEg12yQ@mail.gmail.com>
Subject: Re: An endless loop fetching issue with partial clone, alternates and
 commit graph
To:     git@vger.kernel.org, chiyutianyi@gmail.com
Cc:     ps@pks.im, jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 13 Jun 2022 00:17:07 +0800, Han Xin wrote:
> We found an issue that could create an endless loop where alternates
> objects are used improperly.
>
> While do fetching in a partial cloned repository with a commit graph,
> deref_without_lazy_fetch_extended() will call lookup_commit_in_graph()
> to find the commit object. We can found the code in commit-graph.c:
>
>      struct commit *lookup_commit_in_graph(struct repository *repo, const=
 struct object_id *id)
>      {
>           =E2=80=A6
>           if (!search_commit_pos_in_graph(id, repo->objects->commit_graph=
, &pos))
>                return NULL;
>           if (!repo_has_object_file(repo, id))
>                return NULL;

> If we found the object in the commit graph, but missing it in the reposit=
ory,
> we will go into an endless loop:
>      git fetch -> deref_without_lazy_fetch_extended() ->
>           lookup_commit_in_graph() -> repo_has_object_file() ->
>                promisor_remote_get_direct() -> fetch_objects() ->
>                     git fetch
>
> I know that the reason for this issue is due to improper use of
> alternates, we can ensure that objects will not be lost by maintaining
> all the references. But shouldn't we do something about this unusual
> usage, it will cause a fetch bombardment of the remote git service.
>
> We can reproduce this issue with the following test case, it will
> generate a lot of git processes, please be careful to stop it.
> =E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94
> #!/bin/sh
>
> test_description=3D'test for an endless loop fetching=E2=80=99
>
> GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
> . ./test-lib.sh
>
> test_expect_success 'setup=E2=80=99 =E2=80=98
>     git init --bare dest.git &&
>     test_commit one &&
>    git checkout -b testbranch &&
>    test_commit two &&
>    git push dest.git --all
> '
>
> test_expect_success 'prepare a alternates repository without testbranch' =
'
>    git clone -b $GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME dest.git alternates=
 &&
>    oid=3D$(git -C alternates rev-parse refs/remotes/origin/testbranch) &&
>    git -C alternates update-ref -d refs/remotes/origin/testbranch &&
>    git -C alternates gc --prune=3Dnow
> '
>
> test_expect_success 'prepare a repository with commit-graph' '
>    git init source &&
>    echo "$(pwd)/dest.git/objects" >source/.git/objects/info/alternates &&
>    git -C source remote add origin "$(pwd)/dest.git" &&
>    git -C source config remote.origin.promisor true &&
>    git -C source config remote.origin.partialclonefilter blob:none &&
>    git -C source fetch origin &&
>    (
>        cd source &&
>        test_commit three &&
>        git -c gc.writeCommitGraph=3Dtrue gc
>    )
> '
>
> test_expect_success 'change alternates' '
>    echo "$(pwd)/alternates/.git/objects" >source/.git/objects/info/altern=
ates &&
>    # this will bring an endless loop fetching
>    git -C source fetch origin $oid
> '
>
> test_done
>
> ------------------------------------------------------
>
> Thanks
> -Han Xin

I think it's caused by using lazy-fetch in deref_without_lazy_fetch_extende=
d().
In lookup_commit_in_graph(), lazy-fetch is initiated by
repo_has_object_file() used.
has_object() should be used, it's no-lazy-fetch.
