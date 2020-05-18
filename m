Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06613C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E5B2075F
	for <git@archiver.kernel.org>; Mon, 18 May 2020 19:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="f8A5Uwjl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgERTd4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 15:33:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:58155 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728135AbgERTd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 15:33:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1589830426;
        bh=MiEB5j+BzqJh4pQwhwt/V5cVlmBGTR8EbO101eQar7o=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=f8A5UwjlGB3GopRQURLpwUJJEyVpslRTIgDxpZh1XNa0ttBE8pr+x448JjCx1+Vsh
         wIEtpDXbHRPOwf2QtCNgrRP41eHyajeqd/q2+bMzmKD5DtG5N0SgjrhQrYV0/QUgTv
         XPgRugadRJ+Lv3rh9t0qLK7bPAiM6o4T2CKDdJik=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.17.131.160] ([213.196.212.243]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mw9UK-1ikrr34C72-00s3K6; Mon, 18
 May 2020 21:33:46 +0200
Date:   Mon, 18 May 2020 05:27:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philip Oakley <philipoakley@iee.email>
cc:     Andrei Rybak <rybak.a.v@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Paul Ganssle <paul@ganssle.io>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] rebase --autosquash: fix a potential segfault
In-Reply-To: <fc616e86-dfc1-fccf-d22b-ad2aee0d1b16@iee.email>
Message-ID: <nycvar.QRO.7.76.6.2005180522230.55@tvgsbejvaqbjf.bet>
References: <pull.625.git.1588624804554.gitgitgadget@gmail.com> <2367cf9d-2e37-b8c2-6881-f3e6c951a460@gmail.com> <nycvar.QRO.7.76.6.2005071626340.56@tvgsbejvaqbjf.bet> <1a03a7b4-f436-83c5-f825-3b68c07785e9@iee.email> <4f2ddbba-a9ba-a96a-36c1-b233ea861575@gmail.com>
 <fc616e86-dfc1-fccf-d22b-ad2aee0d1b16@iee.email>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1254696943-1589772472=:55"
X-Provags-ID: V03:K1:41XHbkj/5SMafyry3pTVAIkszLtiQLBF1LchwwWlSUoENBZ8r+D
 UPCMbIwXCCWd+foX+Yprd039pgKyDQ89G9fobXxfOYCo0Kaq6gBO6l3kAc6o+u7hF1q3v5z
 hWAVpx31vTcBSsLy5QBENY4guvJUiMy8two7jZnK2E9d8/Kn6G+ETaPl87UtGRNj2n4WvaP
 dYiOLfQG5/ITkbzuAUmkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/y0BZ35ZLrA=:t7inCXkYR3TLDn8qzPxSaw
 hS+6bwhWRZ8lOPFLOeF0crQjoZsPkGHNJIAHDtnbd9UfwnS/4nL7pONs1XdJLhfzMX2sfkr1X
 VXwjTLLoSGSpsp7BvwgGotbyHqXbpzETq9KZcC05kN0pbn36YV+PkDfg9XQn9LOkmPkzdB79L
 moFqVFmaz7Zi8DqGnucj0E5We2TTAm5PF+A6JbFKqtNn0sCwOBqJrY4MSGnI7HQThBM81Y8Tk
 imOv7PWabQ/BQpf7IiuoHhKJl8fBrX7mKIXnJAXFy/w52VJii7Dnlo7iTspKmd8iBgfDDKtZ1
 kc701a5n54dI+ZyagCodN696qALPRP+suKuKHXyJCE+hTnW4BG/l9v5oOO6e9iBcM1u0JWU9I
 XB8ElB1t5u+1CMTAwekvAJFWT5oSCxAqDuYvyEA3U+HfSRS4mEfRb9hRL8LIXgZemSR9eDgMn
 Q5QMb51kVK6CTGIJsyLfgYkDY3xL/9R53itRzygRKLhgUjbRcS+OAFQkv+NmoDGVe0qzU4Oaq
 CAsenv6csKRiEG9GALAuaOQSpYdnC6Uwqb1g+IeKwuYKefPXdMrBv+0WIOWQNuFwWtPX5c2oV
 fGrkypZhMXFwFWtjBQL7zMtyaQdEi2UgcoMPqHvXvqHd5hFbsD5f5IStULbq8qLVnLdgm7JdG
 XoVgo1Lpur9p8xszWVyOfb+/16Ch+gxVaOdWrKUBys+l0YIyFCmssH7pOvVKW/JFlyTpUOXfW
 vWrsZjXEg41nYDwURM/q02+V8a9t7qsutFS1D3HE8FQJ2FDX6QcaOpNoWEhwDqSN/rbbkY0cq
 ETGWa0GmcThIOLZRNx/OOk+8in3dR90MEx6Yl8FNaOIXq1VbdOQ/gw5fTdEgeERmhK5ZZT715
 KKWxeWGOrHSys0KOCAl+rzRMK9To+nAagVC5rbfKPzt3YMtBQYMrE49NdyUc4d7i8Tsnw3m2q
 ydtjkwBXPAGwnvDhGC0l6qFOcGEC9XWnFu3n+uw2MXV8G4+fp5EXWFp/7U8hlL2wUqT4AtAhy
 CtAO0T/fYrTHyiEVJwn6eTi65RkBlunbQL8VBWf4yvZHeDPvx3tl9rFm/y7SHZFstSgL46lTa
 3/N5GJIVR+4oz00KcI39viSP/iKVv2rWpJPuZRYpfvl95Pox9r4Ytr3m5HtHV2BbrA0xztYZL
 9F/F9JCsH4NZYvBEDdr4ayqwWW7TRkak6MUlhpw4ATL7mDm1cNPD74FBPoh3Ro0h3Og3OiTR6
 dm7Kb3+pfBKQpcTgB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1254696943-1589772472=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Philip,

On Mon, 18 May 2020, Philip Oakley wrote:

> On 08/05/2020 17:57, Andrei Rybak wrote:
> > On 2020-05-08 18:43, Philip Oakley wrote:
> >> On 07/05/2020 15:27, Johannes Schindelin wrote:
> >> Is this ability to have a commit message `fixup! <commit-hash>` docum=
ented?
> >> I've looked a few times in the past and didn't find it. The docs for
> >> `git commit --fixup=3D` doesn't put the oid in the commit's subject l=
ine,
> >> rather it puts the subject of the referent commit after the "fixup! "=
.
> >>
> >> Searching from a different direction I've just seen it is mentioned i=
n
> >> the v1.7.4 release notes.
> >>
> >> Would a doc fix to clarify this be appropriate or have I missed somet=
hing?
> >>
> >> Philip
> > Yes, it's documented in description of --autosquash: "A commit matches=
 the `...`
> > if the commit subject matches, or if the `...` refers to the commit's =
hash."
>
> The docs don't=C2=A0 clarify if a full oid has is required, or a unique
> abbreviation within the repository, or just unique within the rebase
> instruction sheet.

It's even worse: _any_ valid reference will do. As you can see from
https://github.com/git/git/blob/efcab5b7a3d2/sequencer.c#L5359-L5381, the
search goes like this:

  - For the remainder of the `fixup! <remainder>` line:

	1. If it is identical to the oneline of any commit mentioned in a
	   previously-seen `pick` line, pick that as target.

	2. Otherwise, if the remainder can be looked up as a commit
	   (think: `fixup! master~3`) _and_ that commit was mentioned in
	   a previously-seen `pick` line, pick that as target.

	3. If all else fails, and if the remainder is the _start_ of a
	   oneline of a commit previously seen in a `pick` line, pick that
	   as target (if multiple lines match, use the first one).

Do feel free to put that into a native-speaker form of a patch to improve
the documentation.

Ciao,
Dscho

--8323328-1254696943-1589772472=:55--
