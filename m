Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACBCC1F404
	for <e@80x24.org>; Thu, 14 Dec 2017 13:28:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752479AbdLNN2P (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Dec 2017 08:28:15 -0500
Received: from quechua.inka.de ([193.197.184.2]:34694 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752228AbdLNN2O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Dec 2017 08:28:14 -0500
X-Greylist: delayed 1084 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2017 08:28:14 EST
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1ePTH7-0004x7-Lb; Thu, 14 Dec 2017 14:10:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id DAFC1120182; Thu, 14 Dec 2017 14:09:33 +0100 (CET)
Date:   Thu, 14 Dec 2017 14:09:33 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Need help migrating workflow from svn to git.
Message-ID: <20171214130933.GA18542@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello folks,

I am wondering whether/how my mode of work for a specific project
(currently based on SVN) could be transferred to git.

I have a repository for maintaining configuration of hosts. This repository
contains several hundered scripts. Most of those scripts are don't depend on
each other.

Every machine has a working copy of the repository in a specific
directory. A cron job (running every 15 minutes) executes "svn update" and
executes the scripts which are contained in this working copy.

This way, I can commit changes to the main repository and all the hosts
will "download" and adopt by executing the newest revision of those
scripts. (The scripts need to be idempotent, but this is a different
topic).

NORMALLY, there are no local modifications in the working copy. Thus,
conflicts can not happen. Everything works fine.

Sometimes, I need to fix a problem on some host or need to implement a new
feature. For this, I go to the working copy of a host where the change
needs to be done and start haking. With svn, I don't need to stop the cron
job. "svn update" will happily merge any in-coming changes and leave alone
the files which were not modified upstream. Conflicts with my local
modifications which I am currently hacking on are extremely rare, because
the scripts are pretty much independent. So I'm pretty much happy with this
mode of operation.

With git, by contrast, this won't work. Git will refuse to pull anything as
long as there are ANY local modifications. The cron job would need to

   git stash
   git pull
   git stash pop

But this will temporarily remove my local modifications. If I happen to do
a test run at this time, the test run would NOT contain the local
modifications which I was about to test. Even worse: if I happen to save
one of the modified files while the modifications are in the stash, the
"git stash pop" will definitely cause a conflict, although nothing really
changed.

So, how would I get this workflow with git? Is it possible to emulate the
behavior of "svn update"?

Any ideas?

-- 
Josef Wolf
jw@raven.inka.de
