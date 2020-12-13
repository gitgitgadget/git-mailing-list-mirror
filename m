Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD7CC4361B
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 01:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFE922AEC
	for <git@archiver.kernel.org>; Sun, 13 Dec 2020 01:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390939AbgLMBKQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Dec 2020 20:10:16 -0500
Received: from injection.crustytoothpaste.net ([192.241.140.119]:59318 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgLMBKQ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 12 Dec 2020 20:10:16 -0500
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id BE37860769
        for <git@vger.kernel.org>; Sun, 13 Dec 2020 01:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1607821745;
        bh=h8LvH2246cp+NNm3rM4BehuSR7DuJXRDgUrNabKN5sY=;
        h=From:To:Subject:Date:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=t3FfH516BzAe3DhMQRZ2G6pqILOMt2yfxzijvfxbyiLSdNfW1gWQ17AjWomb8GRHw
         MzKbwYfF549XRYD8g+ft08qhuJoKGV0r27NDEb+t9Lhk5sOmCucWZdPeGFeDmHmquL
         HfVfMk40qGObp/o/BgKp1Ajh81XNeC0be5JFTelfxlOZ+CWnoLfQpkHSqF+ktdjF81
         yGhXi5B1UiLer3jVdZSQqUYZV4JB5IOFwwJRvnPL/izTGA8iaYqqx1duRgIHyDteNr
         KYA5nietO5NAUabAaYDERpurFgsSBPkcJEWrdTGHYY0vGfM25koTU10WHafKjsXC8M
         WbNzDtF1Dkty5fNdDLPUdwAY6tO0Wc2d5+xpx1w2gDICBoYlXC1jQEtuxWVw1x+kBr
         6H2jtEb0cWUOODtCS1zQHn09llMJ08QlOvnUXVhfVEpL2Zsv7ijioEwgBnbl6v+azb
         Y4pgs0ikwdhTF6fRkKdOaDj0x5DYF+453SQlf170NO84umaOXo/
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Subject: [PATCH 0/1] Hashed mailmap support
Date:   Sun, 13 Dec 2020 01:05:38 +0000
Message-Id: <20201213010539.544101-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many people, through the course of their lives, will change either a
name or an email address.  For this reason, we have the mailmap, to map
from a user's former name or email address to their current, canonical
forms.  Normally, this works well as it is.

However, sometimes people change a name (or an email) and want to
completely cease use of the former name or email.  This could be because
a transgender person has transitioned, because a person has left an
abusive partner or broken ties with an abusive family member, or for any
other number of good and valuable reasons.  In these cases, placing the
former name in the .mailmap may be undesirable.

For those situations, let's introduce a hashed mailmap, where the user's
former name or email address can be in the form @sha256:<hash>.  This
obscures the former name or email.

Note that this is not perfect, because a user can simply look up all the
hashed values and find out the old values.  However, for projects which
wish to adopt the feature, it can be somewhat effective to hash all
existing mailmap entries and include some no-op entries from other
contributors as well, so as to make this process less convenient.

I've spoken to a variety of folks about this, and while we all agree
this design isn't perfect, it is an improvement over the status quo.  It
is obfuscation, not security, and in this case, I think that's fine.
I'm open to hearing ideas about how to improve this design if there are
any.

I welcome feedback on this patch, while encouraging people to be mindful
of our code of conduct.

brian m. carlson (1):
  mailmap: support hashed entries in mailmaps

 mailmap.c          | 39 +++++++++++++++++++++++++++++++++++++--
 t/t4203-mailmap.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+), 2 deletions(-)

