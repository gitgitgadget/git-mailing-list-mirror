Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73561F516
	for <e@80x24.org>; Tue, 26 Jun 2018 07:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932457AbeFZHdF (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 03:33:05 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33378 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeFZHbA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 03:31:00 -0400
Received: by mail-it0-f68.google.com with SMTP id k17-v6so14530440ita.0
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G2NcJpH7xklZi8ttfFG5C/pik/YVnQgO+VrkJvK5C+8=;
        b=R//rRpMFX5ljDks6/ADjVIrn0n+ONIJSqRF1QONfdN9f4ilUmoKh0pwXQw39+6DMt/
         MS6aCgKUnPQ0V7Cd8GwqdjJA25zFMGexybR1rNHgEgeWeG68e5E3iyFlQJzu8lwtgCKT
         L+RlMTCKQ2VK97EoHMKquLivLkcJ4Y6eb+B5W2tgbXZ0WBSGjsCGpuX2mnJ0HwfKUbBi
         9Mpjx1KkqlHQK17oma0kY8KHxayYQ0Xe1Zk+z6GgY5yvGB5+cRRNWP1B3ikL8+iW0B/G
         GLer5+mMVHNTQ3rLeN7fU0rxrv6tQM6+qMxqUx79jBqh+a8R+iwSONQA1aH+r4W8/sjw
         F5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=G2NcJpH7xklZi8ttfFG5C/pik/YVnQgO+VrkJvK5C+8=;
        b=gXeBp7Mn9ZI0NB4L+tCGJBeDriWlFtJo1SgEi1WI5rzq59yq20ytfkaZfKwzji+9fd
         qpa07+YTEHVXoSNbqcgoCCJZWWvJhziXW33jTuF4F88JsUKgBWhrIUNVY/kaJf+gJxJI
         Y3gUdz8WxZpDG5atYsiZsjqo3YDssvIe2Ozb70p1oJHAJr9uNA24uogOdFRdcV2qKHz0
         3Myle/YjyCiemqSi1deZRJ0EHAdSB6xlQHg0FNa8/9tfWnT+9oYF0v66O5AwFzpxpJ/P
         ez0XB9cp92CdoZXTB2mbRR7gdh2on6fCXXvUTOwTKYrrjxkk5XnpgOZRBOPwN61YRSM7
         qN8A==
X-Gm-Message-State: APt69E0rPR5sg3COnkVAJg2yWcGwLZLAXfOg5nJ5CFMSpmJc+H+Pcxuq
        qUDvKFrDVy7kYa4Fujb8JSzoaw==
X-Google-Smtp-Source: ADUXVKJJNg+0EBPmN86attNiXh3qSi/QSknw0ztZDeFOW9LtJnrodFvfFBNRMaAuRbFamONwwIXlVQ==
X-Received: by 2002:a24:eb17:: with SMTP id h23-v6mr505799itj.17.1529998260072;
        Tue, 26 Jun 2018 00:31:00 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id k20-v6sm471361iok.9.2018.06.26.00.30.58
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 00:30:59 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
        Stefan Beller <sbeller@google.com>,
        Elijah Newren <newren@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 10/29] t9001: fix broken "invoke hook" test
Date:   Tue, 26 Jun 2018 03:29:42 -0400
Message-Id: <20180626073001.6555-11-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.419.gfe4b301394
In-Reply-To: <20180626073001.6555-1-sunshine@sunshineco.com>
References: <20180626073001.6555-1-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This test has been dysfunctional since it was added by 6489660b4b
(send-email: support validate hook, 2017-05-12), however, the problem
went unnoticed due to a broken &&-chain late in the test.

The test wants to verify that a non-zero exit code from the
'sendemail-validate' hook causes git-send-email to abort with a
particular error message. A command which is expected to fail should be
run with 'test_must_fail', however, the tests neglects to do so.

Fix this problem, as well as the broken &&-chain behind which the
problem hid.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/t9001-send-email.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index e80eacbb1b..776769fe0d 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -1966,11 +1966,11 @@ test_expect_success $PREREQ 'invoke hook' '
 
 		# Verify error message when a patch is rejected by the hook
 		sed -e "s/add master/x/" ../0001-add-master.patch >../another.patch &&
-		git send-email \
+		test_must_fail git send-email \
 			--from="Example <nobody@example.com>" \
 			--to=nobody@example.com \
 			--smtp-server="$(pwd)/../fake.sendmail" \
-			../another.patch 2>err
+			../another.patch 2>err &&
 		test_i18ngrep "rejected by sendemail-validate hook" err
 	)
 '
-- 
2.18.0.419.gfe4b301394

