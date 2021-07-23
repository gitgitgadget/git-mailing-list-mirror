Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A539C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B81260EBD
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 08:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234443AbhGWHnH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 03:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234461AbhGWHnG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 03:43:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AFDC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 01:23:40 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id n10so2438076plf.4
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 01:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J4h8S9Fs58qcL8g+3geqsvoDhzSoGPOFNRJbQSGwagM=;
        b=dEwDzHBKqYQ1eJ1HD1DY+mTPYteProoHNcx8/LoaSX/ZGlM+uzRc5yoRiEHhpFJ358
         Hl0341CHLzB7f/NYFxU1OgzvGTkPTX3NIiaSdIRwPX4vk1ZD01QXgC6+UHFzgqObVtQ5
         TcpEDylV2D7m6p0oRrKb+zEXSXve+T60T/xb/0pK8RnB9hNqCcV3iRjA6JCiohRBsRdI
         0pE96A5kbp60Jcs7Jd1dUitv6PCZFV3VdNbslXa++wtMbjpZxryjknDSFinOFwgjEYrX
         rptYHAEKoVk+q5UfLaex/HeJH0mGl/yJSZbd08rpIIdxT/PytupAp/S48dvm7MuQw1Zp
         LQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=J4h8S9Fs58qcL8g+3geqsvoDhzSoGPOFNRJbQSGwagM=;
        b=exP4zVcD9zY6fg+x6JI7Mqmg1e8WM65zSCPNtjM8MsyqcaJh/zNO+96Yo2m3G/5DZj
         F7RwD6RRCdsFpxLsOQ9vbj4XUfDfUZOOzOgiACJJ4/dQG+adWyPNU1mu/ZIiyV2pzccc
         nIz/DA/TWUeGvu9zpi66CljXXPIhSUQn07cv2POWCDoSK+p3yOjtXSqFCCm9mONxd+HZ
         ND7Z2BZIz5GH6zwsiwXSEJe5yPP6rHkPAZsiuppjzNAYexG5zktXeQQz7BIbm5ug/bcM
         g+SqJ0bLTFAiyrokiMQO6YzUKnceRwpr/T1ta/LedejsBPUGk6b0WFyFH8s3ul9K+Rkm
         g6YA==
X-Gm-Message-State: AOAM530dZAj75kSHcfE3oHqfqUae4jKKNfn+rl2VFVS3pcXPTMHW2edB
        6b2/zTJowomGj1vli4/3fqk=
X-Google-Smtp-Source: ABdhPJzv06v0yNguYxNn/IYaFGkb1Mrb7VcMK8UzKZdza3T2TDKeZeZsiTFN3/VpWUfhHcEobx0meQ==
X-Received: by 2002:a63:110c:: with SMTP id g12mr3776497pgl.139.1627028620075;
        Fri, 23 Jul 2021 01:23:40 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 73sm28725478pjz.24.2021.07.23.01.23.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jul 2021 01:23:39 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: Re: Bug: All git operations fail when .git contains a non-existent
 gitdir
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
Date:   Fri, 23 Jul 2021 13:53:36 +0530
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <3D8703D8-54E6-4CF0-9E9F-CCAFFAA8914C@gmail.com>
References: <CAFSh4UzCWMCpOGZUYnrxwK79F6jN3irdNs=J7O6RMCeJbBxFBw@mail.gmail.com>
 <YPimnEtNgKD32r2o@camp.crustytoothpaste.net>
 <CAFSh4Uyr5v9Ao-j0j7yO_HkUZSovBmSg7ADia7XCNZfsspFUYg@mail.gmail.com>
To:     Tom Cook <tom.k.cook@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22-Jul-2021, at 18:43, Tom Cook <tom.k.cook@gmail.com> wrote:
> On Wed, Jul 21, 2021 at 11:59 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
>>=20
>> On 2021-07-21 at 09:17:36, Tom Cook wrote:
>>> What did you do before the bug happened? (Steps to reproduce your =
issue)
>>>=20
>>> Add a git submodule to a git repository.
>>> Overlay-mount that submodule to another place in the filesystem.
>>> Attempt any git operation in the overlay-mounted path.
>>=20
>> I'm not sure about what you mean by an overlay-mount operation.  Can =
you
>> provide some specific commands that we can run at a shell that =
reproduce
>> the issue?
>> --
>> brian m. carlson (he/him or they/them)
>> Toronto, Ontario, CA
>=20
> The easiest way to reproduce it is this:
>=20
> $ mkdir test
> $ cd test
> $ echo "gitdir: /foo/bar" > .git
> $ git ls-remote https://github.com/torvalds/linux
>=20
> We happen to use overlay mounts in our build system in a way that maps
> a git submodule from one place to another so that its "gitdir" is
> invalid and then attempt a `git ls-remote` from that location which
> unexpectedly fails.  But the above reproduces the problem well enough.

'ls-remote' needs a valid git directory for the case where the URL is =
not
explicitly supplied (to read the git config and learn the default =
remote).

Making a special case for when an explicit URL is not given is not as
straightforward as it seems, because by the time 'ls-remote' even knows =
about
its arguments, it already takes a worktree prefix and sets up the =
environment,
for which a valid Git repository path is required.

I am not too familiar with this area, and I don't know how feasible it =
is to
delay setting up the environment until after looking at the 'ls-remote'
arguments. At a cursory glance, it looks difficult to do without large
structural changes to the code.

This might have been less of a problem with old-form submodules, where =
'.git'
was an actual directory, rather than a text file pointer [1], but newer
versions of Git discourage their usage.

[1] https://git-scm.com/docs/gitsubmodules#_forms

PS: we prefer bottom posting or inline replies :)

---
Pointers for others who might be interested in looking into this:

The immediate cause of this seems to be 'setup.c:setup_gitdir_gently()' =
[2]
which calls 'setup_gitdir_gently_1()' with the 'die_on_error' argument =
set
to true. This function then calls 'read_gitfile_gently()' with the same =
flag,
which errors out when it runs 'is_git_directory()' [3], because the path =
in
the gitfile is not a valid repository.

[2] =
https://github.com/git/git/blob/eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687/s=
etup.c#L1234
[3] =
https://github.com/git/git/blob/eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687/s=
etup.c#L784-L799

---
Atharva Raykar
=E0=B2=85=E0=B2=A5=E0=B2=B0=E0=B3=8D=E0=B2=B5 =E0=B2=B0=E0=B2=BE=E0=B2=AF=E0=
=B3=8D=E0=B2=95=E0=B2=B0=E0=B3=8D
=E0=A4=85=E0=A4=A5=E0=A4=B0=E0=A5=8D=E0=A4=B5 =E0=A4=B0=E0=A4=BE=E0=A4=AF=E0=
=A4=95=E0=A4=B0

