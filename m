From: "Richard Quirk" <richard.quirk@gmail.com>
Subject: git-cherry-pick no longer detecting moved files in 1.5.3.4
Date: Wed, 17 Oct 2007 00:17:00 +0200
Message-ID: <cac9e4380710161517m64ba737dj8711a6ce59b1b69@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 00:17:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihuix-00007O-Mi
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 00:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965748AbXJPWRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 18:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934808AbXJPWRF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 18:17:05 -0400
Received: from wx-out-0506.google.com ([66.249.82.228]:61136 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934737AbXJPWRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 18:17:01 -0400
Received: by wx-out-0506.google.com with SMTP id h31so2240122wxd
        for <git@vger.kernel.org>; Tue, 16 Oct 2007 15:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=s6RvQwuKCD6fFPiI0loVosOoDIhnGDh7hrXNq1kvtSM=;
        b=RzipeXBY3X2qL1ui0ZYRuZHGFUI8ohl/J3Qdj/FcQ6GUTlK5CZ3lTClEYLBMm9BTq/z3Uj08rIRWmj7O6Go6S7T7VdqyM9NK5Iz1LVu7UhvtA3Z5w1cfFq8wt+qwhc3VSHChf9ZTSSfEw82GRXratq4PYjEyZDVv6HBPDiOdozg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Frc6DUgSfARNeOAdSGLcyC6zzQUBM8bLtHKfRbCrnat8cZywdKEaOyV1+C2qPQJjSjOlggqeOGHna8gh2ErDjFpBT3PqY5Bf+EMn5XRJjvlnWeapvnxyS+qBJ2hfJ0AQ2Nb1SBOCOymi9nw/En5Yel5LiDEs4U2PG/BbXTboMik=
Received: by 10.70.117.3 with SMTP id p3mr13796476wxc.1192573020184;
        Tue, 16 Oct 2007 15:17:00 -0700 (PDT)
Received: by 10.70.63.20 with HTTP; Tue, 16 Oct 2007 15:17:00 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61266>

I recently upgraded from git 1.5.3 to 1.5.3.4 and my cherry picks from
path/to/file.c to path/to/subdir/file.c stopped working. The error being:

CONFLICT (delete/modify): path/to/file.c deleted in HEAD and modified
in 9f944cb... <commit msg> Version 9f944cb... <commit msg> of
path/to/file.c left in tree.

The history of my project is that I had an extra sub directory that I
got rid of, moving files up a level on the master branch but this
extra directory is still present on a "release" branch. It is to this
release branch that I am cherry picking changes from the master one.
This worked fine in 1.5.4.

I tracked the change that scuppered my cherry picking down to this fix
by Linus for rename detection limits:
http://git.kernel.org/?p=git/git.git;a=commit;h=0024a54923a12

Seems like I hit the limit there - the moving changed the location of
about 140 files. I tried setting diff.renamelimit to -1 but to no
avail. Is it that the config value only applies for git-diff, not
git-cherry-pick? (Also, minor thing this, but the docs for git-config
says it is diff.renameLimit but diff.c uses diff.renamelimit.)
Recompiling with diff_rename_limit_default set to -1 in diff.c "fixes"
the cherry picking, but isn't ideal. Anyone have any ideas for a
better workaround/fix?

thanks,
Richard
