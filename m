Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADB7C80D46
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7EAC24831
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728914AbfLMTUo convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 13 Dec 2019 14:20:44 -0500
Received: from wp156.webpack.hosteurope.de ([80.237.132.163]:55314 "EHLO
        wp156.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728833AbfLMTUo (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Dec 2019 14:20:44 -0500
Received: from app02-neu.ox.hosteurope.de ([92.51.170.136]); authenticated
        by wp156.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        id 1ifqUU-0005cC-Ow; Fri, 13 Dec 2019 20:20:42 +0100
Date:   Fri, 13 Dec 2019 20:20:42 +0100 (CET)
From:   Thomas Braun <thomas.braun@virtuell-zuhause.de>
To:     git@vger.kernel.org
Message-ID: <492636883.190386.1576264842701@ox.hosteurope.de>
Subject: Parallel fetch and commit graph writing results in locking failure
 (even on linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev64
X-Originating-Client: open-xchange-appsuite
X-bounce-key: webpack.hosteurope.de;thomas.braun@virtuell-zuhause.de;1576264844;32abd9ef;
X-HE-SMSGID: 1ifqUU-0005cC-Ow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

on git version da72936f (Git 2.24, 2019-11-04) and debian stretch I currently get every now and then the following error during fetching

$git fetch --all --jobs 12
Fordere an von origin
Fordere an von XXXX
Fordere an von YYYY
Fordere an von ZZZZ
Fordere an von EEEE
Von github.com:tango-controls/cppTango
   37cc52f8..4550a743  tango-9-lts -> origin/tango-9-lts
Commit-Graph Generierungsnummern berechnen: 100% (14/14), Fertig.
Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
fatal: Konnte '/home/firma/devel/cppTango/.git/objects/info/commit-graphs/commit-graph-chain.lock' nicht erstellen: Die Datei existiert bereits.

Ein anderer Git-Prozess scheint in diesem Repository ausgeführt
zu werden, zum Beispiel ein noch offener Editor von 'git commit'.
Bitte stellen Sie sicher, dass alle Prozesse beendet wurden und
versuchen Sie es erneut. Falls es immer noch fehlschlägt, könnte
ein früherer Git-Prozess in diesem Repository abgestürzt sein:
Löschen Sie die Datei manuell um fortzufahren.
Konnte 'myFork' nicht anfordern (Exit-Code: 128)
Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.
Commit-Graph Generierungsnummern berechnen: 100% (13/13), Fertig.

(Sorry for the german text, this is not easily reproducible.)
It complains that it could not create the lock file as it already exists.

I've set the following possible relevant settings:

[core]
  commitGraph = true

[fetch]
  prune = true
  writeCommitGraph = true

[protocol]
  version = 2

Anything obvious I'm doing wrong?

Thanks,
Thomas

PS: The error is also present on latest git for windows.
