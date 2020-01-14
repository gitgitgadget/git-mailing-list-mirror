Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40121C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0564E24658
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="U5OdfOu/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgANVHM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:07:12 -0500
Received: from mout.gmx.net ([212.227.17.21]:47601 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgANVHM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:07:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1579036030;
        bh=xSdaj7fBNB4GlKCKbizB/TKov00R0kFNaWWR7KSjFkE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=U5OdfOu/cXX5cpcPkjIOyPVFGMmeIBdlt+LWthBsoxhULrbPkI1AnwbnHx4wGuikb
         0SNe/vXZTMk2/FR1kcLq8Vd8dvCTaC/QH2ovF3DtJnJqN4DcpjF6jLdsBRvadwLtfj
         qfhcxMPwlygqHkX1270bUIoI1byLG8eMIJ4xFN7M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MjS9C-1jWoku0dXG-00kxfU; Tue, 14
 Jan 2020 22:07:10 +0100
Date:   Tue, 14 Jan 2020 22:07:09 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] dir: restructure in a way to avoid passing around a
 struct dirent
In-Reply-To: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001142203450.46@tvgsbejvaqbjf.bet>
References: <pull.692.git.git.1579019532809.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:5j4trkCeUK5RDEo92AZWbVDxBZ/+F0sDcyyi4qklJF+eaJePXDr
 8I0kAXxmNyL+/fs9qTOIBGXyRTl9Zdi0Li2XchCJDqWEzhulGYWV9UuX57U9DInN6jQv+nW
 Zpfpw7+ryay10Wy4nIom65aBcpqlnwrB0vAScej2MFX76wS4E7Hv6jz69MRb4N2FWywlwiv
 KZg6IPwPr2JxpoipldYJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dSg2Tka8TFw=:wttnyW7jqt7IRkyVWCwdAl
 aCp0hAAhJkeXkqsmMr5qQvHoCnv3NWStmNQ9mUsP53MLEsCo3c6IfqJtBxe4QyVI6iXm8rjyI
 4MIlGJ4Q4cNBHSSLgDSK0WLhpxG837bskcxBSJM+7ql7FGQQBa0a7qg8+d9GRnVbmTHtr3xJS
 Q6daVCCiYsb9ioFBPo/FnUxbKrkPB25Uvm56Ty3B3PL4NKI567aUY3xQuT65KtySAigeHQxy/
 8ZARMrjLxGJj0n9qUJ+V7bpPGVSTuPjbqPQQg7/4q2lSat594pM+xbziRko6nOv1P3P2+dtni
 KOIDQBoAjqPaNldon9CuPLf9KbwP+/z31Jt2GMXfvRyic4TE193FVW8kmTPEC5hUTAeNBvKvX
 ccFArXX7raB/41x4t89Rs08E6FgmZKJ6AgZh5VqQH5ewsSsqburY8Y6Jxngtl0OHEAZOrY3GW
 fw5oHyunWKozOs+9KZGH7smzAFjetm5FlaMTGWsJO3NFBabEf41FhaXWUZlRd2UHfaAW/LGpn
 sTiSLyLl4nWDezEFTq3Bu6Ao9ahZKVzR5BEIrhpZPCq7DCADEYOTL8XdRHEuoqDwWDE0qRsDV
 hk/gwUgcf5sDsO3NLb4nqxs/AwSOSvmM1XzmhOpFS9vTuvTWlqKqjKzTcRSo0xhDAXu2kYXLc
 3VcuCE9rCekchvVxXcNbHLcXX8rBt5n/w7nmlsRCKFzghVAjxDV8ySmoMQXLblZphuclXRzdI
 4STxxsOOoTkgiN2aeTE0imMGstUdwd/oPgEP6FhrkLVNlJh2wQEwrHhjSZqqIrxHSYJcEfeTv
 MyB2ZJk4vmSIl8MYBf/nGIyapDb43Col42lPOc1zzJxICcE4GJldIpc0hzn/Y8XtcFGo58eXz
 N12ZHemlfjX80SAJ9zxYwarJl0mI/6nHLKzrY+YiPTWjIzeB9SUFu9b4TGmCmutStKNU+hG6+
 +J6eNhGDdjHnVivTxZz6YnsYnB+4Rsp/foD2JpRkOZxUeJMg6cb8j+kWsJxLjU7bTMbTMuEMy
 FT21Bhk7ItYHkuuFDz9y0fyTGKU65r/6OVptcZ7ehuNScV0BNmQVHrmcRtlhk9/VrLyW9+E1E
 utx8bTOJ2KaHvT5nwyc0yvUbxDWIl6qjtqK+nF6si9V4g65CUIft8zjdDwoxboQMPH2PJ6LcK
 DtgZqDjAUkD09+zGWZNiO1sn8Ecy7QMWCC9bpj6JSyqoo+4M0T/Uw5EGTyLEwlz8HjK6JEjQn
 tu3f7FlIZ0oTEDhCJUKhsRd4s/Kk8lNfw0ZRto6lrPOLK+W9ZmfElU35A0+g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Tue, 14 Jan 2020, Elijah Newren via GitGitGadget wrote:

> Restructure the code slightly to avoid passing around a struct dirent
> anywhere, which also enables us to avoid trying to manufacture one.

Please note that due a bug (which has been fixed in the meantime, see
https://github.com/gitgitgadget/gitgitgadget/pull/188 for details), this
GitGitGadget mail is missing the line

	From: Jeff King <peff@peff.net>

The patch itself looks fine to me.

Thanks,
Dscho
