From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v3] Documentation/urls: Rewrite to accomodate 
	<transport>::<address>
Date: Mon, 5 Apr 2010 19:26:58 +0530
Message-ID: <n2rf3271551004050656vdd7d242dpeebacb25d4082f75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 15:58:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nymo2-0007FI-8K
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 15:57:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435Ab0DEN5V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 09:57:21 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:42525 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751444Ab0DEN5T (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 09:57:19 -0400
Received: by ywh2 with SMTP id 2so2480787ywh.33
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 06:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=o+luUkGcRksWnpuHPscvHBlwTrPdglb1a2UdLBowjfk=;
        b=kVldwICeLGb01If9zD1r7MgjlICdNsqyn1xoJNHVryl5lPyQjwTf+fqewCfVOLxEB+
         jPZV/pUmxd8rRmnSk5HIpatNtz9eGiFCMPdkyudWIrnsfDvZYOzi6Yj+yPaTgQMnc9H3
         PiG+JIXLd+gJFF/5P/xqCaw/mWdKkukxhbTkc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=Ab4lTb+RoiHyXwHWYeT3ryk3dUyHfqGP4OOjqgj30qWtavOBe6BrIYI4kprBuivx3b
         rd/VlrF0ISdPQmdZNDjlLiasnL/WzWUKkN6wdeumaGd3VlGihxyq77BNgMN5JMp+XjPO
         aJ0LuCYz/uuRONE+UxPPhsuBiHuM2hM9DpVcU=
Received: by 10.90.69.14 with HTTP; Mon, 5 Apr 2010 06:56:58 -0700 (PDT)
Received: by 10.91.1.2 with SMTP id d2mr1407349agi.121.1270475838163; Mon, 05 
	Apr 2010 06:57:18 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143982>

Rewrite the first part of the document to explicitly show differences
between the URLs that can be used with different transport
protocols. Mention <transport>::<address> format to explicitly invoke
a remote helper.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Added ftp, ftps and clarified a few things after Ilari's review of v2.

 Documentation/urls.txt |   64 +++++++++++++++++++++++++----------------------
 1 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 459a394..75743f2 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -1,44 +1,48 @@
 GIT URLS[[URLS]]
 ----------------

-One of the following notations can be used
-to name the remote repository:
-
-- rsync://host.xz/path/to/repo.git/
-- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
-
-SSH is the default transport protocol over the network.  You can
-optionally specify which user to log-in as, and an alternate,
-scp-like syntax is also supported.  Both syntaxes support
-username expansion, as does the native git protocol, but
-only the former supports port specification. The following
-three are identical to the last three above, respectively:
-
-- {startsb}user@{endsb}host.xz:/path/to/repo.git/
-- {startsb}user@{endsb}host.xz:~user/path/to/repo.git/
+In general, URLs contain information about the transport protocol, the
+address of the remote server, and the path to the repository.
+Depending on the transport protocol, some of this information may be
+absent.
+
+In addition to SSH, which is the default transport protocol over the
+network, git natively supports git, rsync, http, https, ftp, and ftps
+protocols. The following syntaxes may be used with them. Only SSH and
+git protocols support username expansion.
+
+- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git
+- git://host.xz{startsb}:port{endsb}/path/to/repo.git
+- rsync://host.xz/path/to/repo.git
+- http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git
+- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git
+
+The SSH protocol also supports an alternative scp-like syntax:
+
 - {startsb}user@{endsb}host.xz:path/to/repo.git

-To sync with a local directory, you can use:
+For local respositories, also supported by git natively, the following
+syntaxes may be used:

-- /path/to/repo.git/
-- file:///path/to/repo.git/
+- /path/to/repo.git
+- file:///path/to/repo.git

 ifndef::git-clone[]
-They are mostly equivalent, except when cloning.  See
-linkgit:git-clone[1] for details.
+These two syntaxes are mostly equivalent, except when cloning, when
+the former implies --local option. See linkgit:git-clone[1] for
+details.
 endif::git-clone[]

-ifdef::git-clone[]
-They are equivalent, except the former implies --local option.
-endif::git-clone[]
+When git doesn't know how to handle a certain transport protocol, it
+attempts to use the 'remote-<transport>' remote helper, if one
+exists. To explicitly request a remote helper, the following syntax
+may be used:
+
+- <transport>::<address>

+where <address> may be a path, a server and path, or an arbitrary
+URL-like string recognized by the specific remote helper being
+invoked. See linkgit:git-remote-helpers[1] for details.

 If there are a large number of similarly-named remote repositories and
 you want to use a different format for them (such that the URLs you
-- 
1.7.0.3
