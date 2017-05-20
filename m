Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C096A2023D
	for <e@80x24.org>; Sat, 20 May 2017 05:47:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756578AbdETFrm (ORCPT <rfc822;e@80x24.org>);
        Sat, 20 May 2017 01:47:42 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34234 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751910AbdETFrk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 May 2017 01:47:40 -0400
Received: by mail-pf0-f194.google.com with SMTP id w69so11556420pfk.1
        for <git@vger.kernel.org>; Fri, 19 May 2017 22:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UoWZ2Z2JMK6dk3fV7VLx0CFO9qV1anh6vXScutuyHh8=;
        b=QD8Y47sEBj1gtXsLeq9Z3gNcp1SOaKv/uSgFJS7z/sUdmIZWzcm1IA/Sd94IsqmKHR
         m6JkQYLqZvKr9jJb7MH07tXB9f6li7FYPUarsbwHL8O4vrKGEIjt0aHNU5jFpzX+CVHV
         aAQnTkQ2rytVskTN6hvmz/A7ddYiEfkBXvLIsw1T44wYwzMW3vF6vvJvClbOAsJ1031z
         otjsW0dqLlzYyujuqRyKXotE1y521G66HdR418H+AErKFNC+Ry+H1GD6Ho0XAwTgnz37
         YIb/j3M1Nnt3k12tnEdKLd9QPS1Viqovl/4xeOoZj88IMFMAODeVwCwGseTl+fjeTlyy
         /i0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UoWZ2Z2JMK6dk3fV7VLx0CFO9qV1anh6vXScutuyHh8=;
        b=JpkQaDxkDHhWQaVeyt7u9JW6az1I+I+YEtMKiff2+WAPQeNbNLyzvbrbGQVEd1QRGj
         TZK5YgpJuAl0ltmiiB0T1XRNCDwdq6PDJhkU204u28rq9pAc9Am+/HyyKiSDPQZuzMZY
         Fx0fQ6JVRYbWseUHyMs9E5/zQF9EckuRUvf/h8+tIAsCLhBvBHco+bN41TDJwu9/pMLs
         SJ74kqpeHHwS0kzxabqc8fKNS8KQYO7/a71j22ithzLNvIML6zyPHS0/4CNGZL+9prJ1
         tHwhL6xpH+6wRnsxbbyANr+tu+Unbp/90J4yTaY2L2R9cp6dg0OVyq5r2l3gmICCerpi
         wK2Q==
X-Gm-Message-State: AODbwcCZm9Plm9P6ANJtqdA76CYuyICfI6MvcrznhXLKBOkz/Wf7Gg6C
        Rho7LR+F6kIsNw==
X-Received: by 10.98.3.133 with SMTP id 127mr14164163pfd.172.1495259259991;
        Fri, 19 May 2017 22:47:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:4027:806a:d2b9:807c])
        by smtp.gmail.com with ESMTPSA id v45sm21066957pgn.56.2017.05.19.22.47.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 19 May 2017 22:47:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] name-rev: change a "long" variable to timestamp_t
References: <cover.1493042239.git.johannes.schindelin@gmx.de>
        <cover.1493234408.git.johannes.schindelin@gmx.de>
        <5a17f0ed846b1b894ac023bc8694b6f5c428ff15.1493234408.git.johannes.schindelin@gmx.de>
Date:   Sat, 20 May 2017 14:47:37 +0900
In-Reply-To: <5a17f0ed846b1b894ac023bc8694b6f5c428ff15.1493234408.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 26 Apr 2017 21:29:31 +0200
        (CEST)")
Message-ID: <xmqqa868t6yu.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier dddbad72 ("timestamp_t: a new data type for timestamps",
2017-04-26) updated all in-core variables, fields and function
return values that are used to store "seconds since epoch" to a new
type timestamp_t.  Unfortunately one variable "cutoff", which is
used to keep track of the oldest timestamp of commit we saw on the
command line, was "long", and left behind.

Update it to timestamp_t as well.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Noticed while merging the topic 'mg/name-rev-debug' to 'pu'.

 builtin/name-rev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 4437475017..1f6fcae121 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -15,7 +15,7 @@ typedef struct rev_name {
 	int distance;
 } rev_name;
 
-static long cutoff = LONG_MAX;
+static timestamp_t cutoff = TIME_MAX;
 
 /* How many generations are maximally preferred over _one_ merge traversal? */
 #define MERGE_TRAVERSAL_WEIGHT 65535
-- 
2.13.0-439-gd4feae47b3

