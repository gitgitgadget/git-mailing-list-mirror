Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01AD2047F
	for <e@80x24.org>; Mon, 25 Sep 2017 03:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932076AbdIYDSC (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Sep 2017 23:18:02 -0400
Received: from washoe.dartmouth.edu ([129.170.30.229]:43790 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbdIYDSB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Sep 2017 23:18:01 -0400
Received: from [173.231.109.82] (helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:RSA_AES_256_CBC_SHA1:256)
        (Exim 4.80)
        (envelope-from <yoh@onerussian.com>)
        id 1dwJuA-0004Bm-3i
        for git@vger.kernel.org; Sun, 24 Sep 2017 23:18:00 -0400
Date:   Sun, 24 Sep 2017 23:17:51 -0400
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Message-ID: <20170925031751.lg7zk6krt65dxwas@hopa.kiewit.dartmouth.edu>
References: <20170925000213.rilmsczdbi3jqkta@hopa.kiewit.dartmouth.edu>
 <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwp4nfuv1.fsf@gitster.mtv.corp.google.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 173.231.109.82
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: BUG: merge -s theirs  is not in effect (does the same as -s ours)
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, 25 Sep 2017, Junio C Hamano wrote:

> Yaroslav Halchenko <yoh@onerussian.com> writes:

> > My interest was to get remote branch "merge" the changes in the
> > branch taking the branch's version (primarily alternative symlinks
> > for git-annex'ed content) over the version in master (previous
> > merge of a similar branch).  Unfortunately -s theirs seems to do
> > actually -s ours

> What does

>     ls $(git --exec-path) | grep git-merge

NB when running git just built, --exec-path reports some non existing dir
in ~:

$> git --exec-path 
/home/yoh/libexec/git-core
$> ls -l /home/yoh/libexec/git-core
ls: cannot access '/home/yoh/libexec/git-core': No such file or directory
$> which git
/home/yoh/proj/misc/git/git

> say?  

> The official Git never shipped "git-merge-theirs" as far as I know,
> and it should not exist (neither should "git merge -s theirs"; you
> can use "git reset --hard theirs" instead).

d'oh, indeed there is no git-merge-theirs  neither in debian pkg or a freshly
built git  and I found a rogue script in the PATH (which did nothing
apparently, sorry!). BUT I was originally mislead by the --help/manpage:


MERGE STRATEGIES
       The merge mechanism (git merge and git pull commands) allows the backend merge strategies to be chosen with -s option. Some strategies can also take their own options, which can be passed by giving -X<option>
       arguments to git merge and/or git pull.
       ...
       recursive
           This can only resolve two heads using a 3-way merge algorithm. When there is more than one common ancestor that can be used for 3-way merge, it creates a merged tree of the common ancestors and uses that as
           the reference tree for the 3-way merge. This has been reported to result in fewer merge conflicts without causing mismerges by tests done on actual merge commits taken from Linux 2.6 kernel development
           history. Additionally this can detect and handle merges involving renames. This is the default merge strategy when pulling or merging one branch.

           The recursive strategy can take the following options:

           ours
               This option forces conflicting hunks to be auto-resolved cleanly by favoring our version. ...
           theirs
               This is the opposite of ours.


(Documentation/merge-strategies.txt in the sources I guess)

PS thanks for CCing me in replies!
-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
