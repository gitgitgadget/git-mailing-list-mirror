Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A99C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 18:14:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiCLSPT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 13:15:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiCLSPS (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 13:15:18 -0500
X-Greylist: delayed 405 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Mar 2022 10:14:09 PST
Received: from relay5.hostedemail.com (relay5.hostedemail.com [64.99.140.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 022DE1E523B
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 10:14:04 -0800 (PST)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 1CC54BD4
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 18:07:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: seanm@seanm.ca) by omf02.hostedemail.com (Postfix) with ESMTPA id 961F880011
        for <git@vger.kernel.org>; Sat, 12 Mar 2022 18:07:23 +0000 (UTC)
Date:   Sat, 12 Mar 2022 13:07:12 -0500
From:   Sean MacLennan <seanm@seanm.ca>
To:     git@vger.kernel.org
Subject: Request: a way to ignore .gitattributes
Message-ID: <20220312130712.6d9d2d00@zonker.seanm.ca>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-slackware-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 3o1jm3f597opu5znegqr8e8si85zyemi
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 961F880011
X-Session-Marker: 7365616E6D407365616E6D2E6361
X-Session-ID: U2FsdGVkX18psTwjOXgbPe4LZJo+I5nlUWpMgjALeLA=
X-HE-Tag: 1647108443-432775
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

We have a git repo that is a mirror of an svn repo. The tools create a
huge .gitattribute file that is about 83,000 entries. Almost all are of
the form: <path> -text

This file kills git grep. A grep that takes <1s without the file takes
almost 2 minutes with the file. So git grep it unusable.

My current solution is to rename the file:

-#define GITATTRIBUTES_FILE ".gitattributes"
+#define GITATTRIBUTES_FILE ".gitattributes-no"

But I would like a cleaner solution so I don't have to maintain my own
git.

My request is more for what would be the best gitish way to solve this;
I am willing to do the actual patch.

This needs to be something in the local config and not global. My
current thoughts are:

1) A way to override the default name (much like I do now):
   gitattributesfile = .gitattributes-no

2) A flag variable:
   gitattributes = ignore
        or
   ignoreattributes = true

I personally like 1) because it would also work for the case where you
want to override a bad .gitattributes file (that you have no control
over) with a good .gitattributes file. I just think it would be more
generally useful.

But I would like to pick a solution that is most likely to get
accepted.

Cheers,
   Sean MacLennan
