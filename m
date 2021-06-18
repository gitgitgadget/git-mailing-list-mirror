Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1640C2B9F4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 02:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE29E6135C
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 02:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbhFRCgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 22:36:51 -0400
Received: from beige.elm.relay.mailchannels.net ([23.83.212.16]:44797 "EHLO
        beige.elm.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231289AbhFRCgv (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 17 Jun 2021 22:36:51 -0400
X-Sender-Id: dreamhost|x-authsender|tessa@assorted.tech
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 038121220DE
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 02:34:42 +0000 (UTC)
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (100-96-18-93.trex.outbound.svc.cluster.local [100.96.18.93])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 7DC7B122B2F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 02:34:41 +0000 (UTC)
X-Sender-Id: dreamhost|x-authsender|tessa@assorted.tech
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.96.18.93 (trex/6.3.3);
        Fri, 18 Jun 2021 02:34:41 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|tessa@assorted.tech
X-MailChannels-Auth-Id: dreamhost
X-Obese-Cold: 4b05da3870a9c219_1623983681742_1698567454
X-MC-Loop-Signature: 1623983681742:76205828
X-MC-Ingress-Time: 1623983681741
Received: from pdx1-sub0-mail-a13.g.dreamhost.com (localhost [127.0.0.1])
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTP id 3A0C8806B1
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 02:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=assorted.tech; h=date:from
        :subject:to:message-id:mime-version:content-type; s=
        assorted.tech; bh=bRi3NHeZcwAIfnxGpFW0yxZwzFs=; b=1mfe4r2CfeGHgK
        +ZDG+1igex441/z/hOsKuNFgu76RYXmYTlyB7vfvLhThAvIAtt5WdL6V03ASU2vG
        Xbc95rPvLjHpIuhrIwWrq3ctWyIpUP9oQgvEB8FP9vxdNX0zN6y8tbYEVZMUP7cz
        f25fOwDkLyZptfv4EHKPV4bbloyBY=
Received: from [192.168.88.198] (scio-198-15-3-17.static.smt-net.com [198.15.3.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tessa@assorted.tech)
        by pdx1-sub0-mail-a13.g.dreamhost.com (Postfix) with ESMTPSA id 290028044B
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 02:34:40 +0000 (UTC)
Date:   Thu, 17 Jun 2021 19:34:40 -0700
X-DH-BACKEND: pdx1-sub0-mail-a13
From:   "Tessa L. H. Lovelace" <tessa@assorted.tech>
Subject: Using .gitignore symbolic links?
To:     git@vger.kernel.org
Message-Id: <1623983680.3494.0@smtp.dreamhost.com>
X-Mailer: pantheon-mail/1.0.8
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The recent release candidate of Git (v2.32.0) hit my OS this week, and 
it included a line () on symbolic links for several specific files are 
now ignored.

Thank you for putting the changelogs in an accessible location, knowing 
that this was a known breaking change was useful in debugging why my 
workflows stopped working.

I have two concerns.

First, the error thrown is

 > "warning: unable to access '.gitignore': Too many levels of symbolic 
links",

,,,which does not accurately represent what is happening.

I spent a bit of time convinced that I'd broken something with the 
symbolic links during setup, and an error such as "symbolic linking no 
longer allowed for 'filename'." would make more sense, given the change 
under discussion eliminates *any* use of symbolic links.


Secondly, and more personally important to me, a system administrator:
My repositories use symbolic links to allow a single .gitignore file to 
define my folder structure, allowing me to avoid hardcoding the 
repo-specific folder paths into my configs.

Is there a flag to disable this new behavior?

If not, this change means I need to update dozens of files, duplicates 
all, or completely rewrite my .gitignore files to have shyteloads of 
arbitrary file paths in them, which I'd rather not do.

Also, is there a justification for forcing this as the on-update 
default new behavior, when a user-querying behavior (such as with 'git 
pull' defaults as they've changed recently) exists?

---

ref 
https://github.com/git/git/commit/142430338477d9d1bb25be66267225fb58498d92#diff-eae5facd145e2748250f7b275e45cb001c0b8e2c47c529a4e28bbfa208e5fb59R7


===


Thoughts?

-- 
Tessa L. H. Lovelace
----
office:		503.893.9709
consulting:	assorted.tech

