From: Alexander Gladysh <agladysh@gmail.com>
Subject: False positives in git diff-index
Date: Mon, 27 Dec 2010 11:49:40 +0300
Message-ID: <AANLkTimLW+J_rmRsqUQJO-9Gzn7aK0ZHkd1-s=Wg4Vbi@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 27 09:50:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PX8mQ-00015t-7u
	for gcvg-git-2@lo.gmane.org; Mon, 27 Dec 2010 09:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708Ab0L0IuD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Dec 2010 03:50:03 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:34799 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752523Ab0L0IuB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Dec 2010 03:50:01 -0500
Received: by qwa26 with SMTP id 26so8292239qwa.19
        for <git@vger.kernel.org>; Mon, 27 Dec 2010 00:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=UpcakG2mxj3kILIw5zwbp+KZeLQvb5W9IZGrLCMlemg=;
        b=k8kNCu699fRBiwdyEGsYXlpEC4HgUN0Ul18xXX9Ez4HHlQogi7W3fLCBCVzJ0/dDz+
         osxOGbyA4H6mJkU55RiYQ1EZGDRNW4LN8HzpKLrGf8y30XB3e03bGZSMNY9z3MmoPC24
         3HcViIfR6NIhUGbCzQR2+qEZJjNMI1yINYvcA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=bKtbdM2HRQ0bxDiawf+/4lxEyLkqfbI5hC9gfpjyfyxCIE3zSyyHg5BXCZyLnjK4bR
         QaUb05lK2OOaJsNfGyVAb7aTA3TYS8ZD711n9yvg78W6FQeDvijlYjGTU1Y0/tY33/O3
         0Wgc5oKOj2/xvN3dMgCWA3Ko9HC+AfQ0gaHVE=
Received: by 10.229.250.11 with SMTP id mm11mr4475801qcb.91.1293439800115;
 Mon, 27 Dec 2010 00:50:00 -0800 (PST)
Received: by 10.229.48.5 with HTTP; Mon, 27 Dec 2010 00:49:40 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164216>

Hi, list!

I wrote about the related issue earlier:

http://lists-archives.org/git/731516-false-positives-from-git-diff-inde=
x-when-used-with-git-dir.html

Now I've got a case when I can reproduce this problem each time I try t=
o.

Unfortunately I can not share it or create a minimal example =E2=80=94 =
the
case is triggered by a custom complicated automated build process on a
private repository.

Anyway, I'm ready to debug this issue if someone will guide me.

Workflow:

<...change files in /path/dir1/...>
(cd /path && git add </path/dir1/>)
(cd /path && git commit -m <message1>)

=2E.. repeat change-add-commit several times for various directories
(can be the same directory or not) ...

<...generate file /path/dirN/foo...>
# Accidentally the file is generated the same as it was

(cd /path && git add </path/dirN/>)
(cd /path && git status) # Refresh index
(cd /path && git diff-index --exit-code --quiet HEAD -- /path/dirN) #
Incorrectly reports that there are some changes
(cd /path && git commit -m <messageN>) # fails, saying that there is
nothing to commit

If I insert sleep 10 between git status and git diff-index, the
problem goes away.

Any help?
Alexander.
