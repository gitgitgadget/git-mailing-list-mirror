Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,URIBL_RED
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 652961FE4E
	for <e@80x24.org>; Sun, 10 Jul 2016 00:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbcGJAsP (ORCPT <rfc822;e@80x24.org>);
	Sat, 9 Jul 2016 20:48:15 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:42496 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756765AbcGJAsO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Jul 2016 20:48:14 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438691FE4E;
	Sun, 10 Jul 2016 00:48:13 +0000 (UTC)
Date:	Sun, 10 Jul 2016 00:48:13 +0000
From:	Eric Wong <e@80x24.org>
To:	git@vger.kernel.org
Subject: [ANNOUNCE] more archives of this list
Message-ID: <20160710004813.GA20210@dcvr.yhbt.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Very much a work-in-progress, but NNTP and HTTP/HTTPS sorta work
based on stuff that is on gmane and stuff I'm accumulating by
being a subscriber.

The first two Tor hidden service onions are actually on better
hardware than the non-hidden public-inbox.org one:

nntp://hjrcffqmbrq6wope.onion/inbox.comp.version-control.git
nntp://czquwvybam4bgbro.onion/inbox.comp.version-control.git
nntp://ou63pmih66umazou.onion/inbox.comp.version-control.git
nntp://news.public-inbox.org/inbox.comp.version-control.git

http://czquwvybam4bgbro.onion/git
http://hjrcffqmbrq6wope.onion/git
http://ou63pmih66umazou.onion/git
https://public-inbox.org/git/

HTTP URLs are clonable, but I've generated the following fast-export dump:

	https://public-inbox.org/.temp/git.vger.kernel.org-6c38c917e55c.gz
	(362M)

	git init --bare mirror.git
	curl $FAST_EXPORT_GZ_URL | git --git-dir=mirror.git fast-import
	git --git-dir=mirror.git remote add --mirror=fetch origin $URL

I recommend bare repos for importing, since the trees consist of
2/38 SHA-1 paths of Message-IDs and there's nearly 300K messages.

In contrast, bundles and packs delta poorly and only get down
around 750-800M with aggressive packing
(And I haven't done that in a while.)


Code is AGPL-3.0+: git clone https://public-inbox.org/


Additional mirrors or forks (perhaps different UIs) are very welcome,
as I expect none of my servers or network connections to be reliable.


I have the "public-inbox-watch" command running in screen
watching my Maildirs, it uses a config file which is parseable/writable
using git-config:

==> ~/.public-inbox/config <==
[publicinboxlearn]
	; spam gets moved here for auto-removal:
	watchspam = maildir:/path/to/maildirs/.INBOX.spam
[publicinboxwatch]
	; optional, adds some additional spam checking
	spamcheck = spamc
[publicinbox "git"]
	; git repo for this list
	mainrepo = /path/to/mirror.git

	; this removes the list footer signature:
	filter = PublicInbox::Filter::Vger

	; this is where my git-related mail goes (some of it is from Debian)
	watch = maildir:/path/to/maildirs/.INBOX.git

	; only match messages with the correct List-Id header:
	watchheader = List-Id:<git.vger.kernel.org>

	; next 4 lines are only necessary for HTTP and NNTP servers
	address = git@vger.kernel.org
	url = http://ou63pmih66umazou.onion/git
	newsgroup = inbox.comp.version-control.git
	infourl = http://vger.kernel.org/majordomo-info.html
