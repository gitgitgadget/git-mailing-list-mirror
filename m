Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3A49E7E65A
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 18:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbjIZSXh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 14:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235395AbjIZSXf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 14:23:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02C911F
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 11:23:28 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-774d385dcaaso37570385a.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 11:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695752608; x=1696357408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i+nkw6YwCG3sSR53EVNJ1qmtExb8F5vQAFpSidbcXBs=;
        b=EgLHnbsL+tPyZs6v5AdPJOMHlxP35huD38MFj7orE04r9/ImKohy8x4tHSwDa57SzA
         k9QGkolbvUU0RvTy1lGdlB2fEZ6+CKyAySmAV+VK5FDaEnJVAcNw2l8oub4XzrWfHyzF
         YNDOwK9jv+PA1ujR73BSF/sjH5BfSjlH/6A5rB/Q7zfjJjm5kqXI/qN8JwljJWmU4vQf
         PRhGXQhOgjq+BtQeqWyBYB8A2NoAeGfyzi08C1XsOlSO5Xy2z4RRPoRteLP4TZa55onR
         HHFTc4C1ZV15keZekeIUSZQ8EgAzqPEbCe2HCAM8eqnNfIuy+TaAQDEow3ZBHuR7/bTd
         Ri7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752608; x=1696357408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i+nkw6YwCG3sSR53EVNJ1qmtExb8F5vQAFpSidbcXBs=;
        b=XH59TVafpOKHBghRujAyjqqV2Wu28K+e2biVVfsjFatCvpRZZe60EiZhRSmHVGY00P
         nV1OZlxHM8RYRnzhFbQ2wUmk7bGBlHCuQvsdoE/9DChxPDgAZY3AKmkj8CzJvYNHCUWT
         cF9kVgWq6SaPP6ITBmUscLl/5/b/EgwRxUA/Ctb0y963DhgwlE/GRc9gMmVsqjHp0tRw
         tr+vJgJfeSMY45sCIqWbn3oXVuev2GZ+nc1H8/vioP9flNyPVHtR6DH5lzThiJKbLnsy
         uu8i3xgjsY2/2vT7f1JF6tVDvZEHtDDTnA2Yocjia452TMBrlul6HTB0sx9SSz0MbZPh
         unJA==
X-Gm-Message-State: AOJu0YxizEM3eIc2Tv9IP7cRxwjqP0pWe8faxLOeGlNoOlLs0SKa66di
        9tSPzcK6cApU3T9ze1a3zk4=
X-Google-Smtp-Source: AGHT+IGJc+xrnbjpCV9PXkvWhDAl6XrjVB0+Els3s9JzRsiVYmyeXdwq9cbbcW6xSEO2dLwOtIJX6w==
X-Received: by 2002:a05:620a:1998:b0:774:ace:5a45 with SMTP id bm24-20020a05620a199800b007740ace5a45mr11648236qkb.5.1695752607894;
        Tue, 26 Sep 2023 11:23:27 -0700 (PDT)
Received: from [192.168.1.181] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id r25-20020a05620a03d900b00767e2668536sm4925620qkm.17.2023.09.26.11.23.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 11:23:27 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] attr: attr.allowInvalidSource config to allow invalid revision
Date:   Tue, 26 Sep 2023 14:23:26 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <F825AAFE-E55E-402F-8116-34D6FC61034C@gmail.com>
In-Reply-To: <20230921041545.GA2338791@coredump.intra.peff.net>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
 <xmqqfs38akx5.fsf@gitster.g>
 <20230921041545.GA2338791@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On 21 Sep 2023, at 0:15, Jeff King wrote:

> On Wed, Sep 20, 2023 at 09:06:46AM -0700, Junio C Hamano wrote:
>
>>> With empty repositories however, HEAD does not point to a valid treei=
sh,
>>> causing Git to die. This means we would need to check for a valid
>>> treeish each time.
>>
>> Naturally.
>>
>>> To avoid this, let's add a configuration that allows
>>> Git to simply ignore --attr-source if it does not resolve to a valid
>>> tree.
>>
>> Not convincing at all as to the reason why we want to do anything
>> "to avoid this".  "git log" in a repository whose HEAD does not
>> point to a valid treeish.  "git blame" dies with "no such ref:
>> HEAD".  An empty repository (more precisely, an unborn history)
>> needs special casing if you want to present it if you do not want to
>> spew underlying error messages to the end users *anyway*.  It is
>> unclear why seeing what commit the HEAD pointer points at (or which
>> branch it points at for that matter) is *an* *extra* and *otherwise*
>> *unnecessary* overhead that need to be avoided.
>
> In an empty repository, "git log" will die anyway. So I think the more
> interesting case is "I have a repository with stuff in it, but HEAD
> points to an unborn branch". So:
>
>   git --attr-source=3DHEAD diff foo^ foo
>
> And there you really are saying "if there are attributes in HEAD, use
> them; otherwise, don't worry about it". This is exactly what we do with=

> mailmap.blob: in a bare repository it is set to HEAD by default, but if=

> HEAD does not resolve, we just ignore it (just like a HEAD that does no=
t
> contain a .mailmap file). And those match the non-bare cases, where we'=
d
> read those files from the working tree instead.
>
> So I think the same notion applies here. You want to be able to point i=
t
> at HEAD by default, but if there is no HEAD, that is the same as if HEA=
D
> simply did not contain any attributes. If we had attr.blob, that is
> exactly how I would expect it to work.

You captured this quite well!

>
> My gut feeling is that --attr-source should do the same, and just
> quietly ignore a ref that does not resolve. But I think an argument can=

> be made that because the caller explicitly gave us a ref, they expect i=
t
> to work (and that would catch misspellings, etc). Like:
>
>   git --attr-source=3Dmy-barnch diff foo^ foo
>
> So I'm OK with not changing that behavior.
>
> But what is weird about this patch is that we are using a config option=

> to change how a command-line option is interpreted. If the idea is that=

> some invocations care about the validity of the source and some do not,=

> then the config option is much too blunt. It is set once long ago, but
> it can't distinguish between times you care about invalid sources and
> times you don't.
>
> It would make much more sense to me to have another command-line option=
,
> like:
>
>   git --attr-source=3DHEAD --allow-invalid-attr-source
>
> Obviously that is horrible to type, but I think the point is that you'd=

> only do this from a script anyway (because it's those automated cases
> where you want to say "use HEAD only if it exists").

Yeah, I see the point about using a config to change default behavior of =
a
command leading to confusion.

>
> If there were an attr.blob config option and it complained about an
> invalid HEAD, _then_ I think attr.allowInvalidSource might make sense
> (though again, I would just argue for switching the behavior by
> default). And I really think attr.blob is a better match for what GitLa=
b
> is trying to do here, because it is set once and applies to all
> commands, rather than having to teach every invocation to pass it
> (though I guess maybe they use it as an environment variable).

In retrospect perhaps a config would have been better here. I think this
patch started with improving an existing command line flag [1] by making
it global. So I think we were just thinking about command line flags and
didn't consider configs.

That being said, for GitLab at least there's not a lot of difference sinc=
e
we pass in configs through the commandline anyways rather than relying on=
 the config
state itself on disk for our bare server-side repositories.


1. https://lore.kernel.org/git/pull.1470.git.git.1679109928556.gitgitgadg=
et@gmail.com/

>
> Of course I would think that, as the person who solved GitHub's exact
> same problem for mailmap by adding mailmap.blob. So you may ingest the
> appropriate grain of salt. :)
>
> -Peff


thanks
John

