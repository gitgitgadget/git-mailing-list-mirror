Return-Path: <SRS0=P8cE=5O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5273C43331
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8B62073B
	for <git@archiver.kernel.org>; Sun, 29 Mar 2020 14:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oENvym0q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728250AbgC2Odh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Mar 2020 10:33:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42208 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbgC2Odh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Mar 2020 10:33:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id 22so7266444pfa.9
        for <git@vger.kernel.org>; Sun, 29 Mar 2020 07:33:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q24Ksj7/DjCi6+r+d0a3sLcxotvnPZL+KtnFRr5Uw+I=;
        b=oENvym0quY8gcZL0LB8oCDOwQ30GU+LTyHMgL6D09KxUTQYa1lRTD367pj2XsioCEo
         TF2T32TZNeq4OFwxhxaGyehRckGLLyovQAW4lj64fN8M3pZoAzDUaDyeZfXiedvH4ebg
         eUL/bW0EtW0CMOuXE7xBh81OPTsHyI1sXY1JXyBSE+2M/ZuJY3LX/5s2uejLG3j2yKUq
         Lf2zEwGxuFiccNtEFfbq+h/9dnUc2sVtUEHeZn0MFdMkmGiKNIelMr7YvFTPOR5Emzab
         RzkZHkPN4J1H7jcL83krAbK/z61urpWyDcF0UZl1cq9Pj8xcu6kzidXfhtMXHAaB2IhF
         /J/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q24Ksj7/DjCi6+r+d0a3sLcxotvnPZL+KtnFRr5Uw+I=;
        b=suv5APLmp8bY7QfQwuHuWcCXw++eyFQJdTzaaKM8vlwvbOYNCq1C8Z9NdWXRw3Nfr2
         MUIaAN4UVKiCtdpXBttYVTzulPiLVe81zAM55V2jl95D5iOA7VBUKjCXmzzQibC10GGY
         JL/7r+IDIY3HQydsT2Ap6ua+bXSaMNgqQRppzh23JjI5LM7pn1mLQlE/syTOtI1VXUSG
         scSAgKYkzyzBQUVHEqIum9TEjwTgGeD6pLcMQIOhSpsoZvrMIdD74jXpKnq9qQjROaG1
         52bXamwkVbNOOVvIgbQzWRKRdh1QuTuFMS3+oBq6PFpwp1YGV2YDw4B/RVghK5biA/Qb
         kljw==
X-Gm-Message-State: ANhLgQ3BGrwJGVK0KjefI4+sA4LUQymLdaT1O0RNpGxi91gSUQ1Ew/nj
        BuVqEo5yFKwkT4I/JsI4WpU=
X-Google-Smtp-Source: ADFU+vtLzhLtVwFMMlJhP3W90N0IDglHgYdz1GSMbbyrf5LtudLb+fu3/IOcQPMX91goCqD+mYyKDg==
X-Received: by 2002:a63:1f14:: with SMTP id f20mr8650698pgf.411.1585492415659;
        Sun, 29 Mar 2020 07:33:35 -0700 (PDT)
Received: from tigtog.localdomain.localdomain ([144.34.163.219])
        by smtp.gmail.com with ESMTPSA id u13sm2947246pgp.49.2020.03.29.07.33.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Mar 2020 07:33:34 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v2 0/4] Never report references we not push
Date:   Sun, 29 Mar 2020 10:33:25 -0400
Message-Id: <20200329143329.13846-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.26.0.rc0
In-Reply-To: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
References: <20200325143608.45141-1-zhiyou.jx@alibaba-inc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Hi,

Patches 2/4, 4/3 and 4/4 can be squashed into one commit.

## Changes since v1:

* Add a new common method `reject_atomic_push()`, which is reused for 
  atomic push rejection for SSH and HTTP protocol.

* Other changes see the attached range diff.


## Range diff v1..v2

1:  e1c7aa3501 ! 1:  d84ebf30b5 t5543: never report what we do not push
    @@ t/t5543-atomic-push.sh: test_refs () {
      	test_cmp expect actual
      }
      
    -+format_git_output () {
    -+	awk '/^(To| !) / {print}' | \
    -+	sed \
    -+		-e "s/  *\$//g" \
    -+		-e "s/'/\"/g"
    ++fmt_status_report () {
    ++	sed -n \
    ++		-e "/^To / { s/   */ /g; p; }" \
    ++		-e "/^ ! / { s/   */ /g; p; }"
     +}
     +
      test_expect_success 'atomic push works for a single branch' '
    @@ t/t5543-atomic-push.sh: test_expect_success 'atomic push is not advertised if co
     +	mk_repo_pair &&
     +	(
     +		cd workbench &&
    -+		# Keep constant output.
    -+		git config core.abbrev 7 &&
     +		test_commit one &&
     +		git branch foo &&
     +		git push up master one foo &&
    @@ t/t5543-atomic-push.sh: test_expect_success 'atomic push is not advertised if co
     +
     +		if test "\$1" = "refs/heads/bar"
     +		then
    -+			echo >2 "Pusing to branch bar is prohibited"
    ++			echo >&2 "Pusing to branch bar is prohibited"
     +			exit 1
     +		fi
     +		EOF
    @@ t/t5543-atomic-push.sh: test_expect_success 'atomic push is not advertised if co
     +	) &&
     +	test_must_fail git -C workbench \
     +		push --atomic up master two bar >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	fmt_status_report <out >actual &&
     +	cat >expect <<-EOF &&
     +	To ../upstream
     +	 ! [remote rejected] master -> master (atomic push failure)
    @@ t/t5543-atomic-push.sh: test_expect_success 'atomic push is not advertised if co
     +	) &&
     +	test_must_fail git -C workbench \
     +		push --atomic --mirror up >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	fmt_status_report <out >actual &&
     +	cat >expect <<-EOF &&
     +	To ../upstream
     +	 ! [remote rejected] master -> master (atomic push failure)
    @@ t/t5543-atomic-push.sh: test_expect_success 'atomic push is not advertised if co
     +	) &&
     +	test_must_fail git -C workbench \
     +		push --atomic up master foo bar >out 2>&1 &&
    -+	format_git_output <out >actual &&
    ++	fmt_status_report <out >actual &&
     +	cat >expect <<-EOF &&
     +	To ../upstream
    -+	 ! [rejected]        master -> master (non-fast-forward)
    -+	 ! [rejected]        bar -> bar (atomic push failed)
    ++	 ! [rejected] master -> master (non-fast-forward)
    ++	 ! [rejected] bar -> bar (atomic push failed)
     +	EOF
     +	test_cmp expect actual
     +'
2:  50f1e02a2f ! 2:  a76340633b send-pack: mark failure of atomic push properly
    @@ Metadata
      ## Commit message ##
         send-pack: mark failure of atomic push properly
     
    -    When pusing with SSH or other smart protocol, references are validated
    -    by function `check_to_send_update()` beforce they are sent in commands
    +    When pushing with SSH or other smart protocol, references are validated
    +    by function `check_to_send_update()` before they are sent in commands
         to `send_pack()` of "receve-pack".  For atomic push, if a reference is
         rejected after the validation, only references pushed by user should be
         marked as failure, instead of report failure on all remote references.
    @@ Commit message
         push_refs_with_push, 2019-07-11) wanted to fix report issue of HTTP
         protocol, but marked all remote references failure for atomic push.
     
    -    Revert part of that commit and add additional status for function
    -    `atomic_push_failure()`.  The additional status for it except the
    -    "REF_STATUS_EXPECTING_REPORT" status are:
    +    In order to fix the issue of status report for SSH or other built-in
    +    smart protocol, revert part of that commit and add additional status
    +    for function `atomic_push_failure()`.  The additional status for it
    +    except the "REF_STATUS_EXPECTING_REPORT" status are:
     
         - REF_STATUS_NONE : Not marked as "REF_STATUS_EXPECTING_REPORT" yet.
         - REF_STATUS_OK   : Assume OK for dryrun or status_report is disabled.
     
    -    This commit break test case in t5541, and will fix in other commit.
    +    This fix won't resolve the issue of status report in transport-helper
    +    for HTTP or other protocols, and breaks test case in t5541.  Will fix
    +    it in additional commit.
     
         Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
3:  50bb31ed3a ! 3:  82a8b19430 transport-helper: enforce atomic in push_refs_with_push
    @@ Metadata
     Author: Jiang Xin <zhiyou.jx@alibaba-inc.com>
     
      ## Commit message ##
    -    transport-helper: enforce atomic in push_refs_with_push
    +    transport-helper: mark failure for atomic push
     
         Commit v2.22.0-1-g3bca1e7f9f (transport-helper: enforce atomic in
         push_refs_with_push, 2019-07-11) noticed the incomplete report of
-:  ---------- > 4:  fc8c1af33c transport-helper: new method reject_atomic_push()


Jiang Xin (4):
  t5543: never report what we do not push
  send-pack: mark failure of atomic push properly
  transport-helper: mark failure for atomic push
  transport-helper: new method reject_atomic_push()

 send-pack.c                | 27 ++----------
 t/t5541-http-push-smart.sh | 12 ++++-
 t/t5543-atomic-push.sh     | 89 ++++++++++++++++++++++++++++++++++++++
 transport-helper.c         | 23 ++++++++++
 transport.c                | 14 ------
 transport.h                |  3 ++
 6 files changed, 128 insertions(+), 40 deletions(-)

-- 
2.26.0.4.g39bcdcb101.dirty

