Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3854AC4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 20:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233454AbiLLUTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 15:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiLLUTq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 15:19:46 -0500
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7EB2669
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:19:44 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|joshua@azariah.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 377825C1E19
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 20:19:44 +0000 (UTC)
Received: from pdx1-sub0-mail-a300.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id BA4C85C1D4B
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 20:19:43 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670876383; a=rsa-sha256;
        cv=none;
        b=HiABZR9qkWgZzN1hORGzb5vozYrJGgBkVXU28o5u2F90/jK2FT7P5XPivWMRFP/EjWQI/Y
        3UWpU+H5XvDGdW0BxvAO+KdJ2JAK22zpaoWywZCcX25rCSLnX/kh//+LMtXwyT1TM50ZiO
        7odHMu12iAeF0pXN5L4aXhy5FHnaHE61CuuVgB+CRLknpTMJj7tcRoz5WBdf5BhYGvFOA9
        S7TfxOl0040ZptMTcaxhGWG2c6/izMilBw25UP21oBwGi3GfEYcWULUGUdKc7B+M/yDtyA
        n/iHMou6GIjBvJa+tLQzf7oY+lxZsSYH/D18qsg5qZsutRwAfJ3mP1LKDIXBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670876383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=yL2h9Zk0iFJ7Rt6Uw9VZRKgXsNFjlhOgvihTkuh/ENc=;
        b=gFjPrIHQQykJ0J+vIiWg0ROEPOp8hMTyRENDMASFiSqWoKQwFMv1Wux991j6cfSeQD8Cwk
        +hyx3/uiXQEwvhjBT2fVyMP1PRSGUmJRvXMfanXkycPmaMlyoK0ayh9+EhsXFIcrj9L7vZ
        lRZVy1JkvECE0JF45SDyRYH8/h8eWpTw83PWG5mMvFIImZC2DAQA/xEEBt6ss8Vqg9kNy9
        zIycNwDKGNtFxmSYEBn6+k9HpD1freLhoVwoyM6FnYltQeEWE1U3tWJk3wE/V2fOAPj45T
        Px1HApSm/rNRQYgzEvP0ldPBAcGjKT08Bf2vrf0ThiNB6Q49vIS0capN+AiBkQ==
ARC-Authentication-Results: i=1;
        rspamd-85f95c7974-xk78k;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=joshua@azariah.com
X-Sender-Id: dreamhost|x-authsender|joshua@azariah.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|joshua@azariah.com
X-MailChannels-Auth-Id: dreamhost
X-Madly-Power: 6cf9d7421977d892_1670876383996_3080865611
X-MC-Loop-Signature: 1670876383996:1195658421
X-MC-Ingress-Time: 1670876383996
Received: from pdx1-sub0-mail-a300.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.78 (trex/6.7.1);
        Mon, 12 Dec 2022 20:19:43 +0000
Received: from hosanna.localnet (216-67-98-32.static.acsalaska.net [216.67.98.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: joshua@azariah.com)
        by pdx1-sub0-mail-a300.dreamhost.com (Postfix) with ESMTPSA id 4NWCf737y2zC9
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 12:19:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=azariah.com;
        s=dreamhost; t=1670876383;
        bh=yL2h9Zk0iFJ7Rt6Uw9VZRKgXsNFjlhOgvihTkuh/ENc=;
        h=From:To:Subject:Date:Content-Transfer-Encoding:Content-Type;
        b=uFhE8NxZduK4uN473ogXAxCMBMCYSQt66wywutUnXP9fYTBYcR4XXWyLmy6KHWC/3
         zZRBzPbaMLd4cj+ykhrOqljNE4nG0eSOsB2YMF/NjrrEFlpp1bjihadaV3k1GhSO9D
         lO+nyEPDg/r/bTziW4EHofrOQ5VUXCvY2B73yBVn6E+YVKjmtoyk1MuKu2pPVb5IsJ
         Jfr7cLlhOv0nkxXPWSunm7Cail3qS1R0FqaNEG0wwPUu1TmsclgOGQUvl2VTM+Y3Sl
         W+D/UQRhN1LsHAjH5brNehNltaLqziEN/MIVVrTgn6DGGDdGjFamQL/cDLvdIIKvEy
         TtSGuoZcULbGg==
From:   "Joshua J. Kugler" <joshua@azariah.com>
To:     git@vger.kernel.org
Subject: includeIf appears to not be working
Date:   Mon, 12 Dec 2022 11:19:41 -0900
Message-ID: <8316344.DvuYhMxLoT@hosanna>
Organization: Azariah Enterprises
X-Face: "i;.9?eoq[n1J]7NP093Nf-le\(f:apL[8Qcc^@FG*Lx!`q`1/iCg7oGU/gv&"yx=8K|o: 8e=hQB,0w,`~p}'#>'NF8L3xcI>;?O-ABM#&^UN@Vh{4ktY],7O]OhEyW8tjIdHtN<G<q` Ha]]!@7D)vzKnV!!*{Y>`(&+f>TErbn'9J)'=2RU+3I_OdR)P_I/Bl+l@5)o5,KV}BKhi; DzH7ih^d}V6{2aa8qe&)\B}h;\Tje;[6E4K1Gu-M`>WM7-}cZ'&n(`nk.!coGBc<WTQO.# ?~JA)i#GH)W(jZRI<p]Il-NRMeEX+X/MTW8?T
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So, I've set up includeIf before, and have had it working, but it seems to not 
be working in my latest attempt.

This is git 2.38.2 on Ubuntu Linux 20.04.

Contents of ~/.gitconfig (truncated):

[user]
        name = Joshua Kugler
        email = joshua@personal.com
[includIf "gitdir:~/repos/work/"]
        path = ~/repos/work/gitconfig

Contents of ~/repos/work/gitconfig:

[user]
        name = Joshua Kugler
        email = joshua@work.io

Now, if I do this:

cd /home/jkugler/repos/work/some_repo

and run:

$ git config --show-origin --get user.email
file:/home/jkugler/.gitconfig   joshua@personal.com

Like I said, I've set this up before, and had it working. I don't know what 
I'm doing differently/wrong...but would be happy to be told so.

Is there a debug command which can show if the gitdir is/isn't matching like I 
thought it should?  What other command output could help debug this?

Thanks!

j

-- 
Joshua J. Kugler - Fairbanks, Alaska - joshua@azariah.com
Azariah Enterprises - Programming and Website Design
PGP Key: http://pgp.mit.edu/  ID 0x68108cbb73b13b6a


