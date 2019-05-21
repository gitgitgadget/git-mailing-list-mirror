Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CA91F462
	for <e@80x24.org>; Tue, 21 May 2019 02:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727302AbfEUC7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 22:59:15 -0400
Received: from mail-io1-f45.google.com ([209.85.166.45]:34992 "EHLO
        mail-io1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727026AbfEUC7P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 22:59:15 -0400
Received: by mail-io1-f45.google.com with SMTP id p2so12757603iol.2
        for <git@vger.kernel.org>; Mon, 20 May 2019 19:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=QqQ/0f2A3215IpSpfYNr5Kb5KYmkoqWTUB84PFvKCAQ=;
        b=eIuIY4u+BjWTHXEpWdpd125P1YBv3JRuf1FHKob3Mnx0Yp61Lb1cGAkFLJ7f6FDeBX
         +F+2/kijBhIihh2kYJ2tZAPbEGs2DO4i81Gnoe5lPZP2JoNuDMRP8SIpBQISzS4oVbQH
         D/+Mq1w0AoqIBoia26Mhia4RakJbdPunBQmDFl7HEErZ0ttjr1AV+4VplDAr2B2kFM+l
         VC3SaZWSj/AT2Ew4d0RSs3+yYZGqroFJ7A3UOpqziaQxe9w+PHJDXYHZmHI50Hvaq5PI
         MVfy9SyLILDKl3PCKpRMJSLC5RtzIDiapk3B0YweQMxx6t2QawAOyTZOjeK70UyFMd5C
         jjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=QqQ/0f2A3215IpSpfYNr5Kb5KYmkoqWTUB84PFvKCAQ=;
        b=iYgqOhDX1nUqxBsupQ2t4r2133PAoUu1KVBsA8Hrzb6jlz6/FNGYqVVqQEiCNpyMH1
         dq94Dvd8j9pKuv7v+3HaCdrUzlicUy68vKiTGdswOqXe98dPkH++a9fpYxkMfpdArRoT
         slP68DuhmBurIwHZnJ5b/i5018oRcFFhpV5+rOx0Qx4YbmFL7lLtmDLTd3j21FkZ/zap
         rS+mHxa86fyNEuY08dLGQQlALXQp3esClCzIN2ohk5WiJb4SaO/bcXGdjUv/mQP2drUG
         tQca9khbrSH8U/WH1+uO17H3wrTw2yQmHmi2v6NrRxvcngXN5iudJMEy23oDjF7r7Ecy
         1yLw==
X-Gm-Message-State: APjAAAVHczlxO96UUDlPCdeIS4ICYCUF6WWj6ufsKhETE3mGd49XwBSI
        m4eBHMBrvPLV6uFysCh7+pN64K6JyvJCh1o23BnoddA4fRpqYA==
X-Google-Smtp-Source: APXvYqzGMc3JSPhG2PcKOOlE37AINWNmSteMFXaahIaubnonww0W8LRu4lFswuwFI15gVa83RT9bd0MrjU941dW7swE=
X-Received: by 2002:a6b:5116:: with SMTP id f22mr21145907iob.185.1558407553818;
 Mon, 20 May 2019 19:59:13 -0700 (PDT)
MIME-Version: 1.0
From:   Bryan Turner <bturner@atlassian.com>
Date:   Mon, 20 May 2019 19:59:03 -0700
Message-ID: <CAGyf7-Ew8rS8n67Few9+dT6VXy9rQbaYLswuZkQ3-4j_T_d=qg@mail.gmail.com>
Subject: HEAD and namespaces
To:     Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using GIT_NAMESPACE, it appears the "symref" added to the
capabilities advertisement doesn't get the namespace stripped. The
namespace is stripped for the advertised refs, including "HEAD", but
not on the "symref".

Lafiel:test bturner$ GIT_NAMESPACE=foo GIT_TRACE_PACKET=1 git ls-remote origin
19:51:54.012696 pkt-line.c:80           packet:          git<
b9acca03606d4c674be8b7e79cd788cedbec957c HEAD\0multi_ack thin-pack
side-band side-band-64k ofs-delta shallow deepen-since deepen-not
deepen-relative no-progress include-tag multi_ack_detailed
symref=refs/namespaces/foo/HEAD:refs/namespaces/foo/refs/heads/master
agent=git/2.20.1
19:51:54.013017 pkt-line.c:80           packet:          git<
b9acca03606d4c674be8b7e79cd788cedbec957c refs/heads/master
19:51:54.013028 pkt-line.c:80           packet:          git< 0000
19:51:54.013035 pkt-line.c:80           packet:          git> 0000
b9acca03606d4c674be8b7e79cd788cedbec957c HEAD
b9acca03606d4c674be8b7e79cd788cedbec957c refs/heads/master

I don't know whether the client somehow does some stripping on the
"symref" to decide that HEAD should be
"refs/namespaces/foo/refs/heads/master", but I'd assume not. Either
way, since the clone can't find the HEAD value (either because it
doesn't see "refs/namespaces/foo/HEAD" as HEAD, which I'd assume is
the case, or because it can't find
"refs/namespaces/foo/refs/heads/master"), it falls back on the old
behavior of picking the first branch with a matching commit. That
brings back all the "wrong branch" issues with cloning that adding
"symref"  fixed.

Is this a bug? An oversight? An intentional decision? How is HEAD
supposed to work when using GIT_NAMESPACE? Perhaps the expectation is
that namespaces won't have their own HEADs? I'd say perhaps it's that
even in the namespace the target ref shouldn't be namespaced, but that
doesn't seem like it could possibly be correct since the namespace
could contain refs that don't exist outside it, so Git would see the
symbolic ref as broken.

Any insight would be greatly appreciated!

Bryan
