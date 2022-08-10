Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22D09C25B08
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 13:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbiHJNJ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbiHJNJO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 09:09:14 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B30E79A49
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 06:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Mime-Version:Subject:From:Date:Message-Id; bh=kgqDd
        rk+H2WG+2rkJl7mhyprjk+9ob0hLjst4pYiYxw=; b=EEPTmRE5R+lTkYd7qWf1J
        wusG/ay6oKi073WpTweM5kt4/S2s12DzKiJZqHR4ThWrYIRwDfPpj3a7m59L2HJk
        9WLXJJGx0ScphT1wgvKVAe/x/3AZJcSihsoe85dHD06ObM+CitifytqwdePfuPme
        T6JeE94VeiMNJPpKid6oPM=
Received: from smtpclient.apple (unknown [125.70.13.115])
        by smtp10 (Coremail) with SMTP id DsCowAD35UrwrfNim3cIAg--.33632S3;
        Wed, 10 Aug 2022 21:09:05 +0800 (CST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH 0/3] refs-advertise: add hook to filter advertised refs
From:   =?utf-8?B?5a2Z6LaF?= <16657101987@163.com>
In-Reply-To: <CANYiYbFc6xywoCPgge+RMb6Scr8JwS2f=n65XG2jupHS-w2jLw@mail.gmail.com>
Date:   Wed, 10 Aug 2022 21:09:03 +0800
Cc:     Sun Chao via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1E392965-45B2-4CD8-942C-24E3CA045ABD@163.com>
References: <pull.1301.git.git.1659543457.gitgitgadget@gmail.com>
 <CANYiYbFc6xywoCPgge+RMb6Scr8JwS2f=n65XG2jupHS-w2jLw@mail.gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
X-CM-TRANSID: DsCowAD35UrwrfNim3cIAg--.33632S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw17CF18Xr4rZryDZFWkZwb_yoW5Zw18pr
        4rKr17Jw1kJF1UAr1Utw1rJF18Jrs3Jry5J345Jr1DXws8JF15tFnrtrZ0vayUAwnrJw45
        Xr4UtrW8Jr98A3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRRVbQUUUUU=
X-Originating-IP: [125.70.13.115]
X-CM-SenderInfo: rprwlkyxrqimiyx6il2tof0z/1tbiMhFZglWB0US6yAAAsL
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Aug 10, 2022, at 09:06, Jiang Xin <worldhello.net@gmail.com> wrote:
>=20
> On Thu, Aug 4, 2022 at 12:31 AM Sun Chao via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>=20
>> Gerrit is implemented by JGit and is known as a centralized workflow =
system
>> which supports reference-level access control for repository. If we =
choose
>> to work in centralized workflow like what Gerrit provided, =
reference-level
>> access control is needed and is possible if we add a reference =
advertise
>> filter hook just like what Gerrit did.
>>=20
>> This hook would be invoked by 'git-receive-pack' and =
'git-upload-pack'
>> during the reference discovery phase and the commit fetching phase, =
each
>> reference and will be filtered by this hook. Git server can put
>> reference-level control process to this hook and the git client does =
not
>> need to change or known about that.
>=20
> =46rom the document you provided in patch 3/3, the hook returns not =
only
> names of the references, but also OIDs. Since the oid of reference
> should be provided as-is during the advertising phase, it is
> sufficient for the hook to just return the visible reference names.
>=20
> How about:
> 1. Implement a batch version of "ref_is_hidden()", such as
>    "refs_batch_hidden()", to turn on or turn off the hidden bit
>    for all references.
>=20
> 2. If there is an external hook, such as "hide-refs", call it instead
>    of the config variables such as "transfer.hideRefs" to filter refs
>    based on ACL and operations (read and write).
>=20
> --
> Jiang Xin
>=20

Thanks a lot, Jiang Xin.

Your suggestion is right, for protocol V1 we do not need to filter the =
OIDs, and
there should be a configuration to turn on/off the hidden bit, I will =
try to add
such kind of configuration, maybe "transfer.hideRefs" is a good choice.

And after received Junio's reply I also did tests for V2, I find that =
even I
hide all the refs (by "git config transfer.hiderefs refs/" in upstream) =
the client
can still fetch specific object by it=E2=80=99s object id, here is the =
trace log:

```
.............................           trace: built-in: git fetch =
origin 5585e358b2a240ca8ed65a00008dbc865a1381c1
.............................           packet:        fetch< version 2
.............................           packet:        fetch< =
agent=3Dgit/2.37.1.288.gef002b009d
.............................           packet:        fetch> =
command=3Dls-refs
# the server does not advertise any refs
.............................           packet:        fetch< 0000
.............................           packet:        fetch> =
command=3Dfetch
# the client send the want command with object oid
.............................           packet:        fetch> want =
5585e358b2a240ca8ed65a00008dbc865a1381c1
.............................           packet:        fetch> done
.............................           packet:        fetch> 0000
.............................           packet:        fetch< packfile
# the client received the packfile contains the objects
.............................
=46rom file:///local/upstream.git
 * branch                5585e358b2a240ca8ed65a00008dbc865a1381c1 -> =
FETCH_HEAD
```

Protocol V2 does not limit the request to the advertised refs, and if we =
want to
hide some refs, we need to hide the objects only reachable from them =
(for V2),
but it truly has performance issue for some huge repository.=

