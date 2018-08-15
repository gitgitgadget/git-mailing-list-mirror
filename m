Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14ADD1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:46:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeHOVjj (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:39:39 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34683 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeHOVji (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:39:38 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so1828976ioj.1
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGzYUl5evWKnM46sukqrmX2CstR2sl8gW11TCTHHiLU=;
        b=YCRk8lG72oMOXW+KBfzWjEY/k1ZbKtruoJsGbD+njAJOMXfT7zl3k9TQHkvdpcDsNC
         vGfx53uKtRVzDpqoylySG9LhS/ifY8w/t5oYpZUehEbRETH2gbIXDJlz1qve0uaQeLWW
         EXdCb3WcvS2Hh4oW0CXmsdHdpxeZEgnbKzlGnEOjY19ED2tGrdE+661u2WcIJf6Et4j4
         JiT5EbxnY7zBJ1jbsIAKV7OwzYGNRUp7G6PimicjCpfx6NGtL8YS3MBpSxAd9omVI1vn
         qa3UWZQ5oUuxdKfiwTwDYQY1SB03OUTUNFd9w1HkwG1DslZXVWC1S4hd0DycfW3yl0TN
         v8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NGzYUl5evWKnM46sukqrmX2CstR2sl8gW11TCTHHiLU=;
        b=eHz//Yl2B8hdmzlHrqv7NUJBJt0nO7MltyQcvJSGuicBdjgB+PK4DyHgdLBKpz6F6S
         UWK7TBE1CHaHdGCflefFyAE4zr84mbnjaNOCjejnSS54wL7JfPgbHcC3OJMFZE+ZQdSV
         C/lumUhnipnVz7gMvK5O4Cq2nv433VUVeVZYEpkfU5OIKi+SMJbfs5KZDpzs2zjmzlD8
         0O5ULAkP+yoMTR1a2zz2GLgsVjhrQBmVlNUoqv/bd/S9eDyaqQVBYYvkKD77phAUQqDG
         5TTaH00fMFFzAdJttvGZHJLyzRf074XlO7VY7yeGZDtCW5Nng+thHG+GN0uuPqqR4rJZ
         y6zQ==
X-Gm-Message-State: AOUpUlFgD+kC/GXgeOkliFm74Dc5KBtPe5lEhQfwkUeyen4Gk/nPD+oc
        cnPYq21Dkhj2Bq5TPquow7nnDtYr
X-Google-Smtp-Source: AA+uWPzoIPNfKSyvCs7jSQlrDaAwOG6INQR2dWSm5evBLP1Ir+gJwQzAWprte9lQQXRLwq2ighMYSw==
X-Received: by 2002:a6b:c997:: with SMTP id z145-v6mr23946904iof.266.1534358779614;
        Wed, 15 Aug 2018 11:46:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r14-v6sm6533993ioj.86.2018.08.15.11.46.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 11:46:19 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 6/6] chainlint: add test of pathological case which triggered false positive
Date:   Wed, 15 Aug 2018 14:45:52 -0400
Message-Id: <20180815184552.8418-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180815184552.8418-1-sunshine@sunshineco.com>
References: <20180813084739.16134-1-sunshine@sunshineco.com>
 <20180815184552.8418-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This extract from contrib/subtree/t7900 triggered a false positive due
to three chainlint limitations:

* recognizing only a "blessed" set of here-doc tag names in a subshell
  ("EOF", "EOT", "INPUT_END"), of which "TXT" is not a member

* inability to recognize multi-line $(...) when the first statement of
  the body is cuddled with the opening "$("

* inability to recognize multiple constructs on a single line, such as
  opening a multi-line $(...) and starting a here-doc

Now that all of these shortcomings have been addressed, turn this rather
pathological bit of shell coding into a chainlint test case.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/t7900-subtree.expect | 10 ++++++++++
 t/chainlint/t7900-subtree.test   | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 t/chainlint/t7900-subtree.expect
 create mode 100644 t/chainlint/t7900-subtree.test

diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.expect
new file mode 100644
index 0000000000..c9913429e6
--- /dev/null
+++ b/t/chainlint/t7900-subtree.expect
@@ -0,0 +1,10 @@
+(
+	chks="sub1sub2sub3sub4" &&
+	chks_sub=$(cat | sed 's,^,sub dir/,'
+>>) &&
+	chkms="main-sub1main-sub2main-sub3main-sub4" &&
+	chkms_sub=$(cat | sed 's,^,sub dir/,'
+>>) &&
+	subfiles=$(git ls-files) &&
+	check_equal "$subfiles" "$chkms$chks"
+>)
diff --git a/t/chainlint/t7900-subtree.test b/t/chainlint/t7900-subtree.test
new file mode 100644
index 0000000000..277d8358df
--- /dev/null
+++ b/t/chainlint/t7900-subtree.test
@@ -0,0 +1,22 @@
+(
+	chks="sub1
+sub2
+sub3
+sub4" &&
+	chks_sub=$(cat <<TXT | sed 's,^,sub dir/,'
+$chks
+TXT
+) &&
+	chkms="main-sub1
+main-sub2
+main-sub3
+main-sub4" &&
+	chkms_sub=$(cat <<TXT | sed 's,^,sub dir/,'
+$chkms
+TXT
+) &&
+
+	subfiles=$(git ls-files) &&
+	check_equal "$subfiles" "$chkms
+$chks"
+)
-- 
2.18.0.267.gbc8be36ecb

