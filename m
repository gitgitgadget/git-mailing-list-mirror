Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16CFC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiG1QAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiG1QAA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:00:00 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC56BD44
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 08:59:59 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id ez10so3865512ejc.13
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 08:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=LTjsfU3tNBlKqz5KAKPSE8Jz0Iln8RcbLh6m7d+VyKQ=;
        b=Djedtotj4WUaeg+hSTvCiR/exLwZS4jHFaD7CY5tbgfn+5yKJMX/5lAefOEyIp0bbH
         tKaDcqP2UvexOF1BTq+NBsLaY/rSBTUEpzvcC74F7Ip4LuIglMdYOV39eDaByx1QXv/U
         34qeN614KygGIJVos4Qx5F0vZNVuoVOBA/aA7Rei1+/n2JOfqVfYnHwQDqTko3QCOEoQ
         AnP7xl/1oofeePpr7UUIzvZL0DrLh2BuPwVHZztIMGYdi9Bi+u6yoQoRRLkv7jxxTXyG
         wkmMjvmCWEeLHLOi2cf6Q/yTxkG2gCDLBSSe5LttJaZyItUEteLJoP7jO0ezsuNkud1K
         /tyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=LTjsfU3tNBlKqz5KAKPSE8Jz0Iln8RcbLh6m7d+VyKQ=;
        b=fxqVTP4aFYPnyLxkjyxJNfg1geRZSf1edXuLzcWFl0pmQy5telJgAeGkMRmB4SCzyy
         ZuPdmyOkJdzoc7rGrE+qrCa0prSuLIOBDomwBaWHdWBWTVg0SMXQFgKjWDHJtErpSPu1
         TRpUGpQ8bzCAH9G9xhpUpe05JHeafFMGai6d3cp8sADxAnOxA1t0AYs52IJvhpsXaeN9
         /VVC5O5ozu/uNY966/XlHT1ghFRSBadoZ1RdYwp/bR1RbS4l5qkdkxI6uYiy4n4/xLP2
         mtCWPjEyhZE0QWvr7Ghj6Io+6MD8bnqeO9FldofVNmbj5Uhs0xwvZvedCOOjpH3be9Zg
         wbwQ==
X-Gm-Message-State: AJIora9AvLVTRJyne8dZ7xqZguSQB9i/edcJXi/RHpfHUZMUH/+ELNfA
        uImCBOoCR3oEmp/p+3SAfayqp/3/DAjTFA==
X-Google-Smtp-Source: AGRyM1uScQ3SDoqs624f0HzJk73WHl6S9nAAX61898/L8cJIm41FVIa+Mmnnqxkp/fhs/jmlcIIMIQ==
X-Received: by 2002:a17:907:28c9:b0:72b:6912:5453 with SMTP id en9-20020a17090728c900b0072b69125453mr20832915ejc.419.1659023997004;
        Thu, 28 Jul 2022 08:59:57 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id ck29-20020a0564021c1d00b0043c746cd907sm899456edb.31.2022.07.28.08.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 08:59:56 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oH5vX-0079ao-Fr;
        Thu, 28 Jul 2022 17:59:55 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: Question: What's the best way to implement directory permission
 control in git?
Date:   Thu, 28 Jul 2022 17:50:14 +0200
References: <CAOLTT8QusNzdO1mHqQFPz84pznYSpFWJunroRGXQ7qk6sJjeYg@mail.gmail.com>
 <220727.86mtculxnz.gmgdl@evledraar.gmail.com>
 <CAOLTT8QpYzoKDq6Pf8+YegCWngogy=3hUf-SyV180kntgucMpQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <CAOLTT8QpYzoKDq6Pf8+YegCWngogy=3hUf-SyV180kntgucMpQ@mail.gmail.com>
Message-ID: <220728.861qu5kz2c.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 28 2022, ZheNing Hu wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> =E4=BA=8E2022=
=E5=B9=B47=E6=9C=8827=E6=97=A5=E5=91=A8=E4=B8=89 17:20=E5=86=99=E9=81=93=EF=
=BC=9A
>>
>>
>> On Wed, Jul 27 2022, ZheNing Hu wrote:
>>
>> > if there is a monorepo such as
>> > git@github.com:derrickstolee/sparse-checkout-example.git
>> >
>> > There are many files and directories:
>> >
>> > client/
>> >     android/
>> >     electron/
>> >     iOS/
>> > service/
>> >     common/
>> >     identity/
>> >     list/
>> >     photos/
>> > web/
>> >     browser/
>> >     editor/
>> >     friends/
>> > boostrap.sh
>> > LICENSE.md
>> > README.md
>> >
>> > Now we can use partial-clone + sparse-checkout to reduce
>> > the network overhead, and reduce disk storage space size, that's good.
>> >
>> > But I also need a ACL to control what directory or file people can fet=
ch/push.
>> > e.g. I don't want a client fetch the code in "service" or "web".
>> >
>> > Now if the user client use "git log -p" or "git sparse-checkout add se=
rvice"...
>> > or other git command, git which will  download them by
>> > "git fetch --filter=3Dblob:none --stdin <oid>" automatically.
>> >
>> > This means that the git client and server interact with git objects
>> > (and don't care about path) we cannot simply ban someone download
>> > a "path" on the server side.
>> >
>> > What should I do? You may recommend me to use submodule,
>> > but due to its complexity, I don't really want to use it :-(
>>
>> There isn't a way to do this in git.
>>
>> It's theoretically possible, i.e. a client could be told that the SHA-1
>> of a directory is XYZ, and construct a commit object with a reference to
>> it.
>>
>
> I guess you mean use a special reference to hold the restricted path which
> the client can access, and pre-receive-hook can ban the client from downl=
oading
> other references. But this method is a little weird... How can this refer=
ence
> sync with main branches? If we have changed client permission to access
> server directory, how to get the "history" of the server directory?
>
> I believe this approach is not very appropriate and is not maintainable.

It's not maintainable at all, and I don't believe any current git client
supports this.

But due to git's commits referring to a Merkle tree I can tell you that
a subdirectory "secret" has a current tree SHA-1 of XYZ, without giving
you any of that content.

You *could* then manually construct a commit like:

	tree <NEW_TREE>
	...

Where the "<NEW_TREE>" would be a tree like:

	100644 blob <NEW-BLOB-SHA1>	UPDATED.md
	040000 tree <XYZ>	secret-stuff

And send you a PACK with my new two three new objects (commit, blob &
new top-level NEW_TREE). To the remote end & protocol it wouldn't be
distinguishable from a "normal" push.

But nothing supports this already, as a practical matter most of git
either hard dies if content is missing, or has other odd edge-case
semantics (and I'm not up-to-date on the state of the art).

Anyway, just saying that for the longer term I'm not aware of an
*intrinsic* reason for why we couldn't support this sort of thing, in
case anyone's interested in putting in a *lot* of leg work to make it
happen.

>> But currently a *lot* of things in the client code assume that these
>> things will be available in one way or another.
>>
>> The state-of-the-art in the "sparse" code may differ from the above, I
>> don't know.
>>
>> Also note that there's a well-known edge case in the git protocol where
>> it's really incompatible with the notion of "secret" data, i.e. even if
>> you hide a ref you'll be able to "guess" it by seeing what delta(s) the
>> server will produce or accept etc.
>
> Yeah, there are data security issues... Unless we need to isolate objects
> between directories. Or in this case we disable the delta object.....
> Okay, this seems a little strange.

You can't really just "disable the delta(s)". Well, you can in
principle, but like what I outlined above it's one of those things
that's a far way off, and it's one thing to e.g. have a client that's
able to craft a commit referring to data it doesn't have.

It's quite another to secure a server in such a way that it can serve up
secret data from the repo to some clients, but not to others.

I can imagine some hacks to make that happen, but I won't go into that
here...
