Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBE041F42D
	for <e@80x24.org>; Sun, 20 May 2018 10:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751408AbeETKvF (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 06:51:05 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34554 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751318AbeETKvC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 06:51:02 -0400
Received: by mail-wr0-f196.google.com with SMTP id j1-v6so2271161wrm.1
        for <git@vger.kernel.org>; Sun, 20 May 2018 03:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q6gi05RLicfhhxFQa6ObAp2ouX2siXIbPW1U6MTNaIQ=;
        b=U009vRQ7FGDm51iVLv8nqh6KnAXQFysJEu65SCYO6ZYbPggM3Opqe7iTnGrE/QYy77
         1TRodEkqpv+t+E/2g+XOzaOnDUsShYF+g5H6L/7iuQyu0Gi1sHA1cY+XAk0yU9OJ81tq
         AOAvd3pMnisEyHb+jl2j1gfwvTgVnpXXakeTiV/CxyywXJWCf8RBs9cMVvlFTjumg12Q
         nOLn9sIHqg1WI4DahhYD0sS+ztsyizs5IOe06yhC+eXNZiNcaefg3+N77rk/wKG1tPr7
         YuD+ypqLgSZ+6mA/J20fDUGfvm5ntyL1xHLZxqENAjNoOwvzjdFc31jSKW/YyogqY+U9
         yktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q6gi05RLicfhhxFQa6ObAp2ouX2siXIbPW1U6MTNaIQ=;
        b=kWGPYd8o+0O+oRXK0Tx9HYD3JAL0NDfGjEbWFxcBoL+mdhYTvlk0qkMQVy5i7bL2Va
         EHFytPN7RtfCJwauvRF4t+wE0dfGjUABi7pwD7pvJtuZaSCoGLjlUEmGi0GxsmVDbUqV
         JAKNATGyvjEjtNY5h5Rbn1KSSN4o2TuZf2vOkpsWChNiOBgDNz5rkabhkNp4fTOVNezV
         NyDjAu0TC8miaoYxIpGP62kqYcJ5BlqrKHqwk4LDY0fBj/PwePx1zddh9ne0W7/ZFlVg
         DqEFNENuPOppqHRQJ7uE+xSQ/6SpJmcxOZ/b/4rNh0PlXjxjiD1NC1bjM1ajoZNLf6c5
         2Adg==
X-Gm-Message-State: ALKqPwdy0bRGrZLEMp1y39Wd22dls09dOOLqQDlZIrj0WfbYuLHON6K4
        7YEzljOYoRtHRod39rlkXcQ=
X-Google-Smtp-Source: AB8JxZqPtzRJeJG5yhD5C6YZEN3KQDBIw5/Kq/9M7tdPa12cZtfpGZnV761pCmzJP7jGXT61WOfz3Q==
X-Received: by 2002:adf:80d0:: with SMTP id 74-v6mr3526660wrl.273.1526813460787;
        Sun, 20 May 2018 03:51:00 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id f10-v6sm8733502wmc.0.2018.05.20.03.50.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 May 2018 03:50:59 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] regex: do not call `regfree()` if compilation fails
Date:   Sun, 20 May 2018 12:50:32 +0200
Message-Id: <20180520105032.9464-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.17.0.840.g5d83f92caf
In-Reply-To: <CAPig+cQaJmsJe=E6HdBw0s6eN-qW0OCezBacRcQ+UnJYMbODsw@mail.gmail.com>
References: <CAPig+cQaJmsJe=E6HdBw0s6eN-qW0OCezBacRcQ+UnJYMbODsw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is apparently undefined behavior to call `regfree()` on a regex where
`regcomp()` failed. The language in [1] is a bit muddy, at least to me,
but the clearest hint is this (`preg` is the `regex_t *`):

    Upon successful completion, the regcomp() function shall return 0.
    Otherwise, it shall return an integer value indicating an error as
    described in <regex.h>, and the content of preg is undefined.

Funnily enough, there is also the `regerror()` function which should be
given a pointer to such a "failed" `regex_t` -- the content of which
would supposedly be undefined -- and which may investigate it to come up
with a detailed error message.

In any case, the example in that document shows how `regfree()` is not
called after `regcomp()` fails.

We have quite a few users of this API and most get this right. These
three users do not.

Several implementations can handle this just fine [2] and these code paths
supposedly have not wreaked havoc or we'd have heard about it. (These
are all in code paths where git got bad input and is just about to die
anyway.) But let's just avoid the issue altogether.

[1] http://pubs.opengroup.org/onlinepubs/9699919799/functions/regcomp.html

[2] https://www.redhat.com/archives/libvir-list/2013-September/msg00262.html

Researched-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-byi Martin Ågren <martin.agren@gmail.com>
---

On 14 May 2018 at 05:05, Eric Sunshine <sunshine@sunshineco.com> wrote:
> My research (for instance [1,2]) seems to indicate that it would be
> better to avoid regfree() upon failed regcomp(), even though such a
> situation is handled sanely in some implementations.
>
> [1]: https://www.redhat.com/archives/libvir-list/2013-September/msg00276.html
> [2]: https://www.redhat.com/archives/libvir-list/2013-September/msg00273.html

Thank you for researching this. I think it would make sense to get rid
of the few places we have where we get this wrong (if our understanding
of this being undefined is right).

 diffcore-pickaxe.c | 1 -
 grep.c             | 2 --
 2 files changed, 3 deletions(-)

diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
index 239ce5122b..800a899c86 100644
--- a/diffcore-pickaxe.c
+++ b/diffcore-pickaxe.c
@@ -215,7 +215,6 @@ static void regcomp_or_die(regex_t *regex, const char *needle, int cflags)
 		/* The POSIX.2 people are surely sick */
 		char errbuf[1024];
 		regerror(err, regex, errbuf, 1024);
-		regfree(regex);
 		die("invalid regex: %s", errbuf);
 	}
 }
diff --git a/grep.c b/grep.c
index 65b90c10a3..5e4f3f9a9d 100644
--- a/grep.c
+++ b/grep.c
@@ -636,7 +636,6 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (err) {
 		char errbuf[1024];
 		regerror(err, &p->regexp, errbuf, sizeof(errbuf));
-		regfree(&p->regexp);
 		compile_regexp_failed(p, errbuf);
 	}
 }
@@ -701,7 +700,6 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (err) {
 		char errbuf[1024];
 		regerror(err, &p->regexp, errbuf, 1024);
-		regfree(&p->regexp);
 		compile_regexp_failed(p, errbuf);
 	}
 }
-- 
2.17.0.840.g5d83f92caf

