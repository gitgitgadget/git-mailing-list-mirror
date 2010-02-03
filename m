From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Odd error when doing "clone && cd && checkout -b"
Date: Tue, 2 Feb 2010 23:00:16 -0800
Message-ID: <20100203070016.GA18089@vfb-9.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 03 08:00:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcZDx-000223-Bj
	for gcvg-git-2@lo.gmane.org; Wed, 03 Feb 2010 08:00:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754404Ab0BCHAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Feb 2010 02:00:24 -0500
Received: from mail-px0-f182.google.com ([209.85.216.182]:51304 "EHLO
	mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070Ab0BCHAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Feb 2010 02:00:23 -0500
Received: by pxi12 with SMTP id 12so1096622pxi.33
        for <git@vger.kernel.org>; Tue, 02 Feb 2010 23:00:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:subject
         :message-id:mail-followup-to:mime-version:content-type
         :content-disposition:received:user-agent;
        bh=qVy85FPr40POcSkKo5FiG5X27Z+tMiC4wSWnqzKrQZ0=;
        b=ef06AKUpGc9d5tNpQdj/EviUSlP2dMsLTuvJToHGVuAmaysfKI8HWqQva7EDlPM/p3
         RSg7aMLj7pdh/nDCjRawDG7lxdMl8YJ0yhjkMwGCnFnLW/lMNtDNQxavzxqrjHMsavub
         eVBpKHxYahiDJIn1foenfeFT1AFvqI078+or0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:mail-followup-to:mime-version
         :content-type:content-disposition:user-agent;
        b=Z4U0dXIW14+/9jsCAK25gEhO0rNJC1QuJQwnmp5XMALMVwCUuodlLxAWSluQ8ZUZ62
         cM0ZRPeGip+3cVh2MVSZD3pvWXUbozSHYIYYt38RDJ9HMZtXR18FzmkiFCr93u0H5yOh
         8901QFp/SPNv8jx6vITh7yXGg1046qjtwW/6M=
Received: by 10.140.55.16 with SMTP id d16mr4883437rva.287.1265180422840;
        Tue, 02 Feb 2010 23:00:22 -0800 (PST)
Received: from vfb-9.home ([96.225.220.117])
        by mx.google.com with ESMTPS id 20sm3515882pzk.13.2010.02.02.23.00.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Feb 2010 23:00:22 -0800 (PST)
Mail-Followup-To: Git <git@vger.kernel.org>
Content-Disposition: inline
Received: by 10.141.34.12 with HTTP; Tue, 2 Feb 2010 22:48:31 -0800 (PST)
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138809>

In talking with someone in the IRC channel, I ran across something that
I thought was very odd behavior.  I'm sure there's a very simple
explanation, but I can't think of what it might be.

The person was getting "fatal: git checkout: updating paths is
incompatible with switching branches.", when they tried to create a new
tracking branch, and switch to it, with a fresh clone.  I was able to
reproduce this, but only by one-lining the "clone && cd && checkout -b".

When the "checkout -b" fails from the one-lined version, immediately
doing the "checkout -b" on its own succeeds.

The output below is from zsh (4.3.10), however I get the exact same
behavior when I run the commands using bash (4.0.33).  I was testing
this using Git 1.6.6.1.598.g661e2.

== One-lined Version ==

vfb-9 ~/tmp % git clone git://github.com/rich97/CakeCMP.git && cd CakeCMP && git checkout -b permissions-rewrite origin/permissions-rewrite
Initialized empty shared Git repository in /home/jhe/tmp/CakeCMP/.git/   
remote: Counting objects: 1508, done.
remote: Compressing objects: 100% (1432/1432), done.
remote: Total 1508 (delta 256), reused 1235 (delta 60)
Receiving objects: 100% (1508/1508), 844.43 KiB | 104 KiB/s, done.
Resolving deltas: 100% (256/256), done.
fatal: git checkout: updating paths is incompatible with switching branches.
Did you intend to checkout 'origin/permissions-rewrite' which can not be resolved as commit?

vfb-9 ~/tmp/CakeCMP on master(a026490) sigexit % git checkout -b permissions-rewrite origin/permission-rewrite
Branch permissions-rewrite set up to track remote branch permission-rewrite from origin.
Switched to a new branch 'permissions-rewrite'

== Running "checkout -b" on its own ==

vfb-9 ~/tmp % git clone git://github.com/rich97/CakeCMP.git && cd CakeCMP
Initialized empty shared Git repository in /home/jhe/tmp/CakeCMP/.git/
remote: Counting objects: 1508, done.
remote: Compressing objects: 100% (1432/1432), done.
remote: Total 1508 (delta 256), reused 1235 (delta 60)
Receiving objects: 100% (1508/1508), 844.43 KiB | 93 KiB/s, done.
Resolving deltas: 100% (256/256), done.

vfb-9 ~/tmp/CakeCMP on master(a026490) % git checkout -b permissions-rewrite origin/permission-rewrite
Branch permissions-rewrite set up to track remote branch permission-rewrite from origin.
Switched to a new branch 'permissions-rewrite'

vfb-9 ~/tmp/CakeCMP on permissions-rewrite(ca687f1) % git --version
git version 1.6.6.1.598.g661e2

-Jacob
