From: "Ken Pratt" <ken@kenpratt.net>
Subject: pack operation is thrashing my server
Date: Sun, 10 Aug 2008 12:47:37 -0700
Message-ID: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 10 21:48:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSGu9-0006pA-9I
	for gcvg-git-2@gmane.org; Sun, 10 Aug 2008 21:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYHJTrj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2008 15:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753391AbYHJTrj
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Aug 2008 15:47:39 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:53630 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753387AbYHJTri (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2008 15:47:38 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1922866rvb.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2008 12:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:mime-version:content-type:content-transfer-encoding
         :content-disposition:x-google-sender-auth;
        bh=3QBhJznXWvyT7aVuILgmYiDvpPdB/Gd6M7u7nVZt5pI=;
        b=hu/8XufAn+VP43uQJHOEEpC1kSg2yDL2PiWjs1BGUP43wDO0nwDMy9rSUZza0q45oR
         FvOMmNwgILEilT7VoDtn4cGbKRbgpDpEPbgzuMvR8wCGuXR5GHezIDqPWyiSRS7KCdjI
         CrpxRxx2EGNHISFkdxW8vXh08JyOss525xZx8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=QxY57Bx8dmFfn6Lp6j00KBmF12QXO6+GmtRmD1r2KWTzvN6CgC7XzFvQUkQbz5vN9C
         K5Vfl6oqzA12wjw8HERKbHdOipxOv6aJ50EplTPCcdweFm0BKCXivv4D7VnG9jn/iFw8
         33Lpn2obchdh3h7EaFPsb7lNdeRHr39vWfym4=
Received: by 10.115.110.1 with SMTP id n1mr2963128wam.66.1218397657889;
        Sun, 10 Aug 2008 12:47:37 -0700 (PDT)
Received: by 10.114.149.3 with HTTP; Sun, 10 Aug 2008 12:47:37 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: d0cc190f0adc9522
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91881>

Hi,

I'm having memory issues when trying to clone a remote git repository.

I'm running: "git clone git+ssh://user@foo.bar.com/var/git/foo"

The remote repository is bare, and is 180MB in size (says du), with
1824 objects. The remote (VPS) server is running git version 1.5.6.4
on Arch Linux on a x86_64 Opteron with 256MB of dedicated RAM.

The clone command fires off some packing operations that bring the
server to its knees:

PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
21782 kenpratt  20   0  444m 212m  272 D    3 83.0   0:04.98 git-pack-object

The clone also seems to hang forever. Progress stays at 0% for hours,
and it never progresses past compressing the first object.

I've tried very conservative pack settings:

[pack]
        threads = 1
        windowmemory = 64M
        deltacachesize = 1M
        deltacachelimit = 1M

[pack]
        threads = 1
        windowmemory = 16M
        deltacachesize = 16M
        deltacachelimit = 0

I've tries many variations like those, but nothing seems to help.

A "git repack -a -d" only takes 5 seconds to run on the same
repository on my laptop (a non-bare copy), and seems to peak at ~160MB
of RAM usage.

Any tips/help would be greatly appreciated. This repository is still
small -- it will eventually grow to multiple GB in size, as it is a
mix of small text files and binaries ranging in size from 2MB to
200MB. Is it not feasible to clone repositories of that size that are
hosted on a server with 256MB of RAM?

Thanks!

Ken
