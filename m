Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0816C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 09:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343704AbhLAJRG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 04:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245049AbhLAJPP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 04:15:15 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C3C061574
        for <git@vger.kernel.org>; Wed,  1 Dec 2021 01:11:55 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id y13so98686411edd.13
        for <git@vger.kernel.org>; Wed, 01 Dec 2021 01:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Zg21tVjTAz7tWvyWAI4TXNqvS0rdZadlTlBcUpaAL8g=;
        b=SXO6P0jdp/ykDD7LLTPvrYsT+kr7c+qkoGNty8VeE2T1VvbFGXksLmRnVeIdpUsdhL
         Ixu63g5zyPNkoOxqXEYvw3YCxPKucLOLP+ksrYVXxcMND+48oZos14VnjX6qQfpu8h+3
         +fDwlaGsssqhq8/OnTXjGA92cBjld13Vc6zv6tHGqoJkmom1QxJ5uK+uaZ+YAorrEksH
         sBE+JAk/7PROEBNpKvs5JoTSXQaK29/Y8v+JDveYjvFDIYGJdM0robVwFPzN3VGralJs
         cVmI7VNWgMesTNRtpgxXvHJAroCCS8o2yQsGWg/g3V5EeUoIsAbxdiz9K5QByemAK5B3
         q2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Zg21tVjTAz7tWvyWAI4TXNqvS0rdZadlTlBcUpaAL8g=;
        b=iIXQav8XqDXbQ8JXAYbkBezuiYQBIOQmAK2+iyIHJBs2MKrDYtcGWABrsWTzI6rsuR
         NHuOVJxUf66czIm9rE5lRbTq//XLyJMV69sedHgNECQPqO6vHhrF5i3Q8/1kMEwoEm57
         YegYyRs8GDGn0r10wTLM3+/U08S8VRJLwE1HSM2BBU4nO0v5EMqHnkeUNDKOUz17MQZN
         8kbID+PlkAVAQ+Mo0I37NgrRnOWTI8if9IZUMopVXZv6JfKZMqbkX3+ZFnLl6XspoKbB
         09mnQA4eXt3IGDzz2/FqGClMD4YvVAH/0o3ebmVgMGzO8D3Ob5njin+V3NOaXzCp8BOR
         YrSg==
X-Gm-Message-State: AOAM532FYdpRXFI64j9Ec1Q1YCJlXZPPQdj7TP5BNdEpEjUxHcAbP5Bp
        Y+AkKuGAaxxZO8nR9Rg2pV8mUNWUU3RHaA==
X-Google-Smtp-Source: ABdhPJw8uLPcWdjNwX7PEODtC+XYj+nZR6oiUIdI9zp3e2QvujgZYZdEPTLpm9ohc2IDbV0Qq/lpdg==
X-Received: by 2002:a50:fb09:: with SMTP id d9mr6508139edq.283.1638349913363;
        Wed, 01 Dec 2021 01:11:53 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id dy4sm12838106edb.92.2021.12.01.01.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 01:11:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1msLeZ-001Bwa-Do;
        Wed, 01 Dec 2021 10:11:51 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com
Subject: Re: [PATCH v4] branch: add flags and config to inherit tracking
Date:   Wed, 01 Dec 2021 10:11:03 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <7ad7507f183332cb2b5fdf2eb76fbbc9dd7199ef.1637085915.git.steadmon@google.com>
 <211119.86v90o4oqw.gmgdl@evledraar.gmail.com>
 <YaaYyFhDrvEbenWa@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <YaaYyFhDrvEbenWa@google.com>
Message-ID: <211201.86tufsbsfc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Nov 30 2021, Josh Steadmon wrote:

> On 2021.11.19 07:47, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Tue, Nov 16 2021, Josh Steadmon wrote:
>>=20
>> > I've addressed Glen's feedback from V3. However, this brings up a new
>> > issue that was not obvious before: "branch.<name>.merge" can be
>> > specified more than once. On the other hand, the existing tracking set=
up
>> > code supports only a single merge entry. For now I'm defaulting to use
>> > the first merge entry listed in the branch struct, but I'm curious what
>> > people think the best solution would be. This may be another point in
>> > favor of =C3=86var's suggestion to reuse the copy-branch-config machin=
ery.
>>=20
>> I haven't looked in any detail now at the "should we copy the config?"
>> questions. Just some quick comments/nits below:
>
> Thanks for the comments. They're all fixed in V5, which I'll be sending
> out soon.
>
> [snip]

Thanks, happy that it helped.

>> > @@ -632,8 +632,10 @@ int cmd_branch(int argc, const char **argv, const=
 char *prefix)
>> >  		OPT__VERBOSE(&filter.verbose,
>> >  			N_("show hash and subject, give twice for upstream branch")),
>> >  		OPT__QUIET(&quiet, N_("suppress informational messages")),
>> > -		OPT_SET_INT('t', "track",  &track, N_("set up tracking mode (see gi=
t-pull(1))"),
>> > -			BRANCH_TRACK_EXPLICIT),
>> > +		OPT_CALLBACK_F('t', "track",  &track, "direct|inherit",
>> > +			N_("set up tracking mode (see git-pull(1))"),
>>=20
>> Hrm, should we say "git help pull" here, on just not reference it at all
>> and have a linkgit:git-pull[1]?
>>=20
>> Or maybe git-branch.txt and git-pull.txt should be including a template?
>> As we do with Documentation/rev-list-options.txt, then this
>> cross-reference wouldn't be needed.
>
> Yeah, there's nothing really helpful in git-pull(1) about "--track"
> that's easily searchable (i.e. without reading it all straight through),
> so I just removed the pointer in the option help string, add added
> linkgit:git-pull(1) and linkgit:git-config(1) to git-branch.txt.
>
> I briefly looked at writing a common template for both git-branch.txt
> and git-pull.txt but I feel like the git-pull discussion of tracking is
> so spread out in that doc that it would require a significant rewrite to
> make a common template work.

*nod*. I didn't look into if it was easy/doable, just a hint in case
that direction was fruitful. Makes sense.
