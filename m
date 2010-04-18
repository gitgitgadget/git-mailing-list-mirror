From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 2/5] Documentation/urls: Rewrite to accomodate <transport>::<address>
Date: Sun, 18 Apr 2010 06:24:18 +0530
Message-ID: <1271552047-sup-9523@kytes>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 18 02:56:30 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3IoH-0004LG-KQ
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 02:56:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107Ab0DRA4Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Apr 2010 20:56:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:36522 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754428Ab0DRA4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Apr 2010 20:56:24 -0400
Received: by gwaa18 with SMTP id a18so2016903gwa.19
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 17:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:date:message-id:user-agent:content-transfer-encoding;
        bh=17oVRShYXFxJIEt52JBZfJvt6+nBZR3oKfOTjak3x6k=;
        b=m7EgYz19DAPfE75+l4BykbCJZ7STdv7H6Ox9/s6TuKIu+8nbaNf5f8RjRSTj44A+UQ
         9iRTNCMH8uQG+7AELrKhShrKQs45MIAZimDK1qOlCe/sscQo+4/vcZBgPKJxhaJqOOvN
         oxxM9/IGD7VitF5eBadmGoWG1qvrS3SufkvdE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:date:message-id:user-agent
         :content-transfer-encoding;
        b=fs7jJ/o/ocFE/N96TpGOvZnV7bBY7f4UazG4EncGxYGjahl93zazmVlmUnpDN7wkAK
         6XGmNkhSnGDUeB03y//8wcEIfoMUGWHcHGl2t5L+t2uO0+RRjI9cqL7Bu/QeKmPlnD90
         A7KVKMSKlxT9O7GrUtNzdbPS7xBYaWHvPeljs=
Received: by 10.150.47.15 with SMTP id u15mr3662121ybu.220.1271552182970;
        Sat, 17 Apr 2010 17:56:22 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 22sm3336263iwn.0.2010.04.17.17.56.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 17:56:22 -0700 (PDT)
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145196>

Rewrite the first part of the document to explicitly show differences
between the URLs that can be used with different transport
protocols. Mention <transport>::<address> format to explicitly invoke
a remote helper.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 Documentation/urls.txt |   58 +++++++++++++++++++++++++++--------------------
 1 files changed, 33 insertions(+), 25 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 459a394..a473da6 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -1,44 +1,52 @@
 GIT URLS[[URLS]]
 ----------------
 
-One of the following notations can be used
-to name the remote repository:
+In general, URLs contain information about the transport protocol, the
+address of the remote server, and the path to the repository.
+Depending on the transport protocol, some of this information may be
+absent.
+
+Git natively supports ssh, git, rsync, http, https, ftp, and ftps
+protocols. The following syntaxes may be used with them:
 
-- rsync://host.xz/path/to/repo.git/
-- http://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- https://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- git://host.xz{startsb}:port{endsb}/~user/path/to/repo.git/
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/~user/path/to/repo.git/
-- ssh://{startsb}user@{endsb}host.xz/~/path/to/repo.git
+- git://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- rsync://host.xz/path/to/repo.git/
+- http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
 
-SSH is the default transport protocol over the network.  You can
-optionally specify which user to log-in as, and an alternate,
-scp-like syntax is also supported.  Both syntaxes support
-username expansion, as does the native git protocol, but
-only the former supports port specification. The following
-three are identical to the last three above, respectively:
+An alternative scp-like syntax may also be used with the ssh protocol:
 
-- {startsb}user@{endsb}host.xz:/path/to/repo.git/
-- {startsb}user@{endsb}host.xz:~user/path/to/repo.git/
-- {startsb}user@{endsb}host.xz:path/to/repo.git
+- {startsb}user@{endsb}host.xz:path/to/repo.git/
 
-To sync with a local directory, you can use:
+The ssh and git protocols additionally support ~username expansion:
+
+- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
+- git://host.xz{startsb}:port{endsb}/~{startsb}user{endsb}/path/to/repo.git/
+- {startsb}user@{endsb}host.xz:/~{startsb}user{endsb}/path/to/repo.git/
+
+For local respositories, also supported by git natively, the following
+syntaxes may be used:
 
 - /path/to/repo.git/
 - file:///path/to/repo.git/
 
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
1.7.0.4
