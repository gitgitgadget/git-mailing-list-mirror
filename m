Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CF4CC43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE26120772
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZw+Edtb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgCZI2Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:28:16 -0400
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34307 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727611AbgCZI2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:28:16 -0400
Received: by mail-qv1-f68.google.com with SMTP id o18so2502716qvf.1
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 01:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VWQhrr8PYYm6k+sW4mhXLSagK9LE6Wy/X1u6tMEvEes=;
        b=iZw+Edtb41fVigiO+bNMf42Xg112M/n1E5HaWzZH8r1LP2yhDIYSjy2hXrERpzf5GP
         vjfkcnxp+Le3c5tFDLWq4OoO4uhCWjfncGn74RJJF3rgHeRaxDOD4owezqGlxDBK6pSz
         XKEhdSm0g/cMytsJlGLSX8W/M34gLiVNu0kTsCL++mvfXeqoU3eslEjQVSojnpwKSx7w
         wtOiDiQ8T08q0cyLkPMfeJqK/jB8NmF85RWAtO23ArFiHb8Ldbo6UJtcvdO2+juGeH4D
         9ev4tB7O7MmiDpkevV3wq9VWCMa++rOGLOQXrzKlBaNlXHCMxQVTewOekmWpuvrDmvw1
         RPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VWQhrr8PYYm6k+sW4mhXLSagK9LE6Wy/X1u6tMEvEes=;
        b=KNw/XB6LLLzO05XLxK9UBbWGVVCzVW+CEtNk6JUD2OfrARPu2kzvXYd1jB6LpGjshP
         eJ9EPHk4tP3z+dXHmTSzQ0q54sPyWrzqOJvIWJmqOJzDZJ012/l3WpEv/ZKbJJUWQiPW
         C3Y7HEx8rcaaPk+UOsmXTg5VDZGPXAFqx1NeUMQTyXrpg1x37neIoRXofD/zBGbee0HO
         21IFSwT6wzTOTlkMas/lqgPgtAUSIQ7mpAJ4qqlUgPDR7oNKnol2x/RK0gut3ZOt4Hep
         Tl4WSeAKw/5CP6bwDU/Z6+eV23mn5u20tVT7ljbt3uKWGTJrFFZEDDji8IAGSxOw8XWa
         SjjA==
X-Gm-Message-State: ANhLgQ1JFGZGqpwcSpFKIEXwTTnF5z5uv9Qx75jl+pn2RkbKSylIkqmQ
        dLs6IfyHTweJVrnlNiH71FVU7s48
X-Google-Smtp-Source: ADFU+vsWyy66LsQHODrW8hSYjFu81l3YAsNZLTbFC4cjTUgfREESobyv3YqGx166M0LxSfAe5Pu3KA==
X-Received: by 2002:a05:6214:205:: with SMTP id i5mr6922960qvt.223.1585211294920;
        Thu, 26 Mar 2020 01:28:14 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id g187sm935789qkf.115.2020.03.26.01.28.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 01:28:14 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH v2 0/8] t: replace incorrect test_must_fail usage (part 3)
Date:   Thu, 26 Mar 2020 04:27:47 -0400
Message-Id: <cover.1585209554.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.26.0.159.g23e2136ad0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The overall scope of these patches is to replace inappropriate uses of
test_must_fail. IOW, we should only allow test_must_fail to run on `git`
and `test-tool`. Ultimately, we will conclude by making test_must_fail
error out on non-git commands. An advance view of the final series can
be found here[1].

This is the third part. It focuses on t5*.sh.

The first part can be found here[2]. The second part can be found here[3].

Changes since v1:

* Broke up long generate_references() lines for clarity in 2/8

* For-loop &&-chain and renamed variable to "ref" in 2/8

* Cleaned up commit message in 2/8

* Rewrote 4/8 with a simpler test case

[1]: (may be rebased at any time) https://github.com/Denton-L/git/tree/ready/cleanup-test-must-fail2
[2]: https://lore.kernel.org/git/cover.1576583819.git.liu.denton@gmail.com/
[3]: https://lore.kernel.org/git/cover.1577454401.git.liu.denton@gmail.com/

Denton Liu (8):
  t5512: don't use `test_must_fail test_cmp`
  t5512: stop losing git exit code in here-docs
  t5512: stop losing return codes of git commands
  t5550: simplify no matching line check
  t5607: reorder `nongit test_must_fail`
  t5612: don't use `test_must_fail test_cmp`
  t5612: stop losing return codes of git commands
  t5801: teach compare_refs() to accept !

 t/t5512-ls-remote.sh       | 80 ++++++++++++++++++++------------------
 t/t5550-http-fetch-dumb.sh |  4 +-
 t/t5607-clone-bundle.sh    |  2 +-
 t/t5612-clone-refspec.sh   | 26 ++++++-------
 t/t5801-remote-helpers.sh  | 10 ++++-
 5 files changed, 66 insertions(+), 56 deletions(-)

Range-diff against v1:
1:  3d7dc8428d = 1:  3d7dc8428d t5512: don't use `test_must_fail test_cmp`
2:  674de50db2 ! 2:  97bc46e4a9 t5512: generate references with generate_references()
    @@ Metadata
     Author: Denton Liu <liu.denton@gmail.com>
     
      ## Commit message ##
    -    t5512: generate references with generate_references()
    +    t5512: stop losing git exit code in here-docs
     
         The expected references are generated using a here-doc with some inline
    -    subshells. If one of the `git rev-parse` invocations within the
    -    subshells failed, its return code is swallowed and we won't know about
    -    it. Replace these here-docs with generate_references(), which actually
    -    reports when `git rev-parse` fails.
    +    command substitutions. If one of the `git rev-parse` invocations within
    +    the command substitutions fails, its return code is swallowed and we
    +    won't know about it. Replace these command substitutions with
    +    generate_references(), which actually reports when `git rev-parse`
    +    fails.
     
      ## t/t5512-ls-remote.sh ##
     @@ t/t5512-ls-remote.sh: test_description='git ls-remote'
    @@ t/t5512-ls-remote.sh: test_description='git ls-remote'
      . ./test-lib.sh
      
     +generate_references () {
    -+	for i
    ++	for ref
     +	do
    -+		oid=$(git rev-parse "$i") || return 1
    -+		printf '%s\t%s\n' "$oid" "$i"
    ++		oid=$(git rev-parse "$ref") &&
    ++		printf '%s\t%s\n' "$oid" "$ref" || return 1
     +	done
     +}
     +
    @@ t/t5512-ls-remote.sh: test_expect_success 'ls-remote self' '
     -	$(git rev-parse mark1.2)	refs/tags/mark1.2
     -	$(git rev-parse mark1.10)	refs/tags/mark1.10
     -	EOF
    -+	generate_references refs/tags/mark refs/tags/mark1.1 refs/tags/mark1.2 refs/tags/mark1.10 >expect &&
    ++	generate_references \
    ++		refs/tags/mark \
    ++		refs/tags/mark1.1 \
    ++		refs/tags/mark1.2 \
    ++		refs/tags/mark1.10 >expect &&
      	git ls-remote --sort="version:refname" --tags self >actual &&
      	test_cmp expect actual
      '
    @@ t/t5512-ls-remote.sh: test_expect_success 'ls-remote self' '
     -	$(git rev-parse mark1.1)	refs/tags/mark1.1
     -	$(git rev-parse mark)	refs/tags/mark
     -	EOF
    -+	generate_references refs/tags/mark1.10 refs/tags/mark1.2 refs/tags/mark1.1 refs/tags/mark >expect &&
    ++	generate_references \
    ++		refs/tags/mark1.10 \
    ++		refs/tags/mark1.2 \
    ++		refs/tags/mark1.1 \
    ++		refs/tags/mark >expect &&
      	git ls-remote --sort="-version:refname" --tags self >actual &&
      	test_cmp expect actual
      '
    @@ t/t5512-ls-remote.sh: test_expect_success 'ls-remote self' '
     -	$(git rev-parse mark1.1)	refs/tags/mark1.1
     -	$(git rev-parse mark)	refs/tags/mark
     -	EOF
    -+	generate_references refs/tags/mark1.2 refs/tags/mark1.10 refs/tags/mark1.1 refs/tags/mark >expect &&
    ++	generate_references \
    ++		refs/tags/mark1.2 \
    ++		refs/tags/mark1.10 \
    ++		refs/tags/mark1.1 \
    ++		refs/tags/mark >expect &&
      	git ls-remote --sort="-refname" --tags self >actual &&
      	test_cmp expect actual
      '
    @@ t/t5512-ls-remote.sh: test_expect_success 'protocol v2 supports hiderefs' '
     -	$(git rev-parse refs/tags/mark1.2)	refs/tags/mark1.2
     -	EOF
     +	echo "ref: refs/heads/master	HEAD" >expect &&
    -+	generate_references HEAD \
    ++	generate_references \
    ++		HEAD \
     +		refs/heads/master >>expect &&
     +	oid=$(git rev-parse HEAD) &&
     +	echo "$oid	refs/remotes/origin/HEAD" >>expect &&
    -+	generate_references refs/remotes/origin/master \
    ++	generate_references \
    ++	refs/remotes/origin/master \
     +		refs/tags/mark \
     +		refs/tags/mark1.1 \
     +		refs/tags/mark1.10 \
3:  b3addeb985 = 3:  986ba1dd39 t5512: stop losing return codes of git commands
4:  68c911e29b < -:  ---------- t5550: remove use of `test_might_fail grep`
-:  ---------- > 4:  53e64e7077 t5550: simplify no matching line check
5:  4253f51fea = 5:  4955b701e1 t5607: reorder `nongit test_must_fail`
6:  2bac5f4a29 = 6:  a3d9d3673b t5612: don't use `test_must_fail test_cmp`
7:  b490ccace0 = 7:  bc0e90d5ba t5612: stop losing return codes of git commands
8:  b51f97f6ae = 8:  6a9d3cef2a t5801: teach compare_refs() to accept !
-- 
2.26.0.159.g23e2136ad0

