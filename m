From: Chris Packham <judge.packham@gmail.com>
Subject: re-running merge on a single file
Date: Thu, 11 Mar 2010 10:54:05 -0800
Message-ID: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Mar 11 19:54:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NpnWU-0000zG-6m
	for gcvg-git-2@lo.gmane.org; Thu, 11 Mar 2010 19:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934297Ab0CKSyK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Mar 2010 13:54:10 -0500
Received: from mail-pz0-f194.google.com ([209.85.222.194]:37578 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933735Ab0CKSyH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Mar 2010 13:54:07 -0500
Received: by pzk32 with SMTP id 32so194466pzk.4
        for <git@vger.kernel.org>; Thu, 11 Mar 2010 10:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=xTLTEkDaKobUBp2wXukoWFMsM1vB8TfO4YA81wxQLVQ=;
        b=Z4zOW/lqdyZHz/5qki0R3oDkFfQsiF0jR9jewyByDkMwTYDSqF85eDvBeH1gXQXrnh
         LUAf97HWwVpZPziFs6m0xnBnlGRX2D95489Qe7EzWBpOjuaHEjW0vXhAgygLn8DJn3gE
         wp3jQ4fIeF+3MZu9u2W3RAWmFHugMopYXP3dQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=vQGlqrEE5GZhWTd9xBORJN/joF+MDEqGe1NxYReTI5BauTysvOmUlWXQQ9trakamNb
         qnMvTnozLffYhwt0QBfJMs4T1H6zu4sp88/WvvBBbw2UZ33XFsOJqzPWKsl5A9DPNxDT
         75JXXI5+icJB6dap8qpqh3/Og/zIVPkPkkYZ8=
Received: by 10.115.114.29 with SMTP id r29mr1490581wam.142.1268333646357; 
	Thu, 11 Mar 2010 10:54:06 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141990>

Hi List,

I'm in the middle of updating our copy of another projects repository.
So far its been OK, we haven't diverged too much so it was a fairly
simple operation to add the projects repository as a 'vendor' remote
and get git merge to do most of the heavy lifting then use git merge
tool to fix up the things that git merge couldn't resolve. So right
now I have a history something like this.

-o-o-o-o-o           master
 \           \
  \           m        update
   \         /
    \-o-o-o            vendor

Now I'm finding that when I first used git mergetool for some things I
messed up and need to fix the code. In some cases this is because some
naming schemes changed in the vendor branch so I need to make
equivalent changes to the code we've added, no problem thats just more
commits on the update branch. In other cases I'm actually thinking
that it'd be easier to ask git to try the merge again on that one
file. I can ask git difftool to show me the pre-merge differences with
'git difftool master..vendor <file>' but what I'd really like to do is
ask git mergetool to do something similar so I can re-do my manual
merging.

Alternatively I could manually drive and external merge tool like
kdiff3 if I had a recipe for getting the common ancestor revision.
Something like

git checkout <magic pathspec> -- file
mv file file.base

git checkout master -- file
mv file file.ours

git checkout vendor -- file
mv file file.theirs

kdiff3 file.base file.ours file.theirs -o file

---
Thanks,
Chris
