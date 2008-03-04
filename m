From: "Whit Armstrong" <armstrong.whit@gmail.com>
Subject: t4109-apply-multifrag.sh problem on solaris -- looks like problem w/ solaris patch cmd
Date: Tue, 4 Mar 2008 11:22:58 -0500
Message-ID: <8ec76080803040822n5e463b50sff6639777246de7b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 04 17:23:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWZvd-0003zx-2q
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 17:23:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762487AbYCDQXH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 11:23:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764202AbYCDQXG
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 11:23:06 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:14593 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762418AbYCDQXD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 11:23:03 -0500
Received: by wr-out-0506.google.com with SMTP id 50so1308986wra.13
        for <git@vger.kernel.org>; Tue, 04 Mar 2008 08:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=CwjLDgiw/DBnwpIj6pu9syRnSEAo1Jcp8gbFZpn7hZM=;
        b=bS06tMg4sMipNbc3F0eOptuSW4yV39pMYFh9JEHTXD3d0flpIWNv7r65PC/HI4ZgsCZGvdDJF3DVsuFx9zQ+fu5AqSLllu2IaHJimDY/CLPcDrTpUapMQfoOrHfoLtbEKAChiu+DfZyk+c1iZ08oafX6C/g7et1HZjJpnOmmAhU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FpmRcnKYnljJcKNf/hmyiJcC2FHgt3rA+ibQq5fwRM/d/KJrSPjtmhOobiHvdVMSvRZ9RZc7m26abLU7/yx5jLj9EDR+VkpippuQoj26GcMZYBwLEtvkcXa7/HnmlafwZvbHoSrIIgFOk/oL4K6UFmu4UAam1aKhvp2Loj/eYEU=
Received: by 10.141.170.10 with SMTP id x10mr718923rvo.139.1204647778832;
        Tue, 04 Mar 2008 08:22:58 -0800 (PST)
Received: by 10.141.201.19 with HTTP; Tue, 4 Mar 2008 08:22:58 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76118>

using git current: c95b3ad9ea310ec89e31a21edecaaf2c374e2c46

xs5-trd-p1.grn:warmstro> sh t4109-apply-multifrag.sh -v -i
* expecting success: git apply patch1.patch patch2.patch
*   ok 1: S = git apply (1)

* expecting success: cat patch1.patch patch2.patch | patch -p1
  Looks like a unified context diff.
File to patch: ^CFATAL: Unexpected exit with code 3
xs5-trd-p1.grn:warmstro> sh t4109-apply-multifrag.sh -i -v
* expecting success: git apply patch1.patch patch2.patch
*   ok 1: S = git apply (1)

* expecting success: cat patch1.patch patch2.patch | patch -p1
  Looks like a unified context diff.
File to patch: ^CFATAL: Unexpected exit with code 3
xs5-trd-p1.grn:warmstro>

the test just hangs at "File to patch:" and I have to C^ to exit.

and that's exactly what I get executing the patch command myself:

xs5-trd-p1.grn:warmstro> cd trash/
xs5-trd-p1.grn:warmstro> cat patch1.patch patch4.patch | patch -p1
  Looks like a unified context diff.
File to patch:
No file found -- skip this patch? [no]
File to patch:
No file found -- skip this patch? [no] yes
Skipping patch...
  The next patch looks like a unified context diff.
File to patch: ^Cxs5-trd-p1.grn:warmstro>
xs5-trd-p1.grn:warmstro>


but with GNU patch-2.5.4 the test works (not sure what the failure is
at the end, but it looks like all the individual tests pass):


xs5-trd-p1.grn:warmstro> sh t4109-apply-multifrag.sh -i -v
* expecting success: git apply patch1.patch patch2.patch
*   ok 1: S = git apply (1)

* expecting success: cat patch1.patch patch2.patch | patch -p1
patching file main.c
patching file main.c
*   ok 2: S = patch (1)

* expecting success: cmp main.c.git main.c
*   ok 3: S = cmp (1)

* expecting success: git apply patch1.patch patch2.patch patch3.patch
*   ok 4: S = git apply (2)

* expecting success: cat patch1.patch patch2.patch patch3.patch | patch -p1
patching file main.c
patching file main.c
patching file main.c
*   ok 5: S = patch (2)

* expecting success: cmp main.c.git main.c
*   ok 6: S = cmp (2)

* expecting success: git apply patch1.patch patch4.patch
*   ok 7: S = git apply (3)

* expecting success: cat patch1.patch patch4.patch | patch -p1
patching file main.c
patching file main.c
*   ok 8: S = patch (3)

* expecting success: cmp main.c.git main.c
*   ok 9: S = cmp (3)

* passed all 9 test(s)
FATAL: Unexpected exit with code 0
xs5-trd-p1.grn:warmstro>


Again, this is on a Solaris 5.9 machine:
xs5-trd-p1.grn:warmstro> uname -a
SunOS xs5-trd-p1.grn.tudor.com 5.9 Generic_118558-38 sun4u sparc
SUNW,Sun-Fire-V240 Solaris
xs5-trd-p1.grn:warmstro>

Is the answer to use GNU patch? Or is there a trick to make the
Solaris version of patch work?

Thanks,
Whit
