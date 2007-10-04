From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: stgit: lost all my patches again
Date: Thu, 4 Oct 2007 01:29:17 -0400
Message-ID: <9e4733910710032229m38fb4e47k5aa0b2b2e0eb2251@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 04 07:29:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdJH5-0003A8-4U
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 07:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751789AbXJDF3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 01:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbXJDF3T
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 01:29:19 -0400
Received: from wa-out-1112.google.com ([209.85.146.182]:59821 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751537AbXJDF3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 01:29:18 -0400
Received: by wa-out-1112.google.com with SMTP id v27so74243wah
        for <git@vger.kernel.org>; Wed, 03 Oct 2007 22:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=0qlqUicROBY3otL4U82TqYk8JC1A0ypA919P85TUTdE=;
        b=e0B66Db+VZkuzac63I1aVnWCghhb0jY2T8vOdT3XOZ/JLr+My+L9WRriEcgOP+Ph27PMlZsicHDilhrNRmeutgniUV3jp3JB/wFkMA20sZrehguNbp9jfClhyQT+8FSZQ315FcM+CE51mGkBvyU+4Bd2mJ6g6BZXMNOjLYRCxCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=gv13d/7W9TOhe2B+ZXRwfx8lbVnsmjxyW8TYy5k0sPHbvSW1w/wwQHaDyCpb9K5SAA+IzF1uTGXv79h/tFx1X43TS9CkWXQR4sPwIDHWZVGiz46Tu7bUT5gbWsUZHKLXkmXBTMOEUpAgi6H7/m9oDHX4YtnO2CyHTrGu1pERZsk=
Received: by 10.114.169.2 with SMTP id r2mr9241245wae.1191475757482;
        Wed, 03 Oct 2007 22:29:17 -0700 (PDT)
Received: by 10.114.195.11 with HTTP; Wed, 3 Oct 2007 22:29:17 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59919>

I believe this command did it:

stg refresh -p pcm030_bsp_powerpc -e

that patch whitespace errors in it
I edited the description and removed the last line
it was 10th patch down in the stack

for some reason the refresh from that command didn't close.
Then stg pushed all the patches back after the edit and they got
included into that patch.

stg should definitely have an assert that the previous patch is closed
before auto pushing.
There is a bug somewhere that caused that edit refresh not to get closed.

I am using stg version:
5ae6fcce77a29221e15f6a4e8348bd4276960ba1

It might also be good to make a log that lets me rollback commands.
All of the info is still in the system.

This refresh failed to close:
jonsmirl@terra:~/mpc5200b$ stg log pcm030_bsp_powerpc
95a8e03b [push   ]                               Thu Oct  4 00:27:53 2007 -0400
6094a0a5 [refresh]                               Thu Oct  4 00:00:41 2007 -0400
0c4f5480 [push(f)]                               Wed Oct  3 22:10:38 2007 -0400
9a685ae9 [push(f)]                               Wed Oct  3 22:05:47 2007 -0400

This push ended up in the bsp patch:
jonsmirl@terra:~/mpc5200b$ stg log mpc52xx_restart
801962ed [push   ]                               Thu Oct  4 00:33:42 2007 -0400
9e0c7417 [push   ]                               Thu Oct  4 00:27:53 2007 -0400
37822491 [push   ]                               Thu Oct  4 00:00:41 2007 -0400
9aff07ff [push(f)]                               Wed Oct  3 22:10:38 2007 -0400
c41c9cb3 [push(f)]                               Wed Oct  3 22:05:47 2007 -0400

and so one for nine more patches.
The ten messed up patches still have their descriptions, the are just
missing the changes.

---------------------------------
After an export stg puts the patches into patches-m25
Looking back in my command logs I had done:
  stg export
  cd patches-m25
  grep for some things
  stg refresh -p pcm030_bsp_powerpc -e

I did the 'stg refresh' from a directory that was not being tracked by git.
It is in the .gitignore list. This appears to be the root of the problem.

-- 
Jon Smirl
jonsmirl@gmail.com
