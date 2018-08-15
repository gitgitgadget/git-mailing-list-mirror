Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 595CD1F404
	for <e@80x24.org>; Wed, 15 Aug 2018 18:46:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbeHOVjh (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 17:39:37 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:34967 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeHOVjh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 17:39:37 -0400
Received: by mail-it0-f65.google.com with SMTP id 139-v6so3294676itf.0
        for <git@vger.kernel.org>; Wed, 15 Aug 2018 11:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C6TwnP3skJmhsh/XTqDLzyfn/BI+ffKoaD5WfxoRuzc=;
        b=Fg/5AnlDhBdTlKNkqt9O7oOzqpnSV+jmZXaE9mFx4gxzwgYWAS0hWuWe11IaQiZnLi
         kuuq8GsDBl8uaVL86+NPiEDeqKgEGIhIfPpzviIhKaMXyno87oqLGIhMc/7rfa3YeweY
         3IqY8J3OZukCMqzwVPnrPpvEEonyFZ+GoUziCxSiEMVbmU5u56gmER34nPy/9H05fERo
         gQf2zGvtGZL9mjpiUgxQ7fAY5Js4kIMLsSI5+1SzfCY8n/nX8cAZH1fnEkmC3wyuI3ui
         MBJ4pMRqSL/gKG2BHIOV2FSdL60PsNbbEU1Odzay4iT242oUFNO+xXi77tFoAKShZUNk
         IFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=C6TwnP3skJmhsh/XTqDLzyfn/BI+ffKoaD5WfxoRuzc=;
        b=VJl+hsQFuWc4qA3JQdmXWhkl7F0XgTkwy+PIJ4K1YF0ywR7OGUlS/yd7bxeqX9LORx
         z1ft+egz74d7nA73vyiXVcSzLslkeKTytthJdkLRJnLIg/szcr+9JMT03ZvYzHEu6QGn
         N787GifzeiXoQC81PWHcLW3IwYCI1XpLr5GGFxJPcuWJvjZ24ewxrfJq5KXkbOEEpj2u
         fmbVr8esTJF8RICJCeUEDb6goCD3IqRSD4AHF1e3uzvJEu6cVOXNg1GqIPCehMOJDyjp
         hbpcpE+MdUkr2Ipuyf3QfvpyO/kgd5hUksjjXDqnbuYbupaJUYlwpZ1vrhtlOOai4z1H
         mgtw==
X-Gm-Message-State: AOUpUlHTlVZNcQpfOCyXNTO/OJUb3+M1nssjpkZ5XTxbC0zaDFf8Aazr
        Db+3C261s3+vLtmAcV+CPp8Xq23n
X-Google-Smtp-Source: AA+uWPwycwtl3ihAaDHijLZhPynnj4jY+zVrTrlr/2YGYqEMx4ppie4haQz+7PFYP1HjnvdKiq4vWQ==
X-Received: by 2002:a02:8d43:: with SMTP id o3-v6mr23627092jal.133.1534358777869;
        Wed, 15 Aug 2018 11:46:17 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id r14-v6sm6533993ioj.86.2018.08.15.11.46.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 15 Aug 2018 11:46:17 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 4/6] chainlint: let here-doc and multi-line string commence on same line
Date:   Wed, 15 Aug 2018 14:45:50 -0400
Message-Id: <20180815184552.8418-5-sunshine@sunshineco.com>
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

After swallowing a here-doc, chainlint.sed assumes that no other
processing needs to be done on the line aside from checking for &&-chain
breakage; likewise, after folding a multi-line quoted string. However,
it's conceivable (even if unlikely in practice) that both a here-doc and
a multi-line quoted string might commence on the same line:

    cat <<\EOF && echo "foo
    bar"
    data
    EOF

Support this case by sending the line (after swallowing and folding)
through the normal processing sequence rather than jumping directly to
the check for broken &&-chain.

This change also allows other somewhat pathological cases to be handled,
such as closing a subshell on the same line starting a here-doc:

    (
        cat <<-\INPUT)
        data
        INPUT

or, for instance, opening a multi-line $(...) expression on the same
line starting a here-doc:

    x=$(cat <<-\END &&
        data
        END
        echo "x")

among others.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint.sed                                      | 7 ++++---
 t/chainlint/here-doc-close-subshell.expect           | 2 ++
 t/chainlint/here-doc-close-subshell.test             | 5 +++++
 t/chainlint/here-doc-multi-line-command-subst.expect | 5 +++++
 t/chainlint/here-doc-multi-line-command-subst.test   | 9 +++++++++
 t/chainlint/here-doc-multi-line-string.expect        | 4 ++++
 t/chainlint/here-doc-multi-line-string.test          | 8 ++++++++
 7 files changed, 37 insertions(+), 3 deletions(-)
 create mode 100644 t/chainlint/here-doc-close-subshell.expect
 create mode 100644 t/chainlint/here-doc-close-subshell.test
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.expect
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.test
 create mode 100644 t/chainlint/here-doc-multi-line-string.expect
 create mode 100644 t/chainlint/here-doc-multi-line-string.test

diff --git a/t/chainlint.sed b/t/chainlint.sed
index a21c4b4d71..41cb6ef865 100644
--- a/t/chainlint.sed
+++ b/t/chainlint.sed
@@ -157,6 +157,7 @@ s/.*\n//
 /^[^']*'[^']*$/{
 	/"[^'"]*'[^'"]*"/!bsqstring
 }
+:folded
 # here-doc -- swallow it
 /<<[ 	]*[-\\'"]*[A-Za-z0-9_]/bheredoc
 # comment or empty line -- discard since final non-comment, non-empty line
@@ -255,7 +256,7 @@ s/"//g
 N
 s/\n//
 /"/!bdqstring
-bcheckchain
+bfolded
 
 # found multi-line single-quoted string '...\n...' -- slurp until end of string
 :sqstring
@@ -263,7 +264,7 @@ s/'//g
 N
 s/\n//
 /'/!bsqstring
-bcheckchain
+bfolded
 
 # found here-doc -- swallow it to avoid false hits within its body (but keep
 # the command to which it was attached)
@@ -278,7 +279,7 @@ N
 }
 s/^<[^>]*>//
 s/\n.*$//
-bcheckchain
+bfolded
 
 # found "case ... in" -- pass through untouched
 :case
diff --git a/t/chainlint/here-doc-close-subshell.expect b/t/chainlint/here-doc-close-subshell.expect
new file mode 100644
index 0000000000..f011e335e5
--- /dev/null
+++ b/t/chainlint/here-doc-close-subshell.expect
@@ -0,0 +1,2 @@
+(
+>	cat)
diff --git a/t/chainlint/here-doc-close-subshell.test b/t/chainlint/here-doc-close-subshell.test
new file mode 100644
index 0000000000..b857ff5467
--- /dev/null
+++ b/t/chainlint/here-doc-close-subshell.test
@@ -0,0 +1,5 @@
+(
+# LINT: line contains here-doc and closes nested subshell
+	cat <<-\INPUT)
+	fizz
+	INPUT
diff --git a/t/chainlint/here-doc-multi-line-command-subst.expect b/t/chainlint/here-doc-multi-line-command-subst.expect
new file mode 100644
index 0000000000..e5fb752d2f
--- /dev/null
+++ b/t/chainlint/here-doc-multi-line-command-subst.expect
@@ -0,0 +1,5 @@
+(
+	x=$(bobble &&
+?!AMP?!>>		wiffle)
+	echo $x
+>)
diff --git a/t/chainlint/here-doc-multi-line-command-subst.test b/t/chainlint/here-doc-multi-line-command-subst.test
new file mode 100644
index 0000000000..899bc5de8b
--- /dev/null
+++ b/t/chainlint/here-doc-multi-line-command-subst.test
@@ -0,0 +1,9 @@
+(
+# LINT: line contains here-doc and opens multi-line $(...)
+	x=$(bobble <<-\END &&
+		fossil
+		vegetable
+		END
+		wiffle)
+	echo $x
+)
diff --git a/t/chainlint/here-doc-multi-line-string.expect b/t/chainlint/here-doc-multi-line-string.expect
new file mode 100644
index 0000000000..1e5b724b9d
--- /dev/null
+++ b/t/chainlint/here-doc-multi-line-string.expect
@@ -0,0 +1,4 @@
+(
+?!AMP?!	cat && echo multi-line	string"
+	bap
+>)
diff --git a/t/chainlint/here-doc-multi-line-string.test b/t/chainlint/here-doc-multi-line-string.test
new file mode 100644
index 0000000000..a53edbcc8d
--- /dev/null
+++ b/t/chainlint/here-doc-multi-line-string.test
@@ -0,0 +1,8 @@
+(
+# LINT: line contains here-doc and opens multi-line string
+	cat <<-\TXT && echo "multi-line
+	string"
+	fizzle
+	TXT
+	bap
+)
-- 
2.18.0.267.gbc8be36ecb

