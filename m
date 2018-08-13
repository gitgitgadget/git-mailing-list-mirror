Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 127331F404
	for <e@80x24.org>; Mon, 13 Aug 2018 08:48:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbeHML3h (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 07:29:37 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:38732 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbeHML3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 07:29:36 -0400
Received: by mail-it0-f68.google.com with SMTP id v71-v6so12647788itb.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 01:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NGzYUl5evWKnM46sukqrmX2CstR2sl8gW11TCTHHiLU=;
        b=BoGDM0No2u+A7SY8jgPYnE1nP0yDmEI4g47XQTdVuz+R1s0urHZWpJjfHT5ClDJ/2h
         kk9mf8mE5HiOnvdherwssTj6msK9nVExecQmUT5L/obu8Q+ygRCD+1P5Va5DWFaFzstt
         5/gUPOB9USYqXknugDr9JnrBBfGWbtn5RyACFmiyti8tUM27F6VKo+YSYptAwW6mMIGe
         VQuUZc3ui9Klf0luHCWNhxp/w3CObWUJXx7tRnrTD/UBMGz+HOiGPBV+cMC2Iiaz77Hi
         AyrriJRhYoLqtx4CKtayMkp6aDXJi8LDxLrlWPbFpDBmtsy30nJJ/GeAG23/6VtaxnOf
         ATdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=NGzYUl5evWKnM46sukqrmX2CstR2sl8gW11TCTHHiLU=;
        b=Wq3uXHamcsxXTQ3xbsf/fFL8CsWJ0O/HSfhEBOFGQ7F+F2ETdgvB5FlysnWlgnLFPM
         Sr82zhqLYUZQJeGYeMLBRQ0X+E6tejg2DvVr5Sm/5c0DGGbhNpEBcFgNI8G7OZn/tWlx
         m69kZuFCjU6gUUA6EuEICwcnxRBz45jUMd4DhdiGyrRm6arjeOZYvSpCCJ1ikEd5jVKq
         K+uhqNBmW4lkcNZ/i5TsGmhuBGKWwtNbx+VgvpCaFF3cKne3+On1LyAlYSGmjiZg4XeX
         sAdeYKmrz1aYroyBxgfj3m7dR+/MIIgT+uKV3e7z+QUfRltLUeR1y0rVu9nYbgNJbo7Q
         CD7g==
X-Gm-Message-State: AOUpUlFJy96tq2rSnEfvPJ4lGkRXEmzxrHBKVr+x3PAYT6Mdc3DMYRD9
        nTrMeIC8uOckmv9queHjp3KehO7+
X-Google-Smtp-Source: AA+uWPz608HFPbmVBGqupPYhTylQJtUW0soSsUANWAIImBcunEFUpBoFhND80RaqhLE6vgovzRcdSg==
X-Received: by 2002:a24:ac44:: with SMTP id m4-v6mr9883133iti.90.1534150099940;
        Mon, 13 Aug 2018 01:48:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id g23-v6sm5609405iob.88.2018.08.13.01.48.18
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 13 Aug 2018 01:48:19 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 6/6] chainlint: add test of pathological case which triggered false positive
Date:   Mon, 13 Aug 2018 04:47:39 -0400
Message-Id: <20180813084739.16134-7-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180813084739.16134-1-sunshine@sunshineco.com>
References: <20180807082135.60913-1-sunshine@sunshineco.com>
 <20180813084739.16134-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This extract from contrib/subtree/t7900 triggered a false positive due
to three chainlint limitations:

* recognizing only a "blessed" set of here-doc tag names in a subshell
  ("EOF", "EOT", "INPUT_END"), of which "TXT" is not a member

* inability to recognize multi-line $(...) when the first statement of
  the body is cuddled with the opening "$("

* inability to recognize multiple constructs on a single line, such as
  opening a multi-line $(...) and starting a here-doc

Now that all of these shortcomings have been addressed, turn this rather
pathological bit of shell coding into a chainlint test case.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/t7900-subtree.expect | 10 ++++++++++
 t/chainlint/t7900-subtree.test   | 22 ++++++++++++++++++++++
 2 files changed, 32 insertions(+)
 create mode 100644 t/chainlint/t7900-subtree.expect
 create mode 100644 t/chainlint/t7900-subtree.test

diff --git a/t/chainlint/t7900-subtree.expect b/t/chainlint/t7900-subtree.expect
new file mode 100644
index 0000000000..c9913429e6
--- /dev/null
+++ b/t/chainlint/t7900-subtree.expect
@@ -0,0 +1,10 @@
+(
+	chks="sub1sub2sub3sub4" &&
+	chks_sub=$(cat | sed 's,^,sub dir/,'
+>>) &&
+	chkms="main-sub1main-sub2main-sub3main-sub4" &&
+	chkms_sub=$(cat | sed 's,^,sub dir/,'
+>>) &&
+	subfiles=$(git ls-files) &&
+	check_equal "$subfiles" "$chkms$chks"
+>)
diff --git a/t/chainlint/t7900-subtree.test b/t/chainlint/t7900-subtree.test
new file mode 100644
index 0000000000..277d8358df
--- /dev/null
+++ b/t/chainlint/t7900-subtree.test
@@ -0,0 +1,22 @@
+(
+	chks="sub1
+sub2
+sub3
+sub4" &&
+	chks_sub=$(cat <<TXT | sed 's,^,sub dir/,'
+$chks
+TXT
+) &&
+	chkms="main-sub1
+main-sub2
+main-sub3
+main-sub4" &&
+	chkms_sub=$(cat <<TXT | sed 's,^,sub dir/,'
+$chkms
+TXT
+) &&
+
+	subfiles=$(git ls-files) &&
+	check_equal "$subfiles" "$chkms
+$chks"
+)
-- 
2.18.0.267.gbc8be36ecb

