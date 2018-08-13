Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D59A1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 08:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbeHML3b (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 07:29:31 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:52275 "EHLO
        mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbeHML3b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 07:29:31 -0400
Received: by mail-it0-f47.google.com with SMTP id d9-v6so11982618itf.2
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 01:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TQ3aMkGFQuvwbtp9OFsbiBzJeOUeHeo2CXK3CERI66Q=;
        b=lLBK5dhe86nmb7x4OiRsaXkW2AWezj8zetyMl3wZqQnLmUSfyruvUFMJh7DYbK0QhD
         iTneM4TmaWmhSSsJ22oYvq/HNA3mBjo78VqxgbQQMwTRnz1XGe1j3J0ZsVHGEobiyWK/
         2kkcZh4FDWTAl6x6+sZULLddPeSZvJKxZdJydW8O3CoxIMC2eMCywEIQAa/mj8TZNRcb
         VPhArbdrhh3qNUm/LbNN9SAdgOZ1sGK1uMav4PvlaUO0PEu07rkFtM8O91uEsmhj0pXQ
         wWlBB8gtzfe0EqFTpbGqGsLP4tPg0KzFSvFDjiHSjCbDY7qhhjIDqKNj2Eta6Ee1EGqO
         5blg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TQ3aMkGFQuvwbtp9OFsbiBzJeOUeHeo2CXK3CERI66Q=;
        b=j9z39tmk6yKSDyzaekVFvkNjllojnXuXHRgBvmzWsLC7oUqNRGx/4c0+9fIo9LHT2Q
         SHJj9MWqr5o363kvxah/4o91atLbp1A3Bf+quopVT5ljvLxmsL1UeXfCA2AUmvxob7Ih
         rHlAIPsegpn+aw4a7xFUhYGh6WjrHlvf2/m/3fVMaGz3KyldlD9wgJ8xd8C3KhnaCIWL
         IXlicmSgqCJV5dvqwgQ2w/VR+GRCVQNhm8gBO/CGnIWuPIIeBK+3Zilw44VZ3TKOSxKk
         Nx3WjwhqFZYaIiAyVDkv0IF2hHr5Qr6a4mB4uFu6W7gCuB5wCq2qJK3EzDd8iXvACs9Z
         BO1w==
X-Gm-Message-State: AOUpUlEvIyMXyw/uooFuOtuLVHwQmJxk8kp31xEtUjxQbqQe7IvvL31m
        8qfwAAs7fl9U2Pmm8YL2QNWgiKxA
X-Google-Smtp-Source: AA+uWPwSN6kBxyPE10HYTgZIywYlqS/Y9wUuXe9cW+oPAC+mFHfZslXPXrRK3TWlg9zxmtg7ZfsnwQ==
X-Received: by 2002:a02:9a83:: with SMTP id m3-v6mr14687511jak.116.1534150094208;
        Mon, 13 Aug 2018 01:48:14 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g23-v6sm5609405iob.88.2018.08.13.01.48.12
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 01:48:13 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/6] chainlint: improve robustness against "unusual" shell coding
Date:   Mon, 13 Aug 2018 04:47:33 -0400
Message-Id: <20180813084739.16134-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180807082135.60913-1-sunshine@sunshineco.com>
References: <20180807082135.60913-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a re-roll of [1] which improves chainlint's robustness in the
face of unusual shell coding such as in contrib/subtree/t7900 which
triggered a false-positive[2].

Changes since v1:

* recognize lowercase in here-doc tag names (in addition to uppercase)
* recognize 'quoted' here-doc tag names (in addition to \escaped)

Patch 2/6 is new. Range-diff below.

[1]: https://public-inbox.org/git/20180807082135.60913-1-sunshine@sunshineco.com/
[2]: https://public-inbox.org/git/20180730181356.GA156463@aiede.svl.corp.google.com/

Eric Sunshine (6):
  chainlint: match arbitrary here-docs tags rather than hard-coded names
  chainlint: match 'quoted' here-doc tags
  chainlint: recognize multi-line $(...) when command cuddled with "$("
  chainlint: let here-doc and multi-line string commence on same line
  chainlint: recognize multi-line quoted strings more robustly
  chainlint: add test of pathological case which triggered false
    positive

 t/chainlint.sed                               | 98 ++++++++++++-------
 t/chainlint/here-doc-close-subshell.expect    |  2 +
 t/chainlint/here-doc-close-subshell.test      |  5 +
 .../here-doc-multi-line-command-subst.expect  |  5 +
 .../here-doc-multi-line-command-subst.test    |  9 ++
 t/chainlint/here-doc-multi-line-string.expect |  4 +
 t/chainlint/here-doc-multi-line-string.test   |  8 ++
 t/chainlint/here-doc.expect                   |  4 +
 t/chainlint/here-doc.test                     | 14 +++
 ...ti-line-nested-command-substitution.expect | 11 ++-
 ...ulti-line-nested-command-substitution.test | 11 ++-
 t/chainlint/multi-line-string.expect          | 10 +-
 t/chainlint/multi-line-string.test            | 12 +++
 t/chainlint/nested-here-doc.expect            |  2 +
 t/chainlint/nested-here-doc.test              | 10 ++
 t/chainlint/subshell-here-doc.expect          |  5 +
 t/chainlint/subshell-here-doc.test            | 12 +++
 t/chainlint/t7900-subtree.expect              | 10 ++
 t/chainlint/t7900-subtree.test                | 22 +++++
 19 files changed, 213 insertions(+), 41 deletions(-)
 create mode 100644 t/chainlint/here-doc-close-subshell.expect
 create mode 100644 t/chainlint/here-doc-close-subshell.test
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.expect
 create mode 100644 t/chainlint/here-doc-multi-line-command-subst.test
 create mode 100644 t/chainlint/here-doc-multi-line-string.expect
 create mode 100644 t/chainlint/here-doc-multi-line-string.test
 create mode 100644 t/chainlint/t7900-subtree.expect
 create mode 100644 t/chainlint/t7900-subtree.test

Range-diff against v1:
1:  d9ed356b97 ! 1:  f4c606cb7a chainlint: match arbitrary here-docs tags rather than hard-coded names
    @@ -64,8 +64,8 @@
     -/<<[ 	]*[-\\]*EOF[ 	]*/ {
     -	s/[ 	]*<<[ 	]*[-\\]*EOF//
     -	h
    -+/<<[ 	]*[-\\]*[A-Z0-9_][A-Z0-9_]*/ {
    -+	s/^\(.*\)<<[ 	]*[-\\]*\([A-Z0-9_][A-Z0-9_]*\)/<\2>\1<</
    ++/<<[ 	]*[-\\]*[A-Za-z0-9_]/ {
    ++	s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
     +	s/[ 	]*<<//
      	:hereslurp
      	N
    @@ -88,7 +88,7 @@
     -/<<[ 	]*[-\\]*EOF/bheredoc
     -/<<[ 	]*[-\\]*EOT/bheredoc
     -/<<[ 	]*[-\\]*INPUT_END/bheredoc
    -+/<<[ 	]*[-\\]*[A-Z0-9_][A-Z0-9_]*/bheredoc
    ++/<<[ 	]*[-\\]*[A-Za-z0-9_]/bheredoc
      # comment or empty line -- discard since final non-comment, non-empty line
      # before closing ")", "done", "elsif", "else", or "fi" will need to be
      # re-visited to drop "suspect" marking since final line of those constructs
    @@ -104,7 +104,7 @@
     -/EOF/{ s/[ 	]*<<[ 	]*[-\\]*EOF//; s/^/EOF/; }
     -/EOT/{ s/[ 	]*<<[ 	]*[-\\]*EOT//; s/^/EOT/; }
     -/INPUT_END/{ s/[ 	]*<<[ 	]*[-\\]*INPUT_END//; s/^/INPUT_END/; }
    -+s/^\(.*\)<<[ 	]*[-\\]*\([A-Z0-9_][A-Z0-9_]*\)/<\2>\1<</
    ++s/^\(.*\)<<[ 	]*[-\\]*\([A-Za-z0-9_][A-Za-z0-9_]*\)/<\2>\1<</
     +s/[ 	]*<<//
      :hereslurpsub
      N
    @@ -143,11 +143,11 @@
      EOF
      
     +# LINT: swallow here-doc with arbitrary tag
    -+cat <<-ARBITRARY >foo &&
    ++cat <<-Arbitrary_Tag_42 >foo &&
     +snoz
     +boz
     +woz
    -+ARBITRARY
    ++Arbitrary_Tag_42
     +
      # LINT: swallow here-doc (EOF is last line of test)
      horticulture <<\EOF
-:  ---------- > 2:  61c0d9c979 chainlint: match 'quoted' here-doc tags
2:  d63920cdd5 = 3:  b97a05aa9c chainlint: recognize multi-line $(...) when command cuddled with "$("
3:  a5078923ef = 4:  9d4d2b6c4d chainlint: let here-doc and multi-line string commence on same line
4:  4841ca6ac9 = 5:  0a7f533889 chainlint: recognize multi-line quoted strings more robustly
5:  e9eb45a2dc = 6:  d42bad0323 chainlint: add test of pathological case which triggered false positive
-- 
2.18.0.267.gbc8be36ecb
