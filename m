Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096A1E7E657
	for <git@archiver.kernel.org>; Tue, 26 Sep 2023 18:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbjIZS1b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Sep 2023 14:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235539AbjIZS10 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2023 14:27:26 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B0341B0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 11:27:19 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65b093b97d2so7217836d6.0
        for <git@vger.kernel.org>; Tue, 26 Sep 2023 11:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695752838; x=1696357638; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9wrf2OG6B1NZwClD8FLYCwTJ5guQmh4ZY5Aims+sGU=;
        b=Qd+PusUyXQKpOIRqPmY2Br6MxE9gIBHb6mmM4IPoaDCSfzNFwi1CzXmvNTqt4hnLBS
         7GNm40Sw5JxMQWW4cw/JHfqlPu3wVGedc/htRODuZuPj4bxPm/5FBAZSDDf5mYflSwP8
         49bGJTzVvotQ9wb7QbjR0Fnkw0thuXRpQj4GPJYdkIxoQ8hvFMVIOy3yI0SRcHQ8SCVw
         LQTgxKKGWj0kG+tiwJ8L3DrCvXo3lBltVH74lMb6082nsx/5nhar8sy3qVR88GXmWzZE
         mLyOE2xMTfwbjH3dCpjVg/X9TUN+w8eafe94J3dy8T4tTs4abJKyuTv3bjRk6guNl8O/
         0PgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695752838; x=1696357638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9wrf2OG6B1NZwClD8FLYCwTJ5guQmh4ZY5Aims+sGU=;
        b=d63YlGmj5E6czm0yFJrevEeBm6ry57iDox8eCTI3n7EOltbacp2x4J6AVlh0oVdIt8
         8ooG+6dEddhETRFvHw6Oeh2ewpO/n5eETRYDbK3bVjBZuaWW/lvGq2K9E/5zL5YLaxE1
         elT26Baxe2AX1lJyzboHvgVAwsysc+jH5C/1iCpCtRSfg1STN3XODFv0Zwkr/3p0F1MY
         Ag2Hbc4xloeRuIkKpgnMnK3SqgJNEER3QrC/HQLXV3lFqv2C9Gs2BxA0OD/nUkBmm5U/
         TNVq0IQCodAymw7mURb16VvFanQvdd04daCRQ86D9aYmb6GnGVqnHfL4CJc+pb9+m0as
         tr4g==
X-Gm-Message-State: AOJu0Yxe92Z3LMXG9DMvKeIUsjqxXpDpktU2KZj7d1Cf5kiJf501Pf5J
        Yr/mDh6qhYKxH2KtNVhfIh0=
X-Google-Smtp-Source: AGHT+IF/Znu2bhFb1Z8yEcrfV5HXtBMD/XHKx/5hX1wZVAgKWFm1Odfj6gOqwufl48VUdMTZFPbriw==
X-Received: by 2002:ad4:5fcb:0:b0:64a:8d39:3378 with SMTP id jq11-20020ad45fcb000000b0064a8d393378mr11595304qvb.4.1695752838347;
        Tue, 26 Sep 2023 11:27:18 -0700 (PDT)
Received: from [192.168.1.181] (pool-74-105-67-34.nwrknj.fios.verizon.net. [74.105.67.34])
        by smtp.gmail.com with ESMTPSA id h3-20020a0cf403000000b00655d711180dsm258709qvl.17.2023.09.26.11.27.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Sep 2023 11:27:17 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] attr: attr.allowInvalidSource config to allow invalid revision
Date:   Tue, 26 Sep 2023 14:27:17 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <92BDE017-77A1-444A-A156-7CEC73456268@gmail.com>
In-Reply-To: <20230921214021.GB302338@coredump.intra.peff.net>
References: <pull.1577.git.git.1695218431033.gitgitgadget@gmail.com>
 <xmqqfs38akx5.fsf@gitster.g>
 <20230921041545.GA2338791@coredump.intra.peff.net>
 <xmqq1qer7vrv.fsf@gitster.g>
 <20230921214021.GB302338@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,	=


On 21 Sep 2023, at 17:40, Jeff King wrote:

> On Thu, Sep 21, 2023 at 01:52:52AM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>>> In an empty repository, "git log" will die anyway. So I think the mor=
e
>>> interesting case is "I have a repository with stuff in it, but HEAD
>>> points to an unborn branch". So:
>>>
>>>   git --attr-source=3DHEAD diff foo^ foo
>>
>> This still looks like a made-up example.  Who in the right mind
>> would specify HEAD when both of the revs involved in the operation
>> are from branch 'foo'?  The history of HEAD may not have anything
>> common with the operand of the operation 'foo' (or its parent), or
>> worse, it may not even exist.
>
> I think it's unlikely for a user to write that. But if you are running =
a
> server full of bare repositories that does diffs, you might end up with=

> a script that sticks "--attr-source=3DHEAD" at the beginning of every
> command.
>
> It is true that HEAD may not be related. But that is what we use if you=

> are in a non-bare repository and run "git diff foo^ foo".
>
> Arguably:
>
>   git --attr-source=3D$to diff $from $to
>
> is a better default for this command. But something like "git log -p" i=
s
> trickier, as you have many commits to show. You can try to use the tip
> of the traversal, but there may be multiple. Using the attributes from
> the destination of each commit is the most likely to avoid divergence
> between the attributes and the code, but it may also not be what people=

> want. Using the modern attributes from the working tree often makes
> showing historical commits much nicer.
>
> So I dunno. I could see arguments in both directions, but I think in
> general people have been OK with pulling attributes from the working
> tree. And --attr-source=3DHEAD is the bare equivalent.
>
>> But your "in this repository we never trust attributes from working
>> tree, take it instead from this file or from this blob" example does
>> make a lot more sense as a use case.
>
> I don't know that it was my example. :) But yes, if you do
> "--attr-source=3D$to", you're overriding even the non-bare case. That m=
ay
> be what you want for some cases, but as above, I think it's hard to
> apply consistently (or even what you'd want for the general case).
>
>>> And there you really are saying "if there are attributes in HEAD, use=

>>> them; otherwise, don't worry about it". This is exactly what we do wi=
th
>>> mailmap.blob: in a bare repository it is set to HEAD by default, but =
if
>>> HEAD does not resolve, we just ignore it (just like a HEAD that does =
not
>>> contain a .mailmap file). And those match the non-bare cases, where w=
e'd
>>> read those files from the working tree instead.
>>
>> "HEAD" -> "HEAD:.mailmap" if I recall correctly.
>
> True, yeah. We can't do that here because attributes are spread across
> the tree. So all my mentions of attr.blob would really be attr.tree.
>
>> And if HEAD does not resolve, we pretend as if HEAD is an empty
>> tree-ish (hence HEAD:.mailmap is missing).  It becomes very tempting
>> to do the same for the attribute sources and treat unborn HEAD as if
>> it specifies an empty tree-ish, without any configuration or an
>> extra option.
>>
>> Such a change would be an end-user observable behaviour change, but
>> nobody sane would be running "git --attr-source=3DHEAD diff HEAD^ HEAD=
"
>> to check and detect an unborn HEAD for its error exit code, so I do
>> not think it is a horribly wrong thing to do.
>
> Yeah, that is basically what I am proposing. It sounds from the
> discussion here that there are two interesting cases:
>
>   1. You want to use --attr-source=3DHEAD because you are trying to mak=
e a
>      bare repo behave like a non-bare one. You probably want the "don't=

>      complain if it is missing" behavior.

Yep, this is the primary use case for us.

>
>   2. You are trying to use the attributes from one side of the diff to
>      override the worktree ones (because the two trees are unrelated).
>      In which case it does not really matter if --attr-source complains=
,
>      because the diff will likewise complain if the tree cannot be
>      resolved.
>
> Just trying to play devil's advocate, though, I guess you could run a
> non-diff operation like say:
>
>   git --attr-source=3Dmy-branch check-attr foo
>
> and then you probably _do_ want to know if that source was ignored or
> typo'd.
>
>> But again, as you said, --attr-source=3D<tree-ish> does not sound like=

>> a good fit for bare-repository hosted environment and a tentative
>> hack waiting for a proper attr.blob support, or something like that,
>> to appear.
>
> I think folks mentioned mailmap.blob in the original discussion for
> --attr-source. I don't remember why the patch went with --attr-source
> there. Maybe John can speak to that.

Yeah I was looking for this, and I think I found it in [1], which was par=
t of a
separate patch having to do with gitattributes. If someone did mention it=
 in the
patch for --attr-source, then I can't remember why we decided to go with =
the
comand line flag rather than the config.

1. https://lore.kernel.org/git/ZBMn5T6zfKK+PYUe@coredump.intra.peff.net/

>
> -Peff
