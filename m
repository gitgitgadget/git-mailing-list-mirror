From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: First/oldest entry in reflog dropped
Date: Sat, 20 Nov 2010 22:11:34 -0500
Message-ID: <AANLkTiktGbeSmUB75kn3q=swnw=cHvivX21OkR3sJJDC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 21 04:22:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PK0V5-00013j-Ht
	for gcvg-git-2@lo.gmane.org; Sun, 21 Nov 2010 04:22:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752059Ab0KUDLg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Nov 2010 22:11:36 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58366 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687Ab0KUDLf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Nov 2010 22:11:35 -0500
Received: by qyk5 with SMTP id 5so245501qyk.19
        for <git@vger.kernel.org>; Sat, 20 Nov 2010 19:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=kgx0+Ux3GIAFiA2K5TYL5vMsCdPXKjYzLcxoFPJjikA=;
        b=JHwDGYcZsQFvqWFu9YzFvEq0RBN6aNLYO70h+2lLbNMPmLh6pxGQIKq7ths2Isu5K7
         0QwoQqDi9BKU3wGU7zYdHxw/iOdRyHwdOE1ErLlAeiw96RVxbwR1M7EqRWby6A3dU1uO
         htuZAHtQbTaDn+YtcamIJAdJB4E9BVUWIxxGU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=Dv2kLiBci6+HecnCA6aJPL6A5jOq3JsWwVPlAy83Vq8hailEDrqIIERISOgIuM8+dp
         P/ZuVKzytnd8WNXZ3rtCHaGQxScxCywPi2iI1Cqam+dupGaqhuqbt5MujI/uP4px6Ri9
         753YNpT2SYTKeGS602OAKKM1qAkWZo1mtPq2I=
Received: by 10.224.215.193 with SMTP id hf1mr3595777qab.275.1290309094477;
 Sat, 20 Nov 2010 19:11:34 -0800 (PST)
Received: by 10.224.80.202 with HTTP; Sat, 20 Nov 2010 19:11:34 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161853>

Can someone explain the behavior in the execution below?

# I expected this reflog...
$ git branch tmp
$ git reflog show refs/heads/tmp
b60a214 refs/heads/tmp@{0}: branch: Created from master

# ... and this one as well...
$ git update-ref refs/heads/tmp HEAD^
$ git reflog show refs/heads/tmp
7d1a0b8 refs/heads/tmp@{0}:
b60a214 refs/heads/tmp@{1}: branch: Created from master

# ... but why is the first entry (i.e. "branch: Created from master")
# dropped here?
$ git update-ref refs/heads/tmp HEAD
$ git reflog show refs/heads/tmp
b60a214 refs/heads/tmp@{0}:
7d1a0b8 refs/heads/tmp@{1}:

If the ref is updated once more (to e.g. HEAD^^) before being moved back
to HEAD, the first entry will be shown in the output.

If this is a bug, it seems to be in reflog, rather than in update-ref,
because the first entry does exist in .git/logs/refs/heads/tmp.

Thanks,
Martin
