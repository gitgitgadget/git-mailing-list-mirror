Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED79C76196
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 10:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjDKKkI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 06:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjDKKkH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 06:40:07 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBC210F0
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 03:40:04 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 563C4FF80A;
        Tue, 11 Apr 2023 10:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681209602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kp/CR7e2T1qX3ARK3UZDm6ATdtfuOGrDfZOllNbY20w=;
        b=FprIar+qztdtMDXlp0kmXfESKl02jPsNJn1Hha6YEbpSwHMLFY7XDy8tA68Nma7FqVaBic
        T5tQZT5koLHPDCUqvUHuzvDFDP1jac1RWuTG4ScxlBPu2f3RuLezT4yqp+6jMpIaVhdywC
        lStnikZ0blJYM4VnWc/7DP2ePLksVo8AkyBW7R1aUl8v0eK+Brd5ElpKprHrCv2MnecblE
        Mofs+M+nxgsPgQGfyL4S4lA7NSThJQyL3Ch1nqVAHjwdgvCHE82Iceu2+sjllGEkXdQdCU
        nE/3PLC5paBeh9HsWDxz+CBy0wCM2/8ZLRZK12arNjHrWBM87fmkzzGbLx74pg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 11 Apr 2023 12:39:59 +0200
Message-Id: <CRTV2BVL0265.1H9OALXHPDZF1@ringo>
From:   "Robin Jarry" <robin@jarry.cc>
To:     <phillip.wood@dunelm.org.uk>,
        =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH v2] hooks: add sendemail-validate-series
X-Mailer: aerc/0.14.0-154-g68bc51d7fe3d
References: <20230402185635.302653-1-robin@jarry.cc>
 <20230405231305.96996-1-robin@jarry.cc>
 <230406.868rf5tkzs.gmgdl@evledraar.gmail.com>
 <9b8d6cc4-741a-5081-d5de-df0972efec37@gmail.com>
In-Reply-To: <9b8d6cc4-741a-5081-d5de-df0972efec37@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood, Apr 11, 2023 at 11:58:
> A hook that wants to check some property of the whole series needs to=20
> know which patch is the final one. We could pass that via the=20
> environment as we do for external diff commands with=20
> GIT_DIFF_PATH_COUNTER and GIT_DIFF_PATH_TOTAL.

That may be an appropriate solution and it would avoid adding another
hook. And it would solve the issue of "\n" in filenames.

The only downside is that you would need to store state in an external
file (maybe in GIT_DIR) so that successive calls of the hook script can
pick up where the previous invocation ended.

It all comes down to ergonomics at this point. I don't mind either
solutions as long as validating whole series is possible before sending
emails.
