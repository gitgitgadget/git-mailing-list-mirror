Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 733891F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 18:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728096AbfKMSzv (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 13:55:51 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40608 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbfKMSzt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 13:55:49 -0500
Received: by mail-lj1-f195.google.com with SMTP id q2so3783948ljg.7
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 10:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g9Z4iMJWW6/KaTN7qELoQ4mcTWBr9HV8TZqKdgyaGmo=;
        b=gUGBxnIqCxiovw8YYqlGkIljtHjsV4G4h/vr95gst0knZ8A7MJav6Ls7aAH6SR0YjP
         c6WrIY8sz07P/iQ6ntF7A1AD5c8zrzn4Ig39UMrZEkqNlrdqf/FIjXxj9lTcO+g5eZuU
         oXG6y5BvsuyjnVqOWAAdMDQv21sJx1F7TcHASN4vB4L26isK4L9owmnW1MTrvKVPocyT
         joSzj0BqYq82FQicY0a3ztYAZ8ieOqaGUcqrubz80C57HOjbPzQd5JZJC0QZD4TVmB+s
         33BZfOXlGw2jzFq4HPqwXgkD3lRmvqRMqcNDjgVsbYH+n7qNw0z0GheJVq+gNKWd/cb4
         I3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g9Z4iMJWW6/KaTN7qELoQ4mcTWBr9HV8TZqKdgyaGmo=;
        b=V8lzBtkVroA/urJ8OHZwNn6mg5RAbojVHJ7Ua1m5wqVAzB/2JFBnYjzlplQE/HMmFE
         eujcj9Nvh18agVyJcsabZALoB0/HQdcefqSC1hFIeVGuhYMUcBVDRxY/vziOlsRnyxj4
         9bYk9ug6txie2FXOLhGNIcErzQD+sZzig3fIy1Vh3UESddWbOsaRO3a4ylTm5Rl3r5q6
         CkD4VJoSZ8fCuCbmYs2a48PsB8Rs1ZOO3ek4oqesVukEOLdmuxG6c7QtlfUCU4K9mjEM
         F8b8Xio0x7+sKuJtMURo+gKXtxkKKzkHJstbFitsL5feqpH5c0xJvCJJEYK1lmQrpfTe
         qShA==
X-Gm-Message-State: APjAAAXXB1YlW9wmSPGZk+JXx0zlLHxhQn62IXi+8qU27wwLe1+koDxt
        GgTmB2E3fRn5uJCSqDQ9cTSLWsZw
X-Google-Smtp-Source: APXvYqwQds2K8xBeCjVe4S9+76aXTBNOUzXpPTROrZk9Rocg+sWhfG5CjzILugguR+Qnkfm6AYAlUA==
X-Received: by 2002:a2e:b5d0:: with SMTP id g16mr3782918ljn.88.1573671347148;
        Wed, 13 Nov 2019 10:55:47 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id c24sm1422765lfm.20.2019.11.13.10.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2019 10:55:46 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 6/8] builtin/config: canonicalize "value_regex" with `--type=bool-or-int`
Date:   Wed, 13 Nov 2019 19:55:05 +0100
Message-Id: <5d6bf76f2e9bccf38f566524f6133252be0603c9.1573670565.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1573670565.git.martin.agren@gmail.com>
References: <cover.1573670565.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As an obvious follow-up to the previous commit, also canonicalize the
"value_regex" when the type is "bool-or-int".

Observe that in this case, falling back to handling the "value_regex" as
a normal regex is not just to cater to old scripts and habits. It is
necessary to handle the numerical inputs (or regexes matching some
specific numerical values!) that we must expect.

Future commits will expand on the code for `--type=bool`. Rather than
trying to shoehorn both these cases into a single chunk of code, let's
just duplicate some of the code from the previous commit.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-config.txt |  2 +-
 builtin/config.c             |  9 +++++++++
 t/t1300-config.sh            | 20 ++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 139750bbda..864375b1ec 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -43,7 +43,7 @@ outgoing values are canonicalize-able under the given <type>.  If no
 `--type=<type>` is given, no canonicalization will be performed. Callers may
 unset an existing `--type` specifier with `--no-type`.
 
-With `--type=bool`, if `value_regex` is given
+With `--type=bool` or `--type=bool-or-int`, if `value_regex` is given
 and canonicalizes to a boolean value, it matches all entries
 that canonicalize to the same boolean value.
 
diff --git a/builtin/config.c b/builtin/config.c
index c9fe0c5752..4e274d4867 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -305,6 +305,15 @@ static int handle_value_regex(const char *regex_)
 		}
 	}
 
+	if (type == TYPE_BOOL_OR_INT) {
+		int boolval = git_parse_maybe_bool_text(regex_);
+		if (boolval >= 0) {
+			cmd_line_value.mode = boolean;
+			cmd_line_value.boolean = boolval;
+			return 0;
+		}
+	}
+
 	cmd_line_value.mode = regexp;
 
 	if (regex_[0] == '!') {
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index e4906a893e..f0e9a21dc4 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -472,6 +472,26 @@ test_expect_success '--type=bool with "non-bool" value_regex' '
 	test_must_be_empty output
 '
 
+test_expect_success '--type=bool-or-int with boolean value_regex' '
+	echo true >expect &&
+	git config --type=bool-or-int --get foo.y2 true >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--type=bool-or-int with integer value_regex' '
+	test_must_fail git config --type=bool-or-int --get foo.y2 1 >output &&
+	test_must_be_empty output &&
+	echo 1 >expect &&
+	git config --type=bool-or-int --get foo.y5 1 >output &&
+	test_cmp expect output
+'
+
+test_expect_success '--type=bool-or-int with regex value_regex' '
+	echo true >expect &&
+	git config --type=bool-or-int --get foo.y4 "t.*" >output &&
+	test_cmp expect output
+'
+
 test_expect_success 'setup simple config file' '
 	q_to_tab >.git/config <<-\EOF
 	[a.b]
-- 
2.24.0

