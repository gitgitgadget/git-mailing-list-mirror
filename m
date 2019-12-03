Return-Path: <SRS0=UYkv=ZZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F4D8C432C3
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 08:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FA6720661
	for <git@archiver.kernel.org>; Tue,  3 Dec 2019 08:56:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="vIb/7/rA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725848AbfLCI42 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Dec 2019 03:56:28 -0500
Received: from mail-il1-f182.google.com ([209.85.166.182]:45500 "EHLO
        mail-il1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfLCI41 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Dec 2019 03:56:27 -0500
Received: by mail-il1-f182.google.com with SMTP id o18so2415701ils.12
        for <git@vger.kernel.org>; Tue, 03 Dec 2019 00:56:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=23ozhQdmXLubTiU7cKLmran0N+iSRK0dc5WnOoPPi50=;
        b=vIb/7/rA02GJPrlkEeDvJAv1kW/x8MMQ/ewoP57UNd+OvRvsJa4GrYb2xpQF6bt6Dv
         XhUXOaIE7x2PDVoSFX4Xmx++GD4nvUcsr5NZ+N+RTBILDrG4tcBVt6z8t+s9OluZQo8Y
         mmKkAXUjmJkAUlz+BukNWajEUPC7LfliNW+510CSZZLmWQPADNCAFSa0RpXIESr1HorB
         elILEUiuQloVChrTUcBe31Fy69Y77Cw6gvYK8utNqGuXlTlRiahpv/UvNfxlQvuWcBzX
         j59rk3FhxaTF9qKKEPTc9IFID9IIaGEbD4YbtkpfOPsnXc7rfzF+3ufKS0FQ0uTFbz6k
         8KsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=23ozhQdmXLubTiU7cKLmran0N+iSRK0dc5WnOoPPi50=;
        b=a0m9UiBevrtzJ9BxORhBN2Krvmd2ATtiUnzmujiAOv5LCvuV4KjtmsHG/NcIUHJ+RQ
         Jj9aF2K+e3UYOVL1KYUrEaqtdvSumN87yK0Gy7/6b5xS769EONwMcZFRvLPolx4hDj73
         yp0/FnPFVRtxMSGcT2Hc25sV1KFR4VwNEqhj9/YNYKEu28mb/WbsZEZzXxlUX8b3EoI8
         VdK4A4o9T2D6/1mDWLdAlI4onel1q0MWCQ5TXHnV7X+ChDkzne8XE3pQicVEAmAzFKS+
         iRx9s9/Wzw6ACAebYxkr1tdAncBWs573Tm/TxHVWLrd12FZdhHBoHPN9BKSFFbZD1dvc
         lPmQ==
X-Gm-Message-State: APjAAAUCSqM4IglYxtEEzLV8HrTdHUGZm2XKJHN1sAO/aCpzVZDxa13e
        qt+Sz/6qiN8RPTq0kBc7SAiPCA6AZbc/JFG3LMF2fw==
X-Google-Smtp-Source: APXvYqx3FBb1evmpKajk/5N6C6sbn37ciIbXPekvXb1BwpoABT3ViDO06KotRK78omwGV0tFpEBsnWN19widFQxHW/M=
X-Received: by 2002:a92:901:: with SMTP id y1mr3558626ilg.274.1575363386731;
 Tue, 03 Dec 2019 00:56:26 -0800 (PST)
MIME-Version: 1.0
References: <defeb7be75f54e8483ce529b2571478d@nokia-sbell.com>
 <5e27e2a9f6374742859b4b87d85c56e9@nokia-sbell.com> <1af00173f96243bea760baaddeb15777@nokia-sbell.com>
In-Reply-To: <1af00173f96243bea760baaddeb15777@nokia-sbell.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Tue, 3 Dec 2019 00:56:16 -0800
Message-ID: <CAGyf7-FW_8RjVPEtmKiNFnF5QNZ4f+kqZ_BAGnGu76QcR=F25Q@mail.gmail.com>
Subject: Re: one bug on git
To:     "Lou, Pengfei (NSB - CN/Hangzhou)" <pengfei.lou@nokia-sbell.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 3, 2019 at 12:29 AM Lou, Pengfei (NSB - CN/Hangzhou)
<pengfei.lou@nokia-sbell.com> wrote:
>
> Hello community
>      One problem I found recently within my working, please check my deta=
il below.
>
>      I tried to run my script (check the attached file 'problem.sh') to b=
uild one git repository , it can be successful, but the command "git log -r=
aw -1 ${revision}^ ${revision}" on that repo would generate some  unexpecte=
d result,  please check the result below
>
> [pelou@hzling29 try_des]$ git --version
> git version 2.6.2
>
> [pelou@hzling29 try_des]$ git log --raw -1 164304f48726d31336e2e130a90e42=
b7f1c480f8
> commit 164304f48726d31336e2e130a90e42b7f1c480f8
> Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
> Date:   Tue Dec 3 14:54:33 2019 +0800
>
>     3
>
> :100644 100644 9a7456b... 8148ef7... M  lpf
> [pelou@hzling29 try_des]$ git log --raw -1 164304f48726d31336e2e130a90e42=
b7f1c480f8^ 164304f48726d31336e2e130a90e42b7f1c480f8
> commit dd1a95338ffd471e5b270a487b585bbfcf9926a5
> Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
> Date:   Tue Dec 3 14:54:33 2019 +0800
>
>     2
>
> :100644 100644 d474e1b... 9a7456b... M  lpf
>
>      Next step I changed my script(check the attached file good.sh) and o=
nly add some delays after "git push", everything is normal, check it below
> [pelou@hzling29 try_des]$ git log --raw -1 2027dc54da1896cf1dfa301c3444b1=
690d6cb1d8
> commit 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
> Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
> Date:   Tue Dec 3 15:00:45 2019 +0800
>
>     3
>
> :100644 100644 9a7456b... 8148ef7... M  lpf
> [pelou@hzling29 try_des]$ git log --raw -1 2027dc54da1896cf1dfa301c3444b1=
690d6cb1d8^ 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
> commit 2027dc54da1896cf1dfa301c3444b1690d6cb1d8
> Author: pelou <mailto:pengfei.lou@nokia-sbell.com>
> Date:   Tue Dec 3 15:00:45 2019 +0800
>
>     3
>
> :100644 100644 9a7456b... 8148ef7... M  lpf
>
> So please help me fix it. Please let me know if I was wrong or miss some =
thing

By default, git log sorts commits by their timestamps and outputs them
in reverse chronological order (as stated in the git log
documentation[1]), not the order you requested the commits in. Without
the delays, the commits can happen so fast you end up with identical
timestamps on each commit. I'm not sure git log has a tie-breaker in
such a case (it may just end up being input order).

If you want the commits to be output in the order you ask for them in,
you might try something like "git log --raw --no-walk=3Dunsorted sha^
sha". This will output exactly the commits you ask for (so "sha"'s
first parent and "sha") in the same order you requested them in.

Hope this helps,
Bryan Turner

[1] https://git-scm.com/docs/git-log#_commit_ordering

>
> Br, Hercules
