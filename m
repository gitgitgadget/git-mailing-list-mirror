From: linux@horizon.com
Subject: git-repack made my pack 317x larger...
Date: 15 Jun 2007 04:50:57 -0400
Message-ID: <20070615085057.5706.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 15 10:51:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hz7WH-0001NU-Hi
	for gcvg-git@gmane.org; Fri, 15 Jun 2007 10:51:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751237AbXFOIvA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Jun 2007 04:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbXFOIvA
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jun 2007 04:51:00 -0400
Received: from science.horizon.com ([192.35.100.1]:19084 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750908AbXFOIu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2007 04:50:59 -0400
Received: (qmail 5707 invoked by uid 1000); 15 Jun 2007 04:50:57 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50254>

I was grabbing a copy of the hwmon-2.6 git tree to play with:

> ~/tmp$ git-clone git://lm-sensors.org/kernel/mhoffman/hwmon-2.6.git
> Initialized empty Git repository in /home/linux/tmp/hwmon-2.6/.git/
> remote: Generating pack...
> remote: Done counting 496311 objects.
> remote: Deltifying 496311 objects.
> remote:  100% (496311/496311) done
> Indexing 496311 objects...
> remote: Total 496311 (delta 400999), reused 496151 (delta 400839)
>  100% (496311/496311) done
> Resolving 400999 deltas...
>  100% (400999/400999) done
> Checking 22409 files out...
>  100% (22409/22409) done
> ~/tmp$ ls -l hwmon-2.6/git/objects/pack
> -r--r--r-- 1 linux users  11912528 Jun 15 03:35 pack-d4ec0478f7530345ff466805ab4fe63efc9251df.idx
> -r--r--r-- 1 linux users 166721991 Jun 15 03:35 pack-d4ec0478f7530345ff466805ab4fe63efc9251df.pack

Then I noticed that it's a Linux kernel... oops!
Sorry for wasting the network bandwidth, but I can save myself
the disk space.

> ~/tmp$ rm -r hwmon-2.6/*
> ~/tmp$ mv hwmon-2.6 hwmon-2.6.old
> ~/tmp$ git clone --reference /usr/src/linux -n hwmon-2.6.old hwmon-2.6
> Initialized empty Git repository in /home/linux/tmp/hwmon-2.6/.git/
> remote: Generating pack...
> remote: Done counting 124 objects.
> remote: Deltifying 124 objects...
> remote:  100% (124/124) done
> Indexing 124 objects...
> remote: Total 124 (delta 83), reused 97 (delta 75)
>  100% (124/124) done
> Resolving 83 deltas...
>  100% (83/83) done
> ~/tmp$ rm -rf hwmon-2.6.olf
> ~/tmp$ cd hwmon-2.6
> ~/tmp/hwmon-2.6$ ls -l .git/objects/pack/
> total 168
> -r--r--r-- 1 linux users   4040 Jun 15 03:44 pack-e4de475aa6c82099b4a4a8f6f410dcc316c7cf19.idx
> -r--r--r-- 1 linux users 161548 Jun 15 03:44 pack-e4de475aa6c82099b4a4a8f6f410dcc316c7cf19.pack

Much better!  But since that's only a few objects, let's repack them even tighter...

> ~/tmp/hwmon-2.6$ git-repack -a -d -f --window=50
> Generating pack...
> Done counting 18090 objects.
> Deltifying 18090 objects...
>  100% (18090/18090) done
> Writing 18090 objects...
>  100% (18090/18090) done
> Total 18090 (delta 2465), reused 7876 (delta 0)
> Pack pack-1af4ab6620f71733f17b16d69a89b6741e2c7fe3 created.
> Removing unused objects 100%...
> Done.
> ~/tmp/hwmon-2.6$ ls -l .git/objects/pack/
> total 50620
> -r--r--r-- 1 linux users   435224 Jun 15 04:00 pack-1af4ab6620f71733f17b16d69a89b6741e2c7fe3.idx
> -r--r--r-- 1 linux users 51333891 Jun 15 04:00 pack-1af4ab6620f71733f17b16d69a89b6741e2c7fe3.pack

Uh... what happened?  It's not a full kernel clone, but it's a lot more
objects than I expected.  Where did all the extra objects come from?
