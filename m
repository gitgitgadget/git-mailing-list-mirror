From: szager@google.com
Subject: [PATCH] Enable parallelism in git submodule update.
Date: Tue, 30 Oct 2012 11:03:33 -0700
Message-ID: <50901675.WKMg80aNqNeozrMn%szager@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: c@google.com
To: git@vger.kernel.org, jens.lehmann@web.de, -cc@google.com,
	hvoigt@hvoigt.net, -cc@google.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Oct 30 19:03:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTGAG-0005ep-MI
	for gcvg-git-2@plane.gmane.org; Tue, 30 Oct 2012 19:03:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030Ab2J3SDg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 14:03:36 -0400
Received: from mail-vc0-f202.google.com ([209.85.220.202]:47159 "EHLO
	mail-vc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759668Ab2J3SDf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 14:03:35 -0400
Received: by mail-vc0-f202.google.com with SMTP id fy27so60535vcb.1
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 11:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=GeYm5wfpBxApKv5ybp9BSQyKY3MXeG4vuBeFoZCaSFo=;
        b=MXc4uBbq00wUa3OiUpXjNTSwD+TQsRqqqbJbgcOqD+BUq+AjDsHvDdwPUANMe8eTRE
         6DCsbuuEHgU8XEAtdrX4gJsGja27FLbWz/yyHeNxrpxOV2yYe+iluuhsLeMKvzleK9KB
         3DmySdGAzetM27jFuyN5Fm26W+gr+cvvxVNPXFlB10pAmqfiNHESgvf1cdynuRryKYvw
         FU0Epvl4S0vDxwMOqXVijQxoGFaAWaiaQEkSVHH3JTKy8hRndSjSyh4ZXz+Wq7iPO1Hq
         vElIYs2opCn1rvUmulLDHBcBK//PlYgjYrZn2PQ1mlRL26C7ouYL05F7K3YevXNqz1kX
         RzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=GeYm5wfpBxApKv5ybp9BSQyKY3MXeG4vuBeFoZCaSFo=;
        b=EAOfYHGhhPyQYY3V8FS9OTDdswp6JmEHv1ZmqRUfu2Rj/hM2pjqsOzILCSacv6dMiJ
         pHVujHFC7zeULO05zACH08cO0OjXQQgTDFpKD9yNn4mVKgvFqGuT+Hw4/uatIhDR8pbP
         bo0ISu9V/Q8kAU6CIoJeFbluYxuTO9AqplbCPj7cFIL8VtpfOwp/naF6gqXjDO5ZwJli
         Avu7vk6NKx5VtInOGEwMrESBWJyFHEIoC6g+fN6dpP6nL6d21XYx//1kbhMqkxWX4+dE
         WkUuVUbH/GtiCVZDCOtftAwKzYOuMgrfToHQL663L0ijJYnxQUlV+VfheHfuopIluYCI
         hzLg==
Received: by 10.236.119.145 with SMTP id n17mr25032234yhh.22.1351620214392;
        Tue, 30 Oct 2012 11:03:34 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id l1si8016anm.0.2012.10.30.11.03.34
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 30 Oct 2012 11:03:34 -0700 (PDT)
Received: from wince.sfo.corp.google.com (wince.sfo.corp.google.com [172.31.53.43])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id 30A041E0043;
	Tue, 30 Oct 2012 11:03:34 -0700 (PDT)
Received: by wince.sfo.corp.google.com (Postfix, from userid 138314)
	id A603840BDB; Tue, 30 Oct 2012 11:03:33 -0700 (PDT)
User-Agent: Heirloom mailx 12.5 6/20/10
X-Gm-Message-State: ALoCoQk4oWleoFBff6oJPm/v1WcS4b52QY4n7KsqHuHm0RuDn7hdet3L1kQjHZS+wAjT9Don67hX30U42mNZX2DLITMcGet3wOknilRJC1+e2uWP0tcwvi4qDI3snPqGXbFY9pJKVm016JLWFZfaoQ/kMR410UCEC6aU3dKHQejer2l7jfDxg7wCevpnfXgdbllTwXpK7q+D
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208713>

The --jobs parameter may be used to set the degree of per-submodule
parallel execution.

Signed-off-by: Stefan Zager <szager@google.com>
---
 Documentation/git-submodule.txt |    8 ++++++-
 git-submodule.sh                |   40 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index b4683bb..cb23ba7 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
 'git submodule' [--quiet] init [--] [<path>...]
 'git submodule' [--quiet] update [--init] [-N|--no-fetch] [--rebase]
-	      [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+	      [--reference <repository>] [--merge] [--recursive]
+	      [-j|--jobs [jobs]] [--] [<path>...]
 'git submodule' [--quiet] summary [--cached|--files] [(-n|--summary-limit) <n>]
 	      [commit] [--] [<path>...]
 'git submodule' [--quiet] foreach [--recursive] <command>
@@ -146,6 +147,11 @@ If the submodule is not yet initialized, and you just want to use the
 setting as stored in .gitmodules, you can automatically initialize the
 submodule with the `--init` option.
 +
+By default, each submodule is treated serially.  You may specify a degree of
+parallel execution with the --jobs flag.  If a parameter is provided, it is
+the maximum number of jobs to run in parallel; without a parameter, all jobs are
+run in parallel.
++
 If `--recursive` is specified, this command will recurse into the
 registered submodules, and update any nested submodules within.
 +
diff --git a/git-submodule.sh b/git-submodule.sh
index ab6b110..60a5f96 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -8,7 +8,7 @@ dashless=$(basename "$0" | sed -e 's/-/ /')
 USAGE="[--quiet] add [-b branch] [-f|--force] [--reference <repository>] [--] <repository> [<path>]
    or: $dashless [--quiet] status [--cached] [--recursive] [--] [<path>...]
    or: $dashless [--quiet] init [--] [<path>...]
-   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [--] [<path>...]
+   or: $dashless [--quiet] update [--init] [-N|--no-fetch] [-f|--force] [--rebase] [--reference <repository>] [--merge] [--recursive] [-j|--jobs [jobs]] [--] [<path>...]
    or: $dashless [--quiet] summary [--cached|--files] [--summary-limit <n>] [commit] [--] [<path>...]
    or: $dashless [--quiet] foreach [--recursive] <command>
    or: $dashless [--quiet] sync [--] [<path>...]"
@@ -500,6 +500,7 @@ cmd_update()
 {
 	# parse $args after "submodule ... update".
 	orig_flags=
+	jobs="1"
 	while test $# -ne 0
 	do
 		case "$1" in
@@ -518,6 +519,20 @@ cmd_update()
 		-r|--rebase)
 			update="rebase"
 			;;
+		-j|--jobs)
+			case "$2" in
+			''|-*)
+				jobs="0"
+				;;
+			*)
+				jobs="$2"
+				shift
+				;;
+			esac
+			# Don't preserve this arg.
+			shift
+			continue
+			;;
 		--reference)
 			case "$2" in '') usage ;; esac
 			reference="--reference=$2"
@@ -551,11 +566,34 @@ cmd_update()
 		shift
 	done
 
+	# Correctly handle the case where '-q' came before 'update' on the command line.
+	if test -n "$GIT_QUIET"
+	then
+		orig_flags="$orig_flags -q"
+	fi
+
 	if test -n "$init"
 	then
 		cmd_init "--" "$@" || return
 	fi
 
+	if test "$jobs" != 1
+	then
+		if ( echo test | xargs -P "$jobs" true 2>/dev/null )
+		then
+			if ( echo test | xargs --max-lines=1 true 2>/dev/null ); then
+				max_lines="--max-lines=1"
+			else
+				max_lines="-L 1"
+			fi
+			module_list "$@" | awk '{print $4}' |
+			xargs $max_lines -P "$jobs" git submodule update $orig_flags
+			return
+		else
+			echo "Warn: parallel execution is not supported on this platform."
+		fi
+	fi
+
 	cloned_modules=
 	module_list "$@" | {
 	err=
-- 
1.7.7.3
