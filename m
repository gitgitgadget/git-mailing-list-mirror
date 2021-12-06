Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06E7C433EF
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 23:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343821AbhLFXOI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 18:14:08 -0500
Received: from elephants.elehost.com ([216.66.27.132]:38793 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231144AbhLFXOH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 18:14:07 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [99.229.22.139] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 1B6NAY7M034127
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 6 Dec 2021 18:10:35 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Cc:     <avarab@gmail.com>
Subject: [Question] Switching the URI from SSH to HTTPS for submodules
Date:   Mon, 6 Dec 2021 18:10:30 -0500
Organization: Nexbridge Inc.
Message-ID: <001501d7eaf6$79d8e170$6d8aa450$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: Adfq9nZW5y/XIEIUSFGp0TuHJuNDpQ==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the conversation at #git-devel Standup today.

We encountered the following situation. Our normal clone practice is to use
SSH URIs. So, the clone is straightforward with the main (8 year old) repo
of the style:

git@bitbucket.org:project/repo.git

with submodules referenced as:

git@bitbucket.org:project/module.git

When in SSH mode, clones are simple with --recurse-submodules doing what we
want. However, we had to clone on a system where SSH was locked down and we
could only use HTTPS. The form of the URIs changed rather radically:

https://user@bitbucket.org/project/repo.git

which caused the submodule clone not to work. Fortunately, the number of
submodules was low, so a manual edit of .gitmodules (with update-index
--assume-unchanged) and .git/modules and .git/config was not onerous.
However, we should be able to redirect the configuration without having to
do that. Our directory references are all relative to the main repo, so
those did not have to change. We still use SSH for most work with the repo
but needed to get source onto a test system for debugging. 

I would like to put together a best practice section in
Documentation/gitsubmodules.txt on the subject, but really don't think I did
this *temporary* change the most effective way. I'm looking for better
practices than I used - I'm sure there is at least one. There may be code
changes involved, particularly since .gitmodules is tracked and contains the
full URI (maybe it should not). One option we also explored was explicitly
specifying the URI for each submodule using set-url, which works but it
seems like there should be something in clone that redirects the part of the
URI relative to the main repo - although that would only work in the special
case where the submodules have the same host and project as the main repo.

-Randall

