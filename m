Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E88C433DB
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 17:47:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA848207C8
	for <git@archiver.kernel.org>; Sat,  2 Jan 2021 17:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbhABRqs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Jan 2021 12:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbhABRqr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jan 2021 12:46:47 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B008DC061573
        for <git@vger.kernel.org>; Sat,  2 Jan 2021 09:46:06 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c12so13827428pfo.10
        for <git@vger.kernel.org>; Sat, 02 Jan 2021 09:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=kq12hlCXZTb7vf/xEApkZkFpnHbNPvcUfs2PURLULKs=;
        b=bcDbHAwKeVp9CediRi39Sa7tPxWHjTo6mBl/mMElip57gTOL+AHnfxilLkuTGPw0S3
         +jbWxcSvyL5B1UMATl+ibOkIyWzCiFBuoAn2Ivj6GGFDrwQ3LCiiCBb1/bG5RnzgOAT2
         Ei4/L67vkbHYyoO5aOK9gKR5OUVeqexvxqlwuZ1CvxR4ieeLl3u4GD+YK5gtmkbmFu6d
         qpiGxN7EygT++fA9JIbF1Vy4Zilr2HMGGklmMud72Q4Dx4pncfzL+g1aWYOoFGK3w7jp
         OHkohEW83cOVIajTNaRnnJHToM9vKm/jecug4mbxP+uQcl5KHZkD2EBlpMX/gFquQkjY
         H0lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=kq12hlCXZTb7vf/xEApkZkFpnHbNPvcUfs2PURLULKs=;
        b=KyDVLMQz1vLoIOHe0F/6NTgO6BRC6DJ9wH7rg/h0NfDFRUbHZudFOsfE0ScMWuVODh
         yWOAxeBsvrkLppuWyP6Qoa5nePH3rfDBT2Wn+CmGTNHX3TgLB8xuHeFS658I1iFG7AMg
         SullF7ZOAjbSzKP5DhhddsrRZa2RJO8kPeFnWi3qZmVCRS/rxFbxAA1Q+83AbKHvxUSv
         pBdp2tqCUAh8xdVFA/vHSzaUbjBeBNJ9P5uvF/smd4EPNms4Mg9LJ/3eJCvMFlUsEbi1
         LMa6eXlXB0EQKQI+E8Wf3Se2GW9f0qN0eoP+ZTTQ12JE1RRpKHxj/ut0zSUg6ZyXvDO4
         ThfQ==
X-Gm-Message-State: AOAM533vxg1kIk5M+uNGHfsSUiE1FenQHH52MfYE03KrM+lFq88xQDlS
        egwyU/cj/RMZ+5veeaWUFYSJJv9Ln8ldsVtSEN9yUpmL6aBhpQ==
X-Google-Smtp-Source: ABdhPJwICbo+9PN0uH2nwb+vrjwy+mso4p1HFe4Ylbqs7+eJwM8DzkiKwZZnpTe0rzun1Vsq0qhfhRG1oT9jq7TCsxE=
X-Received: by 2002:a65:6782:: with SMTP id e2mr64161016pgr.424.1609609566102;
 Sat, 02 Jan 2021 09:46:06 -0800 (PST)
MIME-Version: 1.0
From:   Andy Wharton <awharton1976@gmail.com>
Date:   Sat, 2 Jan 2021 17:45:55 +0000
Message-ID: <CANUvzQ12V1ptr9uEpXFnJQWcWgjs4+vTjgaXTMrsJ6foAMpv2Q@mail.gmail.com>
Subject: Expected behaviour of 'git submodule update --remote --recursive'?
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

I have three git repo's:
    A imports B as a submodule, and has "branch = ." set for B in .gitmodules
    B imports C as a submodule, and has "branch = ." set for C in .gitmodules

I had hoped that checking out a branch in A, and then running 'git
submodule update --remote --recursive' in A would checkout the latest
commit from that branch in the two submodules.

This works as expected for B (checks out the right SHA as a deteched
head), but because I'm left on a detached head the update fails for C
with a "branch configured to inherit branch from superproject"
message.

While I'm guessing this is the expected behaviour, is it possible to
make the "branch = ." option use the branch name from the parent
transitively? Or is there another mechanism I should be using to
achieve what I'm trying to do?

Andy.
