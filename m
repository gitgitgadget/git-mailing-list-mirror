Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75B2B1FD99
	for <e@80x24.org>; Sat, 20 Aug 2016 22:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751584AbcHTWuW (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 Aug 2016 18:50:22 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:37309 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751222AbcHTWuW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Aug 2016 18:50:22 -0400
Received: from mfilter17-d.gandi.net (mfilter17-d.gandi.net [217.70.178.145])
        by relay6-d.mail.gandi.net (Postfix) with ESMTP id 4EC25FB88B
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 00:50:19 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter17-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
        by mfilter17-d.gandi.net (mfilter17-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id M5aT_coN1iLn for <git@vger.kernel.org>;
        Sun, 21 Aug 2016 00:50:17 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 75FB0FB882
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 00:50:17 +0200 (CEST)
Date:   Sat, 20 Aug 2016 15:50:15 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
Subject: Extending "extended SHA1" syntax to traverse through gitlinks?
Message-ID: <20160820225013.l7ynru7hzcmrzff7@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, if you have a branch "somebranch" that contains a gitlink
"somecommit", you can write "somebranch:somecommit" to refer to the
commit, just like a tree or blob.  ("man git-rev-parse" defines this
syntax in the "SPECIFYING REVISIONS" section.)  You can use this
anywhere you can use a committish, including "git show
somebranch:somecommit", "git log somebranch:somecommit..anotherbranch",
or even "git format-patch -1 somebranch:somecommit".

However, you cannot traverse *through* the gitlink to look at files
inside its own tree, or to look at other commits relative to that
commit.  For instance, "somebranch:somecommit:somefile" and
"somebranch:somecommit~3" do not work.

I'd love to have a syntax that allows traversing through the gitlink to
other files or commits.  Ideally, I'd suggest the syntax above, as a
natural extension of the existing extended syntax.

(That syntax would potentially introduce ambiguity if you had a file
named "somecommit:somefile" or "somecommit~3".  That doesn't seem like a
problem, though; the existing syntax already doesn't support accessing a
file named "x..y" or "x...y", so scripts already can't expect to access
arbitrary filenames with that syntax without some kind of quoting, wich
we also don't have.)

Does this seem reasonable?  Would a patch introducing such syntax
(including documentation and tests) be acceptable?

- Josh Triplett
