Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EBD6203E4
	for <e@80x24.org>; Tue, 26 Jul 2016 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757029AbcGZQGd (ORCPT <rfc822;e@80x24.org>);
	Tue, 26 Jul 2016 12:06:33 -0400
Received: from mout.gmx.net ([212.227.15.15]:65034 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757007AbcGZQG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jul 2016 12:06:28 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0LgqQQ-1avXw136qU-00oDmT; Tue, 26 Jul 2016 18:05:51
 +0200
Date:	Tue, 26 Jul 2016 18:05:37 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v5 00/16] Use merge_recursive() directly in the builtin am
In-Reply-To: <cover.1469187652.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1469547160.git.johannes.schindelin@gmx.de>
References: <cover.1469187652.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:vbyqy2Km086wY+rnfj+t1SsPudN651DO1XYUQucF9LduQdiOFwq
 +koHAxcgxnjEt7qLpMlH40cJ/3ndxKLxTXTzCxdwoaMeCOx0Zx9Hu7jQfYCE0rStTPLF6Fw
 WMwqNj8kI9tXHVY5frmLMjNiG2cowZC4hCV1KW255yG8kgG/PWxwbhdwz/OzqvCXvtC018U
 XshyzK6vC7DWwAND5R9Gg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:RY67Os7/XIg=:LqDqyswajT0JzzDMmYm7K8
 5fMcAiZfGWXrg8Sdrm9vXXNfTG4tWNTmNDke3lk7ieEK/xnzfl6YVSgO8UeZpp6fmdJ78io1w
 kXeTbZB7Qu9I+wP7YuFCXToiO/jUP89BKQEv3HEXpwh21UidqA+FUbjdPoRFJm5FA5IdGpbma
 1dMKaCYg0WHOD8GTXu4TlK9h1G9sjD6fDQ1hXyColZwOZHP4MXV1CDRYtHym4B+KS08uUEnRe
 lkfQIbVaW+NXVSPRxKmSXMlTSsQBjzbitvjuK7WTADKKwPjnsTqZ4lABMLTF60/05fqlG8G+p
 p7oEyYY04TiFaJVpNo1hkOy8BNsPvEs3oWhmZ4PdyC9VMthgS8pAYV2xeeOIFFQOGO/mg4VFD
 2vAyea8C6yuHtrH7SD9cDX0P3RGLOHU6NpJEaF8mkmCxA6VrFhPirxuama9j/5LUgXzgw4T89
 R+37by91b3V7UAgDPYTL6QlO4AiDspa9XszD6kubKQeoA+UpPb0l0Z8DWWxBbK2HVotsv6top
 4wG2i1851b2/gacXmxLi5QopVZdLweEvmO/Qp8hM0jIxiY8KRRjftodPrr83X5dXx6fwCe6sO
 XNDXp3hRiOIQkRSbrqeK26fydMs97Y6BfqpwjfrQmwgzv7tni0WbSkqh8FfylAkv154nOHUEc
 NwbGlby7HFi1OGZ0Y3fR21CiAmkxE7ar4Ooqe703dvBAxUkMf2nTvRehxiSLM3UQYnZ2rKk37
 DQ9n7V+m+7hXrxhkKLVar9JDT2ei4UsoOn3n6jTS3HRtlWgf/6MFAXQCLdRPJXGc/b8exmosl
 4jExl5q
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This is the fifth iteration of the long-awaited re-roll of the attempt to
avoid spawning merge-recursive from the builtin am and use merge_recursive()
directly instead.

The *real* reason for the reroll is that I need a libified recursive
merge to accelerate the interactive rebase by teaching the sequencer to
do rebase -i's grunt work. Coming with a very nice 3x-5x speedup of
`rebase -i`.

In this endeavor, we need to be extra careful to retain backwards
compatibility. The test script t6022-merge-rename.sh, for example, verifies
that `git pull` exits with status 128 in case of a fatal error. To that end,
we need to make sure that fatal errors are handled by existing (builtin)
users via exit(128) (or die(), which calls exit(128) at the end).  New users
(such as a builtin helper doing rebase -i's grunt work) may want to print
some helpful advice what happened and how to get out of this mess before
erroring out.

The changes relative to the fourth iteration of this patch series:

- the first patch which introduces a tests case to t5520 was prettified:

  - it uses test_seq now,
  - it avoids `printf` when `echo` does the job, too,
  - it adds a missing empty line between test cases, and
  - it clarifies why we need to check out with force.

- the change that would have made the bug report about a too-small
  buffer in imap-send was reverted, because it did more than was claimed
  by the commit message.

- the "Let's teach them manners" part of one commit message was replaced
  with a less flippant description.

- the comment before merge_recursive() that claims that the return value
  is ignored now clarifies that it is ignored unless it indicates an
  error.

- during the rebase to `master`, a trivial merge conflict with the
  `jc/renormalize-merge-kill-safer-crlf` branch was resolved.

This patch series touches rather important code. Now that I addressed
concerns such as prettifying some test code, I would appreciate thorough
reviews with a focus on the critical parts of the code, those that could
result in regressions.


Johannes Schindelin (16):
  t5520: verify that `pull --rebase` shows the helpful advice when
    failing
  Report bugs consistently
  Avoid translating bug messages
  merge-recursive: clarify code in was_tracked()
  Prepare the builtins for a libified merge_recursive()
  merge_recursive: abort properly upon errors
  merge-recursive: avoid returning a wholesale struct
  merge-recursive: allow write_tree_from_memory() to error out
  merge-recursive: handle return values indicating errors
  merge-recursive: switch to returning errors instead of dying
  am -3: use merge_recursive() directly again
  merge-recursive: flush output buffer before printing error messages
  merge-recursive: write the commit title in one go
  merge-recursive: offer an option to retain the output in 'obuf'
  Ensure that the output buffer is released after calling merge_trees()
  merge-recursive: flush output buffer even when erroring out

 builtin/am.c           |  62 ++----
 builtin/checkout.c     |   5 +-
 builtin/ls-files.c     |   3 +-
 builtin/merge.c        |   2 +
 builtin/update-index.c |   2 +-
 grep.c                 |   8 +-
 imap-send.c            |   2 +-
 merge-recursive.c      | 578 +++++++++++++++++++++++++++++--------------------
 merge-recursive.h      |   2 +-
 sequencer.c            |   5 +
 sha1_file.c            |   4 +-
 t/t5520-pull.sh        |  32 +++
 trailer.c              |   2 +-
 transport.c            |   2 +-
 wt-status.c            |   4 +-
 15 files changed, 418 insertions(+), 295 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/am-3-merge-recursive-direct-v5
Interdiff vs v4:

 diff --git a/imap-send.c b/imap-send.c
 index 67d67f8..0f5f476 100644
 --- a/imap-send.c
 +++ b/imap-send.c
 @@ -506,12 +506,12 @@ static char *next_arg(char **s)
  
  static int nfsnprintf(char *buf, int blen, const char *fmt, ...)
  {
 -	int ret = -1;
 +	int ret;
  	va_list va;
  
  	va_start(va, fmt);
  	if (blen <= 0 || (unsigned)(ret = vsnprintf(buf, blen, fmt, va)) >= (unsigned)blen)
 -		die("BUG: buffer too small (%d < %d)", ret, blen);
 +		die("BUG: buffer too small. Please report a bug.");
  	va_end(va);
  	return ret;
  }
 diff --git a/merge-recursive.c b/merge-recursive.c
 index a3d12e6..66e93e0 100644
 --- a/merge-recursive.c
 +++ b/merge-recursive.c
 @@ -2041,9 +2041,10 @@ int merge_recursive(struct merge_options *o,
  		/*
  		 * When the merge fails, the result contains files
  		 * with conflict markers. The cleanness flag is
 -		 * ignored, it was never actually used, as result of
 -		 * merge_trees has always overwritten it: the committed
 -		 * "conflicts" were already resolved.
 +		 * ignored (unless indicating an error), it was never
 +		 * actually used, as result of merge_trees has always
 +		 * overwritten it: the committed "conflicts" were
 +		 * already resolved.
  		 */
  		discard_cache();
  		saved_b1 = o->branch1;
 diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
 index d289056..6ad37b5 100755
 --- a/t/t5520-pull.sh
 +++ b/t/t5520-pull.sh
 @@ -258,20 +258,21 @@ test_expect_success '--rebase' '
  test_expect_success '--rebase with conflicts shows advice' '
  	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
  	git checkout -b seq &&
 -	printf "1\\n2\\n3\\n4\\n5\\n" >seq.txt &&
 +	test_seq 5 >seq.txt &&
  	git add seq.txt &&
  	test_tick &&
  	git commit -m "Add seq.txt" &&
 -	printf "6\\n" >>seq.txt &&
 +	echo 6 >>seq.txt &&
  	test_tick &&
  	git commit -m "Append to seq.txt" seq.txt &&
  	git checkout -b with-conflicts HEAD^ &&
 -	printf "conflicting\\n" >>seq.txt &&
 +	echo conflicting >>seq.txt &&
  	test_tick &&
  	git commit -m "Create conflict" seq.txt &&
  	test_must_fail git pull --rebase . seq 2>err >out &&
  	grep "When you have resolved this problem" out
  '
 +
  test_expect_success 'failed --rebase shows advice' '
  	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
  	git checkout -b diverging &&
 @@ -279,6 +280,7 @@ test_expect_success 'failed --rebase shows advice' '
  	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
  	git update-index --cacheinfo 0644 $sha1 file &&
  	git commit -m v1-with-cr &&
 +	# force checkout because `git reset --hard` will not leave clean `file`
  	git checkout -f -b fails-to-rebase HEAD^ &&
  	test_commit v2-without-cr file "2" file2-lf &&
  	test_must_fail git pull --rebase . diverging 2>err >out &&

-- 
2.9.0.281.g286a8d9

base-commit: 8c6d1f9807c67532e7fb545a944b064faff0f70b
