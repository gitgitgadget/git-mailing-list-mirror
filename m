Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29041F453
	for <e@80x24.org>; Thu, 25 Apr 2019 15:51:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbfDYPvb (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Apr 2019 11:51:31 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38482 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728646AbfDYPva (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Apr 2019 11:51:30 -0400
Received: by mail-pg1-f195.google.com with SMTP id j26so55902pgl.5
        for <git@vger.kernel.org>; Thu, 25 Apr 2019 08:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hrY+jpjJ/la7napOEkZfoHJt/Vt7L0FgqA6m6iB7Ens=;
        b=Skz3TlngI8f1dbCG3Jze0Ggdg0qCjwb/fEHnr46dfQ7mEBzfMh/Zh/reONSoVjO9h3
         JHMFCgpG66C8KpsRouELRIyo5kg4opEFJFgV2lLJM8mCyhCkY1R+mIJbZ6I1oF/jv3fB
         2VrTE5FwdTpvYKjojGbnWqfvXKb48AfQx/TAd3tFgQfbjdknI/6UB/KtoSZkIbJt070z
         adaGxjuA8Vo8RBDNEOhAznp4eCh7a59E0UV5YQghoU9ig/HkIw3GOEG8O7I5aFfL8AsY
         SHcyhMCSQ6CzjjNLlDFrkwfYxWW/DhMf9QjGoN01Iirrwhst2gxO//r7FKlQMLl6egpk
         3WFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hrY+jpjJ/la7napOEkZfoHJt/Vt7L0FgqA6m6iB7Ens=;
        b=ZymQYLgAWNbhC8wulXlfaI1+gsKE7jy1MeKDvvacNQQ83gDovnOqegoeU24lL3lmln
         v+jsUJ5uG1uA614OaWjCrHvpGJgL3W0tyBzt9/rWmJFotAEa4EWK+tldTEUsBPklz5t1
         XS0srV8y1ofuY5Ipl5tjS6HzKHUi9NVs41WJ4PHHcIe6wWd0h6sIJ2uV5P33imt5Lp3L
         8ojUJdEQK5mL0puf/3x04LWhsTHYGIFUFp+QiZN6tPhXxjyOI54ndJiisHozy+FoHEqw
         WAcGF+yy/jqu6AGXw32/rP8rdTeUk6raq3PvYkZc9OfPilbpfOwtPmTdPR5WtharI9AB
         1Fxg==
X-Gm-Message-State: APjAAAUPIOOmmDNkdhiHNpTJgeYT82aOSy4v12zehye0igXn3eVUH5SS
        c3zFoHBy1EdLQpAKy3+zEVUO3+7d
X-Google-Smtp-Source: APXvYqycGUSt8Rfb2R8If4rZbcaLf0mYxEk3clP4tewtEJY/4u++6DSzYCq2ebka1COEvfvKG54quw==
X-Received: by 2002:a63:5012:: with SMTP id e18mr37386411pgb.383.1556207488131;
        Thu, 25 Apr 2019 08:51:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id e6sm15244914pfe.158.2019.04.25.08.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 25 Apr 2019 08:51:27 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/5] fast-import: support 'encoding' commit header
Date:   Thu, 25 Apr 2019 08:51:15 -0700
Message-Id: <20190425155118.7918-3-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.gb6cebc4909
In-Reply-To: <20190425155118.7918-1-newren@gmail.com>
References: <20190425155118.7918-1-newren@gmail.com>
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
 fast-import.c                     | 12 ++++++++++--
 t/t9300-fast-import.sh            | 20 ++++++++++++++++++++
 3 files changed, 37 insertions(+), 2 deletions(-)

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
index f38d04fa58..25026c068a 100644
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
@@ -2607,6 +2608,9 @@ static void parse_new_commit(const char *arg)
 	}
 	if (!committer)
 		die("Expected committer but didn't get one");
+	if (skip_prefix(command_buf.buf, "encoding ", &encoding)) {
+		read_next_command();
+	}
 	parse_data(&msg, 0, NULL);
 	read_next_command();
 	parse_from(b);
@@ -2670,9 +2674,13 @@ static void parse_new_commit(const char *arg)
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
+	strbuf_addf(&new_data, "\n");
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
2.21.0.779.g2f4b9c5032

