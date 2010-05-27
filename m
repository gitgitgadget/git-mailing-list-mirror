From: Chris Packham <judge.packham@gmail.com>
Subject: git fast-export/fast-import *facepalm*
Date: Thu, 27 May 2010 13:46:38 -0700
Message-ID: <AANLkTinV5mEACphA-nW9URce0Mh9xyu3UjWmfBqL6cLN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 27 22:46:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHjyZ-0006iB-MI
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 22:46:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756581Ab0E0Uqk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 16:46:40 -0400
Received: from mail-qy0-f183.google.com ([209.85.221.183]:43032 "EHLO
	mail-qy0-f183.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755281Ab0E0Uqj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 16:46:39 -0400
Received: by qyk13 with SMTP id 13so588084qyk.1
        for <git@vger.kernel.org>; Thu, 27 May 2010 13:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=IUTGN8ZQbUBoI8I2FKTlj8Ly129XqZ8vHUzEwresQPY=;
        b=IvZ9DHmbOQ7lLVeRLXj+DTx706ZZ28foDrOVW7GsnaobuHnyXVFPrfX22B6PBqutgI
         aWlMvwz2EwM9eCIwzhYndJ3cYVqdvAILT6AbqKrDu5Dr5BXCzLS2N0gWDa9EdtFzoIcX
         FlaepD+HURFEEPCPCTzOh7/H5g9THHzZBbc8o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=PN4RJaVsIMirn4zMwxLGNydYXD5vJ7Tc/FpwnIHjXBneUV6leoJtIAEwRfcIGvKp4Q
         HdSQX/k6GG/MUHWPQ8HyrFLbQ4Xvg0VTdzn98qx5e9ILXoCVfkARL6lEi8TQpmcWo7ff
         ATxClJZ+zG7aTGXkCMxXURt+/QUuzPFw5+vy8=
Received: by 10.224.121.212 with SMTP id i20mr5963268qar.11.1274993198670; 
	Thu, 27 May 2010 13:46:38 -0700 (PDT)
Received: by 10.229.26.74 with HTTP; Thu, 27 May 2010 13:46:38 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147897>

Hi,

I've had a bit of a brain melt and have done something silly with git
fast-import and was hoping someone would be able to get me out of the
mess I've created.

Basically I've got a linux repository which for various reasons isn't
based of any of the kernel.org ones but reflects our kernel
development on top of vanilla kernel tarballs. When we update we take
the tarball and extract and commit it to a vendor branch then merge
that with our main. A little strange but it works for us (despite
having to go hunting on kernel.org when we want the external history).

My brain melt came when I wanted to get the set of changes between 2
versions from a public branch and import them into our repository.
Having just learned about git fast-export I decided that it was the
right tool for the job so I did the following

(cd linux-2.6.32.y; git fast-export v2.6.32.12..v2.6.32.14) | git fast-import

What I've ended up with is a repository with a detached set of changes i.e

o -o   l - l - l - l - l - l     o - master
     \                          /
      o - o - o - o - o - o

o = our commits
l = linux commits

Because the code is common textually I think what I really should have done is

(cd linux-2.6.32.y; git format-patch v2.6.32.12..v2.6.32.14) | git am

Which I'll give a try in a minute. In the meantime is there anyway for
me to safely remove the upstream linux commits without loosing our
commits in the process?

Thanks,
Chris
