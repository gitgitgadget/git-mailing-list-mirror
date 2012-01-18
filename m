From: Jason Wenger <jcwenger@gmail.com>
Subject: Interesting behavior in git mergetool with no BASE revision
Date: Wed, 18 Jan 2012 17:05:56 -0600
Message-ID: <CAM6z=4_+yC4EnL9SZFd6=Nxs89QeHevNCakVzVycGBe7G+nTKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 00:06:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RneaG-0007Ly-Gi
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 00:06:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754929Ab2ARXGU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Jan 2012 18:06:20 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:63427 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752085Ab2ARXGT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2012 18:06:19 -0500
Received: by eaac11 with SMTP id c11so1108889eaa.19
        for <git@vger.kernel.org>; Wed, 18 Jan 2012 15:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=nebLfbBuVybmY9abnE7E7KfJ7t0VOliqYqlTKJ3gIiE=;
        b=dvboX1G4ABk018sbpw/jWlIKw7ceDedPmID9N5t1krnUjSK/LQLCSOGldJVudg0ce9
         RBbM2paR5KN6+OPbGOQ8MmmBi1TDnqbcG+eCSc74iQrfo0qIO59DZ1apU6Sa61dOpwWM
         YeJUKiBGmLRAST0qOaVylY3AnnYrWYY4wfVO0=
Received: by 10.213.29.135 with SMTP id q7mr6022243ebc.49.1326927978350; Wed,
 18 Jan 2012 15:06:18 -0800 (PST)
Received: by 10.213.36.16 with HTTP; Wed, 18 Jan 2012 15:05:56 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188776>

Doing a git merge on=A01.7.4.3, on a case where both branches have a
file created, and the base does not. =A0Per git-mergetool:

"the configured command line will be invoked with $BASE set to the
name of a temporary file containing the common base for the merge, if
available;"

So testing in this case, I set my mergetool cmd as "echo $MERGED
$LOCAL $REMOTE $BASE", and I get the following:

cio/.cproject ./cio/.cproject.LOCAL.9029.cproject
=2E/cio/.cproject.REMOTE.9029.cproject
=2E/cio/.cproject.BASE.9029.cproject

ls -a cio shows the following files:

=2Ecproject
=2Ecproject.LOCAL.9325.cproject
=2Ecproject.BACKUP.9325.cproject
=2Ecproject.REMOTE.9325.cproject

So the lack of base file makes sense -- There is no base to start
from. =A0However, $BASE evaluates to=A0./cio/.cproject.BASE.9029.cproje=
ct,
which is a nonexistent file. =A0This makes my actual mergetool upset to
no end. =A0Intuitively=A0from documents, I would expect $BASE to=A0eval=
uate
to an empty string in this case.

Is this intended behavior?

--Jason C. Wenger
