Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE0FC74A5B
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 22:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbjC2WMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjC2WMu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 18:12:50 -0400
X-Greylist: delayed 440 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Mar 2023 15:12:49 PDT
Received: from mailscanner.iro.umontreal.ca (mailscanner.iro.umontreal.ca [132.204.25.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4431FD8
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 15:12:49 -0700 (PDT)
Received: from pmg2.iro.umontreal.ca (localhost.localdomain [127.0.0.1])
        by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id C59EB80A14;
        Wed, 29 Mar 2023 18:05:27 -0400 (EDT)
Received: from mail01.iro.umontreal.ca (unknown [172.31.2.1])
        by pmg2.iro.umontreal.ca (Proxmox) with ESMTP id 68547805BE;
        Wed, 29 Mar 2023 18:05:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=iro.umontreal.ca;
        s=mail; t=1680127525;
        bh=uhg4+q5uS23WOKTLRX9bXr89jbNCQu/UECfSuiH+rQw=;
        h=From:To:Subject:Date:From;
        b=gbdReICXUs00PV/ZX6uD8LqDqniWpHLWknifonw5/wQ/VeB6fXWSnnyh6PLnxR9qW
         JLkjwH1qXEM6IxeRiLdcR10SCQUkmH0Qs6T9Mt2kJkcwAZKrc11WaqRxr7pzTF5ksq
         pSHpavKM/W1lyS4em22SUKY0nwAv2kmVjmBUUYBboYqoogY6OSaQHtho2FLiJjO/qD
         tNE8LFG3OslEEuzEISc2MKmYzjP2vOAE6WbKMUWgbql9WR5x+BfFrrzdH6t9zlnCzA
         /fbQLbUXwz2x4nezh354huOh1QYY1VIcjZdvSKCTS9Z0YxeB3xA+IdoDnZ753KV5XA
         VMUxOkNVR4lZA==
Received: from lechazo (lechon.iro.umontreal.ca [132.204.27.242])
        by mail01.iro.umontreal.ca (Postfix) with ESMTPSA id 4E2C81232F1;
        Wed, 29 Mar 2023 18:05:25 -0400 (EDT)
From:   Stefan Monnier <monnier@iro.umontreal.ca>
To:     git@vger.kernel.org
Subject: `git gc` says "unable to read" but `git fsck` happy
Message-ID: <jwvfs9nusjm.fsf-monnier+Inbox@gnu.org>
Date:   Wed, 29 Mar 2023 18:05:24 -0400
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's an example session:

    % LANG=C git fsck --strict; LANG=C git gc
    Checking object directories: 100% (256/256), done.
    error in tree 2699d230e3b592ae42506d7b5c969a7ac6a4593c: zeroPaddedFilemode: contains zero-padded file modes
    Checking objects: 100% (462555/462555), done.
    Verifying commits in commit graph: 100% (117904/117904), done.
    Enumerating objects: 462573, done.
    Counting objects: 100% (462573/462573), done.
    Delta compression using up to 8 threads
    Compressing objects: 100% (155363/155363), done.
    fatal: unable to read f5e44b38fc8f7e15e5e6718090d05b09912254fa
    fatal: failed to run repack
    %

How come it can't read `f5e44b38fc8f7e15e5e6718090d05b09912254fa` during
"repack" while `git fsck` says everything is fine?

More importantly: how do I diagnose this further and fix it?

Rumors on the net suggest that `git gc --aggressive` may circumvent this
problem occasionally, but those don't seem to know what they're talking
about, and in my case it didn't make any difference (except that it
takes more time :-).


        Stefan

