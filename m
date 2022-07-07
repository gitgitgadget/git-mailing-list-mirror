Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA02C43334
	for <git@archiver.kernel.org>; Thu,  7 Jul 2022 16:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235607AbiGGQew (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jul 2022 12:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbiGGQev (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jul 2022 12:34:51 -0400
X-Greylist: delayed 2298 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Jul 2022 09:34:47 PDT
Received: from smtp.onerussian.com (washoe.dartmouth.edu [129.170.30.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C5B2D1F0
        for <git@vger.kernel.org>; Thu,  7 Jul 2022 09:34:47 -0700 (PDT)
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <yoh@onerussian.com>)
        id 1o9Tre-0008FU-Pk
        for git@vger.kernel.org; Thu, 07 Jul 2022 11:56:26 -0400
Date:   Thu, 7 Jul 2022 11:56:26 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <YscCKuoDPBbs4iPX@lena.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: --git-dir= leads to "The empty string is not a valid path" only some
 times
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Gurus,

The original reported issue possibly with more details:
https://github.com/datalad/datalad/issues/6815

Background: in DataLad we specify empty value for --git-dir in

    git --git-dir= config -z -l --show-origin

call to ensure that we are not picking up any local repository
configurations if called while being under some repo.  It had been
working just fine for years until today user reported that such call
errors out with

	$> git --git-dir= config -z -l --show-origin > /dev/null
	fatal: The empty string is not a valid path

because of having 

	[includeIf "gitdir:**/devbgc/**"]
		path = ~/.gitconfig_bgc

in user's ~/.gitconfig (I have reproduced with git  2.35.1).

Note: specifying some non-empty path pointing to some non-existing path (e.g.
--git-dir=/non-existing) does not cause error.

- should not git behavior on --git-dir  be consistent regardless of the content
of ~/.gitconfig ?

- is use --git-dir= generally legit (seems not documented)?  If not -- why it
is not whenever pointing to non-existing directory is?

- what is a more "legit" way to achieve "do not load local repository
config if under a git repository path"?

Thank you in advance for the clarifications,
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
WWW:   http://www.linkedin.com/in/yarik        

