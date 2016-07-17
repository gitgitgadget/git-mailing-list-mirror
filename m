Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD0111FEAA
	for <e@80x24.org>; Sun, 17 Jul 2016 02:56:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbcGQC4u (ORCPT <rfc822;e@80x24.org>);
	Sat, 16 Jul 2016 22:56:50 -0400
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:60388 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751871AbcGQC4u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2016 22:56:50 -0400
Received: from mfilter23-d.gandi.net (mfilter23-d.gandi.net [217.70.178.151])
	by relay5-d.mail.gandi.net (Postfix) with ESMTP id 3F05F41C080
	for <git@vger.kernel.org>; Sun, 17 Jul 2016 04:56:48 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter23-d.gandi.net
Received: from relay5-d.mail.gandi.net ([IPv6:::ffff:217.70.183.197])
	by mfilter23-d.gandi.net (mfilter23-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 2LOaB3djTOl9 for <git@vger.kernel.org>;
	Sun, 17 Jul 2016 04:56:46 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 4242C41C07D
	for <git@vger.kernel.org>; Sun, 17 Jul 2016 04:56:45 +0200 (CEST)
Date:	Sat, 16 Jul 2016 19:56:44 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	git@vger.kernel.org
Subject: format-patch with pager.format-patch=true gets very confused
Message-ID: <20160717025642.GA30640@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

git-config(1) documents the ability to enable or disable the pager (or
set a command-specific pager) for any command by setting
pager.<cmd>=true.  For most commands, this seems to work as expected.
However, setting pager.format-patch=true (or setting it to any specific
pager) breaks badly: the pager spawns, with no output in it, and the
pager doesn't respond to keystrokes (which makes it difficult to quit).

I think this may occur because format-patch's "reopen_stdout" interacts
badly with the pager.

I think it makes sense for "format-patch --stdout" to respect
pager.format-patch, but for format-patch *without* stdout to ignore
pager.* and *never* spawn a pager, given that its only output (the list
of patch files) goes to "realstdout".

- Josh Triplett
