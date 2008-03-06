From: Thomas Harning <harningt@gmail.com>
Subject: [RFC] Idea for Git Bugtracking Tool
Date: Thu, 6 Mar 2008 14:22:46 -0500
Message-ID: <20080306142246.5d9460b7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 06 20:23:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXLh0-0001au-HQ
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 20:23:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755559AbYCFTXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 14:23:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755873AbYCFTXL
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 14:23:11 -0500
Received: from py-out-1112.google.com ([64.233.166.181]:16997 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754903AbYCFTXJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 14:23:09 -0500
Received: by py-out-1112.google.com with SMTP id u52so24973pyb.10
        for <git@vger.kernel.org>; Thu, 06 Mar 2008 11:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=LZAA4D1MaCPP3ozha8umKTTRZGqXHI1HmUoSOQvYVsM=;
        b=XdPJ6QUXEaRXPHse03i5fmUS85zzqHSVG+5dZtMp8dipPA19tMuQ10tCOs83lUA4zyH1paruJ2dMk1mskkGWbcUVA/D6K8ohysGu7+cPBodF4vmGEfom1o1iNvcif2AxX9NGtE2Yo3IfhAtzhQqhLCVF8ox5US6ai79rgZAu+ME=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=wsm1289Z7/ayCdSgdA29/SgulgmKM+EIqGiTAS9ruAq4RpbQRs2jbhiiRmSzTo1T6eveXJaNvHfgfocyD/+6xl5HJhA7IlnBlpuw/rhEcNkOE2nzWC1a6uqTREyODbw6EInxBGjjVRuvETp7R3aTQigtKaZWNHZDgsYJp3512VM=
Received: by 10.65.20.18 with SMTP id x18mr224621qbi.48.1204831387848;
        Thu, 06 Mar 2008 11:23:07 -0800 (PST)
Received: from localhost ( [149.164.193.61])
        by mx.google.com with ESMTPS id z21sm2760482qbc.21.2008.03.06.11.23.06
        (version=SSLv3 cipher=OTHER);
        Thu, 06 Mar 2008 11:23:07 -0800 (PST)
X-Mailer: Claws Mail 3.3.1 (GTK+ 2.10.11; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76411>

Here's a 'basic' concept on how bugtracking could work w/ GIT

Entities:
  * BUG: Bug Repository
  * GIT: GIT Repository
---- May be co-located...

Idea:
  * BUG
    Receives bug reports referencing GIT revision ID(s) to which it affects
    Generates unique IDs for bugs (non-incremental,
      although a scheme could be setup ex: <UNIQUE-USER>-<INC ID>
    Contains a 'cached' calculated BUG-status from GIT log messages
      + permanent BUG-status changes
    Older status change takes precedence (need to make sure times are
      in sync, for sure!)
  * GIT
    Commit messages/annotated-tags may contain text denoting
      a bug's "new" status (FIXED/REOPEN/TO-BE-TESTED/...)
    On 'push' to a repository w/ BUG-hooks, trigger 'BUG's
      cache updates
    For 'merge' events, BUG-status changes may get a little more
      ugly and complicated...If a BUG-status change occurs in more
      than 1 branch, the user may need to be alerted that some
      manual checking may be necessary.
    BUG-status changes should probably have the name of the
      branch to which the change occurred, so that when a merge
      occurs, its a little easier to visualize from that, what was
      going on

You may query BUG for the list of bugs at any point in history and
it will be able to walk up the list of parents and know what bugs
existed where and what changes occurred.

Workflow enhancement:
  Specific comitters may only be allowed to change the status of
    a bug from OPEN->FIXED, wheras others who state 'FIXED' may
    get the status changed to VERIFY-FIXED or some sort of state
    based on a mapping/workflow tree

Ideally the 'BUG' database can be distributed (potentially within
  a GIT repository...) due to the use of unique IDs.  An issue
  here would be dealing w/ the order/time-sensitive bug status changes...

Any ideas/flaws with this concept?  Anybody up for taking on this project
... or for taking this up as a GSOC project mentor?
