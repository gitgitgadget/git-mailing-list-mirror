Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58FDC43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 17:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3E7624670
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 17:57:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="bLt4rbsb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726325AbfLFR5N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:57:13 -0500
Received: from mout.gmx.net ([212.227.17.20]:50463 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfLFR5N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 12:57:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575655027;
        bh=gaKX+/ECHgVgDtbdXhhLCrYnkuXloh4g2FPORBjgiV8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=bLt4rbsb0IMJgXtMOoXqKV3IvweA3o9qcGDAfKSNJqt7KTWO3JN/uwrNbnGpSYk6a
         XDNyl46I6obXlS40P80JwF3g8pQZ3tR52vlEveQk4pc5oHj7APoGgDn/P4rR4Vu3jx
         /IN4moU3S4+g0rPbewtGpGn/7C9hUCBXVI0pY1ng=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MlNtF-1huMqU0H1h-00li9Z; Fri, 06
 Dec 2019 18:57:07 +0100
Date:   Fri, 6 Dec 2019 18:56:51 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 7/7] apply --allow-overlap: fix a corner case
In-Reply-To: <xmqqa785xv9w.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1912061849300.31080@tvgsbejvaqbjf.bet>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>        <15c4cce5a027d56c7ddbe5523cf0f3beabd06ed7.1575637705.git.gitgitgadget@gmail.com>        <xmqqr21hy3cf.fsf@gitster-ct.c.googlers.com>        <nycvar.QRO.7.76.6.1912061502110.31080@tvgsbejvaqbjf.bet>
 <xmqqa785xv9w.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uuCBzZtix0SICH1QcC26JL62EHhKy5Y7ybWwAte+wnNMgACh8hJ
 /3xwTqchXQFNDNxpPaYLEZe0dSAEa7G12XdDCHxAp6KR5X+FHiwLFCdCDZsufpQsUJM5Cun
 aE6+RgJpVs1ZzUM/ooJEO2wyKOFUGZg9kyQEeFCB3rk6FW9b80CRHZ2HqryLjc0pnOuSTQc
 /m/npLgMgviOA7zqa0teA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+QNvQNQL0ig=:gp322kriTMvXf2U0FiJt/h
 +g1Ih87SgefPkToxGfLVPf6vQUJc210dOr9uaXM6Mf8dEbdwewU82UlnucxGfioXOFrFLbPTw
 q4mi3ov4NCjdASqKBvD0W7k7UrijTBEzd3xmoFfPGIa81/hPfOKMAY1u9cji+PxQYTfU+mEng
 dxLDdrG3+oqJHLgVgtIzNr1R49NkJFk0J08tyL76f3r3v/OO1aPNwLe4pz+diwvhoZRnRtrkr
 uB1a/u630wb/LzO2/aAuImg9KZ232ih0G5pVq4peGXviOUgKjMfz717nm3OMTV0zan2dZ7063
 B88v+6hB+wG4M5jIxjhnSJElXi5crV9fDYZO+gQFD2bK8EXj2ZWOV7hDsnd0PtxaSdhZuGXx3
 x1F5/Dd0UZKD2nxPumbdljGI4cjaFd4YAJIvho6Wa3atz6Yb8dGf5X+uEnYYfL+coVzypnpoL
 aAm6z5Y2ihNeAxnYyJSFH6DPxPAmO0m3sxH/FzB+nR7wkRxhPg9T59xHGzeIkqhqY5fG7AHzf
 wt6GgJ+XJGzuQqCNT9dEJ3nkbC8XUKZ0kgVmhp/tBFttxBuOHuEAF/06Ef3ZIiWyzneW8yyep
 ZaKypxrfqwOP1Bvxs0GDfa0Serj0EBAOXeGr6U/d4VCyCZPoxsn+lP37ZLcVOUUIr8vBKUnzz
 /EPf724qLf7jgyu/whH+u0kq0c/bNtL8tbEDClMi9OgiNyRUmKye12q5tuZJlEOTPbT3MIoFZ
 uNRtIHhYQ6h0uPeAJNhCa7ZKhmUP39r5tFBWE1vfjqK5larnF3BUzCVnqLIJuaEFaQUdxSly3
 X0JdkHEJOvZNDTfkLwFED7JjQt+YlAs2+iY/wqCeSnIbYPVjZPIRGILmxMvqnc7eeCKUh0J/o
 qkqY5/E/UmWMBqBFVkWeTt+hU51es3nm1WJD7ox4nV+nIduvpCCyznzMuOe9QxxTxNqkznOXK
 AKecizSIu3yrQ0Xr/67ghskFVdGSjRmsua7H8XNLVEJkEp/zl4aEYJWacJByy+vOYsPPrYIci
 m+MhCM2Ysbv2OiJSV5T5SzjeMi4Fk7dpIwZX9e0hwadcN1TLvQt5nQWBfONIs+DzJa10vzaco
 B7YpnDkeoFX1U/zkni9Shm2vSLdDpBgD1e90noIuDqaY1a+/qKYpmxvV+2tLHGuhLLEDL+ZrL
 UPStB9ThDM4RFg4OIp3VYCqqPvY3+4BRK5ACB6WCL7xR7zQseIMR6mMEhiep6T7KTBGVixwzb
 p4jGx+61ZIKl5r+ePiZ+TvtRGgsf7Ufu4puXnfhU/iqkpAvI22LmSwCdahQc=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 6 Dec 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > The beginning is more special than the end because it is associated wi=
th
> > the line number 1. The end line number is flexible already.
>
> Yeah, we do not insist "the lineno must be X" at the end like we do
> at the beginning, but we still insist "there cannot be no post
> context if we are adding at the end" just like there cannot be any
> pre context for a patch that adds at the beginning, no?

True.

> > There is another difference: after splitting hunks, the first hunk is
> > applied first, and may render the line numbers of succeeding hunks
> > incorrect. The same is not true for the last hunk: it cannot render th=
e
> > preceding hunks' line numbers incorrect, as it has not been applied ye=
t.
>
> This truly may make quite a difference, especially because the hunks
> are applied in order.

I think you're right, I fooled myself into believing that the line number
1 is special, but the real culprit is that the second hunk is applied
_after_ the first one may have changed the (overlapping) context. The same
is not true for the second-to-last hunk: it will always be applied before
the end of the file can possibly become no longer the end of the file.

I'll try to think up a concise paragraph about this, and stick it into the
commit message.

Ciao,
Dscho
