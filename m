Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBAA8C433E0
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A54864DE9
	for <git@archiver.kernel.org>; Sat, 13 Feb 2021 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbhBMBx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 20:53:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhBMBx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 20:53:26 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD4AC061574
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:45 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id 7so1615801wrz.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 17:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dLa8oJSrcI4mrLk7jJfwUTfRTDscZnOb/sZ/l/2UKNg=;
        b=tNqiSOn0y8aX/TKBQEtQ9ciVuu6O0fPRqvKif2UJEbgQujOVzhzwtesQeKgceaWnsa
         SDU62DU874fO3b1zdOx24V0P7qaIzBNvlRrwbD3A+wqIWlbgtVoSgih6nIQirYliNB/3
         sp0M1HEsLWJb7Q27w4AbSh/G86cbHZkObVzhV/aUcUynB0Rq8LQ/NtWLgR8OR4XDsebg
         l7/EtdqMjh7Mnq1NMcIswFwlBjzbCtFhhAIXkQbbd0nnhnDMv9Jyb0x/Zjn/D/FLANl/
         XlJe4glUKV0+BMAK2GA7zSvSIpOaaIDhyyCDUrgmUJMJuJQ8pfiYkx3rIo5agPc+rXE3
         ISEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dLa8oJSrcI4mrLk7jJfwUTfRTDscZnOb/sZ/l/2UKNg=;
        b=NYpGmw1LKSzqYVd2zrykZHMDd+myylOOYwajxmBtQolGg7safV4INu2AwwvJp9xMhf
         739BxN1iSGWPWa/EJvBXL384TDLnlB/xHFO8pD362WbvtQke0QPDhLyNohhiZyQ1fG5f
         u3BEpkQJ9BHWpc4haQbMWioe4Hhu6spFDTbM0naIvmi7JO86rcwo/zA7RkrdVk5lStzo
         f9IugHA09dCF28a4cfiV2uh6FLmDN11VGQAoJ/LbnC+XRvK0vCqc+4xAzN/+FHSpzX5X
         g3fMYbR+ABWoRYV7gl+UTvYHrx484POMmsJhgLzIvNDLGXK3NiHUudzBHhyrl3cgsJyj
         Hgag==
X-Gm-Message-State: AOAM530OTmsVArhJD5fOtUtJYZEsVsJGxrr2B8kmcd1s5C337uCCr4aV
        h0knWCgcgcCJT9sHM6ziDj/p8/2TwF8=
X-Google-Smtp-Source: ABdhPJwBaCY0gX7nCDF1oCDHhA7ZyUHU15rfFycExCAuFvf/eXsIrKzhuPZXH+Vm/5IW02YhQpGhqw==
X-Received: by 2002:a5d:6942:: with SMTP id r2mr988093wrw.222.1613181164564;
        Fri, 12 Feb 2021 17:52:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d23sm17385719wmd.11.2021.02.12.17.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 17:52:44 -0800 (PST)
Message-Id: <pull.726.v4.git.1613181163.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
References: <pull.726.v3.git.1612602945.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 13 Feb 2021 01:52:39 +0000
Subject: [PATCH v4 0/4] Unify trailers formatting logic for pretty.c and ref-filter.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, there exists a separate logic for %(trailers) in "pretty.{c,h}"
and "ref-filter.{c,h}". Both are actually doing the same thing, why not use
the same code for both of them?

This is the 4th version of the patch series focused on unifying the
"%(trailers)" logic for both 'pretty.{c,h}' and 'ref-filter.{c,h}'. So, we
can have one logic for trailers.

v4 changes:

 * improved tests

Hariom Verma (4):
  t6300: use function to test trailer options
  pretty.c: refactor trailer logic to `format_set_trailers_options()`
  pretty.c: capture invalid trailer argument
  ref-filter: use pretty.c logic for trailers

 Documentation/git-for-each-ref.txt |   8 +-
 pretty.c                           |  98 +++++++++------
 pretty.h                           |  12 ++
 ref-filter.c                       |  36 +++---
 t/t6300-for-each-ref.sh            | 185 ++++++++++++++++++++++-------
 5 files changed, 236 insertions(+), 103 deletions(-)


base-commit: 328c10930387d301560f7cbcd3351cc485a13381
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-726%2Fharry-hov%2Funify-trailers-logic-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-726/harry-hov/unify-trailers-logic-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/726

Range-diff vs v3:

 -:  ------------ > 1:  410b02dbad20 t6300: use function to test trailer options
 1:  81030f00b11b = 2:  fd275fed8347 pretty.c: refactor trailer logic to `format_set_trailers_options()`
 2:  f4a6b2df1444 = 3:  073c75dc4494 pretty.c: capture invalid trailer argument
 3:  47d89f872314 ! 4:  9ec989176993 ref-filter: use pretty.c logic for trailers
     @@ ref-filter.c: static int subject_atom_parser(const struct ref_format *format, st
       
      
       ## t/t6300-for-each-ref.sh ##
     -@@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:unfold) unfolds trailers' '
     - 	test_cmp expect actual
     - '
     +@@ t/t6300-for-each-ref.sh: test_trailer_option '%(trailers:only) shows only "key: value" trailers' \
       
     --test_expect_success '%(trailers:only) shows only "key: value" trailers' '
     -+test_show_key_value_trailers () {
     -+	option="$1"
     -+	test_expect_success "%($option) shows only 'key: value' trailers" '
     -+		{
     -+			grep -v patch.description <trailers &&
     -+			echo
     -+		} >expect &&
     -+		git for-each-ref --format="%($option)" refs/heads/main >actual &&
     -+		test_cmp expect actual &&
     -+		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
     -+		test_cmp expect actual
     -+	'
     -+}
     -+
     -+test_show_key_value_trailers 'trailers:only'
     -+test_show_key_value_trailers 'trailers:only=no,only=true'
     -+test_show_key_value_trailers 'trailers:only=yes'
     -+
     -+test_expect_success '%(trailers:only=no) shows all trailers' '
     - 	{
     --		grep -v patch.description <trailers &&
     -+		cat trailers &&
     - 		echo
     - 	} >expect &&
     --	git for-each-ref --format="%(trailers:only)" refs/heads/main >actual &&
     -+	git for-each-ref --format="%(trailers:only=no)" refs/heads/main >actual &&
     - 	test_cmp expect actual &&
     --	git for-each-ref --format="%(contents:trailers:only)" refs/heads/main >actual &&
     -+	git for-each-ref --format="%(contents:trailers:only=no)" refs/heads/main >actual &&
     - 	test_cmp expect actual
     - '
     + 	EOF
       
     -@@ t/t6300-for-each-ref.sh: test_expect_success '%(trailers:only) and %(trailers:unfold) work together' '
     - 	test_cmp actual actual
     - '
     - 
     --test_expect_success '%(trailers) rejects unknown trailers arguments' '
     --	# error message cannot be checked under i18n
     --	cat >expect <<-EOF &&
     --	fatal: unknown %(trailers) argument: unsupported
     --	EOF
     --	test_must_fail git for-each-ref --format="%(trailers:unsupported)" 2>actual &&
     --	test_i18ncmp expect actual &&
     --	test_must_fail git for-each-ref --format="%(contents:trailers:unsupported)" 2>actual &&
     --	test_i18ncmp expect actual
     -+test_trailer_option() {
     -+	title="$1"
     -+	option="$2"
     -+	expect="$3"
     -+	test_expect_success "$title" '
     -+		printf "$expect\n" >expect &&
     -+		git for-each-ref --format="%($option)" refs/heads/main >actual &&
     -+		test_cmp expect actual &&
     -+		git for-each-ref --format="%(contents:$option)" refs/heads/main >actual &&
     -+		test_cmp expect actual
     -+	'
     -+}
     ++test_trailer_option '%(trailers:only=no,only=true) shows only "key: value" trailers' \
     ++	'trailers:only=no,only=true' <<-EOF
     ++	$(grep -v patch.description <trailers)
     ++
     ++	EOF
     ++
     ++test_trailer_option '%(trailers:only=yes) shows only "key: value" trailers' \
     ++	'trailers:only=yes' <<-EOF
     ++	$(grep -v patch.description <trailers)
     ++
     ++	EOF
      +
     ++test_trailer_option '%(trailers:only=no) shows all trailers' \
     ++	'trailers:only=no' <<-EOF
     ++	$(cat trailers)
     ++
     ++	EOF
     ++
     + test_trailer_option '%(trailers:only) and %(trailers:unfold) work together' \
     + 	'trailers:only,unfold' <<-EOF
     + 	$(grep -v patch.description <trailers | unfold)
     +@@ t/t6300-for-each-ref.sh: test_trailer_option '%(trailers:unfold) and %(trailers:only) work together' \
     + 
     + 	EOF
     + 
      +test_trailer_option '%(trailers:key=foo) shows that trailer' \
     -+	'trailers:key=Signed-off-by' 'Signed-off-by: A U Thor <author@example.com>\n'
     ++	'trailers:key=Signed-off-by' <<-EOF
     ++	Signed-off-by: A U Thor <author@example.com>
     ++
     ++	EOF
     ++
      +test_trailer_option '%(trailers:key=foo) is case insensitive' \
     -+	'trailers:key=SiGned-oFf-bY' 'Signed-off-by: A U Thor <author@example.com>\n'
     ++	'trailers:key=SiGned-oFf-bY' <<-EOF
     ++	Signed-off-by: A U Thor <author@example.com>
     ++
     ++	EOF
     ++
      +test_trailer_option '%(trailers:key=foo:) trailing colon also works' \
     -+	'trailers:key=Signed-off-by:' 'Signed-off-by: A U Thor <author@example.com>\n'
     ++	'trailers:key=Signed-off-by:' <<-EOF
     ++	Signed-off-by: A U Thor <author@example.com>
     ++
     ++	EOF
     ++
      +test_trailer_option '%(trailers:key=foo) multiple keys' \
     -+	'trailers:key=Reviewed-by:,key=Signed-off-by' 'Reviewed-by: A U Thor <author@example.com>\nSigned-off-by: A U Thor <author@example.com>\n'
     ++	'trailers:key=Reviewed-by:,key=Signed-off-by' <<-EOF
     ++	Reviewed-by: A U Thor <author@example.com>
     ++	Signed-off-by: A U Thor <author@example.com>
     ++
     ++	EOF
     ++
      +test_trailer_option '%(trailers:key=nonexistent) becomes empty' \
     -+	'trailers:key=Shined-off-by:' ''
     -+
     -+test_expect_success '%(trailers:key=foo) handles multiple lines even if folded' '
     -+	{
     -+		grep -v patch.description <trailers | grep -v Signed-off-by | grep -v Reviewed-by &&
     -+		echo
     -+	} >expect &&
     -+	git for-each-ref --format="%(trailers:key=Acked-by)" refs/heads/main >actual &&
     -+	test_cmp expect actual &&
     -+	git for-each-ref --format="%(contents:trailers:key=Acked-by)" refs/heads/main >actual &&
     -+	test_cmp expect actual
     -+'
     -+
     -+test_expect_success '%(trailers:key=foo,unfold) properly unfolds' '
     -+	{
     -+		unfold <trailers | grep Signed-off-by &&
     -+		echo
     -+	} >expect &&
     -+	git for-each-ref --format="%(trailers:key=Signed-Off-by,unfold)" refs/heads/main >actual &&
     -+	test_cmp expect actual &&
     -+	git for-each-ref --format="%(contents:trailers:key=Signed-Off-by,unfold)" refs/heads/main >actual &&
     -+	test_cmp expect actual
     - '
     - 
     -+test_expect_success 'pretty format %(trailers:key=foo,only=no) also includes nontrailer lines' '
     -+	{
     -+		echo "Signed-off-by: A U Thor <author@example.com>" &&
     -+		grep patch.description <trailers &&
     -+		echo
     -+	} >expect &&
     -+	git for-each-ref --format="%(trailers:key=Signed-off-by,only=no)" refs/heads/main >actual &&
     -+	test_cmp expect actual &&
     -+	git for-each-ref --format="%(contents:trailers:key=Signed-off-by,only=no)" refs/heads/main >actual &&
     -+	test_cmp expect actual
     -+'
     ++	'trailers:key=Shined-off-by:' <<-EOF
     ++
     ++	EOF
     ++
     ++test_trailer_option '%(trailers:key=foo) handles multiple lines even if folded' \
     ++	'trailers:key=Acked-by' <<-EOF
     ++	$(grep -v patch.description <trailers | grep -v Signed-off-by | grep -v Reviewed-by)
     ++
     ++	EOF
     ++
     ++test_trailer_option '%(trailers:key=foo,unfold) properly unfolds' \
     ++	'trailers:key=Signed-Off-by,unfold' <<-EOF
     ++	$(unfold <trailers | grep Signed-off-by)
     ++
     ++	EOF
     ++
     ++test_trailer_option '%(trailers:key=foo,only=no) also includes nontrailer lines' \
     ++	'trailers:key=Signed-off-by,only=no' <<-EOF
     ++	Signed-off-by: A U Thor <author@example.com>
     ++	$(grep patch.description <trailers)
     ++
     ++	EOF
      +
      +test_trailer_option '%(trailers:key=foo,valueonly) shows only value' \
     -+	'trailers:key=Signed-off-by,valueonly' 'A U Thor <author@example.com>\n'
     ++	'trailers:key=Signed-off-by,valueonly' <<-EOF
     ++	A U Thor <author@example.com>
     ++
     ++	EOF
     ++
      +test_trailer_option '%(trailers:separator) changes separator' \
     -+	'trailers:separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by: A U Thor <author@example.com>,Signed-off-by: A U Thor <author@example.com>'
     ++	'trailers:separator=%x2C,key=Reviewed-by,key=Signed-off-by:' <<-EOF
     ++	Reviewed-by: A U Thor <author@example.com>,Signed-off-by: A U Thor <author@example.com>
     ++	EOF
     ++
      +test_trailer_option '%(trailers:key_value_separator) changes key-value separator' \
     -+	'trailers:key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>\nSigned-off-by,A U Thor <author@example.com>\n'
     ++	'trailers:key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' <<-EOF
     ++	Reviewed-by,A U Thor <author@example.com>
     ++	Signed-off-by,A U Thor <author@example.com>
     ++
     ++	EOF
     ++
      +test_trailer_option '%(trailers:separator,key_value_separator) changes both separators' \
     -+	'trailers:separator=%x2C,key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' 'Reviewed-by,A U Thor <author@example.com>,Signed-off-by,A U Thor <author@example.com>'
     -+
     -+test_failing_trailer_option () {
     -+	title="$1"
     -+	option="$2"
     -+	error="$3"
     -+	test_expect_success "$title" '
     -+		# error message cannot be checked under i18n
     -+		echo $error >expect &&
     -+		test_must_fail git for-each-ref --format="%($option)" refs/heads/main 2>actual &&
     -+		test_i18ncmp expect actual &&
     -+		test_must_fail git for-each-ref --format="%(contents:$option)" refs/heads/main 2>actual &&
     -+		test_i18ncmp expect actual
     -+	'
     -+}
     ++	'trailers:separator=%x2C,key_value_separator=%x2C,key=Reviewed-by,key=Signed-off-by:' <<-EOF
     ++	Reviewed-by,A U Thor <author@example.com>,Signed-off-by,A U Thor <author@example.com>
     ++	EOF
      +
     + test_failing_trailer_option () {
     + 	title=$1 option=$2
     + 	cat >expect
     +@@ t/t6300-for-each-ref.sh: test_failing_trailer_option '%(trailers) rejects unknown trailers arguments' \
     + 	fatal: unknown %(trailers) argument: unsupported
     + 	EOF
     + 
      +test_failing_trailer_option '%(trailers:key) without value is error' \
     -+	'trailers:key' 'fatal: expected %(trailers:key=<value>)'
     -+test_failing_trailer_option '%(trailers) rejects unknown trailers arguments' \
     -+	'trailers:unsupported' 'fatal: unknown %(trailers) argument: unsupported'
     ++	'trailers:key' <<-\EOF
     ++	fatal: expected %(trailers:key=<value>)
     ++	EOF
      +
       test_expect_success 'if arguments, %(contents:trailers) shows error if colon is missing' '
       	cat >expect <<-EOF &&

-- 
gitgitgadget
