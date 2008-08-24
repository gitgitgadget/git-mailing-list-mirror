From: Benny Halevy <bhalevy@panasas.com>
Subject: new file missing after resolving rebase merge conflict
Date: Sun, 24 Aug 2008 20:20:50 +0300
Message-ID: <48B19872.9070707@panasas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 24 19:22:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXJHs-0007kR-4Y
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 19:22:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751292AbYHXRU4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 13:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751698AbYHXRU4
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 13:20:56 -0400
Received: from ey-out-2122.google.com ([74.125.78.25]:9032 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbYHXRUz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 13:20:55 -0400
Received: by ey-out-2122.google.com with SMTP id 6so128045eyi.37
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 10:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding:sender;
        bh=urO2vYJ/6ayzaLPbm4J5d0x+FQgkXbD+Ey5CsX/FUB8=;
        b=sUUAkuHFHLhMC5sXYWww1dZENKFJHDqwCc5lOrVjynxCf/incJe8esal4y0xsc0AMq
         MjqBYAPco8IMVldA51MMYnpK3vbXeha3AkJPwSgAcdvfMP9nT4+ZfaeIYII/oS8Xnfa8
         w1XeQyYwHZlbbQG5CKpPudMq7jvnXCgaNfTCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:sender;
        b=g5ZU2B6QNHwyfL3D7mx+8GZIGRyUniJM6EVljreR5QOD2qblk7lC0j7dRNVgy3kNPj
         479kfC8wzdDq0v/HQKxqxZQmQGSwxujS+MXyy6WH5xHLjq5+Rsd/s5c4MtE2foaxFPAV
         KwhR+kxdm82CoY1zKd9UZL+w+OiDJrOmVTqVI=
Received: by 10.210.120.17 with SMTP id s17mr5199164ebc.90.1219598454031;
        Sun, 24 Aug 2008 10:20:54 -0700 (PDT)
Received: from fs1.bhalevy.com ( [212.235.53.3])
        by mx.google.com with ESMTPS id f13sm16245354gvd.10.2008.08.24.10.20.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 10:20:53 -0700 (PDT)
User-Agent: Thunderbird 3.0a1 (X11/2008050714)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93533>

with git version 1.6.0

When rebasing a branch onto another
(command was git rebase --onto newbase newbase.orig branch)
I've hit a merge conflict in one of the patches that
among other things, adds some new files to the tree.
After resolving the conflict and running git add on the
resolved files I ran git rebase --continue and in a later
patch, when trying to compile I noticed that one of the files
that the former patch was supposed to add is missing from the
tree and from the index.

I'm not sure it's relevant, yet this file is the last hunk in
the patch.

Anyhow, the file still appears with git show of the rebased
patch:

$ git show 39fe203
...
diff --git a/include/linux/pnfs_xdr.h b/include/linux/pnfs_xdr.h
new file mode 100644
index 0000000..1f811c5
--- /dev/null
+++ b/include/linux/pnfs_xdr.h
@@ -0,0 +1,137 @@

but it doesn't appear to exist in the index:

$ git checkout include/linux/pnfs_xdr.h
error: pathspec 'include/linux/pnfs_xdr.h' did not match any file(s) known to git.

only after explicitly re-checking it out from the former patch:
$ git checkout 39fe203 -- include/linux/pnfs_xdr.h

it comes to existence.

Benny
