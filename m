Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80E72C43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 04:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB4782078D
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 04:11:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="akYEpH+8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbgIUEK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 00:10:58 -0400
Received: from mail-41103.protonmail.ch ([185.70.41.103]:63077 "EHLO
        mail-41103.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUEK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 00:10:58 -0400
X-Greylist: delayed 332 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 00:10:57 EDT
Received: from mail-02.mail-europe.com (mail-02.mail-europe.com [51.89.119.103])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-41103.protonmail.ch (Postfix) with ESMTPS id 8A8912005B99
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 04:05:24 +0000 (UTC)
Authentication-Results: mail-41103.protonmail.ch;
        dkim=pass (1024-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="akYEpH+8"
Date:   Mon, 21 Sep 2020 04:05:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail; t=1600661121;
        bh=z9FNfkJrrLfzcBjypYWd72nkGhNUEx0wnDlmqFozTIU=;
        h=Date:To:From:Reply-To:Subject:From;
        b=akYEpH+8SYscQpAwB7NeG0bTbG6WrJwaNv+/sn6nmlm7SiSOsfZj98y+Akzn5vju6
         HyfMFaH1XrhaGXVOV0N1cv6D4ZlgI7/ofyvvsC51xe7IyQPJ0pJGEEqtoErYva1mSn
         7/epHqrgoYoqZFY+PnTI6J5jOCzPPtHcyrZn7heY=
To:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Jack Pearson <jackrpearson@protonmail.com>
Reply-To: Jack Pearson <jackrpearson@protonmail.com>
Subject: Possible bug with shallow git submodules
Message-ID: <TL-eiJO9bgDXcADhNSFRNxeW0f_E_j81jXXUbGjW-1Rib26LB8OViFEeH0ptC3i0px33kk3xKghYr4bYiiHuKSFXwMNAUIh7jisIZeVpQBQ=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I create a shallow submodule, the submodule doesn't stay shallow after=
 the submodule's remote changes if the submodule is re-fetched as a result =
of fresh clone, or a result of manually deleting the submodule's .git folde=
r.

Detailed reproduction instructions here:
https://gist.github.com/jpear1/0ffc28e8167d00504fba54d50ec4848d


Maybe related is another problem I've noticed with git submodules:

I'm unable to discard commits by moving the tracked commit backwards (with =
git reset) in a shallow submodule (the .git/modules/<mod-name>/shallow file=
 doesn't update properly).

Basically it seems like the submodule is using the latest shallow "root" it=
 can find in the branch's history of gitlinks and not allowing me to use an=
ything but that. I'm not sure if this is really what's going on though.

I go into more detail in an SO post here:
https://stackoverflow.com/questions/63976876
