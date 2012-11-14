From: petesea@bigfoot.com
Subject: git init shared=group with a subdir
Date: Wed, 14 Nov 2012 12:00:03 -0800 (PST)
Message-ID: <alpine.OSX.2.00.1211141107180.737@nikto-air>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 14 21:10:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYjHi-0003T0-2Y
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 21:10:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423247Ab2KNUJw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 15:09:52 -0500
Received: from out01.dlls.pa.frontiernet.net ([199.224.80.228]:56921 "EHLO
	out01.dlls.pa.frontiernet.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1423139Ab2KNUJv (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Nov 2012 15:09:51 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Wed, 14 Nov 2012 15:09:51 EST
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AggFAEr3o1AyLoOQ/2dsb2JhbABEv36DPoMoPQKKBwESp2WFMoQCBIonjzKDJwOIWqB1
X-Originating-IP: [50.46.131.144]
Received: from relay01.dlls.pa.frontiernet.net ([199.224.80.244])
  by out01.dlls.pa.frontiernet.net with ESMTP; 14 Nov 2012 20:00:06 +0000
X-Previous-IP: 50.46.131.144
Received: from localhost.localdomain (50-46-131-144.evrt.wa.frontiernet.net [50.46.131.144])
	by relay01.dlls.pa.frontiernet.net (Postfix) with ESMTPA id 774D330C0ED
	for <git@vger.kernel.org>; Wed, 14 Nov 2012 20:00:05 +0000 (UTC)
Received: from nikto-air (nikto-air [192.168.0.103])
	by localhost.localdomain (8.14.2/8.14.2) with ESMTP id qAEK03Nx025232
	for <git@vger.kernel.org>; Wed, 14 Nov 2012 12:00:04 -0800
X-X-Sender: pete@nikto-air
User-Agent: Alpine 2.00 (OSX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209749>

I believe there may be a bug when initializing a new repository relating 
to the directory permissions when the --shared=group option is used and 
the repository is within a sub-directory.

The following will create the "test.git" directory with 2775 permissions 
(which is as expected):

   $ ls -ld test.git
   ls: cannot access test.git: No such file or directory
   $ git init --bare --shared=group test.git
   Initialized empty shared Git repository in /tmp/test.git/
   $ ls -ld test.git
   drwxrwsr-x 7 pete users 4096 2012-11-14 11:15 test.git

This following will also create the "test.git" directory with 2775 
permissions, BUT the "subdir" directory ends up with 755 permissions:

   $ ls -ld subdir
   ls: cannot access subdir: No such file or directory
   $ git init --bare --shared=group subdir/test.git
   Initialized empty shared Git repository in /tmp/subdir/test.git/
   $ ls -ld subdir subdir/test.git
   drwxr-xr-x 3 pete users 4096 2012-11-14 11:16 subdir
   drwxrwsr-x 7 pete users 4096 2012-11-14 11:16 subdir/test.git

Assuming the "subdir" directory doesn't already exist and is created by 
the "git init" command AND the --shared=group option is used, then 
shouldn't the "subdir" directory also have 2775 permissions?
