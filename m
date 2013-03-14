From: Eric Cousineau <eacousineau@gmail.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Thu, 14 Mar 2013 01:30:55 -0500
Message-ID: <51416E9F.7000604@gmail.com>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de> <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com> <513B7D08.20406@web.de> <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 07:31:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG1hH-0006s8-Jl
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 07:31:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab3CNGbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 02:31:00 -0400
Received: from mail-yh0-f43.google.com ([209.85.213.43]:42368 "EHLO
	mail-yh0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753781Ab3CNGa7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 02:30:59 -0400
Received: by mail-yh0-f43.google.com with SMTP id z6so336253yhz.16
        for <git@vger.kernel.org>; Wed, 13 Mar 2013 23:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qCOMsuUBTqI/xfNCpdGUiNHKM4PqPjEBlvoH85dviKQ=;
        b=ws4RvkYyMdkso7UdHrS3lqrkGZefmS4ewPck39ljcEvZHr8PQYzfxWKIXkitJe6EdI
         1CaHpx9lgEstBS7CW+IpF3XqcnSayPDtcpm7syqdZLmS/8/4AC7AOl7djAvX0Vrmhla9
         p3tgnEiuMxm1Sx4T/8pQrBtX2kkmklrBoa+iRRL85sq5c+efIxSxB8AXavqEZDEGuJ+Q
         lgIcz+GGEQmhBgBHXEeAzc7DPeRfffmQrWwTYAgMljmhASYRqWyIBTyOjXgsZbchhY4n
         fYRDT4QN5d1lRYkoVy6Lc4CUleoHPu3S1Ro8U16QzaCyO7ssHGWiUSimvy12ODLjzq3f
         fqNA==
X-Received: by 10.236.68.195 with SMTP id l43mr1305839yhd.200.1363242658082;
        Wed, 13 Mar 2013 23:30:58 -0700 (PDT)
Received: from [10.3.2.6] ([199.30.163.2])
        by mx.google.com with ESMTPS id u3sm2167023yhd.14.2013.03.13.23.30.56
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 13 Mar 2013 23:30:57 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218116>

 From 59fb432e17a1aae9de26bbaaca7f09cc7f03b471 Mon Sep 17 00:00:00 2001
From: Eric Cousineau <eacousineau@gmail.com>
Date: Thu, 14 Mar 2013 01:19:53 -0500
Subject: [PATCH] submodule-foreach: Added in --post-order=<command> per Jens
  Lehmann's suggestion

Signed-off-by: Eric Cousineau <eacousineau@gmail.com>
---
Made the scope of the patch only relate to --post-order.
Would we want to rename this to just --post=<command> ?

Anywho, here it is running in a test setup, where the structure is:
a
- b
- - d
- c

$ git submodule foreach --recursive --post-order 'echo Post $name' 'echo 
Pre $path'
Entering 'b'
Pre b
Entering 'b/d'
Pre d
Entering 'b/d'
Post d
Entering 'b'
Post b
Entering 'c'
Pre c
Entering 'c'
Post c

An interesting note is that it fails with 'git submodule foreach 
--post-order', but not 'git submodule foreach --post-order=', since it 
simply interprets that as an empty command.
If that is important, I could add in a check for $# when parsing the 
argument for --post-order=*.

  git-submodule.sh | 39 ++++++++++++++++++++++++++++++++++-----
  1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 004c034..9b70bc2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -10,7 +10,7 @@ USAGE="[--quiet] add [-b <branch>] [-f|--force] 
[--name <name>] [--reference <re
     or: $dashless [--quiet] init [--] [<path>...]
     or: $dashless [--quiet] update [--init] [--remote] [-N|--no-fetch] 
[-f|--force] [--rebase] [--reference <repository>] [--merge] 
[--recursive] [--] [<path>...]
     or: $dashless [--quiet] summary [--cached|--files] [--summary-limit 
<n>] [commit] [--] [<path>...]
-   or: $dashless [--quiet] foreach [--recursive] <command>
+   or: $dashless [--quiet] foreach [--recursive] 
[--post-order=<command>] <command>
     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
  OPTIONS_SPEC=
  . git-sh-setup
@@ -434,6 +434,8 @@ Use -f if you really want to add it." >&2
  cmd_foreach()
  {
      # parse $args after "submodule ... foreach".
+    # Gratuitous (empty) local's to prevent recursive bleeding
+    local recursive= post_order=
      while test $# -ne 0
      do
          case "$1" in
@@ -443,6 +445,15 @@ cmd_foreach()
          --recursive)
              recursive=1
              ;;
+        --post-order)
+            test "$#" = "1" && usage
+            post_order="$2"
+            shift
+            ;;
+        --post-order=*)
+            # Will skip empty commands
+            post_order=${1#*=}
+            ;;
          -*)
              usage
              ;;
@@ -453,7 +464,7 @@ cmd_foreach()
          shift
      done

-    toplevel=$(pwd)
+    local toplevel=$(pwd)

      # dup stdin so that it can be restored when running the external
      # command in the subshell (and a recursive call to this function)
@@ -465,18 +476,36 @@ cmd_foreach()
          die_if_unmatched "$mode"
          if test -e "$sm_path"/.git
          then
-            say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
+            local name prefix path message epitaph
+            message="$(eval_gettext "Entering '\$prefix\$sm_path'")"
+            epitaph="$(eval_gettext "Stopping at '\$sm_path'; script 
returned non-zero status.")"
              name=$(module_name "$sm_path")
              (
                  prefix="$prefix$sm_path/"
                  clear_local_git_env
                  # we make $path available to scripts ...
                  path=$sm_path
+
+                sm_eval() {
+                    say "$message"
+                    eval "$@" || die "$epitaph"
+                }
+
                  cd "$sm_path" &&
-                eval "$@" &&
+                sm_eval "$@" &&
                  if test -n "$recursive"
                  then
-                    cmd_foreach "--recursive" "$@"
+                    if test -n "$post_order"
+                    then
+                        # Tried keeping flags as a variable, but was 
having difficulty
+                        cmd_foreach --recursive --post-order 
"$post_order" "$@"
+                    else
+                        cmd_foreach --recursive "$@"
+                    fi
+                fi &&
+                if test -n "$post_order"
+                then
+                    sm_eval "$post_order"
                  fi
              ) <&3 3<&- ||
              die "$(eval_gettext "Stopping at '\$sm_path'; script 
returned non-zero status.")"
-- 
1.8.2.rc1.24.g06d67b8.dirty
