From: "Donald Munro" <donaldmunro@gmail.com>
Subject: git-cvsserver and change=T
Date: Wed, 8 Aug 2007 16:45:44 +0200
Message-ID: <89ede7e0708080745y17770fetd6b7e960b0485706@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 08 16:45:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IImnG-0001j4-Af
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 16:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbXHHOpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 10:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751612AbXHHOpq
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 10:45:46 -0400
Received: from an-out-0708.google.com ([209.85.132.250]:42559 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751825AbXHHOpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 10:45:45 -0400
Received: by an-out-0708.google.com with SMTP id d31so33206and
        for <git@vger.kernel.org>; Wed, 08 Aug 2007 07:45:44 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=t5eHCaudCN+Nl+53J9ABuS6iKZnr+uC+N6jzMvbwsI0fp+jZhlp6PmSMF88RF86KMZUfJQ88MvzkriRMYATH+mKUs3eku5UMPQsyAOC17m7UF0deZkN7eUCzCCsgRJgaQ6tTMN2D0tUNRCYyeI9WDyEWgQlJzHMgGZpKQj7yU28=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Auh+Tz96EitvoH4T5kNjahbCZ0JPWSHsTmEdg5jbo3yzjsdLeFSl4up7nJ0e9Sib4eZrmzBxwuswxug5JZyiVWNv6/1qDSck2WrzQaeWrDQlPenOUrUTbDn7lOrG5bpStUTn4Kg4M0OkmdxdYrTtW10n6Sdx/qKTK7UODx+tuoY=
Received: by 10.100.142.12 with SMTP id p12mr1249362and.1186584344668;
        Wed, 08 Aug 2007 07:45:44 -0700 (PDT)
Received: by 10.100.197.3 with HTTP; Wed, 8 Aug 2007 07:45:44 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55322>

git-cvsserver (git v1.5.2.4) seems to be failing on cvs checkout with
the following message:
Died at /usr/bin/git-cvsserver line 2534, <FILELIST> chunk 24.
Issuing rollback() for database handle being DESTROY'd without
explicit disconnect(), <FILELIST> line 24.

The code around 2534 is:
my $filepipe = open(FILELIST, '-|', 'git-diff-tree', '-z', '-r',
$lastpicked, $commit->{hash}) or die("Cannot call git-diff-tree :
$!");
........
my ($mode, $hash, $change) = ($1, $2, $3);
............
if ( $change eq "D" )
.......
elsif ( $change eq "M" )
........
elsif ( $change eq "A" )
........
else
                {
                    $log->warn("UNKNOWN FILE CHANGE mode=$mode,
hash=$hash, change=$change, name=$name");
                    die;
                }
