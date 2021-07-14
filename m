Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFBBC11F66
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CDBB6136E
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237206AbhGNA5B (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbhGNA5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:57:00 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEF1C0613DD
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:08 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id g16so979034wrw.5
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yK/HDx015ailhctq/0C3Ks+Fv2w5pXtQiJHBCQZJGz8=;
        b=INJKhK95m8qYye+fcMnd6RQy0cU/NYWeFLpej2Ay6bhr0cvLpJV+y/YE+W5C01TKw8
         nhNnNM7cYN3KN9suBbYGprMP9yZ4FaINnJJbrH1HFVc66zy/VH7Jr03dC2xmLwgP+iKm
         sPpHqpX207gDNzLxCm5x8SZsQLnhwGA3wWDYb80NJPURI4rbrIjOkrAKIi8X7u2wGwZa
         RVVrghjnZx/SbrPH38OJsouCbu+Tfa79jj/GaT6AJjUGheupaZeYn0H0tpTkJsG/ON/U
         mAW6JTeq3I+XcDkjm6f0FvgVPDSw++294JoNHxMqSlnctA9qAg4M+nXg5lKt/0+RXZT7
         Y4NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yK/HDx015ailhctq/0C3Ks+Fv2w5pXtQiJHBCQZJGz8=;
        b=KAgEZiGyZCAJvLoULXll5IdW5putNphCkTBQdHU5Sd6YHkZP9RrOenwZlldJ+sEk+x
         ZalFvA2WeE0Kjj+jkQCo3z3NWUdTPL2sb/+eHGOo4yFdMbGpUBjlWJ/4UupIAE2v1Rqp
         mUciRsB5oZjLMBepJ5y5e3JVEqW8WwzqjfimdKEKdtDkxaeiIGybQNptNwqCaMLgdGVA
         plneNxHikMUVj09ey9W6FEk0TWFAdmw7NFA6Argz+YH2kBBSYGRr796RTWLA6Y4keV4p
         h7CNWzMtczgmYd6U1NSSnZx26TfCrzjtdDuiqIk/qT5eyq0kukdOqbuMdahX1+Vj0SAD
         N47w==
X-Gm-Message-State: AOAM530RcBmGcRwpIHlzfhwoXCLb5wvHA1T/sZie9abBnXBZkrLPhQOT
        dqhj5XaK6g85ldI5mxSZl+1oajWoW4pT+Hgx
X-Google-Smtp-Source: ABdhPJwPIp0MvmmW+U58PtbmFokDnbIJ5+wvZlsbOPrnVV3Q1IQVV8hO3Bcd7e7Wp3J9Veks5oCemg==
X-Received: by 2002:a5d:4d04:: with SMTP id z4mr9211741wrt.133.1626224046790;
        Tue, 13 Jul 2021 17:54:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm463315wru.95.2021.07.13.17.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:54:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/5] tests: migrate to "test-tool pkt-line"
Date:   Wed, 14 Jul 2021 02:54:00 +0200
Message-Id: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.788.ge724008458
In-Reply-To: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code that uses [de]packetize() to use "test-tool
pkt-line". That we had these two concurrently in the tests is mostly
just a historical anomaly/inconsistency that we can fix.

Hopefully addresses Jeff King's feedback on v2: https://lore.kernel.org/git/cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com/#t

I:

 * Changed the t5411/once-0010-report-status-v1.sh pattern to move
   away from the verbose "printf"..

 * Got rid of the stray strbuf_read()

 * Used a {} block in t/t5562-http-backend-content-length.sh

I kept the test_cmp in favor of the old logic of grepping out specific
parts, now with an updated commit message addressing that in 3/5, and
that we consistently include "0000" in all cases, even when we can
omit it.

Ævar Arnfjörð Bjarmason (5):
  serve tests: add missing "extra delim" test
  serve tests: use test_cmp in "protocol violations" test
  tests: replace [de]packetize() shell+perl test-tool pkt-line
  tests: replace remaining packetize() with "test-tool pkt-line"
  test-lib-functions.sh: remove unused [de]packetize() functions

 t/helper/test-pkt-line.c               | 12 +++++
 t/t5410-receive-pack-alternates.sh     | 42 +++++++++++++-----
 t/t5411/once-0010-report-status-v1.sh  | 20 ++++-----
 t/t5500-fetch-pack.sh                  | 15 ++++---
 t/t5530-upload-pack-error.sh           | 24 +++++-----
 t/t5562-http-backend-content-length.sh | 16 ++++---
 t/t5570-git-daemon.sh                  | 20 ++++++---
 t/t5704-protocol-violations.sh         | 61 ++++++++++++++++++--------
 t/test-lib-functions.sh                | 42 ------------------
 9 files changed, 138 insertions(+), 114 deletions(-)

Range-diff against v2:
1:  67aa814115 = 1:  67aa814115 serve tests: add missing "extra delim" test
2:  64dfd14865 = 2:  64dfd14865 serve tests: use test_cmp in "protocol violations" test
3:  c33f344ab2 ! 3:  92bfd8a87b tests: replace [de]packetize() shell+perl test-tool pkt-line
    @@ Commit message
         more legible code, and for anyone who cares about efficiency it'll be
         faster.
     
    +    The conversion away from extract_haves() in
    +    t5410-receive-pack-alternates.sh and the "just pick out" logic in
    +    t5570-git-daemon.sh isn't strictly required for this migration, but in
    +    this case it's easy enough to test_cmp the whole output, so let's just
    +    do that.
    +
    +    Similarly, there are cases here of changing "printf 0000" to a version
    +    that'll emit a trailing newline after "0000", or where we can do away
    +    with the "0000" trailer. Let's just always include, and include it in
    +    the same way.
    +
         We can't convert all the users of packetize(), it has a feature the
         test-tool is missing. This'll be addressed in the subsequent commit.
     
    @@ t/t5410-receive-pack-alternates.sh: test_expect_success 'with core.alternateRefs
     
      ## t/t5411/once-0010-report-status-v1.sh ##
     @@ t/t5411/once-0010-report-status-v1.sh: test_expect_success "proc-receive: report status v1" '
    + 			printf "%s %s refs/heads/main\0report-status object-format=$GIT_DEFAULT_HASH\n" \
      				$A $B | packetize
      		fi &&
    - 		printf "%s %s refs/for/main/topic1\n" \
    +-		printf "%s %s refs/for/main/topic1\n" \
     -			$ZERO_OID $A | packetize &&
    -+			$ZERO_OID $A | test-tool pkt-line pack &&
    - 		printf "%s %s refs/heads/foo\n" \
    +-		printf "%s %s refs/heads/foo\n" \
     -			$ZERO_OID $A | packetize &&
    -+			$ZERO_OID $A | test-tool pkt-line pack &&
    - 		printf "%s %s refs/for/next/topic\n" \
    +-		printf "%s %s refs/for/next/topic\n" \
     -			$ZERO_OID $A | packetize &&
    -+			$ZERO_OID $A | test-tool pkt-line pack &&
    - 		printf "%s %s refs/for/main/topic2\n" \
    +-		printf "%s %s refs/for/main/topic2\n" \
     -			$ZERO_OID $A | packetize &&
    -+			$ZERO_OID $A | test-tool pkt-line pack &&
    - 		printf 0000 &&
    +-		printf 0000 &&
    ++		test-tool pkt-line pack <<-EOF &&
    ++		$ZERO_OID $A refs/for/main/topic1
    ++		$ZERO_OID $A refs/heads/foo
    ++		$ZERO_OID $A refs/for/next/topic
    ++		$ZERO_OID $A refs/for/main/topic2
    ++		0000
    ++		EOF
      		printf "" | git -C "$upstream" pack-objects --stdout
      	} | git receive-pack "$upstream" --stateless-rpc \
    + 	>out 2>&1 &&
     
      ## t/t5500-fetch-pack.sh ##
     @@ t/t5500-fetch-pack.sh: test_expect_success 'shallow since with commit graph and already-seen commit' '
4:  a44e1790f2 ! 4:  9842c85d1f tests: replace remaining packetize() with "test-tool pkt-line"
    @@ t/helper/test-pkt-line.c: static void pack(int argc, const char **argv)
     +static void pack_raw_stdin(void)
     +{
     +	struct strbuf sb = STRBUF_INIT;
    -+	strbuf_read(&sb, 0, 0);
    ++
     +	if (strbuf_read(&sb, 0, 0) < 0)
     +		die_errno("failed to read from stdin");
     +	packet_write(1, sb.buf, sb.len);
    @@ t/t5411/once-0010-report-status-v1.sh: test_expect_success "proc-receive: report
     -				$A $B | packetize
     +				$A $B | test-tool pkt-line pack-raw-stdin
      		fi &&
    - 		printf "%s %s refs/for/main/topic1\n" \
    - 			$ZERO_OID $A | test-tool pkt-line pack &&
    + 		test-tool pkt-line pack <<-EOF &&
    + 		$ZERO_OID $A refs/for/main/topic1
     
      ## t/t5562-http-backend-content-length.sh ##
     @@ t/t5562-http-backend-content-length.sh: test_expect_success 'setup' '
    @@ t/t5562-http-backend-content-length.sh: test_expect_success 'setup' '
     
      ## t/t5570-git-daemon.sh ##
     @@ t/t5570-git-daemon.sh: test_expect_success 'hostname cannot break out of directory' '
    - '
      
      test_expect_success FAKENC 'hostname interpolation works after LF-stripping' '
    --	{
    + 	{
     -		printf "git-upload-pack /interp.git\n\0host=localhost" | packetize
     -		printf "0000"
    --	} >input &&
    -+	printf "git-upload-pack /interp.git\n\0host=localhost" >has-null &&
    -+	test-tool pkt-line pack-raw-stdin >input <has-null &&
    -+	test-tool pkt-line pack >>input <<-\EOF &&
    -+	0000
    -+	EOF
    ++		printf "git-upload-pack /interp.git\n\0host=localhost" |
    ++		test-tool pkt-line pack-raw-stdin &&
    ++		test-tool pkt-line pack <<-\EOF
    ++		0000
    ++		EOF
    + 	} >input &&
     +
      	fake_nc "$GIT_DAEMON_HOST_PORT" <input >output &&
      	test-tool pkt-line unpack <output >actual &&
5:  cc91d15ef7 = 5:  7ca83c5a55 test-lib-functions.sh: remove unused [de]packetize() functions
-- 
2.32.0.788.ge724008458

