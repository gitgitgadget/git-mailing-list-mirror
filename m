From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH v2] Documentation/urls: Rewrite to accomodate 
	<transport>::<address>
Date: Mon, 29 Mar 2010 22:29:29 +0530
Message-ID: <f3271551003290959v263fe04bt1047f390788916c2@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Mon Mar 29 19:00:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NwIJu-0004Iz-9g
	for gcvg-git-2@lo.gmane.org; Mon, 29 Mar 2010 19:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102Ab0C2Q7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Mar 2010 12:59:53 -0400
Received: from mail-yw0-f172.google.com ([209.85.211.172]:64716 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab0C2Q7v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Mar 2010 12:59:51 -0400
Received: by ywh2 with SMTP id 2so5111518ywh.33
        for <git@vger.kernel.org>; Mon, 29 Mar 2010 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:from:date:received
         :message-id:subject:to:cc:content-type;
        bh=Zva5nB/aryEnhSCNTAJnONI2ra9+hztLF0X6cTP4Omo=;
        b=RWZoq7CtOcXBCtfjWaBkMH5iFeM86xO9TKm4hbLl09GnXv6g5vEvUJMqivGMKUJ1uO
         s+ooL9S6K9wpMNHhS9Vv3catXSJxwycbFdFH2k2sMnaWALASwQPgW3peG7vlDsJJUUvi
         vDlV6BZNvhQN6jnk6kX4v5RYiIcvKONEEmwsk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        b=w2mHrvolwJugW1RXw5PdxKKJzF4xwFMPrlXRdqXO96mup3yAC3bh1mcw8Tp60PNLAR
         zWrSsgw6R9GlgVvgKfuhI9c6jOQhlFxGf9WhrbOHs6oOE2YVNiwXqx8vh63GoS0dOlHa
         Bx4rLvG5Qim1dft52FfiyvHU4nDFoX7lA+wf0=
Received: by 10.90.69.14 with HTTP; Mon, 29 Mar 2010 09:59:29 -0700 (PDT)
Received: by 10.90.59.12 with SMTP id h12mr3940352aga.118.1269881990114; Mon, 
	29 Mar 2010 09:59:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143499>

Rewrite the first part of the document to explicitly show differences
between the URLs that can be used with different transport
protocols. Mention <transport>::<address> format to explicitly invoke
a remote helper.
---
 Complete rewrite since v1. Ilari's review mentioned that <address>
 can be anything, depending on the remote helper used. Removed
 redundancy and clarified rest of document so that this fact isn't
 confusing.

 Documentation/urls.txt |   58 +++++++++++++++++++++++------------------------
 1 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index 459a394..262c729 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -1,44 +1,42 @@
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
+address of the remote server and the path to the repository. Depending
+on the transport protocol, some of these may be omitted.
+
+SSH is the default transport protocol over the network, which allows
+optional username and port specification. An alternate scp-like syntax
+is also supported, and both syntaxes support username expansion.
+
+- ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git
 - {startsb}user@{endsb}host.xz:path/to/repo.git

-To sync with a local directory, you can use:
+The native git, rsync, http, and https transport helpers support the
+following syntaxes:
+
+- git://host.xz{startsb}:port{endsb}/path/to/repo.git
+- rsync://host.xz/path/to/repo.git
+- http://host.xz{startsb}:port{endsb}/path/to/repo.git
+- https://host.xz{startsb}:port{endsb}/path/to/repo.git

-- /path/to/repo.git/
-- file:///path/to/repo.git/
+For local respositories, the following syntaxes are supported:
+
+- /path/to/repo.git
+- file:///path/to/repo.git

 ifndef::git-clone[]
-They are mostly equivalent, except when cloning.  See
-linkgit:git-clone[1] for details.
+They are mostly equivalent, except when cloning, when the former
+implies --local option. See linkgit:git-clone[1] for details.
 endif::git-clone[]

-ifdef::git-clone[]
-They are equivalent, except the former implies --local option.
-endif::git-clone[]
+To explicity request a remote helper for a certain transport protocol,
+you can use:
+
+- <transport>::<address>

+where <address> may be a path, a server and path, or something else
+depending on the remote helper.

 If there are a large number of similarly-named remote repositories and
 you want to use a different format for them (such that the URLs you
-- 
1.7.0.3
