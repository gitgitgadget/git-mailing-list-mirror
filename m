Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F03BDC636D7
	for <git@archiver.kernel.org>; Tue, 21 Feb 2023 21:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBUV3J (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Feb 2023 16:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjBUV3H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2023 16:29:07 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02FE7EC8
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:28:38 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id nt5-20020a17090b248500b00237161e33f4so4260355pjb.4
        for <git@vger.kernel.org>; Tue, 21 Feb 2023 13:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HH/jpK/g8oeT3Refx0R0FvO4O4cMJaeZp+iEkUswa5A=;
        b=prxbVva4YavrLmsMUJ/uaChjWwYXmQRrU9RFlyCJM0Lk9qpM6X4/QW8RlKdzl3BW+U
         SWJNwGOtJJD96bvzYFQjLa1xyZmYHcleI6Bj21LBe1LbVxQ9x0BmbMTMcPWKp6pTccMN
         5cY1y+VLXpyUvBqFjZ9o3kLtOOicI41mCnlsZilD/aXTHtQddzA7bhgXGjVZGfdp2Uf5
         FxvyE9bWDkSW1MEgLUDp7rOshE7Rwlf6tWqj8FY4Mru9Uogluvow1xB4jBrjZXJBYqlX
         6jThyorL8YwLbtG/PXmKg6VW6UPpKPHXQdRYw6EigdbSyQF+eXSGGO3plTKvCQIpZq0/
         GMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HH/jpK/g8oeT3Refx0R0FvO4O4cMJaeZp+iEkUswa5A=;
        b=xnMkdyre3sGJOfLtUDHH0s9r5iao7fGfPJ44UZG+AGZF9lI3ilzcojaslGvcsv3Dva
         x2JkyoiE1O9s/j1kasv2IPNBn5SEP0CEZAYlC/shRbEuf2dAh5et17AHFMPuFn5CTAVn
         vzGxpvLvYILZL6qqsm3Cha4voXj3WkPVvCdJ6DP2owUcJhL/F9HL5fbvBrvMhg7UkjFL
         RUDnwOpe9jbBf3NJMo4anp1ls92ITgiLDJI6VJnzQlRxdhSylBRG+aNc9rmHEFRh96yq
         iDCuYEUO+dpukPnkhAPo0VSHYsuX5T/4xPPVhnFiPNdkvKGJ4xkHJoa/j74b7hZp0+f+
         cgjg==
X-Gm-Message-State: AO0yUKW4H3PQsJ+tHmxjDm1WkKEG7Z2Gb4iM5ugZkyYp4Td5DjbILsSC
        qMZQCc2nEnIEH8UrUvCbkDK+1q1o7GD9Ug==
X-Google-Smtp-Source: AK7set8DszkM5S1jI4/VzNcYdNNRn0SJ5fqDqSTQ+aDyQcPZb6rQJZbh2X6RydojiEu2ZbnZdQNVEg==
X-Received: by 2002:a05:6a20:430e:b0:bf:d67e:5517 with SMTP id h14-20020a056a20430e00b000bfd67e5517mr6364515pzk.42.1677014915492;
        Tue, 21 Feb 2023 13:28:35 -0800 (PST)
Received: from Vivans-MBP.lan (node-1w7jr9y92i5dg56d59ey2wgev.ipv6.telus.net. [2001:56a:740f:7b00:548b:6839:29d0:4517])
        by smtp.gmail.com with ESMTPSA id n24-20020aa79058000000b00592591d1634sm3637086pfo.97.2023.02.21.13.28.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 21 Feb 2023 13:28:35 -0800 (PST)
From:   Vivan Garg <gvivan6@gmail.com>
To:     git@vger.kernel.org, vdye@github.com
Cc:     christian.couder@gmail.com, hariom18599@gmail.com,
        Vivan Garg <gvivan6@gmail.com>
Subject: [GSOC][PATCH v2 0/1] t4121: modernize test style
Date:   Tue, 21 Feb 2023 14:27:52 -0700
Message-Id: <20230221212753.85371-1-gvivan6@gmail.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <xmqq8rgqeplt.fsf@gitster.g>
References: <xmqq8rgqeplt.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Edited the commit message to add what the commit does and added a period at the end of the sentence.

Added a space after the closing bracket in the second test.

Vivan Garg (1):
  t4121: modernize test style

 t/t4121-apply-diffs.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

Range-diff against v1:
1:  61f1ed51f4 ! 1:  77fded7759 t4121: modernize test style
    @@ Commit message
     
         Test scripts in file t4121-apply-diffs.sh are written in old style,
         where the test_expect_success command and test title are written on
    -    separate lines
    +    separate lines, therefore update the tests to adhere to the new
    +    style.
     
         Signed-off-by: Vivan Garg <gvivan6@gmail.com>
     
    @@ t/t4121-apply-diffs.sh: test_expect_success 'setup' \
     -	'check if contextually independent diffs for the same file apply' \
     -	'( git diff test~2 test~1 && git diff test~1 test~0 )| git apply'
     +test_expect_success 'check if contextually independent diffs for the same file apply' '
    -+	( git diff test~2 test~1 && git diff test~1 test~0 )| git apply
    ++	( git diff test~2 test~1 && git diff test~1 test~0 ) | git apply
     +'
      
      test_done
-- 
2.37.0 (Apple Git-136)

