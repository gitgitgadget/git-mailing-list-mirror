Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921371F463
	for <e@80x24.org>; Thu, 19 Sep 2019 21:47:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404861AbfISVra (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Sep 2019 17:47:30 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404752AbfISVr3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Sep 2019 17:47:29 -0400
Received: by mail-wr1-f66.google.com with SMTP id l11so4678791wrx.5
        for <git@vger.kernel.org>; Thu, 19 Sep 2019 14:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0MzvnfBXB8JaOjw6+zEjvICoUYRHnROdi1ECaqsicU=;
        b=Djr5FMakbFFximtPhsTufWEQSSvV/6jKMEBsa1i81RhbeqigvHhjuvCz8ii1dLUhQW
         B0ChoAyhmlrwCd2ZQpVtVTUR4iGZYPzTy+kalHMnzLrdO7fB1d7dhRaPwokPn5rpmgfN
         hMNNae85uJP7SEjK2DC4ZXtuSv1omcpgMHUDwW9vKLbhBLKnd648/U9ITJemugAlgbML
         LUSMYFnDnrKVnjQwK06EAXieadLc18dNMcoFm6Gr3/ad/Z2O93zWMwZ8VrJMrkEneGDo
         3ZQwNm/F2Qvx3IukixCZCcDv2Cs6J0pLW06WQBuvx+FNOWaZ/ynTHSvU+zhOxAwNj7E9
         7XMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0MzvnfBXB8JaOjw6+zEjvICoUYRHnROdi1ECaqsicU=;
        b=POyrH+j0TpUZHpRffOmiMjbXrz6sBIdin0LfO+r+6upaG5ip0abo7OFfPr2GF4touL
         w9ab/KHe/E+VVQ0LTdZl4bcovI4Hc/O0d9n/yUs5g8W2VwrZhVRpYXC/5u62chJN+/fJ
         hR+7luh6gJP1vB0Mh4bzgxEsJrHyfzjIRQL7GODUmIKfFgP167Mn3YQb6iUHI0H5Accv
         Xb3owZoM+yYDcU/0k9dKKfP3lkd2tLVaXnJYL/McjUlq9MuJ2Vez4v6J0B5Hkg53DhOu
         lG2sj+vh4qwfJJrCJpYb8bEQENRF2B4DFadr+8DNxHLG3e8Bb/3kMylziwxMMzZEyRD5
         8yKw==
X-Gm-Message-State: APjAAAXSlZkl4+EYgpOKO1E2YHWHfEXG3pw5ODuPqYY2Bp2PgHiP7Bjv
        K0Ewum1l5khFsT770wSXOMWA/QmB
X-Google-Smtp-Source: APXvYqy6iWbNT8KUHLuIqp6LRxc45x0w1YwbZNsrLSa2SoHqdj9wCwl7+MflYsOQKeTVkqxFkW02+g==
X-Received: by 2002:a5d:6812:: with SMTP id w18mr8434376wru.250.1568929645590;
        Thu, 19 Sep 2019 14:47:25 -0700 (PDT)
Received: from localhost.localdomain (x4db63806.dyn.telefonica.de. [77.182.56.6])
        by smtp.gmail.com with ESMTPSA id b12sm12280wrt.21.2019.09.19.14.47.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 19 Sep 2019 14:47:25 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 06/15] t6120: add a test to cover inner conditions in 'git name-rev's name_rev()
Date:   Thu, 19 Sep 2019 23:47:01 +0200
Message-Id: <20190919214712.7348-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.23.0.331.g4e51dcdf11
In-Reply-To: <20190919214712.7348-1-szeder.dev@gmail.com>
References: <20190919214712.7348-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 'builtin/name-rev.c' in the name_rev() function there is a loop
iterating over all parents of the given commit, and the loop body
looks like this:

  if (parent_number > 1) {
    if (generation > 0)
      // do stuff #1
    else
      // do stuff #2
  } else {
     // do stuff #3
  }

These conditions are not covered properly in the test suite.  As far
as purely test coverage goes, they are all executed several times over
in 't6120-describe.sh'.  However, they don't directly influence the
command's output, because the repository used in that test script
contains several branches and tags pointing somewhere into the middle
of the commit DAG, and thus result in a better name for the
to-be-named commit.  In an early version of this patch series I
managed to mess up those conditions (every single one of them at
once!), but the whole test suite still passed successfully.

So add a new test case that operates on the following history:

    -----------master
   /          /
  A----------M2
   \        /
    \---M1-C
     \ /
      B

and names the commit 'B', where:

  - The merge commit at master makes sure that the 'do stuff #3'
    affects the final name.

  - The merge commit M2 make sure that the 'do stuff #1' part
    affects the final name.

  - And M1 makes sure that the 'do stuff #2' part affects the final
    name.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/t6120-describe.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 07e6793e84..2a0f2204c4 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -421,4 +421,47 @@ test_expect_success 'describe complains about missing object' '
 	test_must_fail git describe $ZERO_OID
 '
 
+#   -----------master
+#  /          /
+# A----------M2
+#  \        /
+#   \---M1-C
+#    \ /
+#     B
+test_expect_success 'test' '
+	git init repo &&
+	(
+		cd repo &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		A=$(git rev-parse HEAD) &&
+
+		git checkout --detach &&
+		echo B >file &&
+		git commit -m B file &&
+		B=$(git rev-parse HEAD) &&
+
+		git checkout $A &&
+		git merge --no-ff $B &&  # M1
+
+		echo C >file &&
+		git commit -m C file &&
+
+		git checkout $A &&
+		git merge --no-ff HEAD@{1} && # M2
+
+		git checkout master &&
+		git merge --no-ff HEAD@{1} &&
+
+		git log --graph --oneline &&
+
+		echo "$B master^2^2~1^2" >expect &&
+		git name-rev $B >actual &&
+
+		test_cmp expect actual
+	)
+'
+
 test_done
-- 
2.23.0.331.g4e51dcdf11

