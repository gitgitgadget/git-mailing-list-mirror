Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A57C54FCB
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522082068F
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bTXxE3U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgDTXy7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725988AbgDTXy7 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 19:54:59 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B49C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:54:59 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d24so4564243pll.8
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:54:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=txnJMFSE/NWuZQh2Wa2EgPjpi3FQ02/FX2RiR0iI15M=;
        b=bTXxE3U0J0s8+QNaG6SjMErspUPF+MXVE8Zh2sQpfMWSQPDjR/DiXeB+ZrDC4AoCHf
         1mkKUXM0GRpiuuv9IuLQlKHdpBHKqRO3MBQqTMgDXKBsZxSqRtsKeXIu+sXgFzR6aS3u
         mQvsdvNMkZwD2CHE0DmqzNRwcZwcP/MdoE69BpTwDRRU0SfdWP6oglFJeOlerertsl7a
         SUVegq5bXlgiXpvGIA4mXu/Jr6f0aGMQhd+dCTudA3VCaaXlmRT+Y8JURQQBaf6263HO
         wEkJROhw0jpa+IGFv3MrxlwsUeY+n1MD8ClXCDcaNDhORcZ62Y8UpkvI6BMBIUAgJKz4
         8aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=txnJMFSE/NWuZQh2Wa2EgPjpi3FQ02/FX2RiR0iI15M=;
        b=FyMHZtSVGpUtn72WFTwqOVKAciPPm1Jq7ZWLokM9uGEi9fS632ZbXDgiPqqbimOyBJ
         mcM4n9PZ1R0DkBfmRDbz8B3LUuUWw5RFSFNMZDJXFA6RLrrDnwGakxiMt293HyVx49pw
         TnlzC1iKeYgiz6joUtAlhA190d7WzqSNKQtYacNkoM+Z+K5Da/e6T9woxaJRwVtx3TTO
         Ax8w5ZilOk4Qh0JE9SKQGiF2Y9TunvUYyxG8WulA1/LcvQJMGBORYGr1FMiUdaADuUIp
         RUcWOyUdtnjfYhCLMnENehO1h7CzrMxV344Wkta8KRFNFp6KEKib28bNQ51ZB/mpUCya
         7ejg==
X-Gm-Message-State: AGi0Puby4wDl1eS8N0l+7G+Wx39z5LOIRNdhuwEiPjU2cE6D7d4hsYbn
        X8lCznKBM6dVztk6Oped2rfMc4lv
X-Google-Smtp-Source: APiQypLJyu1eyukM1J0DrN9wij1O8ZCsKZfoZs9XJOOSBlzgKAQ6iMyR6RgZId97nqnG9hX9LCS7Lg==
X-Received: by 2002:a17:902:aa84:: with SMTP id d4mr19570950plr.158.1587426898268;
        Mon, 20 Apr 2020 16:54:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:effc:5180:3a91:1887])
        by smtp.gmail.com with ESMTPSA id g14sm609248pfh.49.2020.04.20.16.54.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 16:54:57 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] Disallow NUL character in mailinfo
Date:   Tue, 21 Apr 2020 06:54:33 +0700
Message-Id: <cover.1587426713.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb
In-Reply-To: <20200418035449.9450-1-congdanhqx@gmail.com>
References: <20200418035449.9450-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


As of current state, Git disallow NUL character in commit message.

This indirectly disallow NUL in the body of commit message that sent by email
in UTF-8 encoding.

In those below cases:

* NUL character in header field (be it Subject, Author, Email, etc...)
* NUL in the body of commit message that originally sent in other than UTF-8
  encoding

Git silently accepts them, albeit, truncate at the NUL character.

Those email is clearly not generated by Git, they must be crafted.

Complains loudly about those NUL characters.

Change from v2:

* reword 2/3 commit message
* rename helper for crafting faulty patch, use single heredoc,
  and allow quoted NUL in both subject and body
* postpone a grep in test for NUL in subject to clearly indicate that git-am
  is failing instead of wrong error message.
* quote the header that contains NUL in the error message.


Đoàn Trần Công Danh (3):
  t4254: merge 2 steps of a single test
  mailinfo.c: avoid strlen on strings that can contains NUL
  mailinfo: disallow NUL character in mail's header

 mailinfo.c            | 11 +++++++--
 t/t4254-am-corrupt.sh | 53 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 58 insertions(+), 6 deletions(-)

Range-diff against v2:
1:  d1bc31e692 = 1:  d1bc31e692 t4254: merge 2 steps of a single test
2:  e3e542d388 ! 2:  97ede4aab2 mailinfo.c::convert_to_utf8: reuse strlen info
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    mailinfo.c::convert_to_utf8: reuse strlen info
    +    mailinfo.c: avoid strlen on strings that can contains NUL
     
         We're passing buffer from strbuf to reencode_string,
         which will call strlen(3) on that buffer,
    @@ t/t4254-am-corrupt.sh
      test_description='git am with corrupt input'
      . ./test-lib.sh
      
    -+write_nul_patch() {
    ++make_mbox_with_nul () {
     +	space=' '
    -+	qNUL=
    -+	case "$1" in
    -+		subject) qNUL='=00' ;;
    -+	esac
    ++	q_nul_in_subject=
    ++	q_nul_in_body=
    ++	while test $# -ne 0
    ++	do
    ++		case "$1" in
    ++		subject) q_nul_in_subject='=00' ;;
    ++		body)    q_nul_in_body='=00' ;;
    ++		esac &&
    ++		shift
    ++	done &&
     +	cat <<-EOF
     +	From ec7364544f690c560304f5a5de9428ea3b978b26 Mon Sep 17 00:00:00 2001
     +	From: A U Thor <author@example.com>
     +	Date: Sun, 19 Apr 2020 13:42:07 +0700
    -+	Subject: [PATCH] =?ISO-8859-1?q?=C4=CB${qNUL}=D1=CF=D6?=
    ++	Subject: [PATCH] =?ISO-8859-1?q?=C4=CB${q_nul_in_subject}=D1=CF=D6?=
     +	MIME-Version: 1.0
     +	Content-Type: text/plain; charset=ISO-8859-1
    -+	Content-Transfer-Encoding: 8bit
    ++	Content-Transfer-Encoding: quoted-printable
     +
    -+	EOF
    -+	if test "$1" = body
    -+	then
    -+		printf "%s\0%s\n" abc def
    -+	fi
    -+	cat <<-\EOF
    ++	abc${q_nul_in_body}def
     +	---
     +	diff --git a/afile b/afile
     +	new file mode 100644
    @@ t/t4254-am-corrupt.sh: test_expect_success 'try to apply corrupted patch' '
      
     +test_expect_success "NUL in commit message's body" '
     +	test_when_finished "git am --abort" &&
    -+	write_nul_patch body >body.patch &&
    ++	make_mbox_with_nul body >body.patch &&
     +	test_must_fail git am body.patch 2>err &&
     +	grep "a NUL byte in commit log message not allowed" err
     +'
     +
    -+test_expect_failure "NUL in commit message's header" '
    -+	test_when_finished "git am --abort" &&
    -+	write_nul_patch subject >subject.patch &&
    -+	test_must_fail git am subject.patch 2>err &&
    -+	grep "a NUL byte in Subject is not allowed" err
    -+'
    ++test_expect_failure "NUL in commit message's header" "
    ++	test_when_finished 'git am --abort' &&
    ++	make_mbox_with_nul subject >subject.patch &&
    ++	test_must_fail git am subject.patch
    ++"
     +
      test_done
3:  cb96947b36 ! 3:  b2e760227e mailinfo: disallow NUL character in mail's header
    @@ mailinfo.c: static void handle_info(struct mailinfo *mi)
      			continue;
      
     +		if (memchr(hdr->buf, '\0', hdr->len)) {
    -+			error("a NUL byte in %s is not allowed.", header[i]);
    ++			error("a NUL byte in '%s' is not allowed.", header[i]);
     +			mi->input_error = -1;
     +		}
     +
    @@ t/t4254-am-corrupt.sh: test_expect_success "NUL in commit message's body" '
      	grep "a NUL byte in commit log message not allowed" err
      '
      
    --test_expect_failure "NUL in commit message's header" '
    -+test_expect_success "NUL in commit message's header" '
    - 	test_when_finished "git am --abort" &&
    - 	write_nul_patch subject >subject.patch &&
    +-test_expect_failure "NUL in commit message's header" "
    ++test_expect_success "NUL in commit message's header" "
    + 	test_when_finished 'git am --abort' &&
    + 	make_mbox_with_nul subject >subject.patch &&
    +-	test_must_fail git am subject.patch
     +	test_must_fail git mailinfo msg patch <subject.patch 2>err &&
    -+	grep "a NUL byte in Subject is not allowed" err &&
    - 	test_must_fail git am subject.patch 2>err &&
    - 	grep "a NUL byte in Subject is not allowed" err
    - '
    ++	grep \"a NUL byte in 'Subject' is not allowed\" err &&
    ++	test_must_fail git am subject.patch 2>err &&
    ++	grep \"a NUL byte in 'Subject' is not allowed\" err
    + "
    + 
    + test_done
-- 
2.26.1.301.g55bc3eb7cb

