Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0524C25B07
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 23:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239745AbiHDXAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 19:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233923AbiHDW75 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 18:59:57 -0400
Received: from smtp.onerussian.com (washoe.dartmouth.edu [129.170.30.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E04020A
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 15:59:03 -0700 (PDT)
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <yoh@onerussian.com>)
        id 1oJjnx-0001IV-0Q
        for git@vger.kernel.org; Thu, 04 Aug 2022 18:59:01 -0400
Date:   Thu, 4 Aug 2022 18:59:00 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <YuxPNFtTBmkZkiCW@lena.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: --batch or some --paths-file  for very long lists of paths
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Gurus,

In DataLad (https://datalad.org) we are doing "our own" analysis of what
specific files (not entire directories) should git and git-annex operate
on.  Obviously, in large repositories (and we have with >100k files)
that might require invoking  git add  or  git diff  etc with a long list
of paths specified in the command line.  For that we often split
invocation into multiple and even resort to   git commit --amend  to
combine multiple commits then into a single one.

But I wondered if may be there is already some trick to make such
commands as   status, diff, add, commit   to operate on arbitrarily long
list of paths passed to that git command somehow.

Note that gitglossary (at least in 2.35.1 git on debian) says that 

	Pathspecs are used on the command line of "git ls-files", "git
    ls-tree", "git add", "git grep", "git diff", "git checkout", and many other
    commands ...

but 

	$> git ls-tree -h | head -n1
	usage: git ls-tree [<options>] <tree-ish> [<path>...]

so it is <path> not the <pathspec> like (why in stderr this time?)

	$> git commit -h 2>&1 | head -n1
	usage: git commit [<options>] [--] <pathspec>...

So if in both cases it is pathspec, may be pathspec could support some
other magical keyword like :(filelist)/tmp/mylonglistofpaths ?

Thanks in advance for your time and thoughts,
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
WWW:   http://www.linkedin.com/in/yarik        

