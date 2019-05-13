Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EB6F1F461
	for <e@80x24.org>; Mon, 13 May 2019 16:47:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730862AbfEMQrg (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 12:47:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38798 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728347AbfEMQrf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 12:47:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id y2so2047674pfg.5
        for <git@vger.kernel.org>; Mon, 13 May 2019 09:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HiVpC7KjzW8bbMnsL9KkNQYg59lLbsFbWoXBqgEAodg=;
        b=IYdhf/qnK8Oi1cxWnsAcEDKKZ023b8HqJ3JuAWwSflp8/5DCQOAspsKlgwMxgSmQts
         y28LcmWMUngohZ3sde6AQnXCkIV/aO74yaEEm05a5DgUQLzZiMbsVAm6N4RbMpDylD6K
         qFwC5pzdfT83VYUclEKPFt5vUPUyioYzHcnKFy7VsN1ThfosuPMmvqoyUGMgM84JVxvG
         XBdoFeuipn1ZQWn4DyzLHs2G6Fk7sV1AcUhq2UPN/sBSfi7tm1ySI4GonOYfekxHiY92
         25i5kaO7xQgvCfJGdOdwIt91pSeUbqY/pxfo7rh+mmM3KQi136BXX5PtLR845yaYY+l0
         aQvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HiVpC7KjzW8bbMnsL9KkNQYg59lLbsFbWoXBqgEAodg=;
        b=GIU7PuacXQiq02465VZS4HFeQedF3Eu+GQe4PyY6Cn+tnUxcpLWZpy4M1SmURZwTOI
         VvJGMoP67s9QlARSdBt7BYQi45oP9EslxwQKb95AL+1MtNalIafqKy9CjAw2XIvlELbj
         CVAA/L4m/jML3GtE1TAkN6imETWO84pI8stwrNk6u4QGLI/VgtfFZjNTGADGimByiuVE
         xP2tmIKT/WZOhOrjLoOdbfUosBBQimTJ4/MKBZRgoZy71zg/hQRT3c05pjJoxZUIF3Ab
         FuppB+VcnWejmgH3hX5kpiK7SjzsQgzOpFo4+92IsyVBPWYgfc5MDrsRJEmHJe9jofu0
         Y7Qg==
X-Gm-Message-State: APjAAAUdmlUTgJtmyX3KaGSbuBSjJZk+eR5tJonibx0RJmH7bZUwEyOH
        rleJH6gX1DzFQGxsEg/pCks=
X-Google-Smtp-Source: APXvYqzr1NW1lpGgYzl60iASowtKtvdol+RcxXcQhE6jtEuf/BOLazhZPRwRC4wVghFowyOdJsicUg==
X-Received: by 2002:a63:d816:: with SMTP id b22mr31935307pgh.16.1557766054434;
        Mon, 13 May 2019 09:47:34 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id n35sm2851206pgl.44.2019.05.13.09.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 May 2019 09:47:33 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 2/5] fast-import: support 'encoding' commit header
Date:   Mon, 13 May 2019 09:47:19 -0700
Message-Id: <20190513164722.31534-3-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g571613a09e
In-Reply-To: <20190513164722.31534-1-newren@gmail.com>
References: <20190510205335.19968-1-newren@gmail.com>
 <20190513164722.31534-1-newren@gmail.com>
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
2.21.0.782.g571613a09e

