Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58095C678D4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 00:16:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjCCAQi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 19:16:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCCAQg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 19:16:36 -0500
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ED4474F8
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 16:16:35 -0800 (PST)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-53cb9ac9470so12904547b3.10
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4MTmRSc+plzsoYbMwrxvP7Lb21QOpqaJqFauPpl64dQ=;
        b=qO1ll2jD+AtJywjypEL/dA4tDzzHh84fpbuuQRtV20oxAZJV7Z6+RGuvh7xcrObPXU
         w0+VYmbBvT08VAhX+A+4GQyUoBl0G8o8o8TY9Ldbd7JRRsw5EdVq+jDwRn98x4JdHQjb
         6/hTubO/CO6HNfh8hMxCTWm0tFaUXzjjLX3dQ6MwArWRViSjESA5eB+NUIW56e3u812L
         AAo5tT7epiJy8UxlzVgzMAeJZ9LN3JzXSBxdCjNeHdA+nKO7ajHBHi+q9Vh1SgwHbW7X
         GWVg8dGk2J5tYuxB51l+zIxsQp6G0OlZK1emc4w9gCWBApRfRUGtbOjVDpv65xLLIFtd
         U7ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4MTmRSc+plzsoYbMwrxvP7Lb21QOpqaJqFauPpl64dQ=;
        b=RzgOQjJvWqgEHCs8AJPHj4I+GnH+/tXii9eL430CAMyPDrWr++wdAKPrzfIcLWP8k6
         jmCM6zsXB8CwoQyoOXjlAcURTK6nwtAJFGu35UcfKZzI1cSFTkZT6uTQFfrkdDJkPDJ9
         rXygHmMTVqdTLRt5FgwWZuZKL1mUN9XlzKNPxbS7A3AhsCapddpsZil1PnjzN/jMEK0h
         td3XXTR0FUvxj030ErGPxYt7bjdRuS650HmD8+6jAHnI2BpG9ArpXwiFPph3RldMYeqh
         9WUkycoCLDUEZ6HvYJ6d1xuPFxUQE8Fw8BSNyOzU1f4EDkNfc6IcFb6QrpQk6/VPDXLR
         GhIg==
X-Gm-Message-State: AO0yUKX3H4bksW1ig7ahGoqlF09XgkIfwRBU0EZYJBR3D31tjIacWi/j
        cHsykWmsLRfaj9CqCasCxtIB+xra4TOgxMkGicZeNQ==
X-Google-Smtp-Source: AK7set9JhwIogHjc67Jcj/7kiO0vkfEameWreHVaKnNryj7rjsJ4/tMYED8/FgOC2DFCs+EMf2BGIE2Fu+1vOdh1yWw=
X-Received: by 2002:a81:b349:0:b0:533:9ffb:cb12 with SMTP id
 r70-20020a81b349000000b005339ffbcb12mr7447366ywh.10.1677802594919; Thu, 02
 Mar 2023 16:16:34 -0800 (PST)
MIME-Version: 1.0
References: <20230213182134.2173280-1-calvinwan@google.com>
 <20230228185642.2357806-2-calvinwan@google.com> <xmqqttz5pduy.fsf@gitster.g>
In-Reply-To: <xmqqttz5pduy.fsf@gitster.g>
From:   Calvin Wan <calvinwan@google.com>
Date:   Thu, 2 Mar 2023 16:16:24 -0800
Message-ID: <CAFySSZDeZ-HHPsh9noX1xqGfdzkRALwH0DRzcG3XPUKp57P-rg@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] tests: Use `git submodule add` instead of `git add`
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Josh Steadmon <steadmon@google.com>,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2023 at 3:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Calvin Wan <calvinwan@google.com> writes:
>
> > diff --git a/t/t2013-checkout-submodule.sh b/t/t2013-checkout-submodule=
.sh
> > index b2bdd1fcb4..dd2858648b 100755
> > --- a/t/t2013-checkout-submodule.sh
> > +++ b/t/t2013-checkout-submodule.sh
> > @@ -10,7 +10,7 @@ test_expect_success 'setup' '
> >       (cd submodule &&
> >        git init &&
> >        test_commit first) &&
> > -     git add submodule &&
> > +     git submodule add ./submodule &&
>
> The change from "submodule" to "./submodule" was not explained in
> the proposed log message.  I think this is necessary for "git
> submodule add" to function as expected, but if that is why we are
> making this change, perhaps we should mention it?

ack.

>
> > @@ -51,6 +51,7 @@ test_expect_success '"checkout <submodule>" honors su=
bmodule.*.ignore from .gitm
> >       git config diff.ignoreSubmodules none &&
> >       git config -f .gitmodules submodule.submodule.path submodule &&
> >       git config -f .gitmodules submodule.submodule.ignore untracked &&
> > +     git commit -m "Update patterns in .gitmodules" .gitmodules &&
>
> What does "patterns" refer here (another one in the next hunk)?

"patterns" seems unnecessary here. "Update .gitmodules" is more than
sufficient.

>
> > diff --git a/t/t2103-update-index-ignore-missing.sh b/t/t2103-update-in=
dex-ignore-missing.sh
> > index e9451cd567..11bc136f6e 100755
> > --- a/t/t2103-update-index-ignore-missing.sh
> > +++ b/t/t2103-update-index-ignore-missing.sh
> > @@ -36,7 +36,7 @@ test_expect_success basics '
> >               git add file &&
> >               git commit -m "sub initial"
> >       ) &&
> > -     git add xyzzy &&
> > +     git add ./xyzzy &&
>
> Is this supposed to have become "git submodule add ./xyzzy"?  Or
> "git add xyzzy" will trigger "don't add gitlink" warning but you can
> write "git add ./xyzzy" as a way to work around the warning?
>
> Or is this an incomplete change that wasn't spotted during
> proofreading?

The latter. Missed this one when I was reverting the change from v1.

>
> > diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-pu=
sh.sh
> > index 302e4cbdba..f8ef70b5a2 100755
> > --- a/t/t5531-deep-submodule-push.sh
> > +++ b/t/t5531-deep-submodule-push.sh
> > @@ -28,7 +28,7 @@ test_expect_success setup '
> >                       git add junk &&
> >                       git commit -m "Initial junk"
> >               ) &&
> > -             git add gar/bage &&
> > +             git submodule add ./gar/bage ./gar/bage &&
>
> Why does this one (and only this one) look different?  Everybody
> else changed "git add A" to "git submodule add ./A", it seems?

The second ./gar/bage is to define the submodule path. Without it,
submodule add attempts to add it to ./bage instead of ./gar/bage.
This is unique only to this test since the submodule is 2 folders deep.

>
> > diff --git a/t/t6437-submodule-merge.sh b/t/t6437-submodule-merge.sh
> > ...
>
> I think I saw a code section that was touched in the previous patch
> that hand-crafted .gitmodules file to make the gitlink it adds into
> a submodule.  It is unexpected and puzzling that there is no removal
> of that "cat >.gitmodules" from t4060.
>

I have gone ahead and removed the "cat >.gitmodules" from t4060, and
fixed the subsequent tests that were affected by that
