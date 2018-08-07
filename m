Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D14BC208EB
	for <e@80x24.org>; Tue,  7 Aug 2018 08:22:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732770AbeHGKfT (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Aug 2018 06:35:19 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:44216 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeHGKfS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Aug 2018 06:35:18 -0400
Received: by mail-io0-f195.google.com with SMTP id q19-v6so13300743ioh.11
        for <git@vger.kernel.org>; Tue, 07 Aug 2018 01:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q9OGP1Eu/kRdGEjJtna/NsazqxEMZD16wDl5+ZwH3cc=;
        b=m+s76Oh0bLYg8ONzltUEMFcbBW2DssfWQ9XfFP0YImz6TkI76Sf18osiV5wYuiItdu
         9nTbpnBr/2l+0uxo8Q1ctSubfhL4rOp07Kja8OltDdFiJqr4IRin5+laMz74NRHRT4g/
         ksyvtE8NV5K5RtsZvlraznI+7/ENyMF0lNEGIp3kFxAGcnxcsoOOoPntv7JH+2O+VWbf
         iCpUnX1GOqvC1ACE7B7LS5nvPnNb715+Uzy9immhCfc5PtrgfLuQNQnJDXzCbev+ncS/
         Suv0BwbXBQvdDCx9wCYb7fGyidrsSqH7hWOUhDOZWyJGbexOyoSDz0Yf+5sEJ8IZm0HS
         hfcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=q9OGP1Eu/kRdGEjJtna/NsazqxEMZD16wDl5+ZwH3cc=;
        b=WBQ2GDgRyNhjeqpRfS/t2s9ns+Or4JTArtJF6aJ9bEaiWEeWkeIjvL6nt32TCqbl2v
         EU6TT0e3xySju2CM2Tz0mSXqahKNIYhDLT/Q+92aE4DJ+KLPKPhZir7LEz9FnT43t7GP
         Byg43J4fYCn4shU+/RgRV18TljcBPA6ooLp45BuBf05pbe+bNfOYdNhmFU9Kt4umkqzq
         5iHtLRlS2r+gBaP7EUXyOKWPHUOoR/zlJ5gXsflacvXZf7OxipO6muYh5g83TwrHFxJ+
         iLdtl1pxAUfFAMxyJuu/O1fF4UveUxsB8KzSGze4OnsnY8YWjJnJ4ZvNFvxHitOozn/G
         hsLA==
X-Gm-Message-State: AOUpUlGpxMFuZbAMtJYBHwI7u6EWVjkwPDtJkNpeAPTO0xjW+qCLVbbB
        R3Gy6xX8FANplpZlzwtZAlzqezb4
X-Google-Smtp-Source: AA+uWPxqIxchmUi3BfZSVtRyGKFn7bRJHAeFH2xsMKnU6Ajt45dJXMJfr05lBfRRLpgYXGvIRwwd1g==
X-Received: by 2002:a6b:e816:: with SMTP id f22-v6mr16618451ioh.4.1533630125260;
        Tue, 07 Aug 2018 01:22:05 -0700 (PDT)
Received: from localhost.localdomain (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id e19-v6sm210792ioc.46.2018.08.07.01.22.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 07 Aug 2018 01:22:04 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 5/5] chainlint: add test of pathological case which triggered false positive
Date:   Tue,  7 Aug 2018 04:21:35 -0400
Message-Id: <20180807082135.60913-6-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.758.g1932418f46
In-Reply-To: <20180807082135.60913-1-sunshine@sunshineco.com>
References: <20180711064642.6933-1-sunshine@sunshineco.com>
 <20180807082135.60913-1-sunshine@sunshineco.com>
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
2.18.0.758.g1932418f46

