From: Eric Cousineau <eacousineau@gmail.com>
Subject: Re: [PATCH/RFC] Changing submodule foreach --recursive to be depth-first,
 --parent option to execute command in supermodule as well
Date: Mon, 25 Mar 2013 23:03:16 -0500
Message-ID: <51511E04.6070504@gmail.com>
References: <CA+aSAWuoxZkSnRybhefnFr9ngs3tHmt6hAH4o0ebjYKvjJ-vpw@mail.gmail.com> <51351CF5.7010308@web.de> <7vhakqwz1e.fsf@alter.siamese.dyndns.org> <20130305075901.GB4677@sandbox-ub> <7vhakpvnex.fsf@alter.siamese.dyndns.org> <CA+aSAWvQj2wuJX3ENNn7n_pMJjA6nauve5BLRugiTuhWN25Ctg@mail.gmail.com> <7vboaxu23y.fsf@alter.siamese.dyndns.org> <51365AB6.2010602@web.de> <CABURp0psgofX=ean+KKooN74pF4Ns-gDGt68vc5Exs6NmDRUyw@mail.gmail.com> <513B7D08.20406@web.de> <CABURp0qBA6myf7_SuaxJSrePJHmh2v-nmtLRzKTtgAJxLkJ-tQ@mail.gmail.com> <51416E9F.7000604@gmail.com> <5147863B.8010104@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Mar 26 05:03:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKL70-0004V2-EX
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 05:03:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142Ab3CZEDU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 00:03:20 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:64601 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750857Ab3CZEDT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 00:03:19 -0400
Received: by mail-ie0-f177.google.com with SMTP id tp5so4011530ieb.36
        for <git@vger.kernel.org>; Mon, 25 Mar 2013 21:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Ih0jUxrcMDvvua8NHSUZwFGt5OdZLSpHxmjiPdvKo+o=;
        b=tTTSapYFglkWVSfCjmlRBdG1kaO8gOX48ZN1JvK7lvxycJVMPBQlv9lKaQ5PLe9L5r
         gQXUclBsRyq7GifrppZ9K5vI+9tRXITUu0K0FOlptGBX9kjBsCBIA3DdZ4Ee8tvQZlxa
         5RK65yNpTx5FN3K9m64wsSoS7vVesPiUot2qq1h2SDdVMMYPvrd0w2cvsoePkEiHggJX
         cs6j24QEIrWAeOsZNadKrI/qW4kiyjf6Pz1nXy7/wnyRXouis4PdpxQbDp6GReIdhFBK
         M/mw/6vKk0FDmprPaLcShEz8klNYMEX08Z1OnmIIYCUyXbUO72bcBdAdxx1b0pGdqJ/C
         y4cA==
X-Received: by 10.50.153.198 with SMTP id vi6mr246031igb.112.1364270598833;
        Mon, 25 Mar 2013 21:03:18 -0700 (PDT)
Received: from [10.3.2.6] ([199.30.163.2])
        by mx.google.com with ESMTPS id wx2sm1039800igb.4.2013.03.25.21.03.17
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 25 Mar 2013 21:03:18 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <5147863B.8010104@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219131>

 From 2c2923ada809d671828aa58dcda05a1b71222b70 Mon Sep 17 00:00:00 2001
From: Eric Cousineau <eacousineau@gmail.com>
Date: Mon, 25 Mar 2013 22:27:06 -0500
Subject: [PATCH] submodule-foreach: Added in --post-order=<command> and
  adjusted code per Jens Lehmann's suggestion

Signed-off-by: Eric Cousineau <eacousineau@gmail.com>
---
Updated the usage line.
I had put the locals in there before because I think I was having 
trouble with resolving some
of the variables in nested submodules, but now that I've taken them out 
they seem to work fine.
I also changed the message for the post-order to say "Exiting".

I did not have a chance to look into why I couldn't group the 
--post-order stuff into a string
when passing it on to submodule. I can look at it later on though.

Now the output is as follows:

$ git submodule foreach --recursive --post-order 'echo Post $name' 'echo 
Pre $path'
Entering 'b'
Pre b
Entering 'b/d'
Pre d
Exiting 'b/d'
Post d
Exiting 'b'
Post b
Entering 'c'
Pre c
Exiting 'c'
Post c

  git-submodule.sh |   35 ++++++++++++++++++++++++++++++-----
  1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 004c034..4c9923a 100755
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
+   or: $dashless [--quiet] foreach [--recursive] [--post-order 
<command>] <command>
     or: $dashless [--quiet] sync [--recursive] [--] [<path>...]"
  OPTIONS_SPEC=
  . git-sh-setup
@@ -434,6 +434,8 @@ Use -f if you really want to add it." >&2
  cmd_foreach()
  {
  	# parse $args after "submodule ... foreach".
+	recursive=
+	post_order=
  	while test $# -ne 0
  	do
  		case "$1" in
@@ -443,6 +445,15 @@ cmd_foreach()
  		--recursive)
  			recursive=1
  			;;
+		--post-order)
+			test "$#" = "1" && usage
+			post_order="$2"
+			shift
+			;;
+		--post-order=*)
+			# Will skip empty commands
+			post_order=${1#*=}
+			;;
  		-*)
  			usage
  			;;
@@ -465,7 +476,9 @@ cmd_foreach()
  		die_if_unmatched "$mode"
  		if test -e "$sm_path"/.git
  		then
-			say "$(eval_gettext "Entering '\$prefix\$sm_path'")"
+			enter_msg="$(eval_gettext "Entering '\$prefix\$sm_path'")"
+			exit_msg="$(eval_gettext "Exiting '\$prefix\$sm_path'")"
+			die_msg="$(eval_gettext "Stopping at '\$sm_path'; script returned 
non-zero status.")"
  			name=$(module_name "$sm_path")
  			(
  				prefix="$prefix$sm_path/"
@@ -473,13 +486,25 @@ cmd_foreach()
  				# we make $path available to scripts ...
  				path=$sm_path
  				cd "$sm_path" &&
-				eval "$@" &&
+				say "$enter_msg" &&
+				eval "$@" || die "$die_msg" &&
  				if test -n "$recursive"
  				then
-					cmd_foreach "--recursive" "$@"
+					if test -n "$post_order"
+					then
+						# tried keeping flags as a variable, but was having difficulty
+						cmd_foreach --recursive --post-order "$post_order" "$@"
+					else
+						cmd_foreach --recursive "$@"
+					fi
+				fi &&
+				if test -n "$post_order"
+				then
+					say "$exit_msg" &&
+					eval "$post_order" || die "$die_msg"
  				fi
  			) <&3 3<&- ||
-			die "$(eval_gettext "Stopping at '\$sm_path'; script returned 
non-zero status.")"
+			die "$die_msg"
  		fi
  	done
  }
-- 
1.7.9.5
