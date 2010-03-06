From: Adam Mercer <ramercer@gmail.com>
Subject: Determining if a tree is clean
Date: Sat, 6 Mar 2010 09:12:42 -0600
Message-ID: <799406d61003060712t120d7f11me6e2ab212c55271@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 06 22:27:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1No15l-0004YU-5M
	for gcvg-git-2@lo.gmane.org; Sat, 06 Mar 2010 21:59:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753607Ab0CFPNI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Mar 2010 10:13:08 -0500
Received: from mail-bw0-f222.google.com ([209.85.218.222]:61004 "EHLO
	mail-bw0-f222.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751306Ab0CFPNG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Mar 2010 10:13:06 -0500
Received: by bwz22 with SMTP id 22so1579497bwz.28
        for <git@vger.kernel.org>; Sat, 06 Mar 2010 07:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:message-id
         :subject:to:content-type;
        bh=yYQW9Lc4SFvBjG/r1pZOoV7DXjrLWIt/mk2+9L5Kf0M=;
        b=CZwAJbAl9N/sUjb7gUm98qew4EpAUS0Y2xI7URThdqSYuYJXIIfTeAMvjp3Tm4zrUS
         oVUmzcPDLOUGDx0fDbOS4qULPbWQr0xZ0lVXRC8I5kJUdgVIiIb4fjtAlocKLiUH7tir
         xgJMyBqmIhxvNE97ocZUFEShi00R/gQkGK10Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=M0puyUEMaf1PnQhAQ8osKeLod20csdSUskDabie/YzDj6Jo9uBywUgvarHvKxZtcMQ
         s38ChR6R/cgCw2mNcLeDmL8hy8PoVG2ajKCkRMQ3Nm6Ycrc2UqBg6MOebFmgAWD36Wid
         R3BMskAz/0ZuMESmbsdIDw3B9wwliXWS+aQ3M=
Received: by 10.204.34.3 with SMTP id j3mr1821312bkd.23.1267888382189; Sat, 06 
	Mar 2010 07:13:02 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

In one of the projects I work in we have a script which creates a
header file containing various commit information, such as the id of
the HEAD commit, the date it was committed, who made the commit, and
if the tree is clean (i.e. no uncommitted changes). In order to
determine if the tree is clean we use the command

git diff-index --quiet HEAD

and if the this exits with a non-zero return code then we assume that
the tree is unclean. However I have found a case when this exits with
a return code of 1 when the tree has no uncommitted changes, e.g.:

$ git diff-index --quiet HEAD
$ echo $?
1
$

and when I look at what file it thinks is unclean I get:

$ git diff-index HEAD
:100644 100644 3b839718d3f182119db5d9e2b88e516e02ecc00b
0000000000000000000000000000000000000000 M
lal/include/lal/LALConfig.h.in
$ git diff-index -p HEAD
diff --git a/lal/include/lal/LALConfig.h.in b/lal/include/lal/LALConfig.h.in
$

which shows no changes in the actual file. This file is the template
for a header created using the AC_CONFIG_HEADERS() autoconf macro.
From the above it looks like the build process has created a new file
with exactly the same contents as the file specifies in the index. Is
there a way that I can tell git-diff-index that this is OK? Or is
there another way I can determine if the tree has any uncommitted
changes?

I'm seeing this with git-1.7, on Mac OS X 10.6, and git-1.5.5.6, on RHEL5.

Cheers

Adam
