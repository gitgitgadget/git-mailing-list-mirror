From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: [PATCH] 7/7 add -N option to cg-init
Date: Fri, 08 Jul 2005 06:54:58 -0400
Message-ID: <42CE5B82.8040901@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 13:05:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DqqfP-0005Oy-7D
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 13:05:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262506AbVGHLEz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 07:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262501AbVGHLEs
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 07:04:48 -0400
Received: from zproxy.gmail.com ([64.233.162.203]:31035 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262536AbVGHLEj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 07:04:39 -0400
Received: by zproxy.gmail.com with SMTP id 13so182963nzp
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 04:04:38 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=I0z0QG0jEAR7rEy87vmh+ourdl1pxcIex2FRkxb5GZE9rXL5bMPQqjEC0ZZeVrkfyYoQ0e/GSQIHVcamGbsgROeN5l8B4oq7hW1FzPIqdor8yXYnOh7UPHsjJiUULVP7zfQzpi55QddEcZ2LNaUGzhBy3PVxu1b+I2UITYKetco=
Received: by 10.36.222.60 with SMTP id u60mr672048nzg;
        Fri, 08 Jul 2005 04:04:38 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 22sm767265nzn.2005.07.08.04.04.38;
        Fri, 08 Jul 2005 04:04:38 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

add -N option to cg-init

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

  cg-init |   22 +++++++++++++++++++---
  1 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/cg-init b/cg-init
--- a/cg-init
+++ b/cg-init
@@ -10,13 +10,29 @@
  #
  # If `cg-init` is run in a non-empty directory files in the top and
  # sub directory will automatically be added.
+#
+# OPTIONS
+# -------
+# -N::
+#   Only update the cache: do not copy the data into the object database.
+#

-USAGE="cg-init"
+USAGE="cg-init [-N]"
  _git_repo_unneeded=1

  . ${COGITO_LIB}cg-Xlib

-uri=$1
+
+infoonly=
+while optparse; do
+       if optparse -N; then
+               infoonly=-N
+       else
+               optfail
+       fi
+done
+
+uri=$ARGV

  [ -e $_git ] && die "$_git already exists"

@@ -38,7 +54,7 @@ if [ "$uri" ]; then
         echo "Cloned (origin $uri available as branch \"origin\")"
  else
         git-read-tree # Seed the dircache
-       find * \( -type f -o -type l \) -print0 | xargs -0r cg-add
+       find * \( -type f -o -type l \) -print0 | xargs -0r cg-add 
${infoonly}
         cg-commit -C -m"Initial commit" -E
  fi
