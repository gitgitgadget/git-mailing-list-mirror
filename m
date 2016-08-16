Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1CE21F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753552AbcHPQTu (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:19:50 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48317 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbcHPQSp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:18:45 -0400
Received: from mfilter43-d.gandi.net (mfilter43-d.gandi.net [217.70.178.174])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id EC782A80C0
	for <git@vger.kernel.org>; Tue, 16 Aug 2016 18:18:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter43-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter43-d.gandi.net (mfilter43-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id I306vwLYKjG2 for <git@vger.kernel.org>;
	Tue, 16 Aug 2016 18:18:41 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 1B608A80CF
	for <git@vger.kernel.org>; Tue, 16 Aug 2016 18:18:40 +0200 (CEST)
Date:	Tue, 16 Aug 2016 09:18:39 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	git@vger.kernel.org
Subject: upload-pack/ls-remote: showing non-HEAD symbolic refs?
Message-ID: <20160816161838.klvjhhoxsftvkfmd@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.2-neo (2016-08-08)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Commit 5e7dcad771cb873e278a0571b46910d7c32e2f6c in September 2013 added
support to upload-pack to show the symbolic target of non-HEAD symbolic
refs.  However, commit d007dbf7d6d647dbcf0f357545f43f36dec46f3b in
November 2013 reverted that, because it used a capability to transmit
the information, and capabilities have a limited size (limited by the
pkt-line format which can't send lines longer than 64k) and can't
transmit an arbitrary number of symrefs.

(Incidentally, couldn't the same problem occur if the HEAD points to a
long enough path to exceed 64k?  Unlikely to arise in practice, but
theoretically possible for a constructed repository.  Not a major
problem at the moment, since send-pack doesn't seem to support
*sending* symbolic refs, but it would become a problem given any
mechanism to send symbolic refs to the server.)

I'd like to be able to see the targets of non-HEAD symbolic refs for a
repository (symbolic refs under refs/).  I'm interested in extending
upload-pack to expose those somehow.  What seems like a sensible format
to do so?

Would it make sense to advertise a new capability for symbolic ref
targets, which would allow the client to send back a dedicated request
for the targets of all symrefs?

- Josh Triplett
