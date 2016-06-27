Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EAB72018A
	for <e@80x24.org>; Mon, 27 Jun 2016 14:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbcF0OkM (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 10:40:12 -0400
Received: from plane.gmane.org ([80.91.229.3]:51956 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751655AbcF0OkL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 10:40:11 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1bHXhk-0000Qr-CH
	for git@vger.kernel.org; Mon, 27 Jun 2016 16:40:04 +0200
Received: from cpe-67-250-52-183.nyc.res.rr.com ([67.250.52.183])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 16:40:04 +0200
Received: from ourobourbon by cpe-67-250-52-183.nyc.res.rr.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 16:40:04 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:	git@vger.kernel.org
From:	Greg Werbin <ourobourbon@gmail.com>
Subject: Segfault during a big messy rebase
Date:	Mon, 27 Jun 2016 06:51:26 +0000 (UTC)
Message-ID: <loom.20160627T084323-107@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 67.250.52.183 (Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

I was in the middle of a big messy rebase when the following
happened:

$ git rebase --continue
/usr/local/Cellar/git/2.9.0/libexec/git-core/git-rebase--interactive:
line 238: 60305 
Segmentation fault: 11  "$@"
Could not commit staged changes.

And then I tried:

$ git rebase --abort
fatal: Unable to create '/Users/greg/my-project/.git/MERGE_RR.lock':
File exists.

Another git process seems to be running in this repository, e.g.
an editor opened by 'git commit'. Please make sure all processes
are terminated then try again. If it still fails, a git process
may have crashed in this repository earlier:
remove the file manually to continue.

Then I ran:

$ rm .git/MERGE_RR.lock
$ git rebase --abort
No rebase in progress?

Which left the branch in a kind of half-rebased limbo, and my only option
was to put it out of its misery and delete it. Fortunately I had backed up
my work to a different branch, so recovery was not a problem.

I don't know where to look inside Git for diagnostic logs; let me know if there's
anything I can add to help track down the issue.

