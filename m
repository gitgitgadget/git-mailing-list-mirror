From: Nicholas Kirchner <kirc0076@umn.edu>
Subject: Inconsistency in --work-tree behaviors
Date: Tue, 19 Jun 2012 18:26:03 -0500
Message-ID: <AAB7D0C4-2A3E-4CCF-8D3E-A2C689B2826D@umn.edu>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 20 01:41:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh82u-0005Ni-RH
	for gcvg-git-2@plane.gmane.org; Wed, 20 Jun 2012 01:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755171Ab2FSXlM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jun 2012 19:41:12 -0400
Received: from vs-a.tc.umn.edu ([134.84.135.107]:55022 "EHLO vs-a.tc.umn.edu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab2FSXlL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jun 2012 19:41:11 -0400
X-Greylist: delayed 901 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2012 19:41:11 EDT
Received: from mail-yw0-f43.google.com (mail-yw0-f43.google.com [209.85.213.43])
	by vs-a.tc.umn.edu (UMN smtpd) with ESMTP
	for <git@vger.kernel.org>; Tue, 19 Jun 2012 18:26:07 -0500 (CDT)
X-Umn-Remote-Mta: [N] mail-yw0-f43.google.com [209.85.213.43] #+LO+TR
X-Umn-Classification: local
Received: by mail-yw0-f43.google.com with SMTP id k6so9748614yhk.16
        for <git@vger.kernel.org>; Tue, 19 Jun 2012 16:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:date:message-id
         :to:mime-version:x-mailer:x-gm-message-state;
        bh=Opzw4aizm1WIkQ4BX4IxXeMz/C4LBC89SgmKyxGG22w=;
        b=JZ7SNXKQXZ635oDMKp1wxCghygOA/9ihvQgiFmliBet9lpCYI6Gh9D+qkUHAJE4k5p
         +lvcjhzb5R2eZt/+wUyw7VnGcAUTFuiUCgFAr7ZBiKD/MVZVIBK+VhdUicw2kOzGOa4U
         e/m5OgvpaY2AEAs5yuO1T/+EkTH96rpEeExTgHWpbOgitK710JCvGnSKEef/UG2U9L6p
         IhcBkoqTRTppgYNBVOo9dk+UYJwATyclgXEbxIxpPC+g+iUSvtSalCdV6EMWEIJr/sxN
         bXQLuB8hhsIUqr66Iks72tI+nPTzioslz+7xGXPZF6tc7kxOkMLk5sDpcStyjhEw/U8b
         RgDg==
Received: by 10.43.69.12 with SMTP id ya12mr9230655icb.50.1340148366806;
        Tue, 19 Jun 2012 16:26:06 -0700 (PDT)
Received: from [192.168.1.103] (67-6-4-16.mpls.qwest.net. [67.6.4.16])
        by mx.google.com with ESMTPS id ut5sm23996885igc.13.2012.06.19.16.26.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Jun 2012 16:26:05 -0700 (PDT)
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQkb8QPPUvnb9T4M4mySQayJW5Moo4rdmCsMh+O2AL7T0iRyAA1IiK3bD3Tehzkzb/NR3j8/
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200275>

There appears to be an inconsistency in how ls-files handles --work-tree compared to how status handles --work-tree.

Context: I have a directory dotfiles.git with core.worktree = /Users/nick (my home directory; I'm on OS X Lion with MacPorts git version 1.7.10.4).

Below are the outputs of git ls-files and git status for the following options of --work-tree:
1) none (equivalent to --work-tree=/Users/nick because of core.worktree setting, right?)
2) --work-tree=~
3) --work-tree=/Users/nick
4) --work-tree=/Users/nick. (note the period at the end)

Note that ls-files works properly with "/Users/nick." and "~", while status works properly with "/Users/nick" and none.  No output is produced for "git ls-files" or "git --work-tree=/Users/nick".

$ git status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	../.hiya
nothing added to commit but untracked files present (use "git add" to track)

$ git ls-files

$ git --work-tree=~ ls-files
.bash_profile
.bashrc
.gemrc
.profile
.rvmrc
.screenrc

$ git --work-tree=~ status
fatal: This operation must be run in a work tree

$ git --work-tree=/Users/nick status
# On branch master
# Untracked files:
#   (use "git add <file>..." to include in what will be committed)
#
#	../.hiya
nothing added to commit but untracked files present (use "git add" to track)

$ git --work-tree=/Users/nick ls-files

$ git --work-tree=/Users/nick. ls-files
.bash_profile
.bashrc
.gemrc
.profile
.rvmrc
.screenrc

$ git --work-tree=/Users/nick. status
fatal: This operation must be run in a work tree