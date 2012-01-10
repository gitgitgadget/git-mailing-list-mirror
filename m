From: Seth Robertson <in-gitvger@baka.org>
Subject: Re: rsync a *bunch* of git repos
Date: Tue, 10 Jan 2012 16:24:50 -0500
Message-ID: <201201102124.q0ALOowL026941@no.baka.org>
References: <20120110211548.GD10255@titan.lakedaemon.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Jason <git@lakedaemon.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 22:25:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkjBj-0001Gw-Lc
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 22:25:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756861Ab2AJVYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 16:24:54 -0500
Received: from tsutomu.baka.org ([66.114.72.182]:40733 "EHLO tsutomu.baka.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756734Ab2AJVYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 16:24:53 -0500
Received: from no.baka.org (no.baka.org [IPv6:2001:470:88bb::2])
	by tsutomu.baka.org (8.14.4/8.14.4) with ESMTP id q0ALOo7f008140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 10 Jan 2012 16:24:50 -0500
Received: from no.baka.org (localhost [127.0.0.1])
	by no.baka.org (8.14.4/8.14.0) with ESMTP id q0ALOowL026941;
	Tue, 10 Jan 2012 16:24:50 -0500
In-reply-to: <20120110211548.GD10255@titan.lakedaemon.net>
Comments: In reply to a message from "Jason <git@lakedaemon.net>" dated "Tue, 10 Jan 2012 16:15:48 -0500."
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188293>


In message <20120110211548.GD10255@titan.lakedaemon.net>, Jason writes:

    The nuts and bolts of this aren't difficult, the problem is I don't have
    a complete understanding of how git stores data.  I've heard in the
    past that it uses a lot of hardlinks and softlinks.  I need to make
    sure, that once I transfer the data, and reboot the machine with the new
    partition mounted under /home, that all my git repos will be okay.

Under most circumstances, git will do the right thing.  Only if you
use specific flags on clone (like --shared or --reference) might
something go wrong, and as the manual page explains, you can use
git-repack to undo these.

The real solution is, after you rsync, to:

for f in */.git; do (cd $f; git fsck >&/dev/null || echo "$f is BAD!!"); done

If you get no output, you should be golden.  If you get output, check
to make sure the repo you are copying from is good as well.

					-Seth Robertson
