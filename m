From: David Turner <dturner@twopensource.com>
Subject: [PATCH/RFC 0/9] Pseudorefs
Date: Fri, 24 Jul 2015 00:45:20 -0400
Message-ID: <1437713129-19373-1-git-send-email-dturner@twopensource.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Jul 24 06:45:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZIUrt-0003mj-Fu
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jul 2015 06:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751130AbbGXEpt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2015 00:45:49 -0400
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34324 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751053AbbGXEps (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2015 00:45:48 -0400
Received: by qgeu79 with SMTP id u79so6101793qge.1
        for <git@vger.kernel.org>; Thu, 23 Jul 2015 21:45:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=ekbjXkb5M0XZqXc3pQLHi6XYjc4LT/yvH+i/Xao1QSI=;
        b=fVeoM1X9bsCFk/Bk1VcD3jg6Zs98nt/gs0LQ+OjrgPTXYCKMHG1BRsYLc4OdYN6raz
         7UQCoNTfV1NHxT9Qd9RDplYDVfmnTbWMAO7VSLTOzri6+gSWER7TZ7+kjAMye63/1PsX
         CwGa0DMeKPULOCgrcsaZK3NNdUt3SqxQxN7WSXO9UMHrxufPaX5sFUGxXgvp5TRnPa7q
         YZ2w5fG9wqOhBrboXap16tiz89j0dTzIZZVcQsNkhzrvpnpxbRQWDyVo/ceQroICNvb8
         opOkhLqu7rMDs80zZ0mCCiiiteBGdz39ZdOdiRYbhp+k+uT/ZCVtTOULqWwjPGSGLTd7
         xYmg==
X-Gm-Message-State: ALoCoQn/s8EphCq+VBD9LXaptjmzk4/ipfT+YUwkJ9sjAHq/jsoH0m2dW7MutNqef8J01VX4OQ0p
X-Received: by 10.140.104.236 with SMTP id a99mr17988240qgf.71.1437713147746;
        Thu, 23 Jul 2015 21:45:47 -0700 (PDT)
Received: from ubuntu.twitter.corp? (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id p74sm3541579qkp.11.2015.07.23.21.45.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Jul 2015 21:45:46 -0700 (PDT)
X-Mailer: git-send-email 2.0.4.315.gad8727a-twtrsrc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274545>

This series is another chunk of the pluggable refs backend work.  The
major reason it is listed as "PATCH/RFC" is beacuse it breaks
t9300-fast-import.sh, because fast-import wants to create a ref called
TEMP_TAG, which would now be a pseudoref.  The commit that introduces
this test says that cvs2svn creates a tag called TAG_FIXUP "as a branch
name for temporary work needed to cleanup the tree prior to creating
an annotated tag object."

It appears that cvs2svn still does this.  So I'm not quite sure what to
do about this particular case.

As we discussed earlier, the motivation for this series is that refs
backends other than the files-based backend need to treat per-worktree
refs (HEAD) and pseudorefs (FETCH_HEAD) differently from other refs;
other refs are per-repo rather than per-worktree.
