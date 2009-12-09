From: Jay Soffian <jaysoffian@gmail.com>
Subject: Help: approach for rebasing to older commits after merging more 
	recent commits
Date: Wed, 9 Dec 2009 12:04:26 -0800
Message-ID: <76718490912091204u3a4596fdi504005624d5a5bce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Dec 09 21:04:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NISm2-00078G-VK
	for gcvg-git-2@lo.gmane.org; Wed, 09 Dec 2009 21:04:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757333AbZLIUEV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2009 15:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756986AbZLIUEV
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Dec 2009 15:04:21 -0500
Received: from mail-iw0-f171.google.com ([209.85.223.171]:59805 "EHLO
	mail-iw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750955AbZLIUEU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Dec 2009 15:04:20 -0500
Received: by iwn1 with SMTP id 1so4836948iwn.33
        for <git@vger.kernel.org>; Wed, 09 Dec 2009 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=3AtyY/BIxzkiHwxYdgOnPZriersCTc3dEQfCi8PuERM=;
        b=KFGDf0Rcl+q6urovJuiGYCMIsLoGsX8ce3/JOJ9aqX4XR5u0Sv1fMCaFB4ROdwA8nV
         fh76JKnvxBImNtB8Qh/Baaexo6s8yTGtE9BwVlrZVAkf9EqNyXgRP7HXy9KK4kfDyeOj
         USb5qxleY1+eLJ31BSQpI+dsNFQqD6qQrhdCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=WmSiaOAEIm3EaUAWNCutitTZtQfYlUjX0bDO9y4tEt4uRLC/wMSv5jXa5kQXRNAj3g
         69QpxM9rQtzFsA8BYsgok45wuuBtqJX8vwI/pjvKuhSAPMtG/5lznQvyTlx53tOa/93I
         yzgtmMPMm6/dsbEMRD43pcHjhCVren2b6q2KI=
Received: by 10.231.42.150 with SMTP id s22mr334530ibe.22.1260389066664; Wed, 
	09 Dec 2009 12:04:26 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134995>

I have an interesting problem I'm not sure how best to tackle.

A small development team is basing its product on an upstream git repo that is
itself an svn clone. Currently the process looks like this:

r1--r2--r3--r4--r5   upstream trunk   (git svn clone)
 \       \       \
  A---B---C---D---E  local trunk      (git clone of upstream)
       \     /
        F---G        developerN trunk (git clones of local)

So local trunk has both daily merges from the local developers, as well as
less periodic (typically weekly) merges from upstream trunk. The reason being
that it is necessary to remain on top of the upstream bleeding edge.

This works out okay, but there is a minor problem and a major problem.

The minor problem is that the local trunk is cluttered with the developerN
merges. That is easy to solve by having local developers rebase before pushing
to local trunk. That would look like:

r1--r2--r3--r4--r5            upstream trunk
 \       \       \
  A---B---C---D---E---F'---G'  local trunk

The major problem is that local trunk is also cluttered with merges from
upstream. The is a problem because at some point in the future, upstream
is going to declare some rN as being officially blessed. And we're going to
want to rewind any rN changes past that point.

So the question is, what's the best way to do this? Say r2 is blessed by
upstream. The obvious thing to do (I think...) is:

(local-trunk)$ git rebase -i r2

removing C and E from the pick list.

But, occassionally the merges from upstream require much conflict resolution.
Would enabling rerere during merges help with the rebasing? I would want to
reuse as much conflict resolution as possible.

Is there a better approach altogether? Should we be doing something other
than merging to stay atop upstream?

Suggestions/comments greatly appreciated.

j.
