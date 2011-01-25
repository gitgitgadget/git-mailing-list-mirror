From: Francis Moreau <francis.moro@gmail.com>
Subject: Can't find the revelant commit with git-log
Date: Tue, 25 Jan 2011 10:01:47 +0100
Message-ID: <m2ipxd2w78.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 25 10:02:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Phen6-0004eL-8y
	for gcvg-git-2@lo.gmane.org; Tue, 25 Jan 2011 10:02:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753147Ab1AYJBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Jan 2011 04:01:53 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39049 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753139Ab1AYJBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Jan 2011 04:01:52 -0500
Received: by bwz15 with SMTP id 15so3961bwz.19
        for <git@vger.kernel.org>; Tue, 25 Jan 2011 01:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:mail-followup-to:date
         :message-id:user-agent:mime-version:content-type;
        bh=d6uLmwM+IqdWtYMkA8u6SUwWXe4A6LrTRb6a2QZv/mM=;
        b=Hkw5fm1dz32cp4VigPKzRBwm+TkcNDHFXwFkx3IVA9KlkxRF9kCq7Fe9TnESBlw4d3
         rxIqdLJ2kbMkzJKiuGnYJUnHFyK2EH1mvA0+wk1td22+lsGhODVSvU0jsijBBhKiYFvh
         Vh0qiXa2l86WpclkUdyexDoOjzXbkBBzO5c7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:mail-followup-to:date:message-id:user-agent
         :mime-version:content-type;
        b=Gb63mHb0p9qmxznPNDDylfQs9C/w81/6XLcEeDmRpuTkef4eRKZjDxMDpl5c36PIUS
         nyN/hzP/TIQZNSHx5b9GmnRr3PEpbdIugnNd25QFDZc0iVFIu7pVW0IAWfvty6olcKYt
         L941pGOyS9vVhjF/YCh5x7P8EIh/Z8qt9uFEQ=
Received: by 10.204.67.5 with SMTP id p5mr4806125bki.59.1295946111429;
        Tue, 25 Jan 2011 01:01:51 -0800 (PST)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id q18sm6663012bka.15.2011.01.25.01.01.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 25 Jan 2011 01:01:50 -0800 (PST)
Mail-Followup-To: git@vger.kernel.org
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165477>

Hello,

I'm trying to find out a commit which removed a function inside a file.

The project is the Linux kernel, and I'm trying to look for changes
which happened between v2.6.27 and v2.6.28. The changes happened in the
following file: drivers/pci/intel-iommu.c where a function has been
removed:

   $ git --version
   git version 1.7.4.rc3

   $ cd ~/linux-2.6/drivers/pci/
   $ git grep blacklist v2.6.27 -- drivers/pci/intel-iommu.c
   $

No ouput... hmm, I know it's in... oh maybe the path is incorrect

   $ git git grep blacklist v2.6.27 -- intel-iommu.c
   v2.6.27:intel-iommu.c:static int blacklist_iommu(const struct dmi_system_id *id)
   v2.6.27:intel-iommu.c:          .callback = blacklist_iommu,

ah, so Git failed previously without any comments on the wrong
path... maybe it should ?

So at that point I know that in the revision v2.6.27, there's a function
called "blacklist_iommu" in drivers/pci/intel-iommu.c

Now take a look if it's still there in v2.6.28:

   $ git git grep blacklist v2.6.28 -- intel-iommu.c
   $

This time nothing is printed but I know that the command is correct.

So now I'm interested in looking for the commit which removed this
function. Fo this I'm trying to use git-log(1):

   $ git log --full-history --follow -S'static int blacklist_iommu(const struct dmi_system_id *id)' v2.6.27..v2.6.28 -- intel-iommu.c
   $ echo $?
   0

I tried different options but it fails.

Also I found that passing the exact string to '-S' is annoying, are
there any way to just pass a part of the string such as
"-Sblacklist_iommu" ?

Sorry if I miss the revelant git-log's option, but there're so many...
-- 
Francis
