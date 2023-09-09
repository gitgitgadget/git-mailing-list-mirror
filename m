Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9435FEE14C3
	for <git@archiver.kernel.org>; Sat,  9 Sep 2023 23:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345123AbjIIXKA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 9 Sep 2023 19:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240174AbjIIXKA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Sep 2023 19:10:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC67E19F
        for <git@vger.kernel.org>; Sat,  9 Sep 2023 16:09:55 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-402d499580dso34718695e9.1
        for <git@vger.kernel.org>; Sat, 09 Sep 2023 16:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694300994; x=1694905794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ur3M1xYXb0l7OnJEv5IJt9YjDawIz60kKYahgPHj/x4=;
        b=eHd8b/x5OyhCxf/E3Zal/ikD/A2vJi8B0pN5T/jgp2Pc9mokgF+i9yW/LQjgIR0OsS
         dKZROmaKbzXxko7cDHFOCk7vRoA2Wt6iq4ZehLI5J+NdKPzQx4fXVCOWDhtQbVwXeo5w
         e6cxwrvoF1PYRqIndcT6TzUQfk+2Sza0Uzg+euI3P2gBCOTIwNsgTv1aaVupgUlX0MqH
         B252nUI/Jk9i3YYWMPzsLcYQ1jUwAijCQBVoVluzLq63H6vnNvJKKqpCOQW9HLUdRI4P
         kfwt+iU9OyctBrPVu+6s4pZpRD0hJrd+Aw0zu4S41QbIT5LRfQAD2YXbRt20Ryhl98UZ
         b4Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694300994; x=1694905794;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ur3M1xYXb0l7OnJEv5IJt9YjDawIz60kKYahgPHj/x4=;
        b=pk2vWVeiAH6zBZQq+uuBgkPqMW4mXSWkjJkH8FiH+vAJAItTeh1PGHiseC89dijLxR
         cREEnqVYFW0JZV0m3VzW7waVqQWzkqugIzHtTtOCOk7UdxX4+lkVAeoLOkR7vXdK0cWZ
         Gv1J3Rw8kYt8eYFi5iyb/YKiGqOUAQ6rA/gLdW5aQ/+CWFDaj7OxA6kKysh8mju6kqPH
         JLVv79f5XvAtZaQpMZQDU/6hCt5aS5lGG7dJvAgFc5uzqxsDcpts/+ONJvnDjDhrkCOm
         8yzArN83KGaPWcKrc+BsS80X4HLFzinsqtH+hTAvypAqcJ9qTLroQTSicnvadL66gqzm
         zXiw==
X-Gm-Message-State: AOJu0YxK8vkdpHdLEMtTM0WmCtg/uTJX+hgOPIu94q63pBj6/xuEzEy1
        HyZWiHItwU14R4mcpAybbhudeQR7u4g=
X-Google-Smtp-Source: AGHT+IFZ4mXxDZgwLzLye3+L7mIcAWZDKIVSu4RsN0yhr4XhdmiLyToRVffq1gx3yUhvgtNYzlG+tw==
X-Received: by 2002:a1c:7c08:0:b0:402:ba85:3e3a with SMTP id x8-20020a1c7c08000000b00402ba853e3amr4919949wmc.19.1694300994091;
        Sat, 09 Sep 2023 16:09:54 -0700 (PDT)
Received: from [192.168.2.52] (16.red-88-14-199.dynamicip.rima-tde.net. [88.14.199.16])
        by smtp.gmail.com with ESMTPSA id o1-20020a5d6841000000b003143b14848dsm5816790wrw.102.2023.09.09.16.09.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Sep 2023 16:09:53 -0700 (PDT)
Subject: [PATCH 2/2] test-lib: fix GIT_TEST_SANITIZE_LEAK_LOG
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
References: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
Message-ID: <64825651-00d2-d2c5-2da2-91a9917bef21@gmail.com>
Date:   Sun, 10 Sep 2023 01:09:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <68522960-edda-26d3-ddca-cee63f2d859e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GIT_TEST_SANITIZE_LEAK_LOG=true with a test that leaks, will make the
test return zero unintentionally:

  $ git checkout v2.40.1
  $ make SANITIZE=leak
  $ make -C t GIT_TEST_SANITIZE_LEAK_LOG=true t3200-branch.sh
  ...
  With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!
  # faked up failures as TODO & now exiting with 0 due to --invert-exit-code

Let's use invert_exit_code only if needed.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 t/test-lib.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 88a34fba67..87cfea9e9a 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1263,7 +1263,8 @@ check_test_results_san_file_ () {
 	then
 		say "As TEST_PASSES_SANITIZE_LEAK=true isn't set the above leak is 'ok' with GIT_TEST_PASSING_SANITIZE_LEAK=check" &&
 		invert_exit_code=t
-	else
+	elif test "$test_failure" = 0
+	then
 		say "With GIT_TEST_SANITIZE_LEAK_LOG=true our logs revealed a memory leak, exit non-zero!" &&
 		invert_exit_code=t
 	fi
-- 
2.40.1

