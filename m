Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9377C1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 21:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757856AbcG1VL7 (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 17:11:59 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:57108 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438AbcG1VL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 17:11:58 -0400
Received: from mfilter25-d.gandi.net (mfilter25-d.gandi.net [217.70.178.153])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 6E5DEA80C6;
	Thu, 28 Jul 2016 23:11:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter25-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
	by mfilter25-d.gandi.net (mfilter25-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id N61U9ICFLrwx; Thu, 28 Jul 2016 23:11:54 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 40DFBA80D9;
	Thu, 28 Jul 2016 23:11:52 +0200 (CEST)
Date:	Thu, 28 Jul 2016 14:11:51 -0700
From:	Josh Triplett <josh@joshtriplett.org>
To:	git@vger.kernel.org
Subject: [RFC] git-format-patch: default to --from to avoid spoofed mails?
Message-ID: <20160728211149.GA371@x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When git-format-patch formats a patch authored by someone other than
yourself, it defaults to filling in the "From:" field of the email from
the commit author.  If you explicitly pass the --from option,
git-format-patch will instead use your own committer identity as the
"From:", and then put a "From:" line at the top of the body if the
commit author differs.  (git-am know to use that as the commit author
when applying.)

While git-send-email knows how to change the patch mails to use your own
address as "From:" and add a "From:" line to the body for the author,
any other tool used to send emails doesn't do that.  I've seen more than
a few mails sent to various mailing lists and patch review tools with a
spoofed "From:" field pointing to the commit author, typically without
the knowledge of the author, which can lead to interesting surprises.

I'd like to propose changing the default behavior of git-format-patch to
--from (and adding a --from-author option to override, and perhaps a
config setting).  This will not change the output *except* when
formatting patches authored by someone else.  git-am and git-send-email
both handle the --from format without any issues.

Before I write such a patch: does anyone see a problem with such a
change?

- Josh Triplett
