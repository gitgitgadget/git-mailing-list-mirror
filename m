From: Bryan Larsen <bryan.larsen@gmail.com>
Subject: [PATCH] 6/7 Add the -N option to cg-commit.
Date: Fri, 08 Jul 2005 06:54:51 -0400
Message-ID: <42CE5B7B.7000503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri Jul 08 13:09:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dqqj6-0005w3-BP
	for gcvg-git@gmane.org; Fri, 08 Jul 2005 13:09:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262563AbVGHLI1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jul 2005 07:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262509AbVGHLHZ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jul 2005 07:07:25 -0400
Received: from zproxy.gmail.com ([64.233.162.192]:16927 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262494AbVGHLEb (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Jul 2005 07:04:31 -0400
Received: by zproxy.gmail.com with SMTP id o37so184531nzf
        for <git@vger.kernel.org>; Fri, 08 Jul 2005 04:04:31 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:subject:content-type:content-transfer-encoding;
        b=U56cNSQR4OV/gMEEsgEHqg9vTvNGg0mh+ob7dOFcGtKyoPKCj+S5O31MHt51Gf5FxZ/V6FkZPPhvEhdc/7PaxdGhNTNYmf/wvyEU6eeGnR7slGBFY8KaUDyYbNXct4L4QYG7WxNyvqQ4nLYGhwsJy7glE0c8ACzUDZ9BKjl50+Y=
Received: by 10.36.3.7 with SMTP id 7mr654423nzc;
        Fri, 08 Jul 2005 04:04:31 -0700 (PDT)
Received: from ?192.168.1.100? ([70.26.43.137])
        by mx.gmail.com with ESMTP id 38sm776347nzf.2005.07.08.04.04.30;
        Fri, 08 Jul 2005 04:04:31 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



Add the -N option to cg-commit.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---


  cg-commit |   15 ++++++++++++---
  1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/cg-commit b/cg-commit
--- a/cg-commit
+++ b/cg-commit
@@ -39,6 +39,10 @@
  #	the tree is the same as the last time you committed, no changes
  #	happenned.
  #
+# -N::
+#   Don't add the files to the object database, just update the caches
+#   and the commit information.
+#
  # FILES
  # -----
  # $GIT_DIR/author::
@@ -103,11 +107,16 @@ fi
  force=
  forceeditor=
  ignorecache=
+infoonly=
  commitalways=
+nocheck=
  msgs=()
  while optparse; do
  	if optparse -C; then
  		ignorecache=1
+	elif optparse -N; then
+		nocheck=--no-check
+		infoonly=--info-only
  	elif optparse -e; then
  		forceeditor=1
  	elif optparse -E; then
@@ -278,9 +287,9 @@ precommit_update () {
  		eval "queue$op[\${#queue$op[@]}]=\"\$fname\""
  	done
  	# XXX: Do we even need to do the --add and --remove update-caches?
-	[ "$queueN" ] && { git-update-cache --add -- "${queueN[@]}" || return 1; }
+	[ "$queueN" ] && { git-update-cache --add ${infoonly} -- 
"${queueN[@]}" || return 1; }
  	[ "$queueD" ] && { git-update-cache --force-remove -- "${queueD[@]}" 
|| return 1; }
-	[ "$queueM" ] && { git-update-cache -- "${queueM[@]}" || return 1; }
+	[ "$queueM" ] && { git-update-cache ${infoonly} -- "${queueM[@]}" || 
return 1; }
  	return 0
  }

@@ -300,7 +309,7 @@ if [ -s "$_git/HEAD" ]; then
  	oldheadstr="-p $oldhead"
  fi

-treeid=$(git-write-tree)
+treeid=$(git-write-tree ${nocheck})
  [ "$treeid" ] || die "git-write-tree failed"
  if [ ! "$force" ] && [ ! "$merging" ] && [ "$oldhead" ] &&
     [ "$treeid" = "$(tree-id)" ]; then



