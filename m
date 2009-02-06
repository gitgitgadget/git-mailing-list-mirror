From: "Bisani, Alok" <alok.bisani@credit-suisse.com>
Subject: git checkout effect on ls-files --others, how to merge
 partially?
Date: Fri, 6 Feb 2009 12:36:56 -0000
Message-ID: <C5E2CAEE4A87D24DAB5334F62A72D1F43ADCBD@ELON17P32001A.csfb.cs-group.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 13:38:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVPyl-0007LY-Jh
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 13:38:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753129AbZBFMhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 07:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752673AbZBFMhR
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 07:37:17 -0500
Received: from mail-gw18.credit-suisse.com ([198.240.130.183]:42005 "EHLO
	nys17a-3003.corpny.csfb.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753095AbZBFMhQ convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 6 Feb 2009 07:37:16 -0500
Received: by nys17a-3003.corpny.csfb.com; Fri, 6 Feb 2009 07:37:09 -0500 (EST) 
X-Server-Uuid: 4EAC7D12-E00D-46D7-91F2-2C1B0FAC6618
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: git checkout effect on ls-files --others, how to merge
 partially?
thread-index: AcmIV5iO11dGnEFJSFeaZfzf+QVnFw==
X-OriginalArrivalTime: 06 Feb 2009 12:36:57.0117 (UTC)
 FILETIME=[993C54D0:01C98857]
X-WSS-ID: 6592F1630ZK270140-02-05
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108694>

Hi,

	I found a feature that was a bit surprising. Basically, a file
exist on master as untracked (git-ls-files --others). It is git-add'ed
on a branch. Now switching back to master, removes the file from
master's working directory as well.

	Whereas, I was expecting it to simply be present as an untracked
file on master as before. This maybe be unreasonable expectation, but
still. To bring the file back on the master branch I had to $ git merge
<branch>. This, however, would pull in all the changes from the branch.
Whereas, I want to limit the merge only to the file.

	Is there a way to pull in changes from a branch but only limited
to a file/files? I ended up doing a manual restore using git-cat-file
<branch>@{0}:/file. And checked in.

    $ git init

    $ echo first > first

    $ echo second > second

    $ git add second

    $ git commit

    $ git ls-files
    first

    $ git ls-files --all

    $ git ls-files --others
    second

    $ git ls-files --others --cached
    first
    second

    $ git checkout -b test_branch HEAD

    $ git branch
      master
    * test_branch

    $ git ls-files --cached
    second

    $ git ls-files --others
    first

    $ git add first

    $ git commit -m "first"

    $ git ls-files --cached
    first
    second

    $ git ls-files --others

    $ git checkout master

    $ git ls-files --others
    # the file "first" which was --others before, has now been removed
upon checking out master

    $ git cat-file blob test_branch@{0}:first > first
    # To bring the file first back on the master branch as an untracked
file

Best regards,
Alok

==============================================================================
Please access the attached hyperlink for an important electronic communications disclaimer: 

http://www.credit-suisse.com/legal/en/disclaimer_email_ib.html
==============================================================================
