From: John Keeping <john@keeping.me.uk>
Subject: git-cvsimport-3 and incremental imports
Date: Sun, 20 Jan 2013 20:09:22 +0000
Message-ID: <20130120200922.GC7498@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Eric S. Raymond" <esr@thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 20 21:09:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tx1DH-00062I-Kp
	for gcvg-git-2@plane.gmane.org; Sun, 20 Jan 2013 21:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab3ATUJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jan 2013 15:09:30 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:60074 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab3ATUJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jan 2013 15:09:29 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 1322E866002;
	Sun, 20 Jan 2013 20:09:29 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3wsSVQa-IJ+6; Sun, 20 Jan 2013 20:09:28 +0000 (GMT)
Received: from aardwolf.aluminati.org (aardwolf.aluminati.org [10.0.7.189])
	by jackal.aluminati.org (Postfix) with ESMTP id 408C0866008;
	Sun, 20 Jan 2013 20:09:27 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by aardwolf.aluminati.org (Postfix) with ESMTP id D1AFC276DFF;
	Sun, 20 Jan 2013 20:09:27 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from aardwolf.aluminati.org ([127.0.0.1])
	by localhost (aardwolf.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id a3VuyDpg-uH3; Sun, 20 Jan 2013 20:09:27 +0000 (GMT)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by aardwolf.aluminati.org (Postfix) with ESMTPSA id D2FDE276DFD;
	Sun, 20 Jan 2013 20:09:24 +0000 (GMT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214043>

I've now spent some time looking at git-cvsimport-3.py from
jc/cvsimport-upgrade and made some progress in making it pass more of
the Git test suite (my work in progress is at [1]).

However, I think there is a fundamental problem with the way it handles
incremental imports and I'm hoping someone with more git-fast-import
experience can point me in the right direction.

Currently, cvsps-3 never writes a "from ..." line in the first commit it
outputs for a branch, even when the output is restricted by date (i.e. a
continuation of a previously imported branch), which results in failure
to update branches since git-fast-import is run without "--force".  If I
make a simple modification so that it does this, it can end up
outputting an empty commit (a duplicate of the current tip commit on the
branch).

Given that the start date for the import is currently just read from
HEAD there is probably scope for this being worse on other branches if
they have more recent commits than the current branch.

I don't think there is any way to solve this without giving cvsps more
information, probably the last commit time for all git branches, but
perhaps I'm missing a fast-import feature that can help solve this
problem.


[1] https://github.com/johnkeeping/git/tree/cvsimport-3


John
