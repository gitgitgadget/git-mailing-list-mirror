From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] daemon: add tests
Date: Wed, 04 Jan 2012 12:13:31 -0800
Message-ID: <7vehvfp6ok.fsf@alter.siamese.dyndns.org>
References: <7v8vlovavj.fsf@alter.siamese.dyndns.org>
 <1325692539-26748-1-git-send-email-drizzd@aon.at>
 <7vy5tnpcuw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>,
	Erik Faye-Lund <kusmabite@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Wed Jan 04 21:13:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiXDQ-0005GG-MA
	for gcvg-git-2@lo.gmane.org; Wed, 04 Jan 2012 21:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756818Ab2ADUNg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jan 2012 15:13:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56149 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756731Ab2ADUNe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jan 2012 15:13:34 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB1CA7FB2;
	Wed,  4 Jan 2012 15:13:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rGtSc3CS0u3+cSVpAh6Pwqna++M=; b=hVg1f0
	D7etCuapLDVDuUgsV6uVeeE0DBKs8o8PEgE5ZPRdolgVpksIRvDhJr5LtaZiXvKH
	C3xZKN7ZebUWu1a1oEOfKRYGpKpUF0rRAHcum7WRBV3RB986OkFEAuusSYTLsONw
	unB9oSKlCYpN7aD8igAjCz1Vr1HpeWr+8ekgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qPpIq0fASHawJvxSKTb6vYs44wmIvTQT
	JhqVB7Mit2rlBDHnS3VyN2pBs5XVbAdll1Ko8ZZ3evF1Uk8M2ISY4mcJubutWT9s
	YMCQ/AWlUivKF/STJK+24oWq4yk3CeaiewnTSRygdibecPbUul1tmQ0sZx0CVclu
	UfDrj6fRh/0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A0AC17FB0;
	Wed,  4 Jan 2012 15:13:33 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 94A217FAB; Wed,  4 Jan 2012
 15:13:32 -0500 (EST)
In-Reply-To: <7vy5tnpcuw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Jan 2012 10:00:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 933415EE-3710-11E1-B08D-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187942>

Junio C Hamano <gitster@pobox.com> writes:

> Clemens Buchacher <drizzd@aon.at> writes:
> ...
>>> >> +	# kill git-daemon child of git
>>> >> +	say >&3 "Stopping git daemon ..."
>>> >> +	pkill -P "$DAEMON_PID"
>>> 
>>> How portable is this one (I usually do not trust use of pkill anywhere)?
>>
>> I read that it is supposed to be more portable than skill or killall.
>> But I have no way to research this. I have implemented a workaround
>> using only 'ps' and 'kill' in [PATCH 3/6] avoid use of pkill.
>
> Yuck, that patch looks even uglier X-<.
>
> Do you really need to kill the children but not the daemon?

To reduce round-trip cost, here is what I'll queue for now.

-- >8 --
From: Clemens Buchacher <drizzd@aon.at>
Date: Wed, 4 Jan 2012 16:55:35 +0100
Subject: [PATCH] daemon: add tests

The semantics of the git daemon tests are similar to the http transport
tests.  In fact, they are only a slightly modified copy of t5550, plus the
newly added remote error tests.

All git-daemon tests will be skipped unless the environment variable
GIT_TEST_GIT_DAEMON is set.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/lib-git-daemon.sh   |   56 ++++++++++++++++++
 t/t5570-git-daemon.sh |  148 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 204 insertions(+), 0 deletions(-)
 create mode 100644 t/lib-git-daemon.sh
 create mode 100755 t/t5570-git-daemon.sh

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
new file mode 100644
index 0000000..c0ff9e2
--- /dev/null
+++ b/t/lib-git-daemon.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+if test -z "$GIT_TEST_GIT_DAEMON"
+then
+	skip_all="git-daemon testing disabled (define GIT_TEST_GIT_DAEMON to enable)"
+	test_done
+fi
+
+LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-'8121'}
+
+GIT_DAEMON_PID=
+GIT_DAEMON_DOCUMENT_ROOT_PATH="$PWD"/repo
+GIT_DAEMON_URL=git://127.0.0.1:$LIB_GIT_DAEMON_PORT
+
+start_git_daemon() {
+	if test -n "$GIT_DAEMON_PID"
+	then
+		error "start_git_daemon already called"
+	fi
+
+	mkdir -p "$GIT_DAEMON_DOCUMENT_ROOT_PATH"
+
+	trap 'code=$?; stop_git_daemon; (exit $code); die' EXIT
+
+	say >&3 "Starting git daemon ..."
+	git daemon --listen=127.0.0.1 --port="$LIB_GIT_DAEMON_PORT" \
+		--reuseaddr --verbose \
+		--base-path="$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
+		"$@" "$GIT_DAEMON_DOCUMENT_ROOT_PATH" \
+		>&3 2>&4 &
+	GIT_DAEMON_PID=$!
+}
+
+stop_git_daemon() {
+	if test -z "$GIT_DAEMON_PID"
+	then
+		return
+	fi
+
+	trap 'die' EXIT
+
+	# kill git-daemon child of git
+	say >&3 "Stopping git daemon ..."
+	pkill -P "$GIT_DAEMON_PID"
+	wait "$GIT_DAEMON_PID"
+	ret=$?
+	#
+	# We signal TERM=15 to the child and expect the parent to
+	# exit with 143 = 128+15.
+	#
+	if test $ret -ne 143
+	then
+		error "git daemon exited with status: $ret"
+	fi
+	GIT_DAEMON_PID=
+}
diff --git a/t/t5570-git-daemon.sh b/t/t5570-git-daemon.sh
new file mode 100755
index 0000000..7cbc999
--- /dev/null
+++ b/t/t5570-git-daemon.sh
@@ -0,0 +1,148 @@
+#!/bin/sh
+
+test_description='test fetching over git protocol'
+. ./test-lib.sh
+
+LIB_GIT_DAEMON_PORT=${LIB_GIT_DAEMON_PORT-5570}
+. "$TEST_DIRECTORY"/lib-git-daemon.sh
+start_git_daemon
+
+test_expect_success 'setup repository' '
+	echo content >file &&
+	git add file &&
+	git commit -m one
+'
+
+test_expect_success 'create git-accessible bare repository' '
+	mkdir "$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo.git" &&
+	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo.git" &&
+	 git --bare init &&
+	 : >git-daemon-export-ok
+	) &&
+	git remote add public "$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo.git" &&
+	git push public master:master
+'
+
+test_expect_success 'clone git repository' '
+	git clone "$GIT_DAEMON_URL/repo.git" clone &&
+	test_cmp file clone/file
+'
+
+test_expect_success 'fetch changes via git protocol' '
+	echo content >>file &&
+	git commit -a -m two &&
+	git push public &&
+	(cd clone && git pull) &&
+	test_cmp file clone/file
+'
+
+test_expect_failure 'remote detects correct HEAD' '
+	git push public master:other &&
+	(cd clone &&
+	 git remote set-head -d origin &&
+	 git remote set-head -a origin &&
+	 git symbolic-ref refs/remotes/origin/HEAD > output &&
+	 echo refs/remotes/origin/master > expect &&
+	 test_cmp expect output
+	)
+'
+
+test_expect_success 'prepare pack objects' '
+	cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo.git "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git &&
+	 git --bare repack -a -d
+	)
+'
+
+test_expect_success 'fetch notices corrupt pack' '
+	cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
+	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad1.git &&
+	 p=`ls objects/pack/pack-*.pack` &&
+	 chmod u+w $p &&
+	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
+	) &&
+	mkdir repo_bad1.git &&
+	(cd repo_bad1.git &&
+	 git --bare init &&
+	 test_must_fail git --bare fetch "$GIT_DAEMON_URL/repo_bad1.git" &&
+	 test 0 = `ls objects/pack/pack-*.pack | wc -l`
+	)
+'
+
+test_expect_success 'fetch notices corrupt idx' '
+	cp -R "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_pack.git "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
+	(cd "$GIT_DAEMON_DOCUMENT_ROOT_PATH"/repo_bad2.git &&
+	 p=`ls objects/pack/pack-*.idx` &&
+	 chmod u+w $p &&
+	 printf %0256d 0 | dd of=$p bs=256 count=1 seek=1 conv=notrunc
+	) &&
+	mkdir repo_bad2.git &&
+	(cd repo_bad2.git &&
+	 git --bare init &&
+	 test_must_fail git --bare fetch "$GIT_DAEMON_URL/repo_bad2.git" &&
+	 test 0 = `ls objects/pack | wc -l`
+	)
+'
+
+test_remote_error()
+{
+	do_export=YesPlease
+	while test $# -gt 0
+	do
+		case $1 in
+		-x)
+			shift
+			chmod -x "$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo.git"
+			;;
+		-n)
+			shift
+			do_export=
+			;;
+		*)
+			break
+		esac
+	done
+
+	if test $# -ne 3
+	then
+		error "invalid number of arguments"
+	fi
+
+	cmd=$1
+	repo=$2
+	msg=$3
+
+	if test -x "$GIT_DAEMON_DOCUMENT_ROOT_PATH/$repo"
+	then
+		if test -n "$do_export"
+		then
+			: >"$GIT_DAEMON_DOCUMENT_ROOT_PATH/$repo/git-daemon-export-ok"
+		else
+			rm -f "$GIT_DAEMON_DOCUMENT_ROOT_PATH/$repo/git-daemon-export-ok"
+		fi
+	fi
+
+	test_must_fail git "$cmd" "$GIT_DAEMON_URL/$repo" 2>output &&
+	echo "fatal: remote error: $msg: /$repo" >expect &&
+	test_cmp expect output
+	ret=$?
+	chmod +x "$GIT_DAEMON_DOCUMENT_ROOT_PATH/repo.git"
+	(exit $ret)
+}
+
+msg="access denied or repository not exported"
+test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git '$msg'"
+test_expect_success 'push disabled'      "test_remote_error    push  repo.git    '$msg'"
+test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    '$msg'"
+test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    '$msg'"
+
+stop_git_daemon
+start_git_daemon --informative-errors
+
+test_expect_success 'clone non-existent' "test_remote_error    clone nowhere.git 'no such repository'"
+test_expect_success 'push disabled'      "test_remote_error    push  repo.git    'service not enabled'"
+test_expect_success 'read access denied' "test_remote_error -x fetch repo.git    'no such repository'"
+test_expect_success 'not exported'       "test_remote_error -n fetch repo.git    'repository not exported'"
+
+stop_git_daemon
+test_done
-- 
1.7.8.2.340.gd18f0f
