Return-Path: <SRS0=ZAU+=3M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10067C2D0DB
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBA522253D
	for <git@archiver.kernel.org>; Thu, 23 Jan 2020 19:26:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XL8Nh0ym"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728842AbgAWT0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jan 2020 14:26:46 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:42131 "EHLO
        mail-yb1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgAWT0p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jan 2020 14:26:45 -0500
Received: by mail-yb1-f195.google.com with SMTP id c8so2200168ybk.9
        for <git@vger.kernel.org>; Thu, 23 Jan 2020 11:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=w61GzlVC9BsDpO1xYgMtYRQ04ng53rNZTQeHKo8xg24=;
        b=XL8Nh0ymM7tPi31QlV3G/m3UeoXV4lvwhgBaOw8jT8+p8MUlQ4jDf/BeQYX/n0ai14
         MKE+ll8zM21wJhgSCVglp8VvEoK4XOJmoJ6c6be9pdyYV2qSL8irYzKZPYY8c+lab7Bg
         z7vLBAROGtHJqhNqUYMXxvUkwYxtQ9eIOcJW3YnkiILnDEB+IS6r5yJNmJOpmSTGzcL3
         pYnSEF6tUGQKK8lRUn0kLYbg51lfPK9/7LG8Sl31mP9cRJ3dFWjUWL8X2CLrdS8hXhQs
         71T4oencdnfCgZzERFAgicIopCjILwRXuqli7oADD8Es9CzDo4yhn4A4Z/PwnAKJtmZq
         OUsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=w61GzlVC9BsDpO1xYgMtYRQ04ng53rNZTQeHKo8xg24=;
        b=Rar4owDdoq97ptU5ZX+n9Cg84Iykmr0tNc0qOeUSsxso7ktjr3P5SqGvsN7wC+3oRK
         qPb6Bqu+73rHyu0qU0jXAWRc/WArRpj42D+W5eGzniXOqzVLVdqvuGndqizro6aghyK9
         uG0kd55T3umFEpMwT9WpVYrAQt7votGxkQLOJqZ/dZFNzUmXsr7o9yRed41SV2EO4Wi+
         E+dTg79dC51AfRud7TagsCATUg53abg5A4EBSe4u0zM9mfuAyY4Vnnlvi5iDVck1gCs1
         ryjZsa/i5Z18OLyP1IFB4ZY9a3uQD4FOA5mdrzrEYnO0fa1levYMqKcPHf1+DnH3ljCW
         V2cg==
X-Gm-Message-State: APjAAAUu6ZbtwL5ltAyM+xr3fRkxxAGWQkG/TdR4tCw2Ie789KakGJJc
        TdxvvEBEe6To70//EFlNMos=
X-Google-Smtp-Source: APXvYqxinJcLe3cmpxN1mHML6b14me12/RXR3AJ9cFxug9z05ss2pWcwI3tQs2iIJAEgHngqgoZsTA==
X-Received: by 2002:a25:d658:: with SMTP id n85mr12936556ybg.373.1579807604656;
        Thu, 23 Jan 2020 11:26:44 -0800 (PST)
Received: from flurp.local (user-12l2dpj.cable.mindspring.com. [69.81.55.51])
        by smtp.gmail.com with ESMTPSA id t142sm1251228ywf.53.2020.01.23.11.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 11:26:44 -0800 (PST)
Date:   Thu, 23 Jan 2020 14:26:38 -0500
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        ch <cr@onlinehome.de>,
        Martin von Zweigbergk <martinvonz@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] gitk: to run in a bare repository (was: gitk can't be
 run from non-worktree folders)
Message-ID: <20200123192638.GA3177@flurp.local>
References: <4e2e5829-b9a7-b9b4-5605-ac28e8dbc45a@onlinehome.de>
 <20200123163151.GC6837@szeder.dev>
 <CAPig+cTixT9JYDPn-umKdQLtTm5byA1wwmvVY1ryuh+hv2=6MQ@mail.gmail.com>
 <xmqqpnfa3sj1.fsf@gitster-ct.c.googlers.com>
 <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqk15i3rp7.fsf_-_@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 23, 2020 at 11:20:36AM -0800, Junio C Hamano wrote:
> Use the gitworktree helper introduced in 65bb0bda ("gitk: Fix the
> display of files when filtered by path", 2011-12-13), which is
> prepared to see failures from "rev-parse --show-toplevel" and other
> means it tries to find the top-level of the working tree instead to
> work around this issue.  The resulting value in $worktree global,
> when run in a bare repository, is bogus, but the code is not
> prepared to run external diff correctly without a working tree
> anyway ;-)
> 
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/gitk b/gitk
> @@ -12599,7 +12599,7 @@ set cdup {}
>  if {[expr {[exec git rev-parse --is-inside-work-tree] == "true"}]} {
>      set cdup [exec git rev-parse --show-cdup]
>  }
> -set worktree [exec git rev-parse --show-toplevel]
> +set worktree [gitworktree]

This helps but doesn't quite make it functional due to a bug in gitworktree() which results in:

    Error in startup script: can't read "_gitworktree": no such variable
        while executing
    "if {$_gitworktree eq ""} {

So, to make this work, it also needs:

--- >8 ---
diff --git a/gitk-git/gitk b/gitk-git/gitk
index abe4805ade..8cbca113e3 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -34,8 +34,7 @@ proc gitworktree {} {
         # cdup to obtain a relative path to the top of the worktree. If
         # run from the top, the ./ prefix ensures normalize expands pwd.
         if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
-	    catch {set _gitworktree [exec git config --get core.worktree]}
-	    if {$_gitworktree eq ""} {
+	    if {[catch {set _gitworktree [exec git config --get core.worktree]}]} {
 		set _gitworktree [file normalize ./[exec git rev-parse --show-cdup]]
 	    }
         }
--- >8 ---
