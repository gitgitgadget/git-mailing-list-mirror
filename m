From: Sam Varshavchik <sam.varshavchik@gmail.com>
Subject: Push to a branch breaks origin, requires a manual gc to fix
Date: Sun, 17 Jun 2012 11:07:50 -0400
Message-ID: <CAMO9iftAP_QKDJwssvPhg0jm8MBjV3isCxKNuP0Ewf-X6kYtxQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 17 17:08:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SgH5X-0005mI-7I
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jun 2012 17:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757442Ab2FQPH4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jun 2012 11:07:56 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:56475 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757426Ab2FQPHu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Jun 2012 11:07:50 -0400
Received: by obbtb18 with SMTP id tb18so7080749obb.19
        for <git@vger.kernel.org>; Sun, 17 Jun 2012 08:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=h5bdPQbL2yqzqYFmxr80CktdCQQisy+9JC+dnBQvCMQ=;
        b=Q54gJsamxXKYKefqfBmE0yVdDLL5uF3HWa5u+O2uXP3ce6wigsahTXWHckBoh1w+L0
         cQWlu6zCxVUjOT3zv4K8VoccD8Vp4lyOrCGe4ZZKEqyGxBMAnT8BGj+bUGInfXyL9Y1B
         h9RH/p8s6JKckw0t7Vrc/xqqeg2XSEb+Lz3tRgAUGFaEMV9s8ByiNSTRMp6E0ews2gP3
         recCsF5S94zLxOexiyCgh59Z1lqqnnwOkUfKNlyPvsdV4EVz/4KrnALClOEOAez5jBac
         jVFmHBzGcXS004JFTGuP4gs5AJYH7Xo/epX5Xxevad1s0nPNwnQpQrUUfkrrlPCjqWZy
         uZbA==
Received: by 10.50.222.134 with SMTP id qm6mr6208085igc.49.1339945670062; Sun,
 17 Jun 2012 08:07:50 -0700 (PDT)
Received: by 10.231.245.5 with HTTP; Sun, 17 Jun 2012 08:07:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200123>

Something's goes wrong every time I push a branch to origin.

When I start, everything looks ok:

$ git remote show origin
* remote origin
=C2=A0 Fetch URL: http://monster/gitrepos/stasher.git/
=C2=A0 Push=C2=A0 URL: http://monster/gitrepos/stasher.git/
=C2=A0 HEAD branch: master
=C2=A0 Remote branches:
=C2=A0=C2=A0=C2=A0 distreboot tracked
=C2=A0=C2=A0=C2=A0 master=C2=A0=C2=A0=C2=A0=C2=A0 tracked
=C2=A0 Local branches configured for 'git pull':
=C2=A0=C2=A0=C2=A0 distreboot merges with remote distreboot
=C2=A0=C2=A0=C2=A0 master=C2=A0=C2=A0=C2=A0=C2=A0 merges with remote ma=
ster
=C2=A0 Local refs configured for 'git push':
=C2=A0=C2=A0=C2=A0 distreboot pushes to distreboot (fast-forwardable)
=C2=A0=C2=A0=C2=A0 master=C2=A0=C2=A0=C2=A0=C2=A0 pushes to master=C2=A0=
=C2=A0=C2=A0=C2=A0 (up to date)

I push:

$ git push
=46etching remote heads...
  refs/
  refs/heads/
  refs/tags/
updating 'refs/heads/distreboot'
  from 0000000000000000000000000000000000000000
  to   e0bce568272859eca817455acafb5f0a52b8fd5a
    sending 6 objects
    done
Updating remote server info
To http://monster/gitrepos/stasher.git/
   6d4900e..e0bce56  distreboot -> distreboot

This breaks something:

$ git remote show origin
* remote origin
  Fetch URL: http://monster/gitrepos/stasher.git/
  Push  URL: http://monster/gitrepos/stasher.git/
  HEAD branch: (unknown)
  Remote branches:
    distreboot                 tracked
    refs/remotes/origin/master stale (use 'git remote prune' to remove)
  Local branches configured for 'git pull':
    distreboot merges with remote distreboot
    master     merges with remote master
  Local ref configured for 'git push':
    distreboot pushes to distreboot (up to date)

Going forward, clone will fail:

$ git clone http://monster/gitrepos/stasher.git/ stasher-test
Cloning into 'stasher-test'...
warning: remote HEAD refers to nonexistent ref, unable to checkout.

If I do some random fiddling in the origin repo (not really knowing
what I'm doing, I can usually fix it:

sh-4.2$ cat HEAD
ref: refs/heads/master
sh-4.2$ ls -al refs/heads
total 16
drwxr-xr-x 3 apache apache 4096 Jun 17 10:53 .
drwxr-xr-x 4 apache apache 4096 May 24 10:37 ..
drwxr-xr-x 2 apache apache 4096 Jun 17 10:53 .DAV
-rw-r--r-- 1 apache apache   41 Jun 17 10:53 distreboot
sh-4.2$ cat info/refs
e0bce568272859eca817455acafb5f0a52b8fd5a	refs/heads/distreboot
sh-4.2$ git gc
Counting objects: 124, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (59/59), done.
Writing objects: 100% (124/124), done.
Total 124 (delta 67), reused 116 (delta 63)
sh-4.2$ cat info/refs
e0bce568272859eca817455acafb5f0a52b8fd5a	refs/heads/distreboot
ee94edb5fcdc7a28ffbdeaabe841e3ecff863983	refs/heads/master
sh-4.2$ ls -al refs/heads
total 12
drwxr-xr-x 3 apache apache 4096 Jun 17 10:54 .
drwxr-xr-x 4 apache apache 4096 May 24 10:37 ..
drwxr-xr-x 2 apache apache 4096 Jun 17 10:53 .DAV

git clone starts working again.

Until I push the branch, and then master breaks again.
