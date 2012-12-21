From: Manlio Perillo <manlio.perillo@gmail.com>
Subject: recommendation for patch maintenance
Date: Fri, 21 Dec 2012 15:45:03 +0100
Message-ID: <50D475EF.6060303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 15:45:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm3r6-00013p-LX
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 15:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751293Ab2LUOp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 09:45:27 -0500
Received: from mail-wg0-f54.google.com ([74.125.82.54]:50223 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751031Ab2LUOpZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 09:45:25 -0500
Received: by mail-wg0-f54.google.com with SMTP id fg15so2102566wgb.21
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 06:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=Cns3vaZWsgH8Jddjc1VCtwXRKNIKcTPMiOqY2RYMUBw=;
        b=qgNpe7khtYzO/DAv5hMNUPCReh9DHeyh7/CXHqo4+iuiOAX6MLXp8el6PX6uMLh+rZ
         IG+8qbLc7n1uqQ5Y5ONctszGp0dA8ijQ2CO/ZTlzVT/ZxIIslcmvgZabytfp596aW+zD
         J2GOH0byMqHbcb3w/RPkcZttgPRRsq1fNUEFhAd6Zy4dDlwcOF1THJnDPpoFrJ7GK6ST
         cfe0P6me+CQeFa7y24R6eGEsaqAvmV/BhvYVNe/+/l4xOL8OC+CyRcgSaqln37ckhlFs
         ktDGNC+EOO6AIw12cy5N0fpOqs4uo/Kfyw3m8LVwLR8ElVbNHwyt26isZAQK1bLYpoXK
         d/lg==
X-Received: by 10.194.88.164 with SMTP id bh4mr9094887wjb.37.1356101124520;
        Fri, 21 Dec 2012 06:45:24 -0800 (PST)
Received: from [192.168.0.3] ([151.70.200.164])
        by mx.google.com with ESMTPS id i2sm30102248wiw.3.2012.12.21.06.45.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 06:45:23 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.16) Gecko/20121216 Icedove/3.0.11
X-Enigmail-Version: 1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211972>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.

I would like to have advices about some possible workflows to use when
maintaining a patch, that can evolve over the time (fixing bugs, and
applying advices from reviewers).

In my case I have a single commit to maintain.


The workflow I use now is this:

  1) create a topic branch, e.g. mp/complete-path
  2) write code
  3) commit
  4) format-patch --output=mp/complete-patch master
  5) review the patch
  6) send-email

when I need to update the patch:

  1) modify code
  2) commit --amend
  3) format-patch --subject-prefix="PATCH v<n>" \
     --output=mp/complete-patch master
  4) edit patch to add a list of what was changed
  5) review the patch
  6) send-email


This is far from ideal, since all my local changes are lost.
Another problem is that when I found some trivial error in 5), I need to
call format-patch again, loosing the "what's changed list".


A possible solution is to:

1) create a "public" topic branch, e.g. mp/complete-patch
2) create the associated "private" topic branch, e.g.
   mp/complete-patch/private
...

Changes are committed to the private branch.
When I need to update the patch:

  1) update code
  2) commit new changes; the commit message will contain the
     "what's changed" list to be used for the new version of the patch
  3) checkout <public branch>
  4) merge --squash <private branch>

Now I have my full history, and the "what's changed list" is saved in
the private commits.

(not tested)


What is the workflow you usually use?


Thanks   Manlio
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlDUde4ACgkQscQJ24LbaUSqOwCfZON5f9mdAYkvACim802JGFhP
5W8An1Y7WXgsH/Q/p1/0jVMo1dJ3HwwO
=Xydn
-----END PGP SIGNATURE-----
