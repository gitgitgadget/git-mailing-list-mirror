Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B93C77B73
	for <git@archiver.kernel.org>; Sun, 23 Apr 2023 13:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjDWNq7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Apr 2023 09:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjDWNq5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Apr 2023 09:46:57 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C30410EA
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 06:46:55 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4efe8991b8aso1222680e87.0
        for <git@vger.kernel.org>; Sun, 23 Apr 2023 06:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682257613; x=1684849613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtvSvK34qyeFoM4mF9Hcxfk1N8vJ0R1tt7iQQxgPuaw=;
        b=BKldvShIniGEmDa5foG1jJxe2f4Bb43PdNwnCPoduDSdIJCQKrLeb32qImZzjI4olw
         5FdsLuKWg8uUKy/tx3r9NbNbpjluv2swzq0S28zeNsHZ94r93Gs3Rl3LNSnvSb9zhDGz
         pDeReJz/6Om9AiQjLU+4BUPvcZvtscnbK6NvmGCXwIgYxHC0hYGOca+bvlthWqVPc/D8
         O9bMK3PD8UF8yXhP054E5h7PYlFvqd7yV3F6gxqXqxiLx984v8u31zYBRnzGX/OsPKgB
         uuAZ3ekVFqA+VmHzsMBBy7HiA9CRNUOb4cPNnxRi3pElOM88/UOBjGJSwLbrwuzpz8wX
         3wnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682257613; x=1684849613;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtvSvK34qyeFoM4mF9Hcxfk1N8vJ0R1tt7iQQxgPuaw=;
        b=I8f6rQnpZ6J0pCn0tU+ImFLHCBrGuqjbO4N9iQtA8MtVm/6x3y3zxdorvbRNkXyfCs
         sV3VPvIe2cxR3Q1x+rPf4egsGPvzKhDzCDYGlUwDkbb3q1r/9AIud4HSbGUv6vZ4scBv
         AyGnC81CAhcCsYRJqYXX7j3Xvm9axle4tD9YqzbcXb2dNYP6p6U3qaYn7rkbB9jYCBrL
         qgD9hSnTDfY0xeq7sC4F8E9CpTSIE0HiopZGDUeDkU4envt+y+sPdf3zOKyxCIxlQmb+
         fq0AsvU/rg2nMmn31c+14A65/vtS6NNyNe+/WbAT5aFiqiXHwSuI96YS4tfFgRk2GyWs
         MHMw==
X-Gm-Message-State: AAQBX9dBUP3wUitDojI+OWWXjSr4igwE+VYEug2mznH3Pk6rGognXG1w
        56Ru5c5i2KOXiC3xV8AymZQfKpY+2803Ut2p
X-Google-Smtp-Source: AKy350b1hF/B8riUlThNI7/cBtX2jwb26Oj+HkW/C+7QeCxqEHeQiO3tcDdGOZRqnrKDKIoW3d+VyA==
X-Received: by 2002:a19:f804:0:b0:4e8:485c:6a13 with SMTP id a4-20020a19f804000000b004e8485c6a13mr2456227lff.21.1682257612855;
        Sun, 23 Apr 2023 06:46:52 -0700 (PDT)
Received: from titov.fritz.box ([195.246.120.55])
        by smtp.gmail.com with ESMTPSA id j24-20020ac24558000000b004db3eff4b12sm1272641lfm.171.2023.04.23.06.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Apr 2023 06:46:52 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 0/3] git config tests for "'git config ignores pairs ..."
Date:   Sun, 23 Apr 2023 15:46:46 +0200
Message-Id: <20230423134649.431783-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418175034.982433-1-rybak.a.v@gmail.com>
References: <20230418175034.982433-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clean up existing tests and add new tests in t1300-config.sh.

v1 cover letter:
  https://lore.kernel.org/git/20230414081352.810296-1-rybak.a.v@gmail.com/
v2 cover letter:
  https://lore.kernel.org/git/20230418175034.982433-1-rybak.a.v@gmail.com/

Changes since v2:
  - Patch 3 updates:
    - Added missing word "are" in commit message
    - Added signoff
    - Wrapped $1 and $2 in double quotes for consistency with
      `git grep -P 'local .*="?[$][1-9]"? &&$' -- t`
    - Added &&-chainging to function "test_missing_key"
    - Fixed quoting so that substitution of $key happens inside eval
    - Added tests about config subsections

Changes since v1:
  - Rewritten commit message for patch 2.
  - New RFC patch 3.

Andrei Rybak (3):
  t1300: drop duplicate test
  t1300: check stderr for "ignores pairs" tests
  t1300: add tests for missing keys

 t/t1300-config.sh | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

Range diff against v2:
1:  cf812f4fa8 = 1:  cf812f4fa8 t1300: drop duplicate test
2:  b4132adea8 = 2:  b4132adea8 t1300: check stderr for "ignores pairs" tests
3:  6126f42449 ! 3:  ba536bf855 t1300: add tests for missing keys
    @@ Metadata
      ## Commit message ##
         t1300: add tests for missing keys
     
    -    There several tests in t1300-config.sh that validate failing invocations
    -    of "git config".  However, there are no tests that check what happens
    -    when "git config" is asked to retrieve a value for a missing key.
    +    There are several tests in t1300-config.sh that validate failing
    +    invocations of "git config".  However, there are no tests that check
    +    what happens when "git config" is asked to retrieve a value for a
    +    missing key.
     
    -    Add tests that check this for various combinations of "<section>.<key>".
    +    Add tests that check this for various combinations of "<section>.<key>"
    +    and "<section>.<subsection>.<key>".
    +
    +    Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
     
      ## t/t1300-config.sh ##
     @@ t/t1300-config.sh: test_expect_success 'subsections are not canonicalized by git-config' '
    @@ t/t1300-config.sh: test_expect_success 'subsections are not canonicalized by git
      '
      
     +test_missing_key () {
    -+	local key=$1
    -+	local title=$2
    -+	test_expect_success "value for $title is not printed" "
    -+		test_must_fail git config $key >out 2>err &&
    ++	local key="$1" &&
    ++	local title="$2" &&
    ++	test_expect_success "value for $title is not printed" '
    ++		test_must_fail git config "$key" >out 2>err &&
     +		test_must_be_empty out &&
     +		test_must_be_empty err
    -+	"
    ++	'
     +}
     +
     +test_missing_key 'missingsection.missingkey' 'missing section and missing key'
     +test_missing_key 'missingsection.penguin' 'missing section and existing key'
     +test_missing_key 'section.missingkey' 'existing section and missing key'
    ++test_missing_key 'section.MissingSubSection.missingkey' 'missing subsection and missing key'
    ++test_missing_key 'section.SubSection.missingkey' 'existing subsection and missing key'
    ++test_missing_key 'section.MissingSubSection.key' 'missing subsection and existing key'
     +
      cat > .git/config <<\EOF
      [alpha]

-- 
2.40.0
