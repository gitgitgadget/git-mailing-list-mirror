Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32B2A1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 05:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933635AbeGDFxV (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 01:53:21 -0400
Received: from gproxy2-pub.mail.unifiedlayer.com ([69.89.18.3]:47401 "EHLO
        gproxy2-pub.mail.unifiedlayer.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932978AbeGDFxT (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 4 Jul 2018 01:53:19 -0400
X-Greylist: delayed 2367 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Jul 2018 01:53:19 EDT
Received: from cmgw14.unifiedlayer.com (unknown [10.9.0.14])
        by gproxy2.mail.unifiedlayer.com (Postfix) with ESMTP id E37D61E17B0
        for <git@vger.kernel.org>; Tue,  3 Jul 2018 23:12:14 -0600 (MDT)
Received: from box5008.bluehost.com ([50.116.64.19])
        by cmsmtp with ESMTP
        id aa5NfbKNz9wBZaa5NfBTjT; Tue, 03 Jul 2018 23:12:13 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=mad-scientist.us; s=default; h=Content-Transfer-Encoding:Mime-Version:
        Content-Type:Date:To:Reply-To:From:Subject:Message-ID:Sender:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vksx4tv97qDPDKF08CIDIlFYu2NSdGYyH6ijReLGRe0=; b=CHDWNxpqpsp3h2evkA5uAcm00q
        HmsjkoLdboeeMWWkGMm9L+NYjRZ5XEa9CY/Y1mmMEGm9mG/SHnWtk0+Dkc2erFhlzzgW1wwSjNpGm
        uIewK+oD1bb0r1Nuz7tk+WK8v;
Received: from pool-72-70-58-227.bstnma.fios.verizon.net ([72.70.58.227]:33766 helo=homebase.home)
        by box5008.bluehost.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <paul@mad-scientist.net>)
        id 1faa5O-0033hN-8M
        for git@vger.kernel.org; Tue, 03 Jul 2018 23:12:14 -0600
Message-ID: <97803ec8dae0a73bae301a37377b7b4a78f77e99.camel@mad-scientist.net>
Subject: Git 2.18: RUNTIME_PREFIX... is it working?
From:   Paul Smith <paul@mad-scientist.net>
Reply-To: paul@mad-scientist.net
To:     Git mailing list <git@vger.kernel.org>
Date:   Wed, 04 Jul 2018 01:12:13 -0400
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5008.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - mad-scientist.net
X-BWhitelist: no
X-Source-IP: 72.70.58.227
X-Source-L: No
X-Exim-ID: 1faa5O-0033hN-8M
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: pool-72-70-58-227.bstnma.fios.verizon.net (homebase.home) [72.70.58.227]:33766
X-Source-Auth: paul@mad-scientist.us
X-Email-Count: 1
X-Source-Cap: bWFkc2NpZTE7bWFkc2NpZTE7Ym94NTAwOC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was excited to see the RUNTIME_PREFIX for POSIX systems patchset go
by earlier this year.  Although I didn't see any mention of it being
included in the 2.18.0 release notes, it does appear that it was merged
in for this release.

Has anyone else tried to get it working?  It doesn't appear to be
working properly for me so I'm not sure if I'm supposed to be doing
something different... I didn't see any documentation on it.

Basically what happens is that I run configure with
--prefix=/my/install/path --with-gitconfig=etc/gitconfig
--with-gitattributes=etc/gitattributes.

Then I run make with RUNTIME_PREFIX=YesPlease.

When I look in the makefile, I see that the make variable gitexecdir is
initially properly set to libexec/git-core which is what I expect.

However, later in the makefile we include the config.mak.autogen file,
which was generated from config.mk.in by configure.  In the .in file we
have this:

 gitexecdir = @libexecdir@/git-core

After configure gets done with it, this becomes:

 gitexecdir = ${prefix}/libexec/git-core

which is a fully-qualified path.  This means that exec-cmd.c is
compiled with -DGIT_EXEC_PATH="/my/install/path/libexec/git-core" which
effectively disables RUNTIME_PREFIX, as the exec-cmd.c:system_prefix()
function always returns FALLBACK_RUNTIME_PREFIX since GIT_EXEC_PATH is
not a suffix of executable_dirname (once the install location has been
moved).

I suppose we need to pass more configure options to reset paths; is
there information somewhere on exactly which ones should be overridden?
 For example if I try to pass configure --libexecdir=libexec to solve
the above issue, I get an error from configure:

 configure: error: expected an absolute directory name for --libexecdir: libexec

Any info on how this is supposed to work, is welcome!
