Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED,WEIRD_PORT shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1915321841
	for <e@80x24.org>; Tue,  1 May 2018 06:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751109AbeEAGkY (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 02:40:24 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:40150 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbeEAGkX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 02:40:23 -0400
Received: by mail-pg0-f54.google.com with SMTP id l2-v6so7842229pgc.7
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 23:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kojima-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WviDpFeRuzZJTUFuxAgiRrx86S0eVORr6ErWBqDKe5Q=;
        b=TT7ErkJbdlMtSDbyMP365V9vJHxHbyI/yMkWNa8nND6G6df+Uvvd5qXKasf89Z4E13
         5txb1cp1j0ZufEN4/99ZaOdf5ENgeqWW7K/ZKctiiv9Fm7xpeDpmwmX38NwYVnjjU7tx
         mH57EkLq7gwZNEXuRFlWO2sCw8sOZBA+MEOpoL0f1eKlILWPTg1ULwQ0t0hT41ZLwFRT
         j8YU4gL/UyUtbn3AUwbOCyAZ1OnxZ9VYRLxnOBH8d05BMe8mi6vKXxuFSEmdQ6TNcoQ4
         ye82XtOUzhIGQ6c3lWH256FVjroY82xqHbKu4GRkg5TkdN2BC3pyKW4iVnjEN1ReMHo0
         6VUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WviDpFeRuzZJTUFuxAgiRrx86S0eVORr6ErWBqDKe5Q=;
        b=YNsrhxvlfti1vOi7wSNHKFHz4fUY3NrmbBi6NLYygaTVmy3a8tDCziZlDvfshhiwka
         9HYnB8Z+Q7D5b1TNTRrFP5lBnOGFTM6uGNu1rgLOwHgcot8YNN0mHcA7sa5z9RoOU99t
         HT80TWMFkg8Br0pCDQypdXCOgu8gE8QRcAYhMtUvMy+WY5c/pQkqCllNZHl3f+GZxv0x
         LQfMCsWmhYr3UTzZkYVsuKNNmxiSmdqJq7oUrOo4/yyDH+IhTurQ6XqYTV2WL1zsQWgQ
         +tQ7L8Ypo08EGzWfRkesRxo08ImcxijiuKi2pMPG9WR45E5XtZz/o67Qw+DPGmD1hqAu
         K5oQ==
X-Gm-Message-State: ALQs6tAWxdfuXpDLwNe/AiTSSSqONjOgFQRXr3LY+OWGE5RwIi5wGD7X
        edDc9BoaS+fHDlNKP6OsdBvBqnTGcVQ=
X-Google-Smtp-Source: AB8JxZpztfLDJLH9IDIISKC/wAGe8co5tWF0vc+Yks5QB851BQDuXtxCkiCbNdDaGzhson347JqxNg==
X-Received: by 2002:a17:902:a70b:: with SMTP id w11-v6mr14969917plq.342.1525156822697;
        Mon, 30 Apr 2018 23:40:22 -0700 (PDT)
Received: from localhost.localdomain (momo.interlink.or.jp. [203.141.128.59])
        by smtp.gmail.com with ESMTPSA id q76sm18597029pfi.139.2018.04.30.23.40.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Apr 2018 23:40:21 -0700 (PDT)
From:   Shin Kojima <shin@kojima.org>
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Shin Kojima <shin@kojima.org>
Subject: [PATCH] gitweb: Measure offsets against UTF-8 flagged string
Date:   Tue,  1 May 2018 15:40:15 +0900
Message-Id: <20180501064015.59977-1-shin@kojima.org>
X-Mailer: git-send-email 2.17.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Offset positions should not be counted by byte length, but by actual
character length.

>    5183 	# We need to untabify lines before split()'ing them;
>    5184 	# otherwise offsets would be invalid.

Horizontal tab is not the only case we need to consider.  Please excuse
me for using your name here, but the following URL can not find "match"
occurances while using `git-instaweb` on the git repository.

    http://127.0.0.1:1234/?p=.git&a=search&h=HEAD&st=grep&s=Nar%C4%99bski

Signed-off-by: Shin Kojima <shin@kojima.org>
---
 gitweb/gitweb.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2594a4bad..a5a9093a1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1697,7 +1697,7 @@ sub unquote {
 
 # escape tabs (convert tabs to spaces)
 sub untabify {
-	my $line = shift;
+	my $line = to_utf8(shift);
 
 	while ((my $pos = index($line, "\t")) != -1) {
 		if (my $count = (8 - ($pos % 8))) {
-- 
2.17.0

