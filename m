Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7B2C4332F
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 16:32:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238677AbiKOQcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 11:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiKOQcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 11:32:08 -0500
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 555D8BC96
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 08:32:05 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rjp.ie; s=key1;
        t=1668529923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FFG9XZ2FZiy3jMyE2oam26CN1i9Ag4/QHnns61Kdfhc=;
        b=E2eB1QtgPlfRSMzzQOkLFr9v4UhscFsZ7JeQPuf3z+cspm5LdnUY05i0KdRX07v0gdFanc
        a7eCyPkcCVupPsDg/Q6GuuW2fxF69p6oAjefCVQhlwreCUa1X5i1jgKDeQKK5fe9FmQP/o
        tWZFmCrGTj7YnuGnb8lfwIfZ06Krq+E=
Date:   Tue, 15 Nov 2022 16:32:03 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   ronan@rjp.ie
Message-ID: <1ab6aa0e8178c88689f26b8df9ec75cb@rjp.ie>
Subject: Re: [PATCH v2] maintenance --unregister: fix uninit'd data use & 
 -Wdeclaration-after-statement
To:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?=" <avarab@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
In-Reply-To: <patch-v2-1.1-f37e99c9d59-20221115T160240Z-avarab@gmail.com>
References: <patch-v2-1.1-f37e99c9d59-20221115T160240Z-avarab@gmail.com>
 <patch-1.1-54d405f15f1-20221115T080212Z-avarab@gmail.com>
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

November 15, 2022 9:04 AM, "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason" <avar=
ab@gmail.com> wrote:=0A=0A> Since (maintenance: add option to register in=
 a specific config,=0A> 2022-11-09) we've been unable to build with "DEVE=
LOPER=3D1" without=0A> "DEVOPTS=3Dno-error", as the added code triggers a=
=0A> "-Wdeclaration-after-statement" warning.=0A> =0A> And worse than tha=
t, the data handed to git_configset_clear() is=0A> uninitialized, as can =
be spotted with e.g.:=0A=0ASorry, I'm a little confused. I had sent v1, v=
2, and v3 of the "maintenance: add option [...]" patch, but as I understa=
nd it v2 had already been applied so I was asked to resubmit the changes =
from v3 rebased on next.=0A=0AI had done that in [1], but these issues we=
re caught in review so I submitted a v2 of that correction in [2] which d=
eclares the configsset earlier and unconditionally initializes it is clea=
red. Are these further issues discovered after [2] was applied, or was th=
ere some issue rebasing the patches?=0A=0A[1] https://lore.kernel.org/git=
/20221110225310.7488-1-ronan@rjp.ie/=0A[2] https://lore.kernel.org/git/20=
221111231910.26769-1-ronan@rjp.ie/
