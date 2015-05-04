From: Chris Lasell <chrisl@pixar.com>
Subject: Bug: git-p4 edit_template() and P4EDITOR w/options
Date: Mon, 4 May 2015 14:26:03 -0700
Message-ID: <5D2E2EAF-FFE7-437F-A716-E152E865E634@pixar.com>
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 04 23:35:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpO1n-0008TY-0s
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 23:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbbEDVfr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 May 2015 17:35:47 -0400
Received: from smtp-lb.pixar.com ([138.72.247.109]:16634 "EHLO
	smtp-lb.pixar.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751613AbbEDVfp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 May 2015 17:35:45 -0400
X-Greylist: delayed 580 seconds by postgrey-1.27 at vger.kernel.org; Mon, 04 May 2015 17:35:45 EDT
DomainKey-Signature: s=emeryville; d=pixar.com; c=nofws; q=dns;
  h=Authentication-Results:X-PixarMID:X-PixarRecvListener:
   X-PixarRemoteIP:X-PixarMailFlowPolicy:X-IronPort-AV:
   Received:From:Content-Type:Content-Transfer-Encoding:
   Subject:Message-Id:Date:To:Mime-Version:X-Mailer;
  b=KEgewapwyMtqXaMp44Ln+bFrS51LFRsS43RvpEMCj8iuhHb0win+A72D
   iPobx86grTagOrR8/X6jG0gV20rP0vj+hx2WWiyITL6RRM8shH6mb8+QN
   PbulwOVGXiJWib+Of7vq8IL2C7C+9zT9KGYbgNoxY6pZ0QK2+0uFyg87d
   g6mVPsZ15KdQ56XhKGVOZr0EqwcwvZ5uivR5SPFSXQtykopFf5xtlzjw8
   M8++ydRPYrbU/U1QhDDK+vp3YCqPmaxQy+3dZyRaV8htHkqiUxNBqxS3a
   m5XmZ6HQdJ8z446YRzIaKIDlRt5sBNYgyildw9PYMj32J3zSfPCQIoP1S
   w==;
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=pixar.com; i=@pixar.com; q=dns/txt; s=dkimdefault;
  t=1430775345; x=1462311345;
  h=from:content-transfer-encoding:subject:message-id:date:
   to:mime-version;
  bh=6UZwyxGFEwCZbpCSb0jX3dcvB9KQRpTarBjT7m6Bf5Q=;
  b=PWHcCkRNSNyuHOqorloBPJYCetHp3IRKu1mwYYkkY1EEU39z9V+EZu5V
   npuLgyDR8hnfWuTaprlJf/LU22Ppr1j0I9a0wF7ri8mT3RJC7LdT9iNio
   uMpAlDlJZcN+1lIeuw/1kv8/l8otvphAU6YArlJPh077SLHhmO/3M0uTM
   RoBZ8X07YfaAPpu435lP6socy+3YMjg1bX7+Sq5Ec/XTDEY3fBKoLf8uM
   qyKiqa52H+lyXcO2WtGNuq7sq/WYU5jYJ7zCZi3eEECQBugxcP9Bm/CQD
   zQTxPQd/IY56GvtYLUMwFjtDfPqMGyaM1diFeVJiJ6glLUYq0oy7pncGu
   w==;
Authentication-Results: smtp-lb.pixar.com; dkim=neutral (message not signed) header.i=none
X-PixarMID: 32499829
X-PixarRecvListener: OutBoundAuth
X-PixarRemoteIP: 138.72.244.133
X-PixarMailFlowPolicy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.13,368,1427785200"; 
   d="scan'208";a="32499829"
Received: from unknown (HELO [138.72.244.133]) ([138.72.244.133])
  by smtp-lb.pixar.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 04 May 2015 14:26:04 -0700
X-Mailer: Apple Mail (2.1993)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268357>

Hello Git Folks!

I recently had a user who was unable to perform a 'git p4 submit', with=
 the following traceback:

=3D=3D=3D=3D=3D=3D=3D=3D
Traceback (most recent call last):
  File "/usr/local/pixar/Cellar/git/2.2.2/libexec/git-core/git-p4", lin=
e 3302, in <module>
    main()
  File "/usr/local/pixar/Cellar/git/2.2.2/libexec/git-core/git-p4", lin=
e 3296, in main
    if not cmd.run(args):
  File "/usr/local/pixar/Cellar/git/2.2.2/libexec/git-core/git-p4", lin=
e 1723, in run
    ok =3D self.applyCommit(commit)
  File "/usr/local/pixar/Cellar/git/2.2.2/libexec/git-core/git-p4", lin=
e 1477, in applyCommit
    if self.edit_template(fileName):
  File "/usr/local/pixar/Cellar/git/2.2.2/libexec/git-core/git-p4", lin=
e 1228, in edit_template
    system([editor, template_file])
  File "/usr/local/pixar/Cellar/git/2.2.2/libexec/git-core/git-p4", lin=
e 196, in system
    retcode =3D subprocess.call(cmd, shell=3Dexpand)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/py=
thon2.7/subprocess.py", line 524, in call
    return Popen(*popenargs, **kwargs).wait()
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/py=
thon2.7/subprocess.py", line 711, in __init__
    errread, errwrite)
  File "/System/Library/Frameworks/Python.framework/Versions/2.7/lib/py=
thon2.7/subprocess.py", line 1308, in _execute_child
    raise child_exception
OSError: [Errno 2] No such file or directory
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This is running on OS X 10.9.5, with git 2.2.2 installed via homebrew, =
but we=E2=80=99ve replicated it with the version of git that comes with=
 XCode
(which I believe is older, 1.9.x)

We chased this down to the fact that his P4EDITOR ( and GIT_EDITOR) val=
ues have a command-line option in them:  /path/to/mate -w,

The edit_template() function passes that value as-is to  system(), and =
then on to subprocess.call(), in such a way that the entirety of P4EDIT=
OR is=20
treated as the command name.

I have confirmed this by modifying the system() call in edit_template()=
  thus, and it works:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
if editor.split()[-1][0] =3D=3D "-":
    cmd =3D editor.split() + [template_file]
    system(cmd)
 else:
    system([editor, template_file])
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Which results, if the last word of 'editor' begins with a hyphen,  in [=
 "/path/to/mate", "-w", "/path/to/template"]  being passed to system() =
 rather
than the non-funcional [ "/path/to/mate -w", "/path/to/template"].

Clearly my hack is not the best way to address this, especially since I=
=E2=80=99m not much of a python coder, nor am I familiar with the git-p=
4 source.
I was just confirming my suspicion and trying to get things working for=
 the user.

Thank you!
-Chris Lasell

PS: 'mate' is the CLI invocation of the TextMate GUI editor for OS X. T=
he -w is required in this instance, or the 'mate' command would return=20
instantly when the document opens. The -w causes it to wait until the d=
ocument window is closed.

I have noticed that the help output for mate says:
=3D=3D=3D=3D=3D=3D=3D
By default mate will wait for files to be closed if the command name
has a "_wait" suffix (e.g. via a symbolic link)
=3D=3D=3D=3D=3D=3D=3D

and I have instructed my user to do just that for now. However, options=
 to EDITOR environment variables are not uncommon, so I wanted
to address this to the right people

--=20
Chris Lasell, Apple Peeler, MacTeam
Pixar Animation Studios, Emeryville, CA
