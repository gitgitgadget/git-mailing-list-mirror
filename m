Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3108DC352BE
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CBE22243
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 16:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i19flMdL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405643AbgDPQY1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Apr 2020 12:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732064AbgDPQYX (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 16 Apr 2020 12:24:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A28C061A41
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:21 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id nu11so1579693pjb.1
        for <git@vger.kernel.org>; Thu, 16 Apr 2020 09:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BCxyw/xWoFr0LZZKjhR7W4Y0iP33Gpii3AXhte5SrPw=;
        b=i19flMdLnTnagDz3ytSqwbPe28mqHHHv/bCqhK+vekLYkZnWDgsmPCWqp54A3//ae2
         5rnwmtfE7eFLZ7e1cH0uPxWdFXLn20AQQgKhlUcD4ZAAPKclMQZch6jeiItPMSxY8ck0
         ABJKrlYnuaEuofhzF5gOMp+zQtPT7q+INq0iE0YGGWKzSUx0DOFXGRfm6o4icB4Yayun
         UnVyYO4AY6cK/AakEXKNWmZPFLJ9ENg0aRL2AUq0C5fOEpvweHbfa6G/H+mJV+p8nxv6
         c/i6wX3iRK0qaQvIK8XzYyFB0FwPqA/W3X4kMNbgSq5nFhckEIh9gv/fs7tVAPWOsuWF
         HN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BCxyw/xWoFr0LZZKjhR7W4Y0iP33Gpii3AXhte5SrPw=;
        b=KHWannD12Sxxs6HoCi1Ki6RBvYmd5u9LUahoG3xohimwxe2qvFsSgIqzJaWHsYrc1d
         MlTHqhSYm0q3UyqonmncLrP13rOXWJ5gvOCQsxH9gGdkw2YI1InjAtDUj3C13XvEhChk
         bUICCFDgnFhTpOYPquRVAQmejt4JI4DJxUZQoAHjWb+VihfNjbTzDxAJWoBbDxYH8tFE
         o/ymVNq9cAIKUjtNy0UqsibSQRk2kCc6MbJVRFR35/+bB313sUcjeta6QfaZZJiyYVIw
         Ea1n2lohIs5QAmIYabZpwKtVMHTzjQUEiqoMFxLT5lU/ygnCyn7IeeLEmvbpqqbQTaVl
         h68g==
X-Gm-Message-State: AGi0PuZ3BXPjot1VZnVwjqG6ek21meGRZYVxppJwnDLaVYHCguQiXI5S
        o6A0+lg2xB9D1NT2NGLghXI=
X-Google-Smtp-Source: APiQypJaFK2s0ISs19ncgUreNNBrv7wKpr+Ic/FBPrdLdunjnnQ/Mz9sR2j7DORfScS0a9QDDrQdHg==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr10216912plr.246.1587054261181;
        Thu, 16 Apr 2020 09:24:21 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id c125sm17007933pfa.142.2020.04.16.09.24.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Apr 2020 09:24:20 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v3 0/5] fix git-push porcelain output and atomic report issue
Date:   Thu, 16 Apr 2020 12:24:10 -0400
Message-Id: <20200416162415.5751-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200329143329.13846-1-worldhello.net@gmail.com>
References: <20200329143329.13846-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Find a new issue on porcelain output for git-push, add a new patch 1/5
to fix this issue.  This fix overlaps with and the topic `jx/atomic-push`,
so merge them together.

I find this issue when adding test cases of porcelain output for topic
`jx/proc-receive-hook`, which depends on this fix.

## Details of this new issue

The porcelain output of a failed `git-push` command is inconsistent for
different protocols.  For example, the following `git-push` command
failed because of the failure of `pre-receive` hook.

    git push --porcelain origin HEAD:refs/heads/master

For SSH protocol, the porcelain output does not end with a "Done"
message:

	To <URL/of/upstream.git>
	!  HEAD:refs/heads/master  [remote rejected] (pre-receive hook declined)

While for HTTP protocol, the porcelain output does end with a "Done"
message;

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


## Range-diff v2...v3


-:  ---------- > 1:  d9ea3c35a3 send-pack: fix inconsistent porcelain output
1:  7a0579ba13 = 2:  bb07d5c330 t5543: never report what we do not push
2:  9b4bca8f4c ! 3:  1aa917b097 send-pack: mark failure of atomic push properly
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
3:  a7e8d7c893 ! 4:  2848088852 transport-helper: mark failure for atomic push
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
4:  94b13f5dcd ! 5:  d2f0b50395 transport-helper: new method reject_atomic_push()
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

 send-pack.c                |  32 +---
 t/t5541-http-push-smart.sh |  12 +-
 t/t5543-atomic-push.sh     |  89 +++++++++++
 t/t5548-push-porcelain.sh  | 300 +++++++++++++++++++++++++++++++++++++
 transport-helper.c         |  23 +++
 transport.c                |  24 ++-
 transport.h                |   3 +
 7 files changed, 439 insertions(+), 44 deletions(-)
 create mode 100755 t/t5548-push-porcelain.sh

-- 
2.24.1.15.g448c31058d.agit.4.5

