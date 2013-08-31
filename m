From: Patrick Atoon <patrick.atoon@gmail.com>
Subject: Authentication with e-mail address as user name for HTTPS remote
Date: Sat, 31 Aug 2013 08:52:06 +0200
Message-ID: <CADZGgi9-nLpcaHQOevBnY9HZtkLD6Zn=gCZq8u5yefPV7gYaTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 31 08:52:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFf2b-00005y-Bi
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 08:52:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756130Ab3HaGwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 02:52:08 -0400
Received: from mail-qc0-f171.google.com ([209.85.216.171]:57623 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753324Ab3HaGwH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 02:52:07 -0400
Received: by mail-qc0-f171.google.com with SMTP id n1so1513513qcw.2
        for <git@vger.kernel.org>; Fri, 30 Aug 2013 23:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=u4yzCRZL+ZXogLb5Va3+wTR8osgVfR1OLFl10razczA=;
        b=AvBq14hzYRZ7CfrdMMs8l9S/cPRbDiW6HiwWzj2lmkAklzM35MwmRW1YiRzhi+hw3a
         XkQ/8jYp4kxaD5B1Kb+rAqiorm+S3MT6zHq2OD2K2QsdWtcFxO2PQTkMBOufRXDrXFPq
         EtY88CDtuQfB9qPwL9SINZn2cr6HwsXVo+cIIXKXIH7pT5QnKdLM63ALm1U2qpf0QHWv
         t5vRFYzX/9TkbasZEgKa+6WlGpe/OEFoTxK8jkbRm8spHhC+rgTQEE+xvCY6c8dRjtFn
         k3tB5JNpQh9Lwoa7BYmvW5J57mFkj+ZPs91MNIKA4un5hA/Eij+VRGuusgmxXMVknaDp
         KWYQ==
X-Received: by 10.224.28.130 with SMTP id m2mr17311487qac.35.1377931926353;
 Fri, 30 Aug 2013 23:52:06 -0700 (PDT)
Received: by 10.49.39.71 with HTTP; Fri, 30 Aug 2013 23:52:06 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233505>

Hello,

I run into a problem with command line git on Linux.

The remote git server I try to clone from uses HTTPS as a protocol and
requires full
fledged e-mail addresses for a user name in its authentication. In
TortoiseGit (with
winstore) or SourceTree, the user name and password are asked and
stored. But on the
command line I'm stuck, unable to provide the user name.

Here is what happens. First try cloning without specifying the user name:

---8<-------------------------------------------------------
$ git clone https://git.server.com/git/test.git
Initialized empty Git repository in /tmp/git/test/.git/
error: The requested URL returned error: 401 Authorization Required
while accessing
https://git.server.com/git/test.git/nfo/refs

fatal: HTTP request failed
---8<-------------------------------------------------------

I couldn't find a "--username" flag or something similar for the git
command, so my next
try was to incorporate the user name in the URL, basic auth style. The
repo URL looks
something like this:

https://user.email@emaildomain.com@git.server.com/git/test.git

Note the double "@" there, it is bound to cause trouble.
This is what happened:

---8<-------------------------------------------------------
$ git clone https://user.email@emaildomain.com@git.server.com/git/test.git
Initialized empty Git repository in /tmp/git/test/.git/
Password:
error: Couldn't resolve host 'emaildomain.com@git.server.com' while accessing
https://user.email@emaildomain.com@git.server.com/git/test.git/info/refs

fatal: HTTP request failed
---8<-------------------------------------------------------

It appears the "@" was picked up as an indication that the URL
contains the username,
however the URL was split at the wrong position. The splitting
algorithm doesn't seem to
take into account that a user name might contain an "@".

My request: please modify command line git to support full fledged
e-mail addresses as
user names in HTTPS requests.

I'm not a C adept, still I browsed the code a bit and bumped into
"transport.c"'s
"transport_anonymize_url" method. I think that code could be modified
to do a better job
of splitting the URL, which might then avoid problems down the line.

Thanks for reading this far.

Regards,

Patrick
