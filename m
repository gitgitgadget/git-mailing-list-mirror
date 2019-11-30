Return-Path: <SRS0=RoqO=ZW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A4AC432C0
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 22:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944CB2082E
	for <git@archiver.kernel.org>; Sat, 30 Nov 2019 22:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kcCPKv/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727374AbfK3WK0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Nov 2019 17:10:26 -0500
Received: from mout.gmx.net ([212.227.15.19]:54051 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfK3WK0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Nov 2019 17:10:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575151821;
        bh=hyQbWX/1Lq9ZAEGT8lS2ZkIFnWi6bUc66datHYXNACY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=kcCPKv/haC3xDkN8rq8KdKvVYA/KovID7Hu338UGIX1ZRH7rGDqEm0rkf4uOEe452
         kY+WwbiLz1f2jbu7GWeV8kk/ZDVLtx7zfP6rm6Quk2433GT5wTITKk//ciwhUecUC+
         2Z5RGtoezWpX4ZvssyybuupTP6kVpTgOedTHAsZc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1hiVEZ2PyY-0180eU; Sat, 30
 Nov 2019 23:10:21 +0100
Date:   Sat, 30 Nov 2019 23:10:06 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] mingw: spawned processes need to inherit only standard
 handles
In-Reply-To: <653e0604-3fd0-235d-564e-8f8a5900a0ae@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1911302308580.31080@tvgsbejvaqbjf.bet>
References: <pull.670.git.git.1574433665.gitgitgadget@gmail.com> <feb197792814701bf36cb15b73e1e73aae2baa4d.1574433665.git.gitgitgadget@gmail.com> <00ef72f5-b1fa-f449-0e00-23713bed0187@kdbg.org> <nycvar.QRO.7.76.6.1911291036320.31080@tvgsbejvaqbjf.bet>
 <653e0604-3fd0-235d-564e-8f8a5900a0ae@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ZkLYfNz5Hv55WKqoZippi276s5Y+EQinjYzVqez9p9YwcsDZvS4
 NlabJe2r4ZBSl8cid6/LHrdnSfSJZgO6P+V9HxHuAx67uZwGInEu7jvcrolnNIoLtcw75VR
 Vx7/g4wgtHJzqjyHw6vD/fETlq5N83MCwDYiFXG6cfaDYtlYvzzB9Wx17v8MKTMXGEEac9A
 NiqXie2gJJTCIr+/faqdw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BXT5lBrU0yk=:SdDip6XZia4mRyl4AoUvms
 wIBcIY3j/oBfaRCnM3M3akYV/91zw2Qb90quSlFAjkKAHeE+dRQRr23v+FA1MjXQcFVSZcoez
 XmRNPolcBnQCJ08JA6M5rk8nzGnF2wLiGYVonIasRvmSKcQcMYNGv82kSBgUz65BUBw5vU95i
 2QmYEtTDWtKlCp7HVZEMWtgbRgy4i6Wl1Z3aEzDObuG7d3verO8VYl2ofKZFcvpFXsh0gh2/4
 rD5Qp7ROaJi2ZKBlSw9rP3MODXcKt9DNFxxKH13JIsC2Ir/QXgWr8LQUD+g3zpZfqzAb/xZXD
 Nlog2+hHVfx7OmzsqR54Jld3Jr2rV360mQQqtuyjI6Gv3ce6Yurdw/cOIkJbhg9n2ltT8YueQ
 4ci/JlZhCIXUpPkaonfWKyf/gNbze5OWvTsZ7JM/QThN0noTmn7NKo5jLiDGD6aC8Lifyz2aY
 AMmDSpFmlZQu8fjPb2owNeOkKwEwlILhH+ep/B6/NJz+mCX/CdrcklADkIHSW5ZGY+RM1zcUk
 E4ALkWWvJPGmQJy/V1Nf1n4XXlO5bCzALDaURJxKA5+FdevCgT9uhYhH31q4bg9PtVIW0ZDup
 RBZ35sSyvZ4dl1h/xmRFSIgrf+BUb5WXBKnhPY+jpbYcEtI53/9E2mGWtYV3tVM3ND7B2pOJt
 T0kMfzB/UO3vFHcx1MkssV+49nWxWnUMbr7zIHdh8tvURr1sCDS010iLOMkBh46lh6Hxt1HdP
 MUxdpAITudGRpcBz12v71T8UTkJgZ76UX9/Z/9pGLqJSYQ3GA6c0p9oG+1IoLqdWFPNcfy5s4
 efddGcKWOv51lrlkMauXqv9TRLUF5TOdv6pybLgmBVN+56frOJzrxUA6VQHpIkLHy38i9NNmz
 M/vKt/WxldE3MnmsxjEfelNgFSPp8AVseqvsLWbDEqfIwESFqMdcp47DhwKiKsuZOwrodr4Mi
 YKHEFKk68D2UR0r1TG2YAQGhnd6CYDBE+NET00CNy4stqPyfKoIK/z7da2rp7T+0eftn39+aD
 IPMX3IBUMDK0obqmJUE7CLHkwshqDLm83Gr13ls9/jW1M87cCKu3jBb0odZMdEivH79MM7wzu
 SdplPLc46tKgeS9nAKB+cWScVwnuJcbBccAUqnnXTy32easWBfp7Q1gJ+r1vtCjDhO+dKvppY
 kTSYDgAXNFCeDoX6/rjdaO8aAzFQ3GrdoqytztYGh/D5vS2PCFD3otIiGoG4oMILRvBR5ldeh
 RDPOmlJzZZ2Z9QOBjCc1eAgfpISMcIvxS5DwAqBeyjyT5bMCY0q7ZiAX0RFY=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Fri, 29 Nov 2019, Johannes Sixt wrote:

> Am 29.11.19 um 14:52 schrieb Johannes Schindelin:
> > On Thu, 28 Nov 2019, Johannes Sixt wrote:
> >> Am 22.11.19 um 15:41 schrieb Johannes Schindelin via GitGitGadget:
> >>> +		    !getenv("SUPPRESS_HANDLE_INHERITANCE_WARNING")) {
> >>
> >> ... and the variable isn't set, so we continue here. (But I don't thi=
nk
> >> it is important.)
>
> It's actually not that unimportant because ...
>
> >>
> >>> +			DWORD fl =3D 0;
> >>> +			int i;
> >>> +
> >>> +			setenv("SUPPRESS_HANDLE_INHERITANCE_WARNING", "1", 1);
> >>> +
> >>> +			for (i =3D 0; i < stdhandles_count; i++) {
> >>> +				HANDLE h =3D stdhandles[i];
> >>> +				strbuf_addf(&buf, "handle #%d: %p (type %lx, "
> >>> +					    "handle info (%d) %lx\n", i, h,
> >>> +					    GetFileType(h),
> >>> +					    GetHandleInformation(h, &fl),
> >>> +					    fl);
>
> ... ERANGE happens here in the second iteration, in particular, when
> strbuf_vaddf needs to grow the buffer. vsnprintf generates it.

Ooops. I meant to ask you about using `NO_GETTEXT` in _this_ context. I
could imagine that gettext's `vsnprintf()` version behaves at least
slightly differently here, and probably different enough to cause an
`ERANGE` in your setup but not in mine.

Ciao,
Dscho

> >>> +			}
> >>> +			strbuf_addstr(&buf, "\nThis is a bug; please report it "
> >>> +				      "at\nhttps://github.com/git-for-windows/"
> >>> +				      "git/issues/new\n\n"
> >>> +				      "To suppress this warning, please set "
> >>> +				      "the environment variable\n\n"
> >>> +				      "\tSUPPRESS_HANDLE_INHERITANCE_WARNING=3D1"
> >>> +				      "\n");
> >>> +		}
>
> -- Hannes
>
