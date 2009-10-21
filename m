From: Daniel Cordero <theappleman@gmail.com>
Subject: [bug][bisected] git-svn with root branches
Date: Wed, 21 Oct 2009 15:41:13 +0100
Message-ID: <20091021144113.GA7440@cumin>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Brewster <adambrewster@gmail.com>,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Oct 21 16:40:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0cMs-0002FM-Dt
	for gcvg-git-2@lo.gmane.org; Wed, 21 Oct 2009 16:40:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753596AbZJUOjQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Oct 2009 10:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbZJUOjP
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 10:39:15 -0400
Received: from ey-out-2122.google.com ([74.125.78.24]:10127 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753577AbZJUOjO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Oct 2009 10:39:14 -0400
Received: by ey-out-2122.google.com with SMTP id 9so1451071eyd.19
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 07:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:user-agent;
        bh=qS2rG6bfGUsIapDda58z+2ytWB9wjhVjMkSYwH8sb8A=;
        b=xd9v4a0JpyzfglI8X2IHWfa26LE8KUPLqa/KxCrI/m5e+SU+Ypo1cF/4F+GfoqMMmI
         Imzw01zjKL6pJJyxkvPTD74WeiCQi19ylG06aQIPjI1j529cOh1xJM6D7VLnZrFjg/pz
         47Eu+vz2AlHJ8kzNd4TjcXfRxeKwfoQI9JbhA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=hoTgQrUV14GwaYKMUmkyu1GmkpJoqHJBtVxu6x7w552hcxDDfL5uH/Z/XeGmxS9fdP
         Ou1ltMLScNlui0L3CBGi4R4Kk48ExuqHQT50QHRejFmF0YHbb/w54q6wNxXNWECOQ52G
         xFPvhzyQdfp6hAvZIxy4aS4chi8moGnUm2zs0=
Received: by 10.216.88.132 with SMTP id a4mr2763158wef.203.1256135958403;
        Wed, 21 Oct 2009 07:39:18 -0700 (PDT)
Received: from cumin (82-35-17-232.cable.ubr03.hari.blueyonder.co.uk [82.35.17.232])
        by mx.google.com with ESMTPS id t2sm3581556gve.27.2009.10.21.07.39.16
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:39:16 -0700 (PDT)
Mail-Followup-To: Daniel Cordero <theappleman@gmail.com>,
	Adam Brewster <adambrewster@gmail.com>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130922>

Hello,

when trying to clone a svn repo with the command-line:

	$ git svn clone -b / http://svn.collab.net/repos/svn/

(that is, each folder in the root of the repo should be considered it's
own branch)
the clone sometimes[1] fails saying:

	ref: 'refs/remotes/' ends with a trailing slash, this is not permitted by git nor Subversion

The offending config is:
[svn-remote "svn"]
        url = http://svn.collab.net/repos/svn
        branches = /*:refs/remotes/*


This used to work in the past; I bisected the bad commit to

commit 6f5748e14cc5bb0a836b649fb8e2d6a5eb166f1d
Author: Adam Brewster <adambrewster@gmail.com>
Date:   Tue Aug 11 23:14:03 2009 -0400

    svn: allow branches outside of refs/remotes


Thanks in advance.


[1] It does work when the URL has at least 1 folder of depth
(e.g. suffix "trunk" to the above URL).

Its config section is:
[svn-remote "svn"]
        url = http://svn.collab.net/repos/svn
	branches = trunk//*:refs/remotes/*
