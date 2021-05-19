Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3ED4C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA6BF610A8
	for <git@archiver.kernel.org>; Wed, 19 May 2021 10:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbhESKur (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239883AbhESKuq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 06:50:46 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8DAC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 03:49:25 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id c17so9608321pfn.6
        for <git@vger.kernel.org>; Wed, 19 May 2021 03:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hocynm0wkuOUwYd9SFfJ3TG962ySBcEHejpcVX2BfHM=;
        b=uL0m+sT1tj4ODQ3kqHiNTtRtI7BJ6I0mY0IIipdJOSRSOpd+KBrd+MK4biQoa9dKht
         YO191VKFiKFHJQzZjW+RMeg0I9TMJcntCi17UOtNfcNBJen/2ZrJx9BRKmCU0+qrZi2Q
         ySIiwh1qkDav0I3677uls9bVR+KAlahrKHnmb2I1KhAjx5oyYJlIPlSAkfbdi04Bg6ty
         E+BACzpRhMXSo66MyMy/wXOjRY2r/aJTuKBIiHQ+R3E4euf3a0S1XU4JvMO5xe7cBkyj
         +iiYcpn/gtKKjfE0jO/rQQrv6B0xuTOzu/VRTdfCxssZMtX1P+BmygCt7D3dW7V4JI5v
         al3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Hocynm0wkuOUwYd9SFfJ3TG962ySBcEHejpcVX2BfHM=;
        b=mYTLDcPgs+HSlewCDwDvRd8bLRzqtJC3A4wdx8zGSF8F5g3SV87XaPaCewlKhykTpa
         aj2cyaSberoe+bydG68FDfid9S1XArsOBfd4yKqfVDDmelkDj+wE8oC3rQoBYmA7oaKT
         4efvVYeKVlFYWi9eqIOaInWuSvMcwGb+5nA3BvaTdm/WErtPmJNnYRfTXWN+EgqD09p+
         xJ1PLxJiQJk9+dtU89h/xAoks29Kg8s9699q+uFfYuXDZlshaGu+4GuFMUIj9s/giwO0
         3KKWXfcJGbCmsmG1t8S/xWRAK0swpJm43zr5iyhMH9CpoEIUlKWynKC5R0Ni1JDjoPPw
         Khkw==
X-Gm-Message-State: AOAM532DUrm+ZTR4KhhkUUD7wRJBsbV+lTIMNy/yjfHyl0UkqxKTUIOA
        vqBK+K5JkC5M5CSkWHP7tT/mxWXm3ZYiXA==
X-Google-Smtp-Source: ABdhPJyN19/JwKFXR0692BVCsJcH4yRRzwZVfti7Ib2iqYb5RcJVqccZZSg99/t+9hpsA+Jk87NCmg==
X-Received: by 2002:a62:fb17:0:b029:2df:b6dc:c68c with SMTP id x23-20020a62fb170000b02902dfb6dcc68cmr2766257pfm.31.1621421364923;
        Wed, 19 May 2021 03:49:24 -0700 (PDT)
Received: from atharva-on-air.dlink ([119.82.121.70])
        by smtp.gmail.com with ESMTPSA id s14sm5482499pfs.108.2021.05.19.03.49.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 May 2021 03:49:24 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: Bug in git submodule update --remote
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
Date:   Wed, 19 May 2021 16:19:21 +0530
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EB55447C-538F-44DE-BFC0-A3BD1A970E99@gmail.com>
References: <c4b27662-1228-a1ff-26fc-637897ffc8e7@riscosopen.org>
To:     Ben Avison <bavison@riscosopen.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14-May-2021, at 23:41, Ben Avison <bavison@riscosopen.org> wrote:
>=20
> What's going on is that within "git submodule update --remote", the =
sha1 used is formed by looking up the submodule's ref =
"<remote>/<branch>". The change in git 2.27.1 is that if no remote =
tracking branch is stated in the superproject's .gitmodules file, =
<branch> defaults to "HEAD" rather than "master" as previously. That's =
fine if <remote> is "origin", but in practice, it depends on how the =
submodule is currently checked out:
>=20
> * if it's in detached HEAD state, <remote> is set to "origin"
> * if its branch is not a tracking branch, "origin" is also used
> * but if it's a tracking branch (as I used in my workflow above - not =
uncommon in pull request workflows because you might grant other people =
access to the branch during the review process) then it looks up the =
name of the remote which is being tracked
>=20
> First observation: a ref called "myfork/HEAD" presumably *could* have =
been created by the "git remote add" command, reflecting that remote's =
default branch. Should it?
>=20
> In practice, that's not actually what I'd want, though. If I do "git =
submodule update --remote", I personally normally do so as a shortcut =
compared to cloning everything again. I don't expect the behaviour to =
change depending on whether I happen to have left one of the submodules =
checked out on a tracking branch or not: myfork/master is potentially =
quite out of date compared to origin/master.
>=20
> It also makes very little sense to me that issuing "git submodule =
update --remote" twice in quick succession would leave us in a different =
state, because the first call puts all the submodules into detached HEAD =
state, meaning that the second call always looks up the remote tracking =
branches from the submodule's "origin" remote.

I agree with you, this behaviour is rather inconsistent, and
can be quite surprising to an unsuspecting user.

> One way this could be fixed is that if <branch> turns out to be =
"HEAD", we could force <remote> to be "origin". However, this doesn't =
address the equivalent problem that arises if the remote tracking branch =
*is* named in .gitmodules.
>=20
> I'd therefore like to propose that "git submodule update --remote" =
*always* uses the remote named "origin" to form the ref used to check =
out the submodule. However, I'm not sure whether everyone would agree =
that this constitutes a bugfix, or whether I'd need to introduce a new =
switch to enforce this behaviour.
>=20
> So, what do you think?

If I understood you correctly, you'd prefer that the updating
of the submodule should be independent of the ref that is checked
out in the submodule's directory.

While I am not sure of the reason why the design of 'update --remote'
uses the remote-tracking branch of the submodule, I can imagine
adding a switch like 'submodule.<name>.remote' that defaults to
'origin'. Then the behaviour could be changed such that it always
pulls from the remote specified in that option.

This would help make the behaviour consistent in all the cases you
mentioned, while also giving the option for a user to update the
submodule from the remote of their choice (which may not be origin).

--
Atharva Raykar

