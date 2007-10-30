From: Anton Korobeynikov <asl@math.spbu.ru>
Subject: Possible bug: git-svn leaves broken tree in case of error
Date: Tue, 30 Oct 2007 10:30:26 +0300
Organization: Saint Petersburg State University
Message-ID: <1193729426.30755.32.camel@asl.dorms.spbu.ru>
Reply-To: asl@math.spbu.ru
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 08:49:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImlrF-0002EQ-GM
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 08:49:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbXJ3Htl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 03:49:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbXJ3Htl
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 03:49:41 -0400
Received: from star.math.spbu.ru ([195.19.226.178]:4587 "EHLO
	star.math.spbu.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbXJ3Htk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 03:49:40 -0400
X-Greylist: delayed 534 seconds by postgrey-1.27 at vger.kernel.org; Tue, 30 Oct 2007 03:49:39 EDT
Received: from [195.19.254.136] (asl.dorms.spbu.ru [195.19.254.136])
	by star.math.spbu.ru (8.13.6/8.13.6) with ESMTP id l9U7eZRn036163
	for <git@vger.kernel.org>; Tue, 30 Oct 2007 10:40:37 +0300 (MSK)
X-Mailer: Evolution 2.12.1 
X-Virus-Scanned: ClamAV 0.88.7/4627/Tue Oct 30 08:09:53 2007 on star.math.spbu.ru
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.1.0 (2005-09-13) on star.math.spbu.ru
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello, Everyone.

I noticed this bug several times. Consider the following conditions are
met:
- We're syncing from svn using git-svn :)
- We have authors file provided
- We have a changeset with author unlisted in the authors file.

git-svn dies due to the following code:
sub check_author {
        my ($author) = @_;
        if (!defined $author || length $author == 0) {
                $author = '(no author)';
        }
        if (defined $::_authors && ! defined $::users{$author}) {
                die "Author: $author not defined in $::_authors file\n";
        }
        $author;
}

Unfortunately it leaves repository in some middle state: git-svn itself
thinks, that it synced with everything, but git itself doesn't "see" any
changesets anymore. I found no way to repair tree after such situation,
so I had to repull from scratch.

I found myself, that this should be warning (and fix in this case is
trivial), not error (maybe some commandline switch to control behaviour,
etc). It can be even error, but breaking tree is definitely bug in this
case.

Any thoughts?

-- 
With best regards, Anton Korobeynikov.

Faculty of Mathematics & Mechanics, Saint Petersburg State University.
