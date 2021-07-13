Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 422FDC07E96
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7DF613AB
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 08:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234712AbhGMItI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 04:49:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbhGMItI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 04:49:08 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C25C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:46:18 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id p9so11710573pjl.3
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 01:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b1V+JjqpA3CXIZmc02NyCJbUThK8YSMBCq+axXl+jB4=;
        b=ZQa+ObQs/Bcj126wrS098+VmBWKWq4Xt3hfMd0f1eD8RMLU3MfQ9ktaMalbxZPIAf9
         UUF6aTjpURZQUzMWJmQeWaPbIK37fhx98yCTbE5gZ5FKUC3/eilbKFlb+JlwvxjJS6Sb
         xjfLrRdxQwHN81nrdenXPdMZ91np3rF+zBKVrVcyLKxRe7niIxrOGHOzK/USakS9+e9A
         Vy9JNxordLFZs3BMnk+kcyfsWa1IEheBGdbZIl8Yg0GVvyoV2DgvCo5ZQQqIymg17vdj
         JkWj4FaqrTNXASoJvJY5QNVdZIvCTib+5iWgH7RDC65lSRHhvDuMQkvL0BFte/Hr3MJ7
         Vtnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=b1V+JjqpA3CXIZmc02NyCJbUThK8YSMBCq+axXl+jB4=;
        b=I/j/tfXRn/jQvn9xbCzDhD72UkVfW9c5nDRbKxNLJv10cb9W+roOKCMjrJaP2taY8P
         GX9DRvLmy0Ae6VePJdGfHaF7Mb0dLqyrET1sYCMzWDT+j6Htkgfieill/jquZ7r5jcG3
         3BhcamU/CDdwB06Ij8znL9g/vr8m8aW8IVDyYOtQwlYl6Vts6zDg74FyHTgZHY9QHmvk
         Eqx34QbkpWqiyLVdYVwqpWxf+uGvyujHMLNg0bttHTCXGi1WEcG3Tqw6lD4kLaRGlqld
         VcLXNFpbI4sO+EkK6JJYqz9bqbqzIrNJRfO3GLwH+XBjfS+O4enE6LZSAVvVF6hWuvdy
         WaSg==
X-Gm-Message-State: AOAM533+PiYDwF13htsu2NAqd38tGNUp5fnbeLIG6lEwMvznNkbhdOqd
        TGQQt78KVqsTCJScTpCGIC4=
X-Google-Smtp-Source: ABdhPJy7/lpsyRJh0peSg6baGDoqrAUcea75pwNVdmmFQsl43SUcfgi7JLV2lBnsxUd9sy2JEpAGoA==
X-Received: by 2002:a17:902:ed84:b029:129:73d9:b83d with SMTP id e4-20020a170902ed84b029012973d9b83dmr2702755plj.43.1626165977900;
        Tue, 13 Jul 2021 01:46:17 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 25sm530821pjg.9.2021.07.13.01.46.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jul 2021 01:46:17 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=93_Week_8?=
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <f5b12a75-bdaf-fe5c-ffc2-7b4c8cdfddd6@gmail.com>
Date:   Tue, 13 Jul 2021 14:16:14 +0530
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D3F13902-A7DD-4186-8444-45FD9260CBC8@gmail.com>
References: <CD6968A1-179D-4B77-91C1-4EECB1B69951@gmail.com>
 <f5b12a75-bdaf-fe5c-ffc2-7b4c8cdfddd6@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13-Jul-2021, at 13:48, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> =
wrote:
>=20
> Hi Atharva,
>=20
> On 11/07/21 4:48 pm, Atharva Raykar wrote:
>> Here's my weekly update:
>> https://atharvaraykar.me/gitnotes/week8
>> I am currently blocked by trying to pass a super-prefix parameter
>> to another command, when calling it from within C.
>>=20
>=20
> =46rom the blog:
>=20
>> When queried by the get_super_prefix() function, the answer is =
(null).
>> This boggles my mind to no end (see update). The implementation is =
basically
>> the same getenv() call?
>=20
> Good to see that you were able to identify the reason yourself.
>=20
>> I am not sure how to tell Git that the environment variable has in =
fact
>> been modified, and that it needs to be reinitialized. Maybe I am =
going
>> about this whole thing wrong?
>=20
> I get the same feeling too. I took a brief look at how the issue could =
be
> fixed and it seems to me that you exploring to set super-prefix might =
not
> lead us to the solution. Alternatively, you could explore how other =
sub-commands
> handle recursing into submodules. To me it looks like they handle it =
by spawning
> a sub-process is likely the easiest approach for achieving recursion. =
That would
> solve the super-prefix problem as you have observed.

Yes, I was hoping I would not have to spawn a subprocess for recursing =
on
update, and it does look theoretically possible--it would require =
changing
a lot of of existing code to use functions taking a repository objects
rather than assuming 'the_repository'. But since that was outside the =
scope
of my project, I did it like the other implementations that spawned a =
new
process for the recursion of 'update'.

> Unfortunately, there's not yet proper support for handling recursion =
of submodules
> which calls for working with the data of multiple Git repositories in =
the same
> Git process. There was an effort[1] few years ago to make working with
> other Git repositories simpler without having to spawn a sub-process. =
The state
> of the effort is unclear to me. As far as I know, it has been stalled. =
I hope
> others could provide more details about it.
>=20
> So, you could try the approach of spawning of sub-process for now. In =
case there's
> a better approach than spawning sub-process others might be able to =
point during
> review. In the meanwhile, I'll try to take a better look later and see =
if I could
> find anything.

I was seeing if it was possible to at least save another spawn for =
calling
init when '--init' is provided for an update. The current implementation
does not spawn a separate process for this, so I was hoping I don't add
more overhead in the conversion, but it's looking hard to avoid at the
moment.

> [1]: =
https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com/
>=20
> --=20
> Sivaraam


