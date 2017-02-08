Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3E41FC46
	for <e@80x24.org>; Wed,  8 Feb 2017 05:13:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753481AbdBHFNg (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 00:13:36 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33856 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753473AbdBHFNe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 00:13:34 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so14070862pgv.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2017 21:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=HK8UWgJGsSCV53PFyijNyo/ql5t5APsbmNGAt124nFI=;
        b=qv2mfdUfv0NPtqoKNTuM3B0no0bS9p8T9FzgGGK31MtngfvJ3srKbwbjUgKIXC/Uj0
         2+SuW7Jgl0gH+ns26v/6RtgiqiKxWMF8zgKajUlczYGUwm20J0pIs5uTKh32+7oz499J
         NMhjI1oOFbKyAGEWZ2/a426HlXSL+FtpUT7OyVv7hXf0DuIpW26nPtR9ukzMenLwG/Fm
         LIW1T+aIyHWGmXRpevli5K8MZ3/tN1XrzLUnPiaWC/YnxFY+Q/b5bni3KooX+VpGFe+S
         ZwBZbYnw7zGjsHXB6wxckfKGeeEseY5n/Oo8eVUlAWmPODZPWX/3k/7qTqbxO0/YrWXC
         NdKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=HK8UWgJGsSCV53PFyijNyo/ql5t5APsbmNGAt124nFI=;
        b=doOWgGayzCTY5TcZo53qXHMs1f1ay700mRE6jselM20UaGv/yz0xhPw0Re9ows7oQX
         I6JghssiDD+14BbLJxJ9vYS6ToT9TulhWu4Tv4e3Vcl6k2sqHpiLEKxOLa5JE0q85Iqc
         8gj8ilT+oAVhOJW4crZdSjXIqqgyKfao6aCv/RgFIw1yjbNLYubeSOI5j1zU3S00N/8E
         DZI9Wjwovc7EPwDwjzcOc6NcrLpoTyK4OpNdTXABohxGbtZ4zMis4mp65OnTGgh8LJKd
         kEQDRTMXkiRrcgEzHRlhQlMC4yHnYrTfF9CZXKiISIM0vcmIRdrlrFOy14skR/eibmd4
         9TLA==
X-Gm-Message-State: AIkVDXJVLFi6DQ23HnBBvhvXy6fh1/HJRhmsxLzuZqoaDBD4LLSxiQxhHJuga/QaOJPH8Q==
X-Received: by 10.84.138.165 with SMTP id 34mr31215368plp.37.1486530813902;
        Tue, 07 Feb 2017 21:13:33 -0800 (PST)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id 18sm15751516pgf.28.2017.02.07.21.13.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Feb 2017 21:13:33 -0800 (PST)
Date:   Tue, 7 Feb 2017 21:13:32 -0800 (PST)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/2] pathspec magic: add '^' as alias for '!'
Message-ID: <alpine.LFD.2.20.1702072113040.25002@i7.lan>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 7 Feb 2017 21:05:28 -0800
Subject: [PATCH 1/2] pathspec magic: add '^' as alias for '!'

The choice of '!' for a negative pathspec ends up not only not matching
what we do for revisions, it's also a horrible character for shell
expansion since it needs quoting.

So add '^' as an alternative alias for an excluding pathspec entry.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 pathspec.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/pathspec.c b/pathspec.c
index 7ababb315..ecad03406 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -224,6 +224,12 @@ static const char *parse_short_magic(unsigned *magic, const char *elem)
 		char ch = *pos;
 		int i;
 
+		/* Special case alias for '!' */
+		if (ch == '^') {
+			*magic |= PATHSPEC_EXCLUDE;
+			continue;
+		}
+
 		if (!is_pathspec_magic(ch))
 			break;
 
-- 
2.12.0.rc0.1.g02555c1b2.dirty

