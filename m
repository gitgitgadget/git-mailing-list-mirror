Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC2E91F453
	for <e@80x24.org>; Tue, 30 Apr 2019 18:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbfD3SZb (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 14:25:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36825 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbfD3SZb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 14:25:31 -0400
Received: by mail-pg1-f194.google.com with SMTP id 85so7234051pgc.3
        for <git@vger.kernel.org>; Tue, 30 Apr 2019 11:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVed02TRAf0Sv3ru/14T7UV0pucQYYdM7JNrpO1rvjA=;
        b=fPTS2xy3q5nRCyATm2311a80UO7CiIIgqsMb4myExHBieEzSki352k3DFnxnaodRlp
         bUxlWstVGydao74W5AG9qDBDhVbqYfSNsFg6dCdhgKc0D/8IbuwR6oyLukT25wHo7mZ9
         Fjihh5I5Uor2IKmHuEoHES7Qfp/R/E6mNYahB9y8+Kq6Uy06arlBM+hAXqcoITmcjfar
         HW8Nl1Y6cIkCCwoc7qn6ZgEs8dGuuUdxmAyob6Osgp23ePbITK7Hahy1/Z8jQMsOQtkJ
         KmVOeBxGixMw/1rP/BNQEhn7xJ9CnEFvjYWKkh5oytCAj8V4HhTXE6bTxXrHRFMzVyTa
         WLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVed02TRAf0Sv3ru/14T7UV0pucQYYdM7JNrpO1rvjA=;
        b=dg3uB/K0tE7jcpFCqxZqJr7GzKVZ1/IVafl2ssmNQ1XYNUq8tvJqEPj/N8q11f1dcy
         PIoVc8MQPkvnY7Yx08LcwWiIXXytyGlXLkow+/88oFJPVadNkpBH4d37lAClBVtsKaYT
         UDcFlpULhkeK7UjeFSo+N2n2omykE4bAZCEAfEtLYgoAEhBpo9NNr9qaju7o/mti9XQ+
         Rkz1A0tCwA0TKq3XUVygcg2/fR5fVaxtbkto4H5HLPuvBUIAINsjdNEQ+QJZrQYGYaB8
         75l60BWRhWsWbo1cUtd6luRq25er1/rBXvUCEgtdNKPdBQozYv1+tX8f66f8mlbHQ91L
         xGMg==
X-Gm-Message-State: APjAAAV7ybY0Enx1Lu2qOwjtcWeNeXD+GhhGw3OYKs5EhC5mVj9XBxfC
        WikmplDz6m3tiI5XgVezF5A=
X-Google-Smtp-Source: APXvYqzWbhBs+83a7UbH617jyfi4uMeDyJu6LkS23wr/ix/620ahw0nl/MXOiUTCVzFbt0BTi5cUhQ==
X-Received: by 2002:a63:e20b:: with SMTP id q11mr70158958pgh.263.1556648730324;
        Tue, 30 Apr 2019 11:25:30 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id p2sm111217508pfi.73.2019.04.30.11.25.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Apr 2019 11:25:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 0/5] Fix and extend encoding handling in fast export/import
Date:   Tue, 30 Apr 2019 11:25:18 -0700
Message-Id: <20190430182523.3339-1-newren@gmail.com>
X-Mailer: git-send-email 2.21.0.782.g44aacb1a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While stress testing `git filter-repo`, I noticed an issue with
encoding; further digging led to the fixes and features in this series.
See the individual commit messages for details.

Changes since v1 (full range-diff below):
  * Applied style fixes Eric pointed out in his review (thanks!)
  * Rebased on latest master (83232e38, "The seventh batch"), resolving
    a trivial merge conflict.  Now merges cleanly with next and pu as
    well.

I'm a bit under the weather so I may be slow to respond...

Elijah Newren (5):
  t9350: fix encoding test to actually test reencoding
  fast-import: support 'encoding' commit header
  fast-export: avoid stripping encoding header if we cannot reencode
  fast-export: differentiate between explicitly utf-8 and implicitly
    utf-8
  fast-export: do automatic reencoding of commit messages only if
    requested

 Documentation/git-fast-import.txt |  7 ++++
 builtin/fast-export.c             | 44 +++++++++++++++++++++----
 fast-import.c                     | 11 +++++--
 t/t9300-fast-import.sh            | 20 ++++++++++++
 t/t9350-fast-export.sh            | 53 +++++++++++++++++++++++++------
 5 files changed, 118 insertions(+), 17 deletions(-)

Range-diff:
1:  d6efd05142 ! 1:  9cc04242bd t9350: fix encoding test to actually test reencoding
    @@ -26,8 +26,7 @@
     -	# use author and committer name in ISO-8859-1 to match it.
     -	. "$TEST_DIRECTORY"/t3901/8859-1.txt &&
     +	test_when_finished "git reset --hard HEAD~1" &&
    -+	test_when_finished "git config --unset i18n.commitencoding" &&
    -+	git config i18n.commitencoding iso-8859-7 &&
    ++	test_config i18n.commitencoding iso-8859-7 &&
      	test_tick &&
      	echo rosten >file &&
     -	git commit -s -m den file &&
2:  02f48c7559 ! 2:  0cd023ac7a fast-import: support 'encoding' commit header
    @@ -51,9 +51,8 @@
      	}
      	if (!committer)
      		die("Expected committer but didn't get one");
    -+	if (skip_prefix(command_buf.buf, "encoding ", &encoding)) {
    ++	if (skip_prefix(command_buf.buf, "encoding ", &encoding))
     +		read_next_command();
    -+	}
      	parse_data(&msg, 0, NULL);
      	read_next_command();
      	parse_from(b);
    @@ -69,7 +68,7 @@
     +		strbuf_addf(&new_data,
     +			"encoding %s\n",
     +			encoding);
    -+	strbuf_addf(&new_data, "\n");
    ++	strbuf_addch(&new_data, '\n');
      	strbuf_addbuf(&new_data, &msg);
      	free(author);
      	free(committer);
    @@ -78,14 +77,14 @@
      --- a/t/t9300-fast-import.sh
      +++ b/t/t9300-fast-import.sh
     @@
    - 	background_import_still_running
    + 	sed -e s/LFs/LLL/ W-input | tr L "\n" | test_must_fail git fast-import
      '
      
     +###
    -+### series W (other new features)
    ++### series X (other new features)
     +###
     +
    -+test_expect_success 'W: handling encoding' '
    ++test_expect_success 'X: handling encoding' '
     +	test_tick &&
     +	cat >input <<-INPUT_END &&
     +	commit refs/heads/encoding
3:  86c348402d ! 3:  1fddf51402 fast-export: avoid stripping encoding header if we cannot reencode
    @@ -41,8 +41,7 @@
     +test_expect_success 'encoding preserved if reencoding fails' '
     +
     +	test_when_finished "git reset --hard HEAD~1" &&
    -+	test_when_finished "git config --unset i18n.commitencoding" &&
    -+	git config i18n.commitencoding iso-8859-7 &&
    ++	test_config i18n.commitencoding iso-8859-7 &&
     +	echo rosten >file &&
     +	git commit -s -m "$(printf "Pi: \360; Invalid: \377")" file &&
     +	git fast-export wer^..wer >iso-8859-7.fi &&
4:  c09b23bc59 = 4:  4a2e04b3ae fast-export: differentiate between explicitly utf-8 and implicitly utf-8
5:  24b69a0db9 ! 5:  44aacb1a0b fast-export: do automatic reencoding of commit messages only if requested
    @@ -92,8 +92,7 @@
     +test_expect_success 'reencoding iso-8859-7' '
      
      	test_when_finished "git reset --hard HEAD~1" &&
    - 	test_when_finished "git config --unset i18n.commitencoding" &&
    -@@
    + 	test_config i18n.commitencoding iso-8859-7 &&
      	test_tick &&
      	echo rosten >file &&
      	git commit -s -m "$(printf "Pi: \360")" file &&
    @@ -109,8 +108,7 @@
     +test_expect_success 'aborting on iso-8859-7' '
     +
     +	test_when_finished "git reset --hard HEAD~1" &&
    -+	test_when_finished "git config --unset i18n.commitencoding" &&
    -+	git config i18n.commitencoding iso-8859-7 &&
    ++	test_config i18n.commitencoding iso-8859-7 &&
     +	echo rosten >file &&
     +	git commit -s -m "$(printf "Pi: \360")" file &&
     +	test_must_fail git fast-export --reencode=abort wer^..wer >iso-8859-7.fi
    @@ -119,8 +117,7 @@
     +test_expect_success 'preserving iso-8859-7' '
     +
     +	test_when_finished "git reset --hard HEAD~1" &&
    -+	test_when_finished "git config --unset i18n.commitencoding" &&
    -+	git config i18n.commitencoding iso-8859-7 &&
    ++	test_config i18n.commitencoding iso-8859-7 &&
     +	echo rosten >file &&
     +	git commit -s -m "$(printf "Pi: \360")" file &&
     +	git fast-export --reencode=no wer^..wer >iso-8859-7.fi &&
    @@ -134,8 +131,7 @@
      test_expect_success 'encoding preserved if reencoding fails' '
      
      	test_when_finished "git reset --hard HEAD~1" &&
    -@@
    - 	git config i18n.commitencoding iso-8859-7 &&
    + 	test_config i18n.commitencoding iso-8859-7 &&
      	echo rosten >file &&
      	git commit -s -m "$(printf "Pi: \360; Invalid: \377")" file &&
     -	git fast-export wer^..wer >iso-8859-7.fi &&
-- 
2.21.0.782.g44aacb1a0b

