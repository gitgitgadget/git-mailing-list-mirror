Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DFA0C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 14:01:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjDMOB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 10:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjDMOBv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 10:01:51 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CD7113
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 07:01:47 -0700 (PDT)
Received: (Authenticated sender: robin@jarry.cc)
        by mail.gandi.net (Postfix) with ESMTPSA id 77693FF812;
        Thu, 13 Apr 2023 14:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jarry.cc; s=gm1;
        t=1681394506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y+GXn8NGSCYFR/D3UepQQjFIbntT2kM5UI/Qhr82sjo=;
        b=gf/OALTKXhipJbOFHuvui5i+kJui9uMPHxaa66VQDMjSw+ipfCHjIYLqcD+7VE1oNscONg
        pWwedjvz1e/vbmA9mmvyDI23ZU8WkokIThYnkS3yZrwwOD99r1jF6iB4u0VqOesDgs/ZlR
        z8fBpy/e/VEkmXcIgBiTSwXrVSJuloOZkgxfKOp5C/6JzkVn0PfulCmtE1x90bGty0TEGA
        SlPgmiD0aT8vbdtpkLQ2LknRzuVUYwUGF9OIG4gquGvW3PQM1tanCWaDEakJQtGxh31vSU
        XjSpMs/zPX09eRbSWIPX07fGWl37JjRfkSj9DOtEwClrpQXf15ubYDoNRPPF5w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 13 Apr 2023 16:01:43 +0200
Message-Id: <CRVOLVOVSVO4.UJJ8JLP8Y69T@ringo>
Cc:     =?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, "Tim Culverhouse" <tim@timculverhouse.com>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Junio C Hamano" <gitster@pobox.com>,
        "Eric Sunshine" <sunshine@sunshineco.com>,
        "Michael Strawbridge" <michael.strawbridge@amd.com>
Subject: Re: [PATCH v3] send-email: export patch counters in validate
 environment
From:   "Robin Jarry" <robin@jarry.cc>
To:     <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
X-Mailer: aerc/0.14.0-155-ga46e3b9c027e
References: <20230412095434.140754-1-robin@jarry.cc>
 <20230412214502.90174-1-robin@jarry.cc>
 <240577d5-3412-5a80-c7d9-e3d277869add@gmail.com>
In-Reply-To: <240577d5-3412-5a80-c7d9-e3d277869add@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

Phillip Wood, Apr 13, 2023 at 15:52:
> I think the documentation and implementation look good, I've left a=20
> comment about the example hook below. As Junio has previously mentioned,=
=20
> it would be nice to have a test with this patch.

Yes, I only got Junio's email after sending v3 :)

The test case is ready. I was waiting for more comments before sending
a v4.

> > +	git worktree remove -f "$worktree" 2>/dev/null || :
>
> Now that you've got rid of "set -e" I don't think we need "|| :".

Right.

> I had expected that we'd always create a new worktree on the first
> patch in a series and remove it after processing the the last patch in
> the series, but this seems to leave it in place until the next time
> send-email is run or /tmp gets cleaned up. Also if I've understood it
> correctly the name is set the first time this hook is run, rather than
> generating a new name for each set of files that is validated.

I had thought that it would be useful to keep it in case the user wants
to inspect and resolve issues. I you think it is a problem to leave it,
I can deleted it after the last patch. In any case, if the user
interrupts send-email before it has time to validate all patches, the
worktree will be left in place.

Thanks for the review!
