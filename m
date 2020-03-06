Return-Path: <SRS0=QY2u=4X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C17C3F2C6
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 04:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B517E208C3
	for <git@archiver.kernel.org>; Fri,  6 Mar 2020 04:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWUkf3R+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCFEQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Mar 2020 23:16:40 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35478 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCFEQk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Mar 2020 23:16:40 -0500
Received: by mail-qk1-f196.google.com with SMTP id 145so1151961qkl.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2020 20:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yZ1xkGrVyI3UOHDbS5vYvxjXG3TRCxEPQQgJEuaNvhM=;
        b=CWUkf3R+S3d74CauE2fNUij2XoazxqVrit7rVnFOjighky70pRELeUZu2RG/sBMZJf
         KnaO1M/Hlq4IBimbPvFqQf0l1WZirUbabRCjIqE4F4Mc0gmY9pw6vFnZpuEDTefnCH4B
         Yjs/LdVj7ifdLkLbqnRywSnuKtIyRyPPiCsDPh62Gt7IQs/XIeQdiUbgymTUb6Igqkhb
         54We66xM9uOhTMFvJDDqtzC4Yyr1F6C4XeQrejvREC5jQSnnwTjJV7udF/eY1RqWCpyc
         SDUbGuXjwbRLfAkfCBJ99wutDeHpHMFc6NiN0u9IVviqmCjsVNqybUYFcrwEgCUph6Vz
         KXXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=yZ1xkGrVyI3UOHDbS5vYvxjXG3TRCxEPQQgJEuaNvhM=;
        b=N3RF2r95yspxR2ouicdvieEP0DP7AasiakA0mPcWQ1/rCtpyfrHPR/HytKR3Y+1gbh
         blZS28CZzmOt9wX/u1xcMZOF+X6V3NLptosmJEm5utFrVGZHXVj55o+MmCNjTRvhJx9q
         J4e7JNymrcR/9xi6SBg7PqLT955RAwJRFwG3wrGPrq37ewK7Kj/J6AZlxDorXWgmDe7x
         TGWtRM2xisgMfaJqz0SjjaCjaHv6W6IZyCX0HGxHILBCSQMYTi3clpsJcLIdSoq7/yjT
         UPaWQL9THqTxQYO6cD4qeWqjhsjmzZzt6LVMI0rEm530be8M+BeYRDKuzsbOXrykPZKb
         E98g==
X-Gm-Message-State: ANhLgQ1qAc7+9GfRMo1jslS3eNbzzfLVf77h2Rt3YsaaQ5PVwklUrdBo
        ph9pl7pzFUun+iE50eUB5kI=
X-Google-Smtp-Source: ADFU+vvQDdD+RWZ1ADI5zeOYY+IwBpgQbo5SuVCchoIOP2C8FzobnMtqGSawugF5eUM3RoG0bdPUFw==
X-Received: by 2002:a37:5c9:: with SMTP id 192mr1219006qkf.103.1583468199799;
        Thu, 05 Mar 2020 20:16:39 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id m26sm4821787qtf.63.2020.03.05.20.16.38
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 05 Mar 2020 20:16:38 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH 2/4] doc: document --recurse-submodules for reset and restore
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <20200303172613.vmd47i5bcwg56vyt@feanor>
Date:   Thu, 5 Mar 2020 23:16:36 -0500
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DEF5103D-C687-4EAB-BFF9-58267093B456@gmail.com>
References: <20200228103558.1684937-1-damien.olivier.robert+git@gmail.com> <20200228103558.1684937-3-damien.olivier.robert+git@gmail.com> <9831AAEE-8FBF-4CBD-B589-3F045720D6DC@gmail.com> <20200303172613.vmd47i5bcwg56vyt@feanor>
To:     Damien Robert <damien.olivier.robert@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 3 mars 2020 =C3=A0 12:26, Damien Robert =
<damien.olivier.robert@gmail.com> a =C3=A9crit :
>=20
>>> +	work trees of submodules will not be updated. Just like
>>> +	linkgit:git-submodule[1], this will detach `HEAD` of the =
submodule.
>=20
>> In fact `git submodule` does not unconditionally detach the =
submodules HEAD=20
>> (if `git submodule update` is invoked and a branch is checked out in =
the submodule that points
>> to the same commit as the one recorded in the superproject, the HEAD =
is not detached and the branch
>> stays checked out unless `--force` is given.) So I would instead link =
to `checkout`,=20
>> which does unconditionally detach the submodules HEAD.
>=20
> Ok. I copied the above line from git-switch[1]. Should I also update =
it?
> git-checkout[1] also says that git-submodule will detach HEAD by the =
way.

I would say yes: git-switch(1) should be updated to refer to =
git-checkout(1) instead of git-submodule(1),
and git-checkout(1) should drop the reference to git-submodule(1)=20
and just say that it will detach the submodule HEAD.=20
Maybe in a separate patch before this one ?=
