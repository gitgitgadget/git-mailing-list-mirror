From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git-svn: ignore-paths not enough (not ignoring refs?)
Date: Thu, 6 Oct 2011 10:43:12 +0200
Message-ID: <CAA01CsqEdoqSRrPDTrfOQPS7q-1tVALE_5vjeLUAeh0iXZi3_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Eric Wong <normalperson@yhbt.net>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Olson <mwolson@gnu.org>
X-From: git-owner@vger.kernel.org Thu Oct 06 10:43:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBjXy-00010G-BK
	for gcvg-git-2@lo.gmane.org; Thu, 06 Oct 2011 10:43:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935572Ab1JFInN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Oct 2011 04:43:13 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:36079 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932384Ab1JFInM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Oct 2011 04:43:12 -0400
Received: by ggnv2 with SMTP id v2so1486288ggn.19
        for <git@vger.kernel.org>; Thu, 06 Oct 2011 01:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=bS3CZxo06OeoH6klKN049H3Axjbw6SX5DYl1xdSIl5o=;
        b=DFmnqVLrjz9Jpa6GWHaBLwpAnsvLijW8LDtJo2IXdsdaw0WrjDlJZfU4FjKXGgUusQ
         +5AZLsepy8r8z/WaRfVatThOmmSy6JthsOYaq5t9kJ5QrlPiYhRM8YgkvJla1fl01YFI
         SDh2+7W9rWMKKcXIr4eQ9cDM1rM4gRT6Mp+Go=
Received: by 10.150.208.15 with SMTP id f15mr340480ybg.401.1317890592111; Thu,
 06 Oct 2011 01:43:12 -0700 (PDT)
Received: by 10.150.196.1 with HTTP; Thu, 6 Oct 2011 01:43:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182935>

Hi,

I'm using --ignore-paths options but some paths which should be
ignored (they math the regexp) are not ignored. I suspect this is
because of http://thread.gmane.org/gmane.comp.version-control.git/145398

It seems the patch from that url was never accepted to git. It does
not apply anymore too. Is it possible to update the patch? From the
discussion the patch looked ok (with exception to git-svn dying if a
parent ref didn't exist :) )


Here's my git-svn clone log, with some print lines added to is_path_ignored():

$ git svn clone -s --no-follow-parent  --ignore-paths='$REGEXP -r 1230:1240 $URL
[...]
is_path_ignored: 'xtest/tags/rel1'  # this matches the regexp and
should be ignored
is_path_ignored: 'xtest/tags/rel1/common' # more paths which should be
ignored follow
[...]
r1237 = c660a7e6ad81cafa0a64a7ec85a3e23f0c02bc09
(refs/remotes/tags/rel1) # but it is not!

# I can see the tag:
$ git branch -a
  remotes/tags/rel1

# There are no changes in this change:
$ git show -p c660a7e6ad81cafa0a64a7ec85a3e23f0c02bc09
[...]
    git-svn-id: $URL/rel1@1237 3e523551-a86b-4873-bcb6-76fcd93a4c5c

# Under svn the r1237 is following:
$ svn log -r 1237 -v $URL
------------------------------------------------------------------------
r1237 | ...
Changed paths:
   A /xtest/tags/rel1/common (from /xtest/branches/xtest44/common:1235)

# The xtest/branches/xtest44/common does not match the ignore-paths
and is not ignored.


-- 
Piotr Krukowiecki
