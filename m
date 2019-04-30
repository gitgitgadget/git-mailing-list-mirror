Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EA5B1F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:25:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbfD3SZf (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:25:35 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44914 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbfD3SZd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:25:33 -0400
Received: by mail-pl1-f194.google.com with SMTP id l2so4354261plt.11
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTyPCKFG8MqkVf/vx95OJkgVWPSF2hKNEmPUE3uRsE8=;
        b=lW/ZQ7C1DSlOCykr+BIUTg0hhXYPiIXMKqQobc0qvy5ogr1jX7I9Ntaww0AKBI0Uji
         m4z/ku3L17n/Xsgds/9gdICG4R/4NiOQ1Cr1SQfsFudPC6NLR6YEdZfp+ACDDfSzIUi4
         HaDYZVEjrF+LcvIk0AZ2FNR4rGuG4xbkd0KS/ELa4zzVoVMymp/qa2UHqToB2wdN16GH
         y3ah6mmFVUnmGH26lRYHKkt5QUj4reEPWjGJ0yri1GI321IGoFDr6PdBV8Mi8Wcxlwsp
         UhO6mE2IHABVj33jFd8lDvV5teasKWMU5AA1/yGQ5Rz7SL7r7A1csOF7r8IrfLv8D2y5
         BaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTyPCKFG8MqkVf/vx95OJkgVWPSF2hKNEmPUE3uRsE8=;
        b=TquA503Zi72w8EKcTXYBahLtJL2TPMv6ObwwMpgoo9IKnfZip48Y1fMtAcRcg10VK4
         zYPGH7NUiQH/fnAenRteIMoqS7/ESo+R0ouqR+fR397qaEZ+qnrD7z376AElngC7//tn
         QhMTHWB7VhI77I0T4QYZQQUzOjWNWYWV1h0TcXCdZOI/3ha2+GkxoLJlwSJMRucDQV8p
         XBCZgh4hj3EDKdiLtqNGHpFHphKf1eroMHLw6mQQb4JRA0Qg2EK9plMtn5BjWB1YKeIA
         +/kH0GJWeo0QxthL0mqAKYSXkMML6wF/JGo4nBx1HBiRyb+Z3Cc20NLCyNlSIoJYyp40
         kPIA==
X-Gm-Message-State: APjAAAWZWpnR8mw9MJcY29ZhJIn2ZSSSaG/7UoQsrIcfIXBuLqgruCn4
        4PUMRCO98et1ugYDYpZqQX8=
X-Google-Smtp-Source: APXvYqxFyYkHe61vckgkHVEXdO7tNnRXQ3+6gkBa1tC99XvEDwxjE4LlG/M8zZUkDV37Qd0gD+IdXw==
X-Received: by 2002:a17:902:4101:: with SMTP id e1mr73303003pld.25.1556648732621;
        Tue, 30 Apr 2019 11:25:32 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id p2sm111217508pfi.73.2019.04.30.11.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 11:25:31 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 2/5] fast-import: support 'encoding' commit header
Date:   Tue, 30 Apr 2019 11:25:20 -0700
Message-Id: <20190430182523.3339-3-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g44aacb1a0b
In-Reply-To: <20190430182523.3339-1-newren@gmail.com>
References: <20190430182523.3339-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since git supports commit messages with an encoding other than utf-8,
allow fast-import to import such commits.  This may be useful for folks
who do not want to reencode commit messages from an external system, and
may also be useful to achieve reversible history rewrites (e.g. sha1sum
<-> sha256sum transitions or subtree work) with git repositories that
have used specialized encodings in their commit history.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-fast-import.txt |  7 +++++++
 fast-import.c                     | 11 +++++++++--
 t/t9300-fast-import.sh            | 20 ++++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index d65cdb3d08..7baf9e47b5 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -388,6 +388,7 @@ change to the project.
 	original-oid?
 	('author' (SP <name>)? SP LT <email> GT SP <when> LF)?
 	'committer' (SP <name>)? SP LT <email> GT SP <when> LF
+	('encoding' SP <encoding>)?
 	data
 	('from' SP <commit-ish> LF)?
 	('merge' SP <commit-ish> LF)?
@@ -455,6 +456,12 @@ that was selected by the --date-format=<fmt> command-line option.
 See ``Date Formats'' above for the set of supported formats, and
 their syntax.
 
+`encoding`
+^^^^^^^^^^
+The optional `encoding` command indicates the encoding of the commit
+message.  Most commits are UTF-8 and the encoding is omitted, but this
+allows importing commit messages into git without first reencoding them.
+
 `from`
 ^^^^^^
 The `from` command is used to specify the commit to initialize
diff --git a/fast-import.c b/fast-import.c
index f38d04fa58..76a7bd3699 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2585,6 +2585,7 @@ static void parse_new_commit(const char *arg)
 	struct branch *b;
 	char *author = NULL;
 	char *committer = NULL;
+	const char *encoding = NULL;
 	struct hash_list *merge_list = NULL;
 	unsigned int merge_count;
 	unsigned char prev_fanout, new_fanout;
@@ -2607,6 +2608,8 @@ static void parse_new_commit(const char *arg)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
+	if (skip_prefix(command_buf.buf, "encoding ", &encoding))
+		read_next_command();
 	parse_data(&msg, 0, NULL);
 	read_next_command();
 	parse_from(b);
@@ -2670,9 +2673,13 @@ static void parse_new_commit(const char *arg)
 	}
 	strbuf_addf(&new_data,
 		"author %s\n"
-		"committer %s\n"
-		"\n",
+		"committer %s\n",
 		author ? author : committer, committer);
+	if (encoding)
+		strbuf_addf(&new_data,
+			"encoding %s\n",
+			encoding);
+	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
 	free(author);
 	free(committer);
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 3668263c40..141b7fa35e 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3299,4 +3299,24 @@ test_expect_success !MINGW 'W: get-mark & empty orphan commit with erroneous thi
 	sed -e s/LFs/LLL/ W-input | tr L "\n" | test_must_fail git fast-import
 '
 
+###
+### series X (other new features)
+###
+
+test_expect_success 'X: handling encoding' '
+	test_tick &&
+	cat >input <<-INPUT_END &&
+	commit refs/heads/encoding
+	committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	encoding iso-8859-7
+	data <<COMMIT
+	INPUT_END
+
+	printf "Pi: \360\nCOMMIT\n" >>input &&
+
+	git fast-import <input &&
+	git cat-file -p encoding | grep $(printf "\360") &&
+	git log -1 --format=%B encoding | grep $(printf "\317\200")
+'
+
 test_done
-- 
2.21.0.782.g44aacb1a0b

