Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D4AC433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B87613BB
	for <git@archiver.kernel.org>; Sun,  9 May 2021 17:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhEIRNa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 13:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbhEIRN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 13:13:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015AAC061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 10:12:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so8950679pjb.3
        for <git@vger.kernel.org>; Sun, 09 May 2021 10:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VKE+coDx36L+TbT+suY60/CKa30b2LLS7s3oRhfDGU8=;
        b=VRnxsFwVlRmcSYsLfonuMRdMsVDAqKflkf5dy9rWmyAXCIbKNZ8nSNjOJnY2MXRe3N
         9tvdZPConv1I5KVGQGvf7ydqITd7nRIiztM3bS88O5HcP12HmRqeuEevkm8avcfjIMQE
         Ca2osJytX/ujwc7/jUFfV+qN+d6Xvj+tZby4fENBRqEfRLbzQZ7mE+PTrCseCktaJMe+
         q3VvJlumPe9ZUqbPAmA1rYRviYGdQzeEIqOcykCSs6euQG7jG1WsOPq+9lz6QTn0mGPQ
         UdAKk3IVGWzoSx6M1PG7/qjnNqjLL91WspNY4B29Z0rd3OwBHcHjC9UD303W9dCW/LhH
         wu0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VKE+coDx36L+TbT+suY60/CKa30b2LLS7s3oRhfDGU8=;
        b=nY4reGTph9ajxG8JkUli2LunOqwhXgulvRb/wMgz5H4n5Mu1JXb1UutqMqw63eJZfh
         PNWhQlQhLvkRx7jLSLVKFORjNqQRJtqY3QTNUSwWks4hAcjC830jgbOfF772+tQKba4o
         g2+3Vloe8JTI1cPUoGLMtbBicb+70DTARU7GtACD/NeD9lvDZHqvc+7AFkdhFhzqKOyb
         K61D/4BMap+i13GSB2Lv26JKB8EZuSFUoL+EGf1+LKm8KFL8OUNLE8Ea8Bkmuol3O+pa
         I9D90NE+PIVc9y7/VMeLmElc/v4fADyWc1k9caGc/igtPrldlCOu3KS4bvuGh8vgBCkO
         rj4Q==
X-Gm-Message-State: AOAM533oL+2awrTL2tjXxU7X7Puf1eMCFaaYJEYrwJBI6coGT8k6Ln1y
        TDAcWvWGy3I6NC7udnJgR0OhQbPFpBzyMw==
X-Google-Smtp-Source: ABdhPJzD3wt+4LCFnAoCpY5mLa+GOujlLz8fYBbWnX17V97Jj/pM5Qu6McTjrjG2iwqY6xycKJ50rg==
X-Received: by 2002:a17:90a:d512:: with SMTP id t18mr35471242pju.108.1620580343916;
        Sun, 09 May 2021 10:12:23 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:d379:85bd:c83a:4b40:cd9b])
        by smtp.gmail.com with ESMTPSA id l126sm9249374pga.41.2021.05.09.10.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 10:12:23 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v4 0/6] Teach am/mailinfo to process quoted CR
Date:   Mon, 10 May 2021 00:12:07 +0700
Message-Id: <cover.1620580178.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.31.1.448.g9c2f8508d1
In-Reply-To: <20210421013404.17383-1-congdanhqx@gmail.com>
References: <20210421013404.17383-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When SMTP servers receive 8-bit email messages, possibly with only
LF as line ending, some of those servers decide to change said LF to
CRLF.

Some mailing list software, when receives an 8-bit email message,
decide to encode such message in base64 or quoted-printable.

This series try to help users of such softwares deal with such patches.

Change in v4:
* Mark warning message for l10n
* Change all CR references to CRLF
* Add test case for not warn/strip if CR is found in the middle of the line.

Change in v3:
* Change preparatory step (in mailinfo) to use parse_options
* move "have_quoted_cr" to "struct mailinfo", thus the patch to warn about
  quoted CR is less weird.
* Change "mailinfo_parse_quoted_cr" to Git's do-some-work function, return
  0 on success and negative on failure, eliminate the usage of _invalid_action
* Better error messages if invalid action was given.
* completion support for git am --quoted-cr
* Some style changes

Đoàn Trần Công Danh (6):
  mailinfo: load default metainfo_charset lazily
  mailinfo: stop parsing options manually
  mailinfo: warn if CRLF found in decoded base64/QP email
  mailinfo: allow squelching quoted CRLF warning
  mailinfo: allow stripping quoted CR without warning
  am: learn to process quoted lines that ends with CRLF

 Documentation/git-am.txt               |   4 +
 Documentation/git-mailinfo.txt         |  21 ++++-
 builtin/am.c                           |  51 +++++++++++
 builtin/mailinfo.c                     | 115 ++++++++++++++++++-------
 contrib/completion/git-completion.bash |   5 ++
 mailinfo.c                             |  39 +++++++++
 mailinfo.h                             |  10 +++
 t/t4258-am-quoted-cr.sh                |  37 ++++++++
 t/t4258/mbox                           |  12 +++
 t/t5100-mailinfo.sh                    |  40 +++++++++
 t/t5100/quoted-cr-info                 |   5 ++
 t/t5100/quoted-cr-msg                  |   2 +
 t/t5100/quoted-cr-patch                |  22 +++++
 t/t5100/quoted-cr.mbox                 |  47 ++++++++++
 14 files changed, 376 insertions(+), 34 deletions(-)
 create mode 100755 t/t4258-am-quoted-cr.sh
 create mode 100644 t/t4258/mbox
 create mode 100644 t/t5100/quoted-cr-info
 create mode 100644 t/t5100/quoted-cr-msg
 create mode 100644 t/t5100/quoted-cr-patch
 create mode 100644 t/t5100/quoted-cr.mbox

Range-diff against v3:
1:  fac95392df = 1:  fac95392df mailinfo: load default metainfo_charset lazily
2:  1fb08bb37d = 2:  1fb08bb37d mailinfo: stop parsing options manually
3:  5aac2ba38e ! 3:  50404ffe74 mailinfo: warn if CR found in decoded base64/QP email
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    mailinfo: warn if CR found in decoded base64/QP email
    +    mailinfo: warn if CRLF found in decoded base64/QP email
     
         When SMTP servers receive 8-bit email messages, possibly with only
         LF as line ending, some of them decide to change said LF to CRLF.
    @@ Commit message
         by such mailing list softwares, the recipients will receive an email
         contains a patch mungled with CRLF encoded inside another encoding.
     
    -    Thus, such CR couldn't be dropped by "mailsplit".
    +    Thus, such CR (in CRLF) couldn't be dropped by "mailsplit".
         Hence, the mailed patch couldn't be applied cleanly.
         Such accidents have been observed in the wild [1].
     
         Instead of silently rejecting those messages, let's give our users
    -    some warnings if such CR is found.
    +    some warnings if such CR (as part of CRLF) is found.
     
         [1]: https://nmbug.notmuchmail.org/nmweb/show/m2lf9ejegj.fsf%40guru.guru-group.fi
     
    @@ mailinfo.c: static void handle_filter_flowed(struct mailinfo *mi, struct strbuf
     +static void summarize_quoted_cr(struct mailinfo *mi)
     +{
     +	if (mi->have_quoted_cr)
    -+		warning("quoted CR detected");
    ++		warning(_("quoted CRLF detected"));
     +}
     +
      static void handle_body(struct mailinfo *mi, struct strbuf *line)
    @@ t/t5100-mailinfo.sh: test_expect_success 'mailinfo handles unusual header whites
      '
      
     +check_quoted_cr_mail () {
    -+	git mailinfo -u "$@" quoted-cr-msg quoted-cr-patch \
    -+		<"$DATA/quoted-cr.mbox" >quoted-cr-info 2>quoted-cr-err &&
    -+	test_cmp "expect-cr-msg" quoted-cr-msg &&
    -+	test_cmp "expect-cr-patch" quoted-cr-patch &&
    -+	test_cmp "$DATA/quoted-cr-info" quoted-cr-info
    ++	mail="$1" && shift &&
    ++	git mailinfo -u "$@" "$mail.msg" "$mail.patch" \
    ++		<"$mail" >"$mail.info" 2>"$mail.err" &&
    ++	test_cmp "$mail-expected.msg" "$mail.msg" &&
    ++	test_cmp "$mail-expected.patch" "$mail.patch" &&
    ++	test_cmp "$DATA/quoted-cr-info" "$mail.info"
     +}
     +
    ++test_expect_success 'split base64 email with quoted-cr' '
    ++	mkdir quoted-cr &&
    ++	git mailsplit -oquoted-cr "$DATA/quoted-cr.mbox" >quoted-cr/last &&
    ++	test $(cat quoted-cr/last) = 2
    ++'
    ++
     +test_expect_success 'mailinfo warn CR in base64 encoded email' '
    -+	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-msg" >expect-cr-msg &&
    -+	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-patch" >expect-cr-patch &&
    -+	check_quoted_cr_mail &&
    -+	grep "quoted CR detected" quoted-cr-err
    ++	sed -e "s/%%$//" -e "s/%%/$(printf \\015)/g" "$DATA/quoted-cr-msg" \
    ++		>quoted-cr/0001-expected.msg &&
    ++	sed "s/%%/$(printf \\015)/g" "$DATA/quoted-cr-msg" \
    ++		>quoted-cr/0002-expected.msg &&
    ++	sed -e "s/%%$//" -e "s/%%/$(printf \\015)/g" "$DATA/quoted-cr-patch" \
    ++		>quoted-cr/0001-expected.patch &&
    ++	sed "s/%%/$(printf \\015)/g" "$DATA/quoted-cr-patch" \
    ++		>quoted-cr/0002-expected.patch &&
    ++	check_quoted_cr_mail quoted-cr/0001 &&
    ++	test_must_be_empty quoted-cr/0001.err &&
    ++	check_quoted_cr_mail quoted-cr/0002 &&
    ++	grep "quoted CRLF detected" quoted-cr/0002.err
     +'
     +
      test_done
    @@ t/t5100/quoted-cr-info (new)
     
      ## t/t5100/quoted-cr-msg (new) ##
     @@
    -+On different distro, pytest is suffixed with different patterns.%%
    ++On different distro, %%pytest is suffixed with different patterns.%%
     +%%
     
      ## t/t5100/quoted-cr-patch (new) ##
    @@ t/t5100/quoted-cr-patch (new)
     +--- a/configure%%
     ++++ b/configure%%
     +@@ -814,7 +814,7 @@ if [ $have_python3 -eq 1 ]; then%%
    -+     printf "Checking for python3 pytest (>= 3.0)... "%%
    ++     printf "%%Checking for python3 pytest (>= 3.0)... "%%
     +     conf=$(mktemp)%%
     +     printf "[pytest]\nminversion=3.0\n" > $conf%%
     +-    if pytest-3 -c $conf --version >/dev/null 2>&1; then%%
    @@ -814,7 +814,7 @@ if [ $have_python3 -eq 1 ]; then%%
     
      ## t/t5100/quoted-cr.mbox (new) ##
     @@
    ++From nobody Mon Sep 17 00:00:00 2001
     +From: A U Thor <mail@example.com>
     +To: list@example.org
     +Subject: [PATCH v2] sample
    @@ t/t5100/quoted-cr.mbox (new)
     +Content-Type: text/plain; charset="utf-8"
     +Content-Transfer-Encoding: base64
     +
    -+T24gZGlmZmVyZW50IGRpc3RybywgcHl0ZXN0IGlzIHN1ZmZpeGVkIHdpdGggZGlmZmVyZW50IHBh
    -+dHRlcm5zLg0KDQotLS0NCiBjb25maWd1cmUgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
    -+ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9jb25maWd1cmUgYi9jb25m
    -+aWd1cmUNCmluZGV4IGRiMzUzOGIzLi5mN2MxYzA5NSAxMDA3NTUNCi0tLSBhL2NvbmZpZ3VyZQ0K
    -+KysrIGIvY29uZmlndXJlDQpAQCAtODE0LDcgKzgxNCw3IEBAIGlmIFsgJGhhdmVfcHl0aG9uMyAt
    -+ZXEgMSBdOyB0aGVuDQogICAgIHByaW50ZiAiQ2hlY2tpbmcgZm9yIHB5dGhvbjMgcHl0ZXN0ICg+
    -+PSAzLjApLi4uICINCiAgICAgY29uZj0kKG1rdGVtcCkNCiAgICAgcHJpbnRmICJbcHl0ZXN0XVxu
    -+bWludmVyc2lvbj0zLjBcbiIgPiAkY29uZg0KLSAgICBpZiBweXRlc3QtMyAtYyAkY29uZiAtLXZl
    -+cnNpb24gPi9kZXYvbnVsbCAyPiYxOyB0aGVuDQorICAgIGlmICIkcHl0aG9uIiAtbSBweXRlc3Qg
    -+LWMgJGNvbmYgLS12ZXJzaW9uID4vZGV2L251bGwgMj4mMTsgdGhlbg0KICAgICAgICAgcHJpbnRm
    -+ICJZZXMuXG4iDQogICAgICAgICBoYXZlX3B5dGhvbjNfcHl0ZXN0PTENCiAgICAgZWxzZQ0KLS0g
    -+DQoyLjI4LjANCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
    -+CmV4YW1wbGUgbWFpbGluZyBsaXN0IC0tIGxpc3RAZXhhbXBsZS5vcmcKVG8gdW5zdWJzY3JpYmUg
    -+c2VuZCBhbiBlbWFpbCB0byBsaXN0LWxlYXZlQGV4YW1wbGUub3JnCg==
    ++T24gZGlmZmVyZW50IGRpc3RybywgDXB5dGVzdCBpcyBzdWZmaXhlZCB3aXRoIGRpZmZlcmVudCBw
    ++YXR0ZXJucy4KCi0tLQogY29uZmlndXJlIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
    ++aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvY29uZmlndXJlIGIvY29uZmlndXJl
    ++CmluZGV4IGRiMzUzOGIzLi5mN2MxYzA5NSAxMDA3NTUKLS0tIGEvY29uZmlndXJlCisrKyBiL2Nv
    ++bmZpZ3VyZQpAQCAtODE0LDcgKzgxNCw3IEBAIGlmIFsgJGhhdmVfcHl0aG9uMyAtZXEgMSBdOyB0
    ++aGVuCiAgICAgcHJpbnRmICINQ2hlY2tpbmcgZm9yIHB5dGhvbjMgcHl0ZXN0ICg+PSAzLjApLi4u
    ++ICIKICAgICBjb25mPSQobWt0ZW1wKQogICAgIHByaW50ZiAiW3B5dGVzdF1cbm1pbnZlcnNpb249
    ++My4wXG4iID4gJGNvbmYKLSAgICBpZiBweXRlc3QtMyAtYyAkY29uZiAtLXZlcnNpb24gPi9kZXYv
    ++bnVsbCAyPiYxOyB0aGVuCisgICAgaWYgIiRweXRob24iIC1tIHB5dGVzdCAtYyAkY29uZiAtLXZl
    ++cnNpb24gPi9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgICAgICAgIHByaW50ZiAiWWVzLlxuIgogICAg
    ++ICAgICBoYXZlX3B5dGhvbjNfcHl0ZXN0PTEKICAgICBlbHNlCi0tIAoyLjI4LjAKX19fX19fX19f
    ++X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZXhhbXBsZSBtYWlsaW5nIGxp
    ++c3QgLS0gbGlzdEBleGFtcGxlLm9yZwpUbyB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIGxp
    ++c3QtbGVhdmVAZXhhbXBsZS5vcmcK
    ++
    ++From nobody Mon Sep 17 00:00:00 2001
    ++From: A U Thor <mail@example.com>
    ++To: list@example.org
    ++Subject: [PATCH v2] sample
    ++Date: Mon,  3 Aug 2020 22:40:55 +0700
    ++Message-Id: <msg-id2@example.com>
    ++Content-Type: text/plain; charset="utf-8"
    ++Content-Transfer-Encoding: base64
    ++
    ++T24gZGlmZmVyZW50IGRpc3RybywgDXB5dGVzdCBpcyBzdWZmaXhlZCB3aXRoIGRpZmZlcmVudCBw
    ++YXR0ZXJucy4NCg0KLS0tDQogY29uZmlndXJlIHwgMiArLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
    ++c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvY29uZmlndXJlIGIvY29u
    ++ZmlndXJlDQppbmRleCBkYjM1MzhiMy4uZjdjMWMwOTUgMTAwNzU1DQotLS0gYS9jb25maWd1cmUN
    ++CisrKyBiL2NvbmZpZ3VyZQ0KQEAgLTgxNCw3ICs4MTQsNyBAQCBpZiBbICRoYXZlX3B5dGhvbjMg
    ++LWVxIDEgXTsgdGhlbg0KICAgICBwcmludGYgIg1DaGVja2luZyBmb3IgcHl0aG9uMyBweXRlc3Qg
    ++KD49IDMuMCkuLi4gIg0KICAgICBjb25mPSQobWt0ZW1wKQ0KICAgICBwcmludGYgIltweXRlc3Rd
    ++XG5taW52ZXJzaW9uPTMuMFxuIiA+ICRjb25mDQotICAgIGlmIHB5dGVzdC0zIC1jICRjb25mIC0t
    ++dmVyc2lvbiA+L2Rldi9udWxsIDI+JjE7IHRoZW4NCisgICAgaWYgIiRweXRob24iIC1tIHB5dGVz
    ++dCAtYyAkY29uZiAtLXZlcnNpb24gPi9kZXYvbnVsbCAyPiYxOyB0aGVuDQogICAgICAgICBwcmlu
    ++dGYgIlllcy5cbiINCiAgICAgICAgIGhhdmVfcHl0aG9uM19weXRlc3Q9MQ0KICAgICBlbHNlDQot
    ++LSANCjIuMjguMA0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
    ++X18KZXhhbXBsZSBtYWlsaW5nIGxpc3QgLS0gbGlzdEBleGFtcGxlLm9yZwpUbyB1bnN1YnNjcmli
    ++ZSBzZW5kIGFuIGVtYWlsIHRvIGxpc3QtbGVhdmVAZXhhbXBsZS5vcmcK
4:  d5b2da370d ! 4:  8aeb960dfd mailinfo: allow squelching quoted CR warning
    @@ Metadata
     Author: Đoàn Trần Công Danh <congdanhqx@gmail.com>
     
      ## Commit message ##
    -    mailinfo: allow squelching quoted CR warning
    +    mailinfo: allow squelching quoted CRLF warning
     
    -    In previous change, Git starts to warn for quoted CR in decoded
    +    In previous change, Git starts to warn for quoted CRLF in decoded
         base64/QP email. Despite those warnings are usually helpful,
    -    quoted CR could be part of some users' workflow.
    +    quoted CRLF could be part of some users' workflow.
     
         Let's give them an option to turn off the warning completely.
     
    @@ mailinfo.c: static void handle_filter_flowed(struct mailinfo *mi, struct strbuf
     -	if (mi->have_quoted_cr)
     +	if (mi->have_quoted_cr &&
     +	    mi->quoted_cr == quoted_cr_warn)
    - 		warning("quoted CR detected");
    + 		warning(_("quoted CRLF detected"));
      }
      
     @@ mailinfo.c: int mailinfo(struct mailinfo *mi, const char *msg, const char *patch)
    @@ mailinfo.h: struct mailinfo {
      void clear_mailinfo(struct mailinfo *);
     
      ## t/t5100-mailinfo.sh ##
    -@@ t/t5100-mailinfo.sh: check_quoted_cr_mail () {
    - 	test_cmp "$DATA/quoted-cr-info" quoted-cr-info
    - }
    - 
    --test_expect_success 'mailinfo warn CR in base64 encoded email' '
    -+test_expect_success 'mailinfo handle CR in base64 encoded email' '
    - 	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-msg" >expect-cr-msg &&
    - 	sed "s/%%/$(printf \\015)/" "$DATA/quoted-cr-patch" >expect-cr-patch &&
    - 	check_quoted_cr_mail &&
    --	grep "quoted CR detected" quoted-cr-err
    -+	grep "quoted CR detected" quoted-cr-err &&
    -+	check_quoted_cr_mail --quoted-cr=nowarn &&
    -+	test_must_be_empty quoted-cr-err
    +@@ t/t5100-mailinfo.sh: test_expect_success 'mailinfo warn CR in base64 encoded email' '
    + 	check_quoted_cr_mail quoted-cr/0001 &&
    + 	test_must_be_empty quoted-cr/0001.err &&
    + 	check_quoted_cr_mail quoted-cr/0002 &&
    +-	grep "quoted CRLF detected" quoted-cr/0002.err
    ++	grep "quoted CRLF detected" quoted-cr/0002.err &&
    ++	check_quoted_cr_mail quoted-cr/0001 --quoted-cr=nowarn &&
    ++	test_must_be_empty quoted-cr/0001.err &&
    ++	check_quoted_cr_mail quoted-cr/0002 --quoted-cr=nowarn &&
    ++	test_must_be_empty quoted-cr/0002.err
      '
      
      test_done
5:  9e96d4bf5e ! 5:  448daac5b3 mailinfo: allow stripping quoted CR without warning
    @@ mailinfo.h
      struct mailinfo {
     
      ## t/t5100-mailinfo.sh ##
    -@@ t/t5100-mailinfo.sh: test_expect_success 'mailinfo handle CR in base64 encoded email' '
    - 	check_quoted_cr_mail &&
    - 	grep "quoted CR detected" quoted-cr-err &&
    - 	check_quoted_cr_mail --quoted-cr=nowarn &&
    -+	test_must_be_empty quoted-cr-err &&
    -+	sed "s/%%//" "$DATA/quoted-cr-msg" >expect-cr-msg &&
    -+	sed "s/%%//" "$DATA/quoted-cr-patch" >expect-cr-patch &&
    -+	check_quoted_cr_mail --quoted-cr=strip &&
    - 	test_must_be_empty quoted-cr-err
    +@@ t/t5100-mailinfo.sh: test_expect_success 'mailinfo warn CR in base64 encoded email' '
    + 	check_quoted_cr_mail quoted-cr/0001 --quoted-cr=nowarn &&
    + 	test_must_be_empty quoted-cr/0001.err &&
    + 	check_quoted_cr_mail quoted-cr/0002 --quoted-cr=nowarn &&
    ++	test_must_be_empty quoted-cr/0002.err &&
    ++	cp quoted-cr/0001-expected.msg quoted-cr/0002-expected.msg &&
    ++	cp quoted-cr/0001-expected.patch quoted-cr/0002-expected.patch &&
    ++	check_quoted_cr_mail quoted-cr/0001 --quoted-cr=strip &&
    ++	test_must_be_empty quoted-cr/0001.err &&
    ++	check_quoted_cr_mail quoted-cr/0002 --quoted-cr=strip &&
    + 	test_must_be_empty quoted-cr/0002.err
      '
      
6:  d6aa12acc0 ! 6:  e6dbc9d336 am: learn to process quoted lines that ends with CRLF
    @@ t/t4258-am-quoted-cr.sh (new)
     +test_expect_success 'am warn if quoted-cr is found' '
     +	git reset --hard one &&
     +	test_must_fail git am "$DATA/mbox" 2>err &&
    -+	grep "quoted CR detected" err
    ++	grep "quoted CRLF detected" err
     +'
     +
    -+test_expect_success 'am strip if quoted-cr is found' '
    ++test_expect_success 'am --quoted-cr=strip' '
     +	test_might_fail git am --abort &&
     +	git reset --hard one &&
     +	git am --quoted-cr=strip "$DATA/mbox" &&
     +	git diff --exit-code HEAD two
     +'
     +
    -+test_expect_success 'am strip if quoted-cr is found' '
    ++test_expect_success 'am with config mailinfo.quotecr=strip' '
     +	test_might_fail git am --abort &&
     +	git reset --hard one &&
     +	test_config mailinfo.quotedCr strip &&
-- 
2.31.1.448.g9c2f8508d1

