Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 550842047F
	for <e@80x24.org>; Mon, 25 Sep 2017 00:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933363AbdIYA2L (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 20:28:11 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:36558 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933009AbdIYA2K (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 20:28:10 -0400
X-Greylist: delayed 1548 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Sep 2017 20:28:10 EDT
Received: from [173.231.109.82] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dwGqp-0000QQ-BJ
        for git@vger.kernel.org; Sun, 24 Sep 2017 20:02:20 -0400
Date:   Sun, 24 Sep 2017 20:02:13 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 173.231.109.82
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: BUG: merge -s theirs  is not in effect (does the same as -s ours)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

My interest was to get remote branch "merge" the changes in the branch taking
the branch's version (primarily alternative symlinks for git-annex'ed content)
over the version in master (previous merge of a similar branch).  Unfortunately
-s theirs seems to do actually -s ours -- symlinks and content is taken from
the 'ours' branch instead of theirs.  workaround -- perform -s ours of
master within the branch, and then ff of master to that state:

$> git --version                        
git version 2.14.1.729.g59c0ea183a

$> rm -rf /tmp/repo1; mkdir /tmp/repo1; cd /tmp/repo1; git init .; ln -s sym1 link; echo 1 > file; git add file link; git commit -m 'common'; git co -b b1 ; ln -sf b1link link; echo "b1 file" >| file; git commit -m 'b2 changes' -a; git co master; ln -sf masterlink link; echo "master file" >| file; git commit -m 'also modified in master' -a; git merge -s theirs --no-edit b1; ls -l link; cat file
E: could not determine git repository root
warning: templates not found /home/yoh/share/git-core/templates
Initialized empty Git repository in /tmp/repo1/.git/
[master (root-commit) b6a69d0] common
 2 files changed, 2 insertions(+)
 create mode 100644 file
 create mode 120000 link
Switched to a new branch 'b1'
[b1 739eb85] b2 changes
 2 files changed, 2 insertions(+), 2 deletions(-)
Switched to branch 'master'
[master 18a2da4] also modified in master
 2 files changed, 2 insertions(+), 2 deletions(-)
args: b6a69d0c0c2500530cba8bc2987a1f79998b5e74 -- HEAD 739eb853c480b729ec07da533610243e3a6d69ee
Merge made by the 'theirs' strategy.
lrwxrwxrwx 1 yoh yoh 10 Sep 24 19:58 link -> masterlink
master file


-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
