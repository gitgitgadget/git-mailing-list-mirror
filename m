Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D7EB1F42D
	for <e@80x24.org>; Fri,  1 Jun 2018 05:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750850AbeFAFVD (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Jun 2018 01:21:03 -0400
Received: from ip-122-205.users.unetcom.ru ([91.215.122.205]:33296 "EHLO
        imap.radix.pro" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1750758AbeFAFVC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jun 2018 01:21:02 -0400
X-Greylist: delayed 366 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 Jun 2018 01:21:01 EDT
Received: by imap.radix.pro (Postfix, from userid 243)
        id D6E713001AAB; Fri,  1 Jun 2018 08:09:33 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=radix.pro;
        s=RA20170515; t=1527829773;
        bh=eEEyxqsRJa6+q/8olAgkbs/xhn81Udd4tEmri4OaehE=;
        h=To:Subject:Date:From:Cc;
        b=e3P8g1miq3L2qnE4isr39zJZLKMvAcQ7b9J2+zja5q4XDR2ZjCwihxw/lh9GpMWaz
         iS75hAsK+qFevONNQiLVFC6Yj0rRdD+W4UN1WItAZ7+ocexUTsjapuKR5/VUlWs+rb
         z+Q4j9CfrbTcBCwJQcFS7vFxQjx5/2JD1/8+KUtaKNxrOKqpisyEpODQESuIyIfpSp
         6k6DL2jX3+SN67/HCyUCP1QqCrtY6Eioxz09X5ih4prGLq5w8Kyy8hkzguoMpbbtgi
         JUK3r7TLYZr/9fEm+BXxxpwg6Yv5szDe/nQw13DrUGckj+VegHywxyjUt/RTANHTnv
         W3/a5u0/mDRZw==
To:     git@vger.kernel.org
Subject: [PATCH] f4b04cf65 ("git-subtree: I suggest to add following lines  into commit message", 2018-05-31)
X-PHP-Originating-Script: 243:rcube.php
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Jun 2018 08:09:33 +0300
From:   kx <kx@radix.pro>
Cc:     apenwarr@gmail.com
Organization: Radix Pro Ltd
Message-ID: <8c9290a4a097e490b243c64e1f362327@radix.pro>
X-Sender: kx@radix.pro
User-Agent: post.radix.pro/1.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

 From f4b04cf65c4b220c8127ed2692c057fab76392a9 Mon Sep 17 00:00:00 2001
 From: kx <kx@radix.pro>
Date: Thu, 31 May 2018 22:47:49 +0300
Subject: [PATCH 1/3] I suggest to add following lines into commit 
message
  created by 'git subtree add' command:

     git-subtree-repo: https://github.com/.../remote.git
     git-subtree-ref: master

this allow us to list externals using 'git subtree --list':

foo https://github.com/.../remote.git branch master HEAD

And also when option '-d' is applayed and remote repository
has been updated we can show help message like following:

$ git subtree -d --list
Looking for externals...

Commit: cc0436022362174bf04b0aac504913d4ccbd8b90
foo https://github.com/.../remote.git branch master HEAD

The 'foo' subtree seems not updated:
    original revision: e46649ead5b895cd8d27be734241f50fff4daa60
     reemote revision: b23fec043212d37e549c9c1515ea3b2a955206df
You can update 'foo' subtree by following command:

    git subtree pull --prefix=foo https://github.com/.../remote.git 
master
---
  contrib/subtree/git-subtree.sh  | 141 ++++++++++++++++++++++++++++++++
  contrib/subtree/git-subtree.txt |   5 ++
  2 files changed, 146 insertions(+)

diff --git a/contrib/subtree/git-subtree.sh 
b/contrib/subtree/git-subtree.sh
index d3f39a862..969649530 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -15,8 +15,10 @@ git subtree merge --prefix=<prefix> <commit>
  git subtree pull  --prefix=<prefix> <repository> <ref>
  git subtree push  --prefix=<prefix> <repository> <ref>
  git subtree split --prefix=<prefix> <commit...>
+git subtree --list
  --
  h,help        show the help
+l,list        show externals
  q             quiet
  d             show debug messages
  P,prefix=     the name of the subdir to split out
@@ -48,6 +50,9 @@ annotate=
  squash=
  message=
  prefix=
+repo=
+ref=
+list=

  debug () {
  	if test -n "$debug"
@@ -77,6 +82,119 @@ assert () {
  	fi
  }

+show_externals () {
+  debug "Looking for externals..."
+  dir=
+  rev=
+  updated=
+  commit=
+  repo=
+  ref=
+  git log --grep="^git-subtree-dir: .*\$" \
+          --no-show-signature --pretty=format:'START 
%H%n%s%n%n%b%nEND%n' |
+  while read a b junk
+  do
+    case "$a" in
+    START)
+      commit="$b"
+      ;;
+    git-subtree-dir:)
+      if test -n "$dir"
+      then
+        if test "$dir" = "$b"
+        then
+          break
+        fi
+      fi
+      dir="$b"
+      ;;
+    git-subtree-split:)
+      rev="$b"
+      ;;
+    git-subtree-repo:)
+      repo="$b"
+      ;;
+    git-subtree-ref:)
+      ref="$b"
+      ;;
+    END)
+      if test -n "$dir" -a -e "$dir"
+      then
+        debug ""
+        debug "Commit: $commit"
+        if test -n "$repo"
+        then
+          output="$(git ls-remote $repo)"
+          if test -n "$ref"
+          then
+            if $(echo "$output" | grep -q $ref)
+            then
+              hash="$(echo "$output" | grep "$ref\$" | cut -f1 
-d$'\t')"
+              if test "$hash" != "$rev"
+              then
+                updated="$rev"
+                rev="$hash"
+              fi
+            fi
+          fi
+
+          output="$(echo "$output" | grep $rev)"
+          if test -n "$output"
+          then
+            echo "$output" |
+            while read h r junk
+            do
+              case "$r" in
+                HEAD)
+                  head="yes"
+                  ;;
+                refs/heads/*)
+                  name=$(basename $r)
+                  type="branch"
+                  echo -n "$dir $repo $type $name"
+                  if test "$head" = "yes"
+                  then
+                    echo " HEAD"
+                  else
+                    echo " $rev"
+                  fi
+                  break
+                  ;;
+                refs/tags/*)
+                  name=$(basename $r)
+                  type="tag"
+                  echo "$dir $repo $type $name $rev"
+                  break
+                  ;;
+              esac
+            done
+            if test -n "$updated"
+            then
+              debug ""
+              debug "The '$dir' subtree seems not updated:"
+              debug "   original revision: $updated"
+              debug "    reemote revision: $rev"
+              debug "You can update '$dir' subtree by following 
command:"
+              debug ""
+              debug "   git subtree pull --prefix=$dir $repo $ref"
+              debug ""
+            fi
+          fi
+        else
+          echo "$dir $rev"
+        fi
+      fi
+
+      rev=
+      updated=
+      commit=
+      repo=
+      ref=
+      ;;
+    esac
+  done
+}
+

  while test $# -gt 0
  do
@@ -137,6 +255,9 @@ do
  	--no-squash)
  		squash=
  		;;
+	-l)
+		list=yes
+		;;
  	--)
  		break
  		;;
@@ -149,6 +270,12 @@ done
  command="$1"
  shift

+if test "$list" = "yes"
+then
+  show_externals
+  exit 0
+fi
+
  case "$command" in
  add|merge|pull)
  	default=
@@ -421,6 +548,18 @@ add_msg () {
  		git-subtree-mainline: $latest_old
  		git-subtree-split: $latest_new
  	EOF
+	if test -n "$repo"
+	then
+		cat <<-EOF
+			git-subtree-repo: $repo
+		EOF
+	fi
+	if test -n "$ref"
+	then
+		cat <<-EOF
+			git-subtree-ref: $ref
+		EOF
+	fi
  }

  add_squashed_msg () {
@@ -622,6 +761,8 @@ cmd_add () {
  		# branches fetched via the refspec.
  		ensure_valid_ref_format "$2"

+		repo=$1
+		ref=$2
  		cmd_add_repository "$@"
  	else
  		say "error: parameters were '$@'"
diff --git a/contrib/subtree/git-subtree.txt 
b/contrib/subtree/git-subtree.txt
index 352deda69..4927f9767 100644
--- a/contrib/subtree/git-subtree.txt
+++ b/contrib/subtree/git-subtree.txt
@@ -15,6 +15,7 @@ SYNOPSIS
  'git subtree' push  -P <prefix> <repository> <ref>
  'git subtree' merge -P <prefix> <commit>
  'git subtree' split -P <prefix> [OPTIONS] [<commit>]
+'git subtree' --list


  DESCRIPTION
@@ -131,6 +132,10 @@ OPTIONS
  --debug::
  	Produce even more unnecessary output messages on stderr.

+-l::
+--list::
+	Print the list of joined subtrees and exit.
+
  -P <prefix>::
  --prefix=<prefix>::
  	Specify the path in the repository to the subtree you
-- 
2.17.1


 From cf93ca929b25b948ee41fb921a466205fe979dd1 Mon Sep 17 00:00:00 2001
 From: kx <kx@radix.pro>
Date: Fri, 1 Jun 2018 00:15:02 +0300
Subject: [PATCH 2/3] show same subtree once

---
  contrib/subtree/git-subtree.sh | 4 +++-
  1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh 
b/contrib/subtree/git-subtree.sh
index 969649530..65361a2f3 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -85,6 +85,7 @@ assert () {
  show_externals () {
    debug "Looking for externals..."
    dir=
+  pass=
    rev=
    updated=
    commit=
@@ -118,8 +119,9 @@ show_externals () {
        ref="$b"
        ;;
      END)
-      if test -n "$dir" -a -e "$dir"
+      if test -n "$dir" -a -e "$dir" -a "$dir" != "$pass"
        then
+        pass="$dir"
          debug ""
          debug "Commit: $commit"
          if test -n "$repo"
-- 
2.17.1


 From 548d1a7a739e6d94a4ae0db0dd77953b3cc84010 Mon Sep 17 00:00:00 2001
 From: kx <kx@radix.pro>
Date: Fri, 1 Jun 2018 01:36:06 +0300
Subject: [PATCH 3/3] fix situation when one dirname is a substring of 
other
  dirname

---
  contrib/subtree/git-subtree.sh | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh 
b/contrib/subtree/git-subtree.sh
index 65361a2f3..f7326c986 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -119,9 +119,9 @@ show_externals () {
        ref="$b"
        ;;
      END)
-      if test -n "$dir" -a -e "$dir" -a "$dir" != "$pass"
+      if test -n "$dir" -a -e "$dir" -a -z "$(echo -e "$pass" | grep 
"$dir\$")"
        then
-        pass="$dir"
+        pass="$pass\n$dir\n"
          debug ""
          debug "Commit: $commit"
          if test -n "$repo"
-- 
2.17.1

