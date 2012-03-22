From: Tim Henigan <tim.henigan@gmail.com>
Subject: [PATCH 0/9 v6] difftool: teach command to perform directory diffs
Date: Thu, 22 Mar 2012 15:52:15 -0400
Message-ID: <1332445944-10944-1-git-send-email-tim.henigan@gmail.com>
Cc: Tim Henigan <tim.henigan@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, davvid@gmail.com
X-From: git-owner@vger.kernel.org Thu Mar 22 20:52:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SAo44-0004lr-N8
	for gcvg-git-2@plane.gmane.org; Thu, 22 Mar 2012 20:52:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754680Ab2CVTwr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Mar 2012 15:52:47 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:39771 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752882Ab2CVTwq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Mar 2012 15:52:46 -0400
Received: by qcqw6 with SMTP id w6so1554023qcq.19
        for <git@vger.kernel.org>; Thu, 22 Mar 2012 12:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=GFWUqa7etLyaDzI+6cxl30nffwcikni/xW+0na4zR34=;
        b=bts5Fuw1RPD+XVBoGUeK7yCozhD9WAbBwlOWxlOsUc8qSEKYyADpLHUdUhy8YwPCUm
         ZbPVuPr4JHxLdKwu+I6DKbrhCTYLmRESGpenbUC8uqRZ+1JRN6kN3EgRHCeQdECi1OjE
         uSf/Q3E4tLttQPrkpRTg3Ly8VymAoZqPGQUgxwkKCCdwfR9WvEqQMDuwFZ9GSebVLlui
         CmyA4DFAbxPclHa3p4RHuWqMpgtYlnMUtvNp7WCbrF09Cpgq3Q9ydHMlja2BbLs/9ZYZ
         COBp0zkL3Lxfo+cONeL6s4nqv4jGtE3GBPaLxSY2F/0At/g1TdzZ5827x8R/rLj/OXWU
         XJ2A==
Received: by 10.224.116.18 with SMTP id k18mr12734985qaq.14.1332445964542;
        Thu, 22 Mar 2012 12:52:44 -0700 (PDT)
Received: from localhost (adsl-99-38-69-118.dsl.sfldmi.sbcglobal.net. [99.38.69.118])
        by mx.google.com with ESMTPS id ef6sm10006021qab.7.2012.03.22.12.52.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 22 Mar 2012 12:52:43 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.rc1.36.g15e879
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193699>

Changes in v6:
  - Rebased series to insure Getopt::Long worked correctly from the start.
  - Squashed commits that added tests into the commits that added the
    new features.

Series Overview:

'git difftool' is a very useful command that allows git diffs to be opened
in an external tool. Currently, difftool opens a separate instance of the
external tool for each file that changed.  This can be tedious when many
files have changed.

This series teaches difftool to perform directory diffs, so that all file
changes can be opened/reviewed in a single instance of the external tool.

This is the second phase of development for this feature.  The first phase
was added as a separate command (git diffall) in 1252bbe (contrib: add
git-diffall script).  During review of that script on the Git developers
list, an informal development roadmap was suggested [1]. The next phase
of that plan is to integrate the 'git-diffall' feature into 'difftool'.
This series gets that done.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/191297/focus=191383


Tim Henigan (9):
  difftool: parse options using Getopt::Long
  difftool: add '--no-gui' option
  difftool: exit(0) when usage is printed
  difftool: remove explicit change of PATH
  difftool: stop appending '.exe' to git
  difftool: eliminate setup_environment function
  difftool: replace system call with Git::command_noisy
  difftool: teach difftool to handle directory diffs
  difftool: print list of valid tools with '--tool-help'

 Documentation/git-difftool.txt |   17 ++-
 git-difftool--helper.sh        |   19 ++-
 git-difftool.perl              |  264 +++++++++++++++++++++++++++-------------
 t/t7800-difftool.sh            |   57 +++++++++
 4 files changed, 262 insertions(+), 95 deletions(-)

-- 
1.7.10.rc1.36.g15e879
