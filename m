From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] upload-pack: add a trigger for post-upload-pack hook
Date: Wed, 26 Aug 2009 17:47:41 -0700
Message-ID: <7vy6p69j6a.fsf@alter.siamese.dyndns.org>
References: <1250579093-40706-1-git-send-email-tom@mojombo.com>
 <12c267e40908251043g4f3e36aya05d9c705f5afee2@mail.gmail.com>
 <20090825184525.GC23731@coredump.intra.peff.net>
 <7vprajmp16.fsf@alter.siamese.dyndns.org>
 <7v1vmycfhd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Preston-Werner <tom@mojombo.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Tom Werner <mojombo@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 02:48:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgT9m-0001Gi-Qa
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 02:48:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754431AbZH0Arx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 20:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754309AbZH0Arx
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 20:47:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63845 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754079AbZH0Arw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 20:47:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 0181C1A28C;
	Wed, 26 Aug 2009 20:47:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vm8GHahF8iL3edOIxy9UgvR6W+0=; b=JiyucG
	Qavq8hHzm/ucQ1LWyJj4ofk8y+3/0Nt9rKxAIeiDTyctjrhNIEFjZZRrgCCO2J2a
	dxbykiluG7dskTOpusiEtpPb4EgzZwdB5MpvY2mrIn50NwY13kddtwePTVjbpYDg
	TMnfcztUZqglUvu7uHPh5q6wstVoAX1YGscio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZFKmqikZH6YMrswGvJLu3efcYNfAk9lW
	l3GGkUczKvYslumml/ij4ImVnWJfacp15fY0STROA+Y6LFPpvXqB3Iym8PmjelR3
	X/By8bu4iw2XrZHn/TMGpayNVBEXlLbrYWdW2EEfWhCayNgCHbH927o0Y/h8btCF
	f5TaYDAkG7o=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id BBD711A289;
	Wed, 26 Aug 2009 20:47:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 548571A27E; Wed, 26 Aug
 2009 20:47:43 -0400 (EDT)
In-Reply-To: <7v1vmycfhd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed\, 26 Aug 2009 16\:39\:10 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3EB96B04-92A3-11DE-8FEC-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127126>

After upload-pack successfully finishes its operation, post-upload-pack
hook can be called for logging purposes.

The hook is passed various pieces of information, one per line, from its
standard input.  Currently the following items can be fed to the hook, but
more types of information may be added in the future:

    want SHA-1::
        40-byte hexadecimal object name the client asked to include in the
        resulting pack.  Can occur one or more times in the input.

    have SHA-1::
        40-byte hexadecimal object name the client asked to exclude from
        the resulting pack, claiming to have them already.  Can occur zero
        or more times in the input.

    time float::
        Number of seconds spent for creating the packfile.

    size decimal::
        Size of the resulting packfile in bytes.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 > Here is an illustration patch.

 And here is a bit more polished one with necessary supporting material.

 Documentation/git-upload-pack.txt |    2 +
 Documentation/githooks.txt        |   25 +++++++++++++
 t/t5501-post-upload-pack.sh       |   49 ++++++++++++++++++++++++++
 upload-pack.c                     |   68 +++++++++++++++++++++++++++++++++++-
 4 files changed, 142 insertions(+), 2 deletions(-)
 create mode 100755 t/t5501-post-upload-pack.sh

diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index b8e49dc..63f3b5c 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -20,6 +20,8 @@ The UI for the protocol is on the 'git-fetch-pack' side, and the
 program pair is meant to be used to pull updates from a remote
 repository.  For push operations, see 'git-send-pack'.
 
+After finishing the operation successfully, `post-upload-pack`
+hook is called (see linkgit:githooks[5]).
 
 OPTIONS
 -------
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1c73673..036f6c7 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -307,6 +307,31 @@ Both standard output and standard error output are forwarded to
 'git-send-pack' on the other end, so you can simply `echo` messages
 for the user.
 
+post-upload-pack
+----------------
+
+After upload-pack successfully finishes its operation, this hook is called
+for logging purposes.
+
+The hook is passed various pieces of information, one per line, from its
+standard input.  Currently the following items can be fed to the hook, but
+more types of information may be added in the future:
+
+want SHA-1::
+    40-byte hexadecimal object name the client asked to include in the
+    resulting pack.  Can occur one or more times in the input.
+
+have SHA-1::
+    40-byte hexadecimal object name the client asked to exclude from
+    the resulting pack, claiming to have them already.  Can occur zero
+    or more times in the input.
+
+time float::
+    Number of seconds spent for creating the packfile.
+
+size decimal::
+    Size of the resulting packfile in bytes.
+
 pre-auto-gc
 -----------
 
diff --git a/t/t5501-post-upload-pack.sh b/t/t5501-post-upload-pack.sh
new file mode 100755
index 0000000..2cb63f8
--- /dev/null
+++ b/t/t5501-post-upload-pack.sh
@@ -0,0 +1,49 @@
+#!/bin/sh
+
+test_description='post upload-hook'
+
+. ./test-lib.sh
+
+LOGFILE=".git/post-upload-pack-log"
+
+test_expect_success setup '
+	test_commit A &&
+	test_commit B &&
+	git reset --hard A &&
+	test_commit C &&
+	git branch prev B &&
+	mkdir -p .git/hooks &&
+	{
+		echo "#!$SHELL_PATH" &&
+		echo "cat >post-upload-pack-log"
+	} >".git/hooks/post-upload-pack" &&
+	chmod +x .git/hooks/post-upload-pack
+'
+
+: test_expect_success initial '
+	rm -fr sub &&
+	git init sub &&
+	(
+		cd sub &&
+		git fetch --no-tags .. prev
+	) &&
+	want=$(sed -n "s/^want //p" "$LOGFILE") &&
+	test "$want" = "$(git rev-parse --verify B)" &&
+	! grep "^have " "$LOGFILE"
+'
+
+test_expect_success second '
+	rm -fr sub &&
+	git init sub &&
+	(
+		cd sub &&
+		git fetch --no-tags .. prev:refs/remotes/prev &&
+		git fetch --no-tags .. master
+	) &&
+	want=$(sed -n "s/^want //p" "$LOGFILE") &&
+	test "$want" = "$(git rev-parse --verify C)" &&
+	have=$(sed -n "s/^have //p" "$LOGFILE") &&
+	test "$have" = "$(git rev-parse --verify B)"
+'
+
+test_done
diff --git a/upload-pack.c b/upload-pack.c
index 4d8be83..69a6f46 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -141,8 +141,60 @@ static int do_rev_list(int fd, void *create_full_pack)
 	return 0;
 }
 
+static int feed_obj_to_hook(const char *label, struct object_array *oa, int i, int fd)
+{
+	int cnt;
+	char buf[512];
+
+	cnt = sprintf(buf, "%s %s\n", label,
+		      sha1_to_hex(oa->objects[i].item->sha1));
+	return write_in_full(fd, buf, cnt) != cnt;
+}
+
+static int run_post_upload_pack_hook(size_t total, struct timeval *tv)
+{
+	const char *argv[2];
+	struct child_process proc;
+	int err, i;
+	int cnt;
+	char buf[512];
+
+	argv[0] = "hooks/post-upload-pack";
+	argv[1] = NULL;
+
+	if (access(argv[0], X_OK) < 0)
+		return 0;
+
+	memset(&proc, 0, sizeof(proc));
+	proc.argv = argv;
+	proc.in = -1;
+	proc.stdout_to_stderr = 1;
+	err = start_command(&proc);
+	if (err)
+		return err;
+	for (i = 0; !err && i < want_obj.nr; i++)
+		err |= feed_obj_to_hook("want", &want_obj, i, proc.in);
+	for (i = 0; !err && i < have_obj.nr; i++)
+		err |= feed_obj_to_hook("have", &have_obj, i, proc.in);
+	if (!err) {
+		cnt = sprintf(buf, "time %ld.%06ld\n",
+			      (long)tv->tv_sec, (long)tv->tv_usec);
+		err |= (write_in_full(proc.in, buf, cnt) != cnt);
+	}
+	if (!err) {
+		cnt = sprintf(buf, "size %ld\n", (long)total);
+		err |= (write_in_full(proc.in, buf, cnt) != cnt);
+	}
+	if (close(proc.in))
+		err = 1;
+	if (finish_command(&proc))
+		err = 1;
+	return err;
+}
+
 static void create_pack_file(void)
 {
+	struct timeval start_tv, tv;
 	struct async rev_list;
 	struct child_process pack_objects;
 	int create_full_pack = (nr_our_refs == want_obj.nr && !have_obj.nr);
@@ -150,10 +202,12 @@ static void create_pack_file(void)
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
 	int buffered = -1;
-	ssize_t sz;
+	ssize_t sz, total_sz;
 	const char *argv[10];
 	int arg = 0;
 
+	gettimeofday(&start_tv, NULL);
+	total_sz = 0;
 	if (shallow_nr) {
 		rev_list.proc = do_rev_list;
 		rev_list.data = 0;
@@ -262,7 +316,7 @@ static void create_pack_file(void)
 			sz = xread(pack_objects.out, cp,
 				  sizeof(data) - outsz);
 			if (0 < sz)
-					;
+				total_sz += sz;
 			else if (sz == 0) {
 				close(pack_objects.out);
 				pack_objects.out = -1;
@@ -314,6 +368,16 @@ static void create_pack_file(void)
 	}
 	if (use_sideband)
 		packet_flush(1);
+
+	gettimeofday(&tv, NULL);
+	tv.tv_sec -= start_tv.tv_sec;
+	if (tv.tv_usec < start_tv.tv_usec) {
+		tv.tv_sec--;
+		tv.tv_usec += 1000000;
+	}
+	tv.tv_usec -= start_tv.tv_usec;
+	if (run_post_upload_pack_hook(total_sz, &tv))
+		warning("post-upload-hook failed");
 	return;
 
  fail:
-- 
1.6.4.1.288.g10d22
