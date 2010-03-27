From: Jon Seymour <jon.seymour@gmail.com>
Subject: git gui: merge conflict display is misleading since it hides 
	non-conflicting remote hunks
Date: Sat, 27 Mar 2010 13:20:42 +1100
Message-ID: <2cfc40321003261920k5b649eeeybeb84e1dbcb7787@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 27 03:20:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvLdp-0007LW-F7
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 03:20:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab0C0CUo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 22:20:44 -0400
Received: from mail-pz0-f194.google.com ([209.85.222.194]:36628 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752461Ab0C0CUn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 22:20:43 -0400
Received: by pzk32 with SMTP id 32so3142310pzk.4
        for <git@vger.kernel.org>; Fri, 26 Mar 2010 19:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:received:message-id
         :subject:from:to:content-type;
        bh=xqq6EPNaoeW1VmQVo57HBVJg/h2CANU7bauyK9BWhhY=;
        b=FkLTEZZO4DtYPJtB2BJbrtpiCEPu7PfHZ5MJyJdyVjl7oIz/oHCwXyI2OB0qMgp7ZA
         YHoVjw5KjMFvPn46pI79/lajagEnw93rezJPkcCS8tkhPsJU8eRvVy+rBdA351ZTBy5g
         54gCOxetnUk/c6gMPd3x2KhPiCro1ppLKhZpU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=hRVkcQsbumPbcOndygtqIPwsrE+cUZZWQuxHeJeHwQeF5JZVgK8ZNQmocyhkys6RlS
         44EBy/QvQl3RWhBzYOeId9ofOy5BMBnU2SEHsnSOQiIhzDJZ3w0mfhTKEr9Ylf0En8WM
         L+VS8ImbfwW6+eZollPR8R9+VI/wZJ9X+ujBE=
Received: by 10.115.89.7 with HTTP; Fri, 26 Mar 2010 19:20:42 -0700 (PDT)
Received: by 10.115.98.12 with SMTP id a12mr1876747wam.55.1269656442662; Fri, 
	26 Mar 2010 19:20:42 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143313>

In v1.6.6.1 of git (cygwin build), git gui has behaviour that I
believe is misleading in the presence of merge conflicts.

In the case in point the file being merged had diverged from the base
in both the local and remote repos.

The main hunks in each change merged cleanly, but there was a trivial
conflict on one line.

In GIT gui this was rendered as:

   <<<<<<< HEAD
   +import someclass;
   =======
   >>>>>>> remote

GIT GUI did not render the the interesting hunk from the remote that
merged cleanly.

As a result, the user thinks that the only conflict is the import
statement, and elects to resolve the commit in favour of the local
commit. This is the wrong thing to do because the remote hunk is then
lost to the history.

On the other hand, if the user manually resolves the conflict with an
editor and then rescans, the resolution of the conflict is shown, but
the remote hunk is not shown. Only if the user then adds the resolved
file to the index, does the remote hunk display in GIT GUI.

In my view, the current behaviour of git gui when displaying merge
conflicts is misleading because the display falsely leads the user
into the mistaken believing that the only change in the remote is the
conflict when, in fact, this is not true.

Is there any good reason why GIT gui can't show the full diff between
the working tree file and the current HEAD?

jon.
