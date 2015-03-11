From: Shawn Pearce <spearce@spearce.org>
Subject: git commit --amend safety check?
Date: Tue, 10 Mar 2015 21:31:40 -0700
Message-ID: <CAJo=hJuwdOzNZSVBRAPDz97Gdoi6JWvYxE0ufY+Hd9K8jjCqfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 11 05:32:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YVYJU-0002Kq-1E
	for gcvg-git-2@plane.gmane.org; Wed, 11 Mar 2015 05:32:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbbCKEcD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Mar 2015 00:32:03 -0400
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33007 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751532AbbCKEcC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Mar 2015 00:32:02 -0400
Received: by ykt10 with SMTP id 10so2910114ykt.0
        for <git@vger.kernel.org>; Tue, 10 Mar 2015 21:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=thkCF75P9TyuF2medrM5QH7PYfckqOIBRJ18A0V4JoY=;
        b=GfrnsRQoeY3ROe343bbKkdM/U7kM+F9uSFAOkJNlJ3tlvzxsNOdQLIWUFW+0rllaeu
         swAebU0uyZdo9QhY2fFYzVTuEshRTyli7PvblwqvYkKL4JwYSmnmpWPvA+lAVyvcEfND
         d0BTmQ0pe+vueLVGpNQjnZnUuV2id7sTkmGK4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=thkCF75P9TyuF2medrM5QH7PYfckqOIBRJ18A0V4JoY=;
        b=WIeqgbD4qnVRkTU9oS1zWlrE8LRffNEUbsmR38Vq1HUNPC9OnTRSPpI9BzT0RAxUVG
         4gZMbsRsaBsZZ4kpL6wAlHH4Gsw+doO/LH3btL9RioxuVtVnxsOI5KtJ8j6O/OkPm3dD
         VydKun2v8rQ8beEv0O88tzwFjRhmjB3IYGeRU3kinz3JN/YRHG61barug4eenEDuA/28
         94l+MYOBlK+JZgPx6SHYCL+0kdBIEyPvXw7F3H3JMR9te4uET1ks+ODJURY4mexrDGM7
         LxHYOnbUuFdZmI2rlh/fGrihXYpLUDwlwdBoKcRnqQQZGp7VLjD/QnFjI6Tqzfc5qANz
         0iIA==
X-Gm-Message-State: ALoCoQkaScgzBjqyKsEIjib2NE0m/YRdtc/q6impX7ZcnYopTHnz4V9XjVwLpS7Y1wY3q1WiOAS+
X-Received: by 10.236.228.34 with SMTP id e32mr34569308yhq.33.1426048320563;
 Tue, 10 Mar 2015 21:32:00 -0700 (PDT)
Received: by 10.170.122.149 with HTTP; Tue, 10 Mar 2015 21:31:40 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265299>

We keep seeing reports of Gerrit Code Review users who incorrectly do
something like:

  git clone URL foo
  cd foo
  git commit --amend -m "My first change!" -a
  git push URL HEAD:refs/for/master

Step #3 is where they get into trouble. They just amended the
published tip commit and pushed it back to the server. That is... lets
just say not good.

Hg is known to be more user friendly. One way its user friendly is it
by default refuses to let you amend a change set that the client has
reasonable assertion to believe was already published through a remote
repository.

For Git that would mean `commit --amend` refusing to amend (by
default) if the commit is reachable from a refs/remotes/... tracking
branch.

Thoughts?
