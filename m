Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2868D1F42D
	for <e@80x24.org>; Sat, 26 May 2018 21:49:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032424AbeEZVtd (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 May 2018 17:49:33 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40772 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032388AbeEZVtd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 May 2018 17:49:33 -0400
Received: by mail-pg0-f68.google.com with SMTP id l2-v6so3702372pgc.7
        for <git@vger.kernel.org>; Sat, 26 May 2018 14:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=f3MXKOGMfmWWlDclxART2pG99TaWbShRYkAEskTnCDU=;
        b=alOoBdTIw2O4FboEd7ah3HncUjj6YM191woiuJoeRLpiPmhRy+owf1mw1VXSxg7qqj
         U5bfmYUiSprdaMHvm3g+hdUexPRAX3ylwekJKOS+a7nOAHPZVY4aMBoACioxJMHUfHyb
         5z4Yafv/nH/2/gpOTnwumnzSl7ei95EHl/L3ogWlLXmfsDQDzFpHBirFMgqLWa41xmkp
         TAV2zrRY0eMveh8IbAsqAo5Q1FV0+j/McY1+WU6Irqlz3KobZfv44X+wNbP0GBy+FVK9
         twqQQ8v9x5Qceu6GNrXsVBxdw52Ddz5NV/KnospS3AkBM7GLsnEs5LEo1tKwDbHZgdRb
         CGcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :user-agent:mime-version;
        bh=f3MXKOGMfmWWlDclxART2pG99TaWbShRYkAEskTnCDU=;
        b=WCg0hniEfAO0EgZPJ05joDfcXqY4laEHRVjWIb8maWlPVLpFizkzi5pxbutgAeSpL/
         oDRK8eqnxkgNp6r92DMweLG2PJ2HmwehHyXxjanJOAIbjhkn50xjdlGY80bm8AHwD+m8
         8hrdrW05yfKPrPZyKGZ36nVYuMNwjEWJScYdvsKqacSWEgp33ie9bsoTkvubOK6nFYkv
         RTM6KaNJdJGHQNKw7UMAygkSRVNLguLIralR8eP1SXgQCAyiZzRbijtX0w3YUA8Y81RB
         582My0IqVu2Y1/Antq66z02L8UZQDU+4kkcFzzRzU3Bahtgjit4SwM7EdYgrA93oBUTU
         mg6g==
X-Gm-Message-State: ALKqPwdfKmx/FcEN/nZN8i1jn+bTUlzN0SFzdAgDSXGl7L6Llsbk7TzF
        wNuX9O/h21liAi4Ad6SBYKw=
X-Google-Smtp-Source: AB8JxZpmcAwqeID10ktNoNfiAXyK6inFqXGGh+/fXmdwTvG6G+QG9Zw1mq5zJw6Hhr4UvMpatmTeTQ==
X-Received: by 2002:a65:5003:: with SMTP id f3-v6mr4542812pgo.425.1527371371916;
        Sat, 26 May 2018 14:49:31 -0700 (PDT)
Received: from i7.lan (c-73-11-52-149.hsd1.or.comcast.net. [73.11.52.149])
        by smtp.gmail.com with ESMTPSA id 185-v6sm48172086pfu.13.2018.05.26.14.49.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 May 2018 14:49:31 -0700 (PDT)
Date:   Sat, 26 May 2018 14:49:25 -0700 (PDT)
From:   Linus Torvalds <torvalds@linux-foundation.org>
X-X-Sender: torvalds@i7.lan
To:     Junio C Hamano <gitster@pobox.com>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: [RFC] git gc "--prune=now" semantics considered harmful
Message-ID: <alpine.LFD.2.21.999.1805261449160.6211@i7.lan>
User-Agent: Alpine 2.21.999 (LFD 260 2018-02-26)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


So this is a RFC patch, I'm not sure how much people really care, but I 
find the current behavior of "git gc --prune=now" to be unnecessarily 
dangerous.

There's two issues with it:

 (a) parse_expiry_date() considers "now" to be special, and it actually
     doesn't mean "now" at all, it means "everything".

 (b) the date parsing isn't actually done "now", it's done *after* gc has 
     already run, and we run "git prune --expire". So even if (a) wasn't 
     true, "--prune=now" wouldn't actually mean "now" when the user 
    expects it to happen, but "after doing repacking".

I actually think that the "parse_expiry_date()" behavior makes sense 
within the context of "git prune --expire", so I'm not really complaining 
about (a) per se. I just think that what makes sense within the context of 
"git prune" does *not* necessarily make sense within the context of "git 
gc".

Why do I care? I end up doing lots of random things in my local 
repository, and I also end up wanting to keep my repository fairly clean, 
so I tend to do "git gc --prune=now" to just make sure everything is 
packed and I've gotten rid of all the temporary stuff that so often 
happens when doing lots of git merges (which is what I do). 

You won't see those temporary objects for the usual trivial merges, but 
whenever you have a real recursive merge with automated conflict 
resolution, there will be things like those temporary merge-only objects 
for the 3-way base merge state. 

Soes my use pattern of "git gc --prune=now" make sense? Maybe not. But 
it's what I've gotten used to, and it's at least not entirely insane.

But at least once now, I've done that "git gc" at the end of the day, and 
a new pull request comes in, so I do the "git pull" without even thinking 
about the fact that "git gc" is still running.

And then the "--prune=now" behavior is actually really pretty dangerous. 
Because it will prune *all* unreachable objects, even if they are only 
*currently* unreachable because they are in the process of being unpacked 
by the concurrent "git fetch" (and I didn't check - I might just have been 
unlocky, bit I think "git prune" ignores FETCH_HEAD).

So I actually would much prefer that foir git gc, "--prune=now" means

 (a) "now"

 (b) now at the _start_ of the "git gc" operation, not the time at
     the _end_ of the operation when we've already spent a minute or
     two doing repacking and are now doing the final pruning.

anyway, with that explanation in mind, I'm appending a patch that is 
pretty small and does that. It's a bit hacky, but I think it still makes 
sense.

Comments?

Note that this really isn't likely very noticeable on most projects. When 
I do "git gc" on a fairly well-packed repo of git itself, it takes under 
4s for me. So the window for that whole "do git pull at the same time" is 
simply not much of an issue.

For the kernel, "git gc" takes a minute and a half on the same machine 
(again, this is already a packed repo, it can be worse). So there's a much 
bigger window there to do something stupid,

             Linus

---
 builtin/gc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c4777b244..98368c8b5 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -535,8 +535,12 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	if (argc > 0)
 		usage_with_options(builtin_gc_usage, builtin_gc_options);
 
-	if (prune_expire && parse_expiry_date(prune_expire, &dummy))
-		die(_("failed to parse prune expiry value %s"), prune_expire);
+	if (prune_expire) {
+		if (!strcmp(prune_expire, "now"))
+			prune_expire = show_date(time(NULL), 0, DATE_MODE(ISO8601));
+		if (parse_expiry_date(prune_expire, &dummy))
+			die(_("failed to parse prune expiry value %s"), prune_expire);
+	}
 
 	if (aggressive) {
 		argv_array_push(&repack, "-f");
