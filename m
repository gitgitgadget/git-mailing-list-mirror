Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEEF51F404
	for <e@80x24.org>; Thu, 25 Jan 2018 20:37:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeAYUhz (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 15:37:55 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:56879 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeAYUhy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 15:37:54 -0500
Received: from hopa.kiewit.dartmouth.edu ([129.170.31.166] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1eeoHQ-0005Eo-Pt
        for git@vger.kernel.org; Thu, 25 Jan 2018 15:37:53 -0500
Date:   Thu, 25 Jan 2018 15:37:47 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20180125203747.GI3658@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SA-Exim-Connect-IP: 129.170.31.166
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: please resolve a mystery for me: what is j-c-diff exactly? ;)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio et al,

j-c-diff is "used" in the docs within git, git-annex, and other places
discussing git.  But I failed to find it to seek for an ultimate prototypical
example of the diff command used by git ppl ;)

$> git log -Sj-c-diff -p Documentation/gitattributes.txt 
commit 2cc3167c688d1c91bc4cb9b1caa737b9d4971056
Author: Junio C Hamano <junkio@cox.net>
Date:   Mon Apr 23 00:21:02 2007 -0700

    Document "diff=driver" attribute
    
    Signed-off-by: Junio C Hamano <junkio@cox.net>

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 126871756d..d2edb9b14a 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -151,8 +151,34 @@ Unspecified::
        text, it is treated as text.  Otherwise it would
        generate `Binary files differ`.
 
-Any other value set to `diff` attribute is ignored and git acts
-as if the attribute is left unspecified.
+String::
+
+ Diff is shown using the specified custom diff driver.
+ The driver program is given its input using the same
+ calling convention as used for GIT_EXTERNAL_DIFF
+ program.
+
+
+Defining a custom diff driver
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The definition of a diff driver is done in `gitconfig`, not
+`gitattributes` file, so strictly speaking this manual page is a
+wrong place to talk about it.  However...
+
+To define a custom diff driver `jcdiff`, add a section to your
+`$GIT_DIR/config` file (or `$HOME/.gitconfig` file) like this:
+
+----------------------------------------------------------------
+[diff "jcdiff"]
+ command = j-c-diff
+----------------------------------------------------------------
+
+When git needs to show you a diff for the path with `diff`
+attribute set to `jcdiff`, it calls the command you specified
+with the above configuration, i.e. `j-c-diff`, with 7
+parameters, just like `GIT_EXTERNAL_DIFF` program is called.
+See gitlink:git[7] for details.

Cheers!
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
