Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D59C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 12:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbiG2Mto (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 08:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234644AbiG2Mtn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 08:49:43 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180A14D80F
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:49:41 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id n138so3535157iod.4
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 05:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wztJ7FdpwuvptLsXtEImSXpEnYops35Vk771QezEvMk=;
        b=Eh7nFfqoTd21rBZ+DA2C6J0JRGToF/WbQqJFaaRItiMr+7oBzPzyGj964JAn6vItw/
         2cf+qAYNRiHzdpcYUOLud5iacWB9vTDfXup77ILtIfnMQdClqifjHtsxiddY8SKVqYnc
         Ay9kKoVJ+hpm1OxzPcOhdk53qIq8X/3iBHPiRwh2e5fDhLABZs/Nmt0WiR8B7bAP2IkU
         vPQnNNEaa8/hlsh6Dxq2yAW93jq/OoTbjBbT0QnudfiFCpRunpsOvTQxXUPCsOrPwo23
         uYF+MOkRkVT2CH2WVXJyYv0LmC1IlmnPGQU/pqsmPKQn9IVTV7X0CSP+lQaYid6GH6Yz
         Mugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wztJ7FdpwuvptLsXtEImSXpEnYops35Vk771QezEvMk=;
        b=DAontn5oHF2T6dT1w6mCK44S6ldyJD4qJ5glHiE1pEOVTmn1Sikf/3vXlwBBlkswoS
         WrvASOEo88DnkUYGOJWbjmOjem7Cv4oROBWt4MZGYiynKC+7crSftL0YtaLoApQ57oVe
         PYm46FE/rG5/+Ltrl4L0e/8BUtEogtY9J4o1k8u737+RHSPU8vcE8AU4eGaKrvybb/Wt
         aTKgaXdteZkGEr5aQaEDpB51pxVr4PgGL+Yas/dOexeW5H7+fo61ZT7eQE6Hipm0OLA8
         uuF/OfRoPqDPvMkGYm8Gclo8Qjs9UuaKHcfb3KJByNXTJyUQO8nDh3Xt9TO3wXv+GrGb
         ZvrA==
X-Gm-Message-State: AJIora9kwsSI903uDmOx0Vx6O9ALlQ+d1VZa0Y33kjRx2Ni33QL+dIL3
        h1TOKFQlI4A/Ictu1JOFPD1GYYlvGyiSzkxr+UQ=
X-Google-Smtp-Source: AGRyM1tDmnLJDFH7LFcCaJE+AvzHGhukRpQQxpas4WDEmSEUl0vGLVHM3lheKpN0VXCqXx58waIyhzg3nvA70Lq1wHc=
X-Received: by 2002:a05:6638:12d4:b0:33f:aaab:8d84 with SMTP id
 v20-20020a05663812d400b0033faaab8d84mr1396461jas.67.1659098980439; Fri, 29
 Jul 2022 05:49:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
 <80dd46c5-f9ff-d2b3-2d7f-4b80e00494b8@gmail.com>
In-Reply-To: <80dd46c5-f9ff-d2b3-2d7f-4b80e00494b8@gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Fri, 29 Jul 2022 20:49:29 +0800
Message-ID: <CAOLTT8R0C_j1o6bXLtve0kCV2eUUgwLUk8+fUzwEYKgzPLPj3Q@mail.gmail.com>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
To:     Thomas Guyot <tguyot@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Guyot <tguyot@gmail.com> =E4=BA=8E2022=E5=B9=B47=E6=9C=8827=E6=97=A5=
=E5=91=A8=E4=B8=89 17:27=E5=86=99=E9=81=93=EF=BC=9A
>
> On 2022-07-27 04:56, ZheNing Hu wrote:
> > if there is a monorepo such as
> > git@github.com:derrickstolee/sparse-checkout-example.git
> >
> > There are many files and directories:
> >
> > client/
> >      android/
> >      electron/
> >      iOS/
> > service/
> >      common/
> >      identity/
> >      list/
> >      photos/
> > web/
> >      browser/
> >      editor/
> >      friends/
> > boostrap.sh
> > LICENSE.md
> > README.md
> >
> > Now we can use partial-clone + sparse-checkout to reduce
> > the network overhead, and reduce disk storage space size, that's good.
> >
> > But I also need a ACL to control what directory or file people can fetc=
h/push.
> > e.g. I don't want a client fetch the code in "service" or "web".
>
> Pushes can easily be blocked with a pre-receive or update hook on the
> server side. That covers the case where you want to prevenr users to
> update certain paths in the repo.

Agree. pre-receive-hook/update-hook may be the only way git does ACL
when client push.

> > Now if the user client use "git log -p" or "git sparse-checkout add ser=
vice"...
> > or other git command, git which will  download them by
> > "git fetch --filter=3Dblob:none --stdin <oid>" automatically.
> >
> > This means that the git client and server interact with git objects
> > (and don't care about path) we cannot simply ban someone download
> > a "path" on the server side.
>
> Indeed - core devs can correct me if I'm wrong but afaik even in the
> case of sparse checkouts and partial clones the packs may include other
> objects. I have no ideas how git selects objects and packs on sent and
> when it decides to repack objects... What I know is it can pack entire
> repos in just a few files using delta compression and it would probably
> make sense to sent these pack if there is no real benefit in repacking
> just the requested objects.

Yeah, here we need to consider the tradeoff between repacking all
objects in path
and sending objects one by one.

> > What should I do? You may recommend me to use submodule,
> > but due to its complexity, I don't really want to use it :-(
>
> Submodules is definitively an option for read ACLs, and considering git
> was not originally designed to hide information from a single store it's
> probably your only option. Moreover, if the git client is able to fetch
> directly blobs and trees (the later includes partial trees as a tree
> object is a single "directory" that can contain other blobs and trees),
> then even the server has no knowledge of where a tree hook into, or even
> how it's named. All that information would have to be mapped elsewhere.
>

An association: how does the linux file system do ACL?

1. The uid, gid of the file or sub directory record in directory entry.
2. When a user wants to access the file or sub directory, filesystem
check if the user has the same permission of uid/gid.

This is just a casual thought:

Let git imitate the linux file system, we may need to record user
signatures in entry of tree objects.

Then we let the server just download the objects which match
the user signature.

> To take your example above, the "common" subtree of "service/" could be
> in multiple top level directories (i,e, the same tree with same
> contents), and each top level dirs could have a different "common"
> subtree. So git would have to find where each tree object (one per
> directory) is accessible from for *each revision* before deciding if a
> client should be authorized to fetch an object, and the same would be
> required for blobs (and tree objects don't even know their own name,
> that comes from the reference in the parent tree or commit object for
> the top-level tree).
>

If the client tells the server what the objects it wants , yes, it
needs to check
all the paths which may "hold" these objects... But if user tell
server what's the
path it wants,  that will be easier for the server to check...

> So even before solving the client/server protocol issue you mentioned,
> you can't just hide part of a repo in git right now and changing that is
> definitively not trivial.
>

Agree. It's hard to change...

> --
> Thomas

ZheNing Hu
