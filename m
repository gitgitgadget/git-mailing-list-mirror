From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: msgmft segfaulting on tiger
Date: Fri, 22 Feb 2008 12:53:54 +1300
Message-ID: <46a038f90802211553g735215c6q260ddc49ac149bb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>,
	"=?WINDOWS-1252?Q?Basilio_Brice=96=F1o_H.?=" <bbh@tampico.org.mx>,
	gsaldana@gmail.com
X-From: git-owner@vger.kernel.org Fri Feb 22 00:55:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSLFr-0005ni-BK
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 00:55:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936456AbYBUXyA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 18:54:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936130AbYBUXx7
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 18:53:59 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:50122 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936444AbYBUXx5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 18:53:57 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1144743ugc.16
        for <git@vger.kernel.org>; Thu, 21 Feb 2008 15:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=7C4L5jIr6R9PcDlw3fR6S/JHgoIu9SdwJv1HUr2MIDo=;
        b=q9zI2XT/N9dR7BD2jMvvBvQoYx4AIOpQFbgLGpFLXSmL7wiL9qb4QO99i8/dlm8KVtjFsoAOfNc1rysuzLFcwwqd6G3W34luuoEM8FPpNaSCVrfj5Al5nLdyGtlKcRR4zqQqy0ihbYpk2oze9GZjINTXEY94EPXSncWlP6j6L0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Byqr+djHL9/MyvZS3rzmsx/mRhoKmUHZ4eVqJzc22edb5MypvWWtnQnqGdCN2xqQ0mpJX6hjNmFF2cTTS7qOYAw6tOVR6eyYb32jxpGf3uLdLhut1uz0LaOHpZZX8eXa55zx60mQ8GO1QYv7Mrh9tbxF9rFK9+YP8s+fN3HxtcY=
Received: by 10.66.251.3 with SMTP id y3mr1565786ugh.88.1203638035021;
        Thu, 21 Feb 2008 15:53:55 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Thu, 21 Feb 2008 15:53:54 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74682>

Today I've debugged a compile of git 1.5.4.2 failing on OSX Tiger (on
Basilio's machine). The problem is during the git-gui build, in the PO
file handling. Apparently fmtmsg (from fink) segfaults on de.po so the
fix is to say

   make NO_MSGFMT=NoneThere

I don't think we can do much about it -- my guess is that fink has
been built and tested in a different OSX release, and happens to go
bellyup on Tiger. Here's a transcript in case it helps anyone.

Here's the tail of the build message, with make called with -d:

GITGUI_VERSION = 0.9.2
     * new locations or Tcl/Tk interpreter
     GEN git-gui
     INDEX lib/
     MSGFMT    po/de.msg make[1]: *** [po/de.msg] Error 1
 make: *** [all] Error 2

Various versions of things involved:
 $ dpkg -S /sw/bin/msgfmt
 gettext-tools: /sw/bin/msgfmt
 $ dpkg -l gettext-tools
(...)
 ii  gettext-tools                     0.10.40-19
 $ uname -a
 Darwin developer 8.11.1 Darwin Kernel Version 8.11.1: Wed Oct 10
 18:23:28 PDT 2007; root:xnu-792.25.20~1/RELEASE_I386 i386 i386
 $ msgfmt -V
 msgfmt (GNU gettext) 0.10.40
 Copyright (C) 1995-1998, 2000, 2001 Free Software Foundation, Inc.
 This is free software; see the source for copying conditions.  There is NO
 warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 Written by Ulrich Drepper.

Has anyone got any ideas on how to debug this further? I couldn't find
any core files.

cheers,



martin
