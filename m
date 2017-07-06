Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C95E202AB
	for <e@80x24.org>; Thu,  6 Jul 2017 18:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751936AbdGFS4M (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jul 2017 14:56:12 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35186 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbdGFS4K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jul 2017 14:56:10 -0400
Received: by mail-pf0-f193.google.com with SMTP id q85so1377704pfq.2
        for <git@vger.kernel.org>; Thu, 06 Jul 2017 11:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=/O3xYAhGee+fR5COgZF615CGJadg4z5ExutXwxMaxIg=;
        b=lfH2bUCkhqtGa9H5isgVs/1B6e+HsGK8pIBG6dfZtGR4atAQItScxWz2IsaBw44CbV
         nFBH8O6rmvzss2vhaEuAJR/gfE3xSPiZukPyG9b/iPuW5u3fCiP2oN5pGwXN5pWtF0KC
         iQqDNGgr3DJoK5WbAdV3V3qxvB8asWnL6hmhlEAA77dethikumP4jvHpa6bYvAqryBfF
         XJh0jNdxKHlcZGpfV9xHrjFFHNzNKBq/qIkHJotys9/w6PFFnRj4nOHf6HZFGSRc+Q13
         oUy0XOYcKEEHVsm0i78ewF2f4IOL6k0UXY74qpmGLIi+3D9scJJuhZNgDTISOhPa9M3U
         01/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=/O3xYAhGee+fR5COgZF615CGJadg4z5ExutXwxMaxIg=;
        b=s1M2tg+nw7iVcSxtOKrY+0cndT4NidLOOBJs6/mAfQDfEz4JgIP5hZOtRGnoif7MX4
         qthqsnRJTk+lODCSgc4LSkwd0C+I83aL7MXIO0e3V1MFTlKtHpXL6LPaUlqnzYgZEOfY
         qDkl+2q0QbhogFbgEnOPGKJhE6MgWjCy/pU8WLevTxKQUqDaKlFhe6R68jARzO/0vzPw
         x/WoJnJeQKjytqKjeo/tFAVC3ti95Qbw5OZUpRL7AwUiaS79CRtjPVYLALfgbm3SVTzS
         GrVTnTJ5M04Y5AkAfANeOL23n3Tox86IPwpmY8GxWmwdkqLD9Kec4wtEt/enbXH422qY
         Ep1A==
X-Gm-Message-State: AIVw113ZBDWuQaStTYSMnY+SyxOVuo3LtHXPFRONnlB0G78jOJE7shyN
        62O3h9RX/t5kmb99mRk=
X-Received: by 10.99.97.146 with SMTP id v140mr27941049pgb.62.1499367369068;
        Thu, 06 Jul 2017 11:56:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:f878:6796:f790:dc38])
        by smtp.gmail.com with ESMTPSA id e77sm1453629pfk.123.2017.07.06.11.56.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 06 Jul 2017 11:56:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git <git@vger.kernel.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Stefan Haller <haller@ableton.com>, Jeff King <peff@peff.net>,
        Matt McCutchen <matt@mattmccutchen.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Francesco Mazzoli <f@mazzo.li>
Subject: [PATCH] push: disable lazy --force-with-lease by default
References: <CA+P7+xqS1Fh0aDV=QYbVMdRa=M4e-mBtjvknR=U_RShDoccNjQ@mail.gmail.com>
        <1n47so5.9e6qvf1bbqww4M%haller@ableton.com>
        <CA+P7+xq6MJa-J5cj2Om20d+g7KBretShpxH=13HWV7vFR9be8g@mail.gmail.com>
        <CACBZZX48RanjHsv1UsnxkbxRtqKRGgMcgmtVqQmR84H5j8awqQ@mail.gmail.com>
        <CA+P7+xowo+qXZ+Vr5vYg8wSpNzF44X9RsV34s_fKhBtVcddBvw@mail.gmail.com>
        <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com>
Date:   Thu, 06 Jul 2017 11:56:05 -0700
In-Reply-To: <CAPc5daXVYA8MsseJxge6Qo6ASc=CL6ySt2K61LpOtZ=3H3gWuw@mail.gmail.com>
        (Junio C. Hamano's message of "Tue, 11 Apr 2017 17:51:47 +0900")
Message-ID: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git push --force-with-lease=<branch>:<expect>" makes sure that
there is no unexpected changes to the branch at the remote while you
prepare a rewrite based on the old state of the branch.  This
feature came with an experimental option that allows :<expect> part
to be omitted by using the tip of remote-tracking branch that
corresponds to the <branch>.

It turns out that some people use third-party tools that fetch from
remote and update the remote-tracking branches behind users' back,
defeating the safety relying on the stability of the remote-tracking
branches.  We have some warning text that was meant to be scary
sounding in our documentation, but nevertheless people seem to be
bitten.  cf. https://public-inbox.org/git/1491617750.2149.10.camel@mattmccutchen.net/
for a recent example.

Let's disable the form that relies on the stability of remote-tracking
branches by default, and allow users who _know_ their remote-tracking
branches are stable to enable it with a configuration variable.

This problem was predicted from the very beginning; see 28f5d176
(remote.c: add command line option parser for "--force-with-lease",
2013-07-08).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This is a bit overdue safety fix that we should have done long
   time ago.  If we had this, I do not think it makes it riskier to
   forbid --force and tell people to use --force-with-lease.

 Documentation/config.txt   |  5 +++++
 Documentation/git-push.txt |  5 +++--
 builtin/send-pack.c        |  5 +++++
 remote.c                   | 16 ++++++++++++----
 remote.h                   |  2 ++
 send-pack.c                |  1 +
 t/t5533-push-cas.sh        | 19 +++++++++++++++++--
 transport-helper.c         |  5 +++++
 transport.c                |  5 +++++
 9 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 06898a7498..2f929315a2 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2588,6 +2588,11 @@ new default).
 
 --
 
+push.allowLazyForceWithLease::
+	If set to true, allow the `--force-with-lease` option
+	without the expected object name (i.e. expecting the objects
+	at the tip of corresponding remote-tracking branches).
+
 push.followTags::
 	If set to true enable `--follow-tags` option by default.  You
 	may override this configuration at time of push by specifying
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 0a639664fd..1fa01210a2 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -212,8 +212,9 @@ must not already exist.
 +
 Note that all forms other than `--force-with-lease=<refname>:<expect>`
 that specifies the expected current value of the ref explicitly are
-still experimental and their semantics may change as we gain experience
-with this feature.
+disabled by default.  Read the note on safety below, and if you think
+you are not affected, enable it with the `push.allowLazyForceWithLease`
+configuration option (cf. linkgit:git-config[1]).
 +
 "--no-force-with-lease" will cancel all the previous --force-with-lease on the
 command line.
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 633e0c3cdd..c008f5b60f 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -68,6 +68,11 @@ static void print_helper_status(struct ref *ref)
 			msg = "stale info";
 			break;
 
+		case REF_STATUS_REJECT_LAZY_CAS:
+			res = "error";
+			msg = "lazy force-with-error";
+			break;
+
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 			res = "error";
 			msg = "already exists";
diff --git a/remote.c b/remote.c
index d87482573d..2d3ee6020f 100644
--- a/remote.c
+++ b/remote.c
@@ -1517,7 +1517,9 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 			     int force_update)
 {
 	struct ref *ref;
+	int allow_lazy_cas = 0;
 
+	git_config_get_bool("push.allowLazyForceWithLease", &allow_lazy_cas);
 	for (ref = remote_refs; ref; ref = ref->next) {
 		int force_ref_update = ref->force || force_update;
 		int reject_reason = 0;
@@ -1544,7 +1546,9 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 		 * branch.
 		 */
 		if (ref->expect_old_sha1) {
-			if (oidcmp(&ref->old_oid, &ref->old_oid_expect))
+			if (!allow_lazy_cas && ref->lazy_cas)
+				reject_reason = REF_STATUS_REJECT_LAZY_CAS;
+			else if (oidcmp(&ref->old_oid, &ref->old_oid_expect))
 				reject_reason = REF_STATUS_REJECT_STALE;
 			else
 				/* If the ref isn't stale then force the update. */
@@ -2341,10 +2345,13 @@ static void apply_cas(struct push_cas_option *cas,
 		if (!refname_match(entry->refname, ref->name))
 			continue;
 		ref->expect_old_sha1 = 1;
-		if (!entry->use_tracking)
+		if (!entry->use_tracking) {
 			hashcpy(ref->old_oid_expect.hash, cas->entry[i].expect);
-		else if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
-			oidclr(&ref->old_oid_expect);
+		} else {
+			ref->lazy_cas = 1;
+			if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
+				oidclr(&ref->old_oid_expect);
+		}
 		return;
 	}
 
@@ -2353,6 +2360,7 @@ static void apply_cas(struct push_cas_option *cas,
 		return;
 
 	ref->expect_old_sha1 = 1;
+	ref->lazy_cas = 1;
 	if (remote_tracking(remote, ref->name, &ref->old_oid_expect))
 		oidclr(&ref->old_oid_expect);
 }
diff --git a/remote.h b/remote.h
index 6c28cd3e4b..22190f4e91 100644
--- a/remote.h
+++ b/remote.h
@@ -89,6 +89,7 @@ struct ref {
 		force:1,
 		forced_update:1,
 		expect_old_sha1:1,
+		lazy_cas:1,
 		deletion:1;
 
 	enum {
@@ -118,6 +119,7 @@ struct ref {
 		REF_STATUS_REJECT_FETCH_FIRST,
 		REF_STATUS_REJECT_NEEDS_FORCE,
 		REF_STATUS_REJECT_STALE,
+		REF_STATUS_REJECT_LAZY_CAS,
 		REF_STATUS_REJECT_SHALLOW,
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
diff --git a/send-pack.c b/send-pack.c
index 11d6f3d983..94f0ad2b14 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -248,6 +248,7 @@ static int check_to_send_update(const struct ref *ref, const struct send_pack_ar
 	case REF_STATUS_REJECT_FETCH_FIRST:
 	case REF_STATUS_REJECT_NEEDS_FORCE:
 	case REF_STATUS_REJECT_STALE:
+	case REF_STATUS_REJECT_LAZY_CAS:
 	case REF_STATUS_REJECT_NODELETE:
 		return CHECK_REF_STATUS_REJECTED;
 	case REF_STATUS_UPTODATE:
diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index d38ecee217..0527832ff5 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -17,7 +17,8 @@ test_expect_success setup '
 	# create template repository
 	test_commit A &&
 	test_commit B &&
-	test_commit C
+	test_commit C &&
+	git config --global push.allowLazyForceWithLease true
 '
 
 test_expect_success 'push to update (protected)' '
@@ -78,7 +79,6 @@ test_expect_success 'push to update (protected, tracking, forced)' '
 	(
 		cd dst &&
 		test_commit E &&
-		git ls-remote . refs/remotes/origin/master >expect &&
 		git push --force --force-with-lease=master origin master
 	) &&
 	git ls-remote dst refs/heads/master >expect &&
@@ -91,6 +91,7 @@ test_expect_success 'push to update (allowed)' '
 	(
 		cd dst &&
 		test_commit D &&
+		git config push.allowLazyForceWithLease false &&
 		git push --force-with-lease=master:master^ origin master
 	) &&
 	git ls-remote dst refs/heads/master >expect &&
@@ -103,6 +104,10 @@ test_expect_success 'push to update (allowed, tracking)' '
 	(
 		cd dst &&
 		test_commit D &&
+		git config push.allowLazyForceWithLease false &&
+		test_must_fail git push --force-with-lease=master origin master 2>err &&
+		grep "lazy force-with-lease" err &&
+		git config --unset push.allowLazyForceWithLease &&
 		git push --force-with-lease=master origin master 2>err &&
 		! grep "forced update" err
 	) &&
@@ -151,6 +156,10 @@ test_expect_success 'push to delete (allowed)' '
 	setup_srcdst_basic &&
 	(
 		cd dst &&
+		git config push.allowLazyForceWithLease false &&
+		test_must_fail git push --force-with-lease=master origin :master 2>err &&
+		grep "lazy force-with-lease" err &&
+		git config --unset push.allowLazyForceWithLease &&
 		git push --force-with-lease=master origin :master 2>err &&
 		grep deleted err
 	) &&
@@ -183,6 +192,9 @@ test_expect_success 'cover everything with default force-with-lease (allowed)' '
 	(
 		cd dst &&
 		git fetch &&
+		git config push.allowLazyForceWithLease false &&
+		test_must_fail git push --force-with-lease origin master master:naster &&
+		git config --unset push.allowLazyForceWithLease &&
 		git push --force-with-lease origin master master:naster
 	) &&
 	git ls-remote dst refs/heads/master |
@@ -196,6 +208,9 @@ test_expect_success 'new branch covered by force-with-lease' '
 	(
 		cd dst &&
 		git branch branch master &&
+		git config push.allowLazyForceWithLease false &&
+		test_must_fail git push --force-with-lease=branch origin branch &&
+		git config --unset push.allowLazyForceWithLease &&
 		git push --force-with-lease=branch origin branch
 	) &&
 	git ls-remote dst refs/heads/branch >expect &&
diff --git a/transport-helper.c b/transport-helper.c
index 33cff38cc0..e36ea5f578 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -736,6 +736,10 @@ static int push_update_ref_status(struct strbuf *buf,
 			status = REF_STATUS_REJECT_STALE;
 			FREE_AND_NULL(msg);
 		}
+		else if (!strcmp(msg, "lazy force-with-error")) {
+			status = REF_STATUS_REJECT_LAZY_CAS;
+			FREE_AND_NULL(msg);
+		}
 		else if (!strcmp(msg, "forced update")) {
 			forced = 1;
 			FREE_AND_NULL(msg);
@@ -847,6 +851,7 @@ static int push_refs_with_push(struct transport *transport,
 		switch (ref->status) {
 		case REF_STATUS_REJECT_NONFASTFORWARD:
 		case REF_STATUS_REJECT_STALE:
+		case REF_STATUS_REJECT_LAZY_CAS:
 		case REF_STATUS_REJECT_ALREADY_EXISTS:
 		case REF_STATUS_UPTODATE:
 			continue;
diff --git a/transport.c b/transport.c
index d75ff0514d..25eeb99a36 100644
--- a/transport.c
+++ b/transport.c
@@ -418,6 +418,10 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count,
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "stale info", porcelain, summary_width);
 		break;
+	case REF_STATUS_REJECT_LAZY_CAS:
+		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+				 "lazy force-with-lease", porcelain, summary_width);
+		break;
 	case REF_STATUS_REJECT_SHALLOW:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				 "new shallow roots not allowed",
@@ -934,6 +938,7 @@ static int run_pre_push_hook(struct transport *transport,
 		if (!r->peer_ref) continue;
 		if (r->status == REF_STATUS_REJECT_NONFASTFORWARD) continue;
 		if (r->status == REF_STATUS_REJECT_STALE) continue;
+		if (r->status == REF_STATUS_REJECT_LAZY_CAS) continue;
 		if (r->status == REF_STATUS_UPTODATE) continue;
 
 		strbuf_reset(&buf);
-- 
2.13.2-765-ge5d8a7f768

