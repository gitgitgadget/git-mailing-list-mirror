Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98BB120966
	for <e@80x24.org>; Sat,  8 Apr 2017 02:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750813AbdDHCP5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Apr 2017 22:15:57 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:41786 "EHLO
        hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdDHCPz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2017 22:15:55 -0400
Received: from homiemail-a60.g.dreamhost.com (homie.mail.dreamhost.com [208.97.132.208])
        by hapkido.dreamhost.com (Postfix) with ESMTP id 19D8182444
        for <git@vger.kernel.org>; Fri,  7 Apr 2017 19:15:55 -0700 (PDT)
Received: from homiemail-a60.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a60.g.dreamhost.com (Postfix) with ESMTP id A7E353BC073
        for <git@vger.kernel.org>; Fri,  7 Apr 2017 19:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=mattmccutchen.net; h=
        message-id:subject:from:to:date:content-type:mime-version:
        content-transfer-encoding; s=mattmccutchen.net; bh=DHfySJKwG+sIj
        tPJe9sXX5SyG44=; b=CWGglmyPilhNIQYgzEFlH0wj3bzUIlgxqBQPjMmTkoc7D
        4XoTzUf0KpgfYBIaINdYUzkDDPWOn40Inpc4/3nhuCy42Hulo54V7s5jgTIzYqfI
        uye6RPQ6eO91NXFX97rCTxRkapLyd7Jd/Wn9JZvdC44Km9cV67CgdI6qWh4V7U=
Received: from main (c-174-63-86-113.hsd1.ma.comcast.net [174.63.86.113])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: matt@mattmccutchen.net)
        by homiemail-a60.g.dreamhost.com (Postfix) with ESMTPSA id 5EC643BC071
        for <git@vger.kernel.org>; Fri,  7 Apr 2017 19:15:54 -0700 (PDT)
Message-ID: <1491617750.2149.10.camel@mattmccutchen.net>
Subject: Tools that do an automatic fetch defeat "git push
 --force-with-lease"
From:   Matt McCutchen <matt@mattmccutchen.net>
To:     git <git@vger.kernel.org>
Date:   Fri, 07 Apr 2017 22:15:50 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-2.fc25) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I'm rewriting history, "git push --force-with-lease" is a nice
safeguard compared to "git push --force", but it still assumes the
remote-tracking ref gives the old state the user wants to overwrite. 
Tools that do an implicit fetch, assuming it to be a safe operation,
may break this assumption.  In the worst case, Visual Studio Code does
an automatic fetch every 3 minutes by default [1], making
--force-with-lease pretty much reduce to --force.

For a safer workflow, "git push" would check against a separate "old"
ref that isn't updated by "git fetch", but is updated by "git push" the
same way the remote-tracking ref is and maybe also by commands that
update the local branch to take into account remote changes (I'm not
sure what reasonable scenarios there are, if any).  Has there been any
work on this?  I can write a wrapper script for the simple case of "git
push" of a single branch to the same branch on a remote, which is
pretty much all I use right now, but a native implementation would
support all of the command-line usage forms, which would be nice.

Thanks for reading!

[1]
https://github.com/Microsoft/vscode/blob/535a3de60023c81d75d0eac22044284f07dbcddf/extensions/git/src/autofetch.ts

Matt
