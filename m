From: Christoph Hellwig <hch@lst.de>
Subject: git-cvsimport fuzzy commit log matching?
Date: Tue, 23 Dec 2008 12:03:02 +0100
Message-ID: <20081223110302.GA9376@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 12:04:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF54M-0006yF-RV
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 12:04:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750811AbYLWLDI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 06:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750755AbYLWLDH
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 06:03:07 -0500
Received: from verein.lst.de ([213.95.11.210]:56903 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbYLWLDG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 06:03:06 -0500
Received: from verein.lst.de (localhost [127.0.0.1])
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id mBNB32IF009489
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 Dec 2008 12:03:03 +0100
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id mBNB32sv009487;
	Tue, 23 Dec 2008 12:03:02 +0100
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103808>

I'm currently trying to get clean git imports of the XFS userspace
repositories.  These are funky in the way they were initially kept in
ptools, and SGI-internal SCM that was built ontop of RCS which changeset
added ontop.  So we know that commits actually were done in atomic
changesets.  But ptools has the "nice" feature of allowing both per-file
and per-changeset commits.   Due to the per-file commits git-cvsimport
often misdetects a single changeset as multiple individual changes, ala:


commit 0d47d43b5878c6e7d7b516a793a82f0076d22089
Author: Barry Naujok <bnaujok@sgi.com>
Date:   Mon Jul 16 15:52:53 2007 +0000

    Perform parallel processing based on AG stride/concat unit
    Merge of master-melb:xfs-cmds:29143a by kenmcd.

      Queue up AGs per thread based on ag stride

commit 1fa4685db126fd3071e008a6d18f9d51209ab305
Author: Barry Naujok <bnaujok@sgi.com>
Date:   Mon Jul 16 15:52:53 2007 +0000

    Perform parallel processing based on AG stride/concat unit
    Merge of master-melb:xfs-cmds:29143a by kenmcd.

      Handle ag stride command line option and setup threads as required

commit a73288784e77c2411687f6778adb4c0b0f9dcdff
Author: Barry Naujok <bnaujok@sgi.com>
Date:   Mon Jul 16 15:52:53 2007 +0000

    Perform parallel processing based on AG stride/concat unit
    Merge of master-melb:xfs-cmds:29143a by kenmcd.

      Execute bits changed from x-- to ---
      Queue up AGs per thread based on ag stride

and so on.

Any idea how to tell git-cvsimport that if we have exactly the same
timestamp, and maybe the same author it really is the same changeset and
we want to merge the commit message?
