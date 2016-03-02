From: Josh Triplett <josh@joshtriplett.org>
Subject: Resumable git clone?
Date: Tue, 1 Mar 2016 17:30:56 -0800
Message-ID: <20160302012922.GA17114@jtriplet-mobl2.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: sarah@thesharps.us, viro@zeniv.linux.org.uk
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 02 02:34:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aavgk-0005UB-DX
	for gcvg-git-2@plane.gmane.org; Wed, 02 Mar 2016 02:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753692AbcCBBel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 20:34:41 -0500
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:47568 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755883AbcCBBdw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 20:33:52 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id 06D1C47AC02
	for <git@vger.kernel.org>; Wed,  2 Mar 2016 02:31:02 +0100 (CET)
Received: from mfilter19-d.gandi.net (mfilter19-d.gandi.net [217.70.178.147])
	by relay6-d.mail.gandi.net (Postfix) with ESMTP id 345A2FB89E;
	Wed,  2 Mar 2016 02:31:01 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter19-d.gandi.net
Received: from relay6-d.mail.gandi.net ([IPv6:::ffff:217.70.183.198])
	by mfilter19-d.gandi.net (mfilter19-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 7_3j81nmjqMp; Wed,  2 Mar 2016 02:30:59 +0100 (CET)
X-Originating-IP: 173.246.103.110
Received: from jtriplet-mobl2.jf.intel.com (joshtriplett.org [173.246.103.110])
	(Authenticated sender: josh@joshtriplett.org)
	by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id AE4A6FB86D;
	Wed,  2 Mar 2016 02:30:58 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288088>

If you clone a repository, and the connection drops, the next attempt
will have to start from scratch.  This can add significant time and
expense if you're on a low-bandwidth or metered connection trying to
clone something like Linux.

Would it be possible to make git clone resumable after a partial clone?
(And, ideally, to make that the default?)

In a discussion elsewhere, Al Viro suggested taking the partial pack
received so far, repairing any truncation, indexing the objects it
contains, and then re-running clone and not having to fetch those
objects.  This may also require extending receive-pack's protocol for
determining objects the recipient already has, as the partial pack may
not have a consistent set of reachable objects.

Before starting down the path of developing patches for this, does the
approach seem potentially reasonable?

- Josh Triplett
