Return-Path: <SRS0=xqrk=6B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6C10C352BE
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92EAC207FC
	for <git@archiver.kernel.org>; Fri, 17 Apr 2020 09:45:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qsJKthmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgDQJpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgDQJpm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Apr 2020 05:45:42 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1AAC061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:41 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id nu11so862892pjb.1
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 02:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5WyHEN9aeNzuelnEQUpUscdNAlDwAXGqnxH/lyK62M=;
        b=qsJKthmEC4wLPAjwqeY2JyJCanZ78vpNCVZM+oejMAJx5nHlqni3jIFrzVHKcsUd/d
         7i700KfuhZu3vhdaPMp5SontUKlb0klcj70LDBaVAvrl8klFLeVbe3U3AvGJgIAjmSaz
         JRkKAEVRAGAO8I0fte/EI4FWJNaCjb3QJ6qpvD2H+VllvtYmxutP55E2rOdpPFo+ik3Y
         GHIN6Xbfbg2tLY4m0qvHC6UsokuT+LvlIckzR9+F16pwd9J8pbDLXwAOeSsysInn5pE4
         talXtJhV/o80Fd7VESV7kjqLYoHKnqICqK9a//DJywmXf5ics5s86iVILcoBVtnQJEdK
         9bWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5WyHEN9aeNzuelnEQUpUscdNAlDwAXGqnxH/lyK62M=;
        b=LwPVZsRNfkLryZS3WSQ+EIiy3U2cXdtz1Dtua43eLDgZmHI6vWsNXU5lc7N+qs3nK9
         kwU9M8lVxBmhWEv4x4xrt6Nxl7TRmJuewUKarsgGlL5DAFG8sTFpBELe7J+kc4erk39W
         C3pfPFuGwJ5HcnISRDJPsnW46aSMpqf5ZV5uHVb6QuobRwQlzhvfXQg10q2b0GS4xMAu
         8caWis30ayiFjh9dEX6sfkWkAgOd73NGauN7su4/ER2wMneos5H8skQ1Ydbq8YCxWpQc
         3WI6fmI16cCR7JEHj1eDqPpbqfe9IMxpkX78P3MNvTR9U3dVCnUJNgdHq0r7ObUleXod
         vfEg==
X-Gm-Message-State: AGi0PuYm1IVU4X17ziNeBCXisK9+kKFKzJq8Cr7dap162iSpc4n74Eor
        nyHhPJ4e50W0RqBe5xKxA1eTD2MS0Xo=
X-Google-Smtp-Source: APiQypIPgz/UCFtyomxgaTesIuzt+r16kEFAhpI13lNr/biQIsTcyuJ3QwSjgsio68wKL7u1vkOM/A==
X-Received: by 2002:a17:90a:f305:: with SMTP id ca5mr3376252pjb.27.1587116741040;
        Fri, 17 Apr 2020 02:45:41 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q145sm4790979pfq.105.2020.04.17.02.45.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Apr 2020 02:45:40 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v4 0/5] fix git-push porcelain output and atomic report issue
Date:   Fri, 17 Apr 2020 05:45:31 -0400
Message-Id: <20200417094536.9463-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200416162415.5751-1-worldhello.net@gmail.com>
References: <20200416162415.5751-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Patch 1/5 fixes format of porcelain output for `git-push`, and it should
belong to a new topic, but it has a overlap with topic `jx/atomic-push`.

So I rebased `jx/atomic-push` on top of it, and resolved conflicts
between these two features.  Patch 2/5 ~ 5/5 are belong to the original
topic `jx/atomic-push`.

Note: Some patches of `jx/proc-receive-hook` also have overlap with this
      patch series, so v13 of `jx/proc-receive-hook` will base on this
      topic, instead of master branch of Git.

## Changes since `jx/atomic-push` v3:

* Fix broken test cases in t5504, and t5516, which is instroduced by
  patch 1/5..

## Changes since `jx/atomic-push` v2:

Add new patch 1/5 which fixes new issue found in git-push porcelain output.
This fix overlaps with and the topic `jx/atomic-push`, so merge them together.

I find this issue when adding test cases of porcelain output for topic
`jx/proc-receive-hook`, which depends on this fix.

Details of this new issue:

The porcelain output of a failed `git-push` command is inconsistent for
different protocols.  For example, the following `git-push` command
may fail due to the failure of the `pre-receive` hook.

    git push --porcelain origin HEAD:refs/heads/master

For SSH protocol, the porcelain output does not end with a "Done"
message:

	To <URL/of/upstream.git>
	!  HEAD:refs/heads/master  [remote rejected] (pre-receive hook declined)

While for HTTP protocol, the porcelain output does end with a "Done"
message:

	To <URL/of/upstream.git>
	!  HEAD:refs/heads/master  [remote rejected] (pre-receive hook declined)
	Done

The following code at the end of function `send_pack()` indicates that
`send_pack()` should not return an error if some references are rejected
in porcelain mode.

    int send_pack(...)
        ... ...

        if (args->porcelain)
            return 0;

        for (ref = remote_refs; ref; ref = ref->next) {
            switch (ref->status) {
            case REF_STATUS_NONE:
            case REF_STATUS_UPTODATE:
            case REF_STATUS_OK:
                break;
            default:
                return -1;
            }
        }
        return 0;
    }

So if atomic push failed, must check the porcelain mode before return
an error.  And `receive_status()` should not return an error for a
failed updated reference, because `send_pack()` will check them instead.


## Range-diff v2...v4

-:  ---------- > 1:  96028ebf7d send-pack: fix inconsistent porcelain output
1:  7a0579ba13 = 2:  77f66ebfd2 t5543: never report what we do not push
2:  9b4bca8f4c ! 3:  cb63c4a9f4 send-pack: mark failure of atomic push properly
    @@ t/t5543-atomic-push.sh: test_expect_failure 'atomic push reports (mirror, but re
      	(
      		cd workbench &&
     
    + ## t/t5548-push-porcelain.sh ##
    +@@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
    + 	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
    + 	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
    + 	# git-push         : master(B)  bar(A)  NULL    next(A)
    +-	test_expect_success "atomic push failed ($PROTOCOL)" '
    ++	test_expect_failure "atomic push failed ($PROTOCOL)" '
    + 		(
    + 			cd workbench &&
    + 			git update-ref refs/heads/master $B &&
    +
      ## transport.c ##
     @@ transport.c: int transport_push(struct repository *r,
      		err = push_had_errors(remote_refs);
3:  a7e8d7c893 ! 4:  3fb57569da transport-helper: mark failure for atomic push
    @@ t/t5541-http-push-smart.sh: test_expect_failure 'push --atomic also prevents bra
      
      test_expect_success 'push --atomic fails on server-side errors' '
     
    + ## t/t5548-push-porcelain.sh ##
    +@@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
    + 	# Refs of upstream : master(A)  bar(B)  baz(A)  next(A)
    + 	# Refs of workbench: master(B)  bar(A)  baz(A)  next(A)
    + 	# git-push         : master(B)  bar(A)  NULL    next(A)
    +-	test_expect_failure "atomic push failed ($PROTOCOL)" '
    ++	test_expect_success "atomic push failed ($PROTOCOL)" '
    + 		(
    + 			cd workbench &&
    + 			git update-ref refs/heads/master $B &&
    +@@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
    + 		make_user_friendly_and_stable_output <out >actual &&
    + 		cat >expect <<-EOF &&
    + 		To <URL/of/upstream.git>
    ++		=    refs/heads/next:refs/heads/next    [up to date]
    + 		!    refs/heads/bar:refs/heads/bar    [rejected] (non-fast-forward)
    + 		!    (delete):refs/heads/baz    [rejected] (atomic push failed)
    + 		!    refs/heads/master:refs/heads/master    [rejected] (atomic push failed)
    +-		!    refs/heads/next:refs/heads/next    [rejected] (atomic push failed)
    + 		Done
    + 		EOF
    + 		test_cmp expect actual &&
    +@@ t/t5548-push-porcelain.sh: run_git_push_porcelain_output_test() {
    + 		EOF
    + 		test_cmp expect actual
    + 	'
    +-
    + 	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
    + 		write_script "$upstream/hooks/pre-receive" <<-EOF
    + 		exit 1
    +
      ## transport-helper.c ##
     @@ transport-helper.c: static int push_refs_with_push(struct transport *transport,
      		case REF_STATUS_REJECT_STALE:
4:  94b13f5dcd ! 5:  1c73ddff0d transport-helper: new method reject_atomic_push()
    @@ send-pack.c: int send_pack(struct send_pack_args *args,
      			if (use_atomic) {
      				strbuf_release(&req_buf);
      				strbuf_release(&cap_buf);
    --				return atomic_push_failure(args, remote_refs, ref);
    +-				atomic_push_failure(args, remote_refs, ref);
     +				reject_atomic_push(remote_refs, args->send_mirror);
    -+				return error("atomic push failed for ref %s. status: %d\n",
    -+					     ref->name, ref->status);
    ++				error("atomic push failed for ref %s. status: %d\n",
    ++				      ref->name, ref->status);
    + 				return args->porcelain ? 0 : -1;
      			}
      			/* else fallthrough */
    - 		default:
     
      ## transport-helper.c ##
     @@ transport-helper.c: static int push_refs_with_push(struct transport *transport,

---

Jiang Xin (5):
  send-pack: fix inconsistent porcelain output
  t5543: never report what we do not push
  send-pack: mark failure of atomic push properly
  transport-helper: mark failure for atomic push
  transport-helper: new method reject_atomic_push()

 send-pack.c                     |  32 +---
 t/t5504-fetch-receive-strict.sh |   1 +
 t/t5516-fetch-push.sh           |   1 +
 t/t5541-http-push-smart.sh      |  12 +-
 t/t5543-atomic-push.sh          |  89 ++++++++++
 t/t5548-push-porcelain.sh       | 300 ++++++++++++++++++++++++++++++++
 transport-helper.c              |  23 +++
 transport.c                     |  24 +--
 transport.h                     |   3 +
 9 files changed, 441 insertions(+), 44 deletions(-)
 create mode 100755 t/t5548-push-porcelain.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

