Return-Path: <SRS0=ylBF=6D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA19C38A30
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 11:00:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36B3822202
	for <git@archiver.kernel.org>; Sun, 19 Apr 2020 11:00:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arw+FP/D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgDSLAv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Apr 2020 07:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725914AbgDSLAu (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 19 Apr 2020 07:00:50 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79C0AC061A0C
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 04:00:50 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x3so3492978pfp.7
        for <git@vger.kernel.org>; Sun, 19 Apr 2020 04:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=swP+oKaiJTVUXA3Z9VeKb1Gt0qoNCtI641XTheNcJPc=;
        b=Arw+FP/DRKgKHVgoo/zcdpaGgt2d4X+PYv/llMtYIYpcS53X5yxIaarOoGaQaSf2D6
         c5pyoF2zo/iDJc3MobgSnYWQrzMWJIoS8Joy9b/s71ovvw3+GZaJXevzflnz1AWTUCyo
         17zrUIIxlpjLFXgLh9clpN+87GCx+fIGCKilRpvOUXXBlzHLCHwdisiJsaT6opN0OB8O
         yttNHRs2ct1buF6Vt9NhszYh+Xqq43W5wbiU07pJq5ki8zOM5HjXXVYTUiTkZjwhmOIr
         dyY6FgmSc+CEI7S5cx46je13nWs2AOmUnxuEqjLQHmyf4G701PYh27P6fDt9t/Ou6wdE
         +dRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=swP+oKaiJTVUXA3Z9VeKb1Gt0qoNCtI641XTheNcJPc=;
        b=Krvxt1gY/4q8DVFGjAjB7pMFFTVbjUPugBmfhbu0/bIdJDHb1RyAloPW/V0qSKVULH
         nZCjnzvKwCM4xcyUN+JEeHhmkOnBuwlvuQm/Ve82GQO956964iPWW/yUAzVH7vw1r7qa
         zKEvuTCfX8uX/y4Au9S5WXZYaZFX+cLXCf0uVPlMm+Tnn4bAtQXwU1VYDui6g4wbn3da
         tm1Ti5JditaujHSDQsn/Tebu3T3Q2Sw+sfnTObELVzMRoLAYefcKQBv92dRIFKBc2V9i
         eBTsxnxVxBDpPpJtKPupqGX2FW0sCzEuuwNGPH3mNJnXSB92+OovrjT9tMzLjrBbfc4S
         yxuA==
X-Gm-Message-State: AGi0Pua46fvTMm9i17dm6iPKo1x37Q7uzbBEmvTsE7+2tOI9vmFHPxxB
        zoPMIfsLvipnoCYbA4/QlNA+aih+
X-Google-Smtp-Source: APiQypJeAYkK6cpi67gwuOEEuRi2FpE9opDINK7WLr9l/KcqT/NuUAWM5kJJ0wIk2C76gZ8q+BJZqg==
X-Received: by 2002:a63:3687:: with SMTP id d129mr11289183pga.67.1587294049411;
        Sun, 19 Apr 2020 04:00:49 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:5380:b9e1:93e1:68db:b9f6])
        by smtp.gmail.com with ESMTPSA id b20sm361692pff.8.2020.04.19.04.00.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 04:00:48 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
Subject: [PATCH v2 0/3] mailinfo: disallow and complains about NUL character
Date:   Sun, 19 Apr 2020 18:00:39 +0700
Message-Id: <cover.1587289680.git.congdanhqx@gmail.com>
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


On 2020-04-18 22:32:30-0700, Junio C Hamano <gitster@pobox.com> wrote:
> Martin Ågren <martin.agren@gmail.com> writes:
>
> > My knee-jerk reaction to Junio's question was along the same line:
> > surely if we could have a NUL in there, the current `strlen()` would use
> > it as an excuse to silently truncate the string, either before
> > processing or afterwards. Thanks for looking into that more.
>
> Exactly.
>
> The change introduces a behaviour change, and we should describe it
> in the log message to help future developers know that we did this
> change, knowingly that we are changing the behaviour, and believing
> that the new behaviour is a better one.

Well, I intended to do something else first (because of Thunderbird started
with HTML email and replace space with non-breaking-space).

I made this change without thinking that much :( And I weren't sure if this
change is well received.

I've rephased the commit message, added some test, and disallow another NUL
characters mailinfo.

-------------------8<------------------------

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

Đoàn Trần Công Danh (3):
  t4254: merge 2 steps of a single test
  mailinfo.c::convert_to_utf8: reuse strlen info
  mailinfo: disallow NUL character in mail's header

 mailinfo.c            | 11 +++++++--
 t/t4254-am-corrupt.sh | 52 +++++++++++++++++++++++++++++++++++++++----
 2 files changed, 57 insertions(+), 6 deletions(-)

Range-diff against v1:
-:  ---------- > 1:  d1bc31e692 t4254: merge 2 steps of a single test
1:  9ce4b7c350 ! 2:  e3e542d388 mailinfo.c::convert_to_utf8: reuse strlen info
    @@ Commit message
         We're passing buffer from strbuf to reencode_string,
         which will call strlen(3) on that buffer,
         and discard the length of newly created buffer.
    -
         Then, we compute the length of the return buffer to attach to strbuf.
     
    +    During this process, we introduce a discrimination between mail
    +    originally written in utf-8 and other encoding.
    +
    +    * if the email was written in utf-8, we leave it as is. If there is
    +      a NUL character in that line, we complains loudly:
    +
    +            error: a NUL byte in commit log message not allowed.
    +
    +    * if the email was written in other encoding, we truncate the data as
    +      the NUL character in that line, then we used the truncated line for
    +      the metadata.
    +
         We can do better by reusing all the available information,
         and call the underlying lower level function that will be called
    -    indirectly by reencode_string.
    +    indirectly by reencode_string. By doing this, we will also postpone
    +    the NUL character processing to the commit step, which will
    +    complains about the faulty metadata.
     
         Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
    @@ mailinfo.c: static int convert_to_utf8(struct mailinfo *mi,
      	return 0;
      }
      
    +
    + ## t/t4254-am-corrupt.sh ##
    +@@
    + test_description='git am with corrupt input'
    + . ./test-lib.sh
    + 
    ++write_nul_patch() {
    ++	space=' '
    ++	qNUL=
    ++	case "$1" in
    ++		subject) qNUL='=00' ;;
    ++	esac
    ++	cat <<-EOF
    ++	From ec7364544f690c560304f5a5de9428ea3b978b26 Mon Sep 17 00:00:00 2001
    ++	From: A U Thor <author@example.com>
    ++	Date: Sun, 19 Apr 2020 13:42:07 +0700
    ++	Subject: [PATCH] =?ISO-8859-1?q?=C4=CB${qNUL}=D1=CF=D6?=
    ++	MIME-Version: 1.0
    ++	Content-Type: text/plain; charset=ISO-8859-1
    ++	Content-Transfer-Encoding: 8bit
    ++
    ++	EOF
    ++	if test "$1" = body
    ++	then
    ++		printf "%s\0%s\n" abc def
    ++	fi
    ++	cat <<-\EOF
    ++	---
    ++	diff --git a/afile b/afile
    ++	new file mode 100644
    ++	index 0000000000..e69de29bb2
    ++	--$space
    ++	2.26.1
    ++	EOF
    ++}
    ++
    + test_expect_success setup '
    + 	# Note the missing "+++" line:
    + 	cat >bad-patch.diff <<-\EOF &&
    +@@ t/t4254-am-corrupt.sh: test_expect_success 'try to apply corrupted patch' '
    + 	test_i18ncmp expected actual
    + '
    + 
    ++test_expect_success "NUL in commit message's body" '
    ++	test_when_finished "git am --abort" &&
    ++	write_nul_patch body >body.patch &&
    ++	test_must_fail git am body.patch 2>err &&
    ++	grep "a NUL byte in commit log message not allowed" err
    ++'
    ++
    ++test_expect_failure "NUL in commit message's header" '
    ++	test_when_finished "git am --abort" &&
    ++	write_nul_patch subject >subject.patch &&
    ++	test_must_fail git am subject.patch 2>err &&
    ++	grep "a NUL byte in Subject is not allowed" err
    ++'
    ++
    + test_done
-:  ---------- > 3:  cb96947b36 mailinfo: disallow NUL character in mail's header
-- 
2.26.1.301.g55bc3eb7cb

