Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 999601FD99
	for <e@80x24.org>; Mon, 29 Aug 2016 17:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755616AbcH2RzQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:55:16 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33808 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755381AbcH2RzP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:55:15 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so10529459wma.1
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Apcv1ZQsrf+LAdyq020qkHYIPWq9e3gKoBtGbyRhQac=;
        b=Sevd8qDeYxeMNjo3XdFKWOMNgVNPK8QvRt/d1WbbrA17ANIJ9wX3vm+diD4aDNmxYZ
         Fi+QF9pDX4r6/oPIyJxstqTg1sVIk+doT87eGQ6IN7P57V27CgBwe6IT3xqgglgvxmas
         ipvyQycLTrFNJPendqpD3wJt5waUR3/2ILbOIMQFpkqWgrKncyVZWE/ZSrfJNHJPrrHi
         ilzMWkmcvJ80RKZW+ZYrGqPE63ziJRUB7SBfm9HQGu0grVVMjI1NywAwnTE9E0cLXgFm
         ekLyycnMiG37GHimU2eGCNxYsjGjleoOIMQEXxhdEBBsnYTjYsd54BSoCD5Z0465nF4r
         4qjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Apcv1ZQsrf+LAdyq020qkHYIPWq9e3gKoBtGbyRhQac=;
        b=FCS/EQr4JuXQu6LF1PgCrG+eYYAhWrLuXQfEhwtSXCOxNx05YgMU64CgqCqGnDO+Lo
         dEadzVIZd4M44CjynzJjr9ZFmjaIBLXJS9mBkMlcYh4xI8Zrz96flmAZjFqzpPPSYDCN
         vMJY5PPmzxYjiJhIMcpMnf2h0qYCCbVkKAEFdCs47cLqZ51K3YnD94C5K1l46ZZ2n74z
         IlPA9XOb+9TpF95RudkrLVjGapDZ0436eqh8V0DGnM5INp2qFAbAHqKnjsALvCPxQcpw
         narBtg5KIyaOYS3Bp+w8sEyVsUjGF58wU7cN3WQvRLV6CYd0zYpFOlMjlVgtKOhVb3J8
         HU7Q==
X-Gm-Message-State: AE9vXwPtM6ZrJxUJt2AU6EjOxYtYrfl5wMivFQkLrPfj28mE3hY39xYFpXy7KcWPPobo4Q==
X-Received: by 10.194.240.196 with SMTP id wc4mr15887964wjc.25.1472493313991;
        Mon, 29 Aug 2016 10:55:13 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id h7sm35466064wjd.17.2016.08.29.10.55.11
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 10:55:13 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     sbeller@google.com, Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v1] pack-protocol: fix maximum pkt-line size
Date:   Mon, 29 Aug 2016 19:55:09 +0200
Message-Id: <20160829175509.69050-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.9.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

According to LARGE_PACKET_MAX in pkt-line.h the maximal length of a
pkt-line packet is 65520 bytes. The pkt-line header takes 4 bytes and
therefore the pkt-line data component must not exceed 65516 bytes.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---

This patch was part of my "Git filter protocol" series [1]. Stefan
suggested to submit this patch individually as it is not strictly
required in the series [2].

Thanks,
Lars


[1] http://public-inbox.org/git/20160825110752.31581-1-larsxschneider@gmail.com/
[2] http://public-inbox.org/git/CAGZ79kaJn-yf28+Ls2JyqSs6Jt-Oj2JW-sAXQn-Oe5xaxSyjMQ@mail.gmail.com/


 Documentation/technical/protocol-common.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/technical/protocol-common.txt b/Documentation/technical/protocol-common.txt
index bf30167..ecedb34 100644
--- a/Documentation/technical/protocol-common.txt
+++ b/Documentation/technical/protocol-common.txt
@@ -67,9 +67,9 @@ with non-binary data the same whether or not they contain the trailing
 LF (stripping the LF if present, and not complaining when it is
 missing).

-The maximum length of a pkt-line's data component is 65520 bytes.
-Implementations MUST NOT send pkt-line whose length exceeds 65524
-(65520 bytes of payload + 4 bytes of length data).
+The maximum length of a pkt-line's data component is 65516 bytes.
+Implementations MUST NOT send pkt-line whose length exceeds 65520
+(65516 bytes of payload + 4 bytes of length data).

 Implementations SHOULD NOT send an empty pkt-line ("0004").

--
2.9.2

