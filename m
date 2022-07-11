Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F45DC43334
	for <git@archiver.kernel.org>; Mon, 11 Jul 2022 15:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbiGKPDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jul 2022 11:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiGKPDW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jul 2022 11:03:22 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F645C97F
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:03:21 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id ss3so3277941ejc.11
        for <git@vger.kernel.org>; Mon, 11 Jul 2022 08:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kW2vqLQ2REmKi/USQNUJKW6O2gF2eIUSKA2Z/llfZRk=;
        b=MYnHKdBALKzcoWEncZhGosbZqdFu8Ywo1Zv63896wSsn+VRLbHOWC/Jbve5X1BUc4f
         Byv0AJyrjw5/GrEvBVioPdNT8GrtMQw/0ebat0o7GqbCr4muVSasSOAoGsK2OvoU5IcO
         t+3bWmQ5PxLgOUG7OzHUlIwKhAqhHNY/xvQqkDUivlAII9/4Jt0EifzzPzwavy2R+029
         C4DI98Mlcg3In+Kd4G+VDnCdMiu7OV75R28dLJtZRwW4hwnthR7wXjfyFAQDtUtRAKzE
         Jr1TTVDuSaGynsP2ceMn2m9drpiKvkMeFFKRl/QCbcsg3CdXjEKMHVWDnT8TXeIJgP5L
         wv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kW2vqLQ2REmKi/USQNUJKW6O2gF2eIUSKA2Z/llfZRk=;
        b=lzXZq5FmLHEjVe8VwmNKs7feF8bk6DTvzHYxxEVW4s0sFjzjzU7OjUqrRPyACw5TK0
         XOQlFbhhVlAWkI1dAXph3FQOo0bni8KSReq8TF5n4i6sJmj3iUmVKTk4aFK7DJfYqzzi
         Z9yTzEgpR5gimI6E95cT+rGX5bLmfL4+zxfIupxW2t0yaJPGpRPVVGlSrMrab/yIsvZH
         EN3r9h3fhJbAiyGcWhyIlz3m0g0CqBbaLkQzei07LlZpBliDArnsprnFdWb/HDmfdufs
         /hhJdGab0lp5R7xccgm0/5VjOJ1N80dzmY1wiQGFPDkzUB14FgDKLP8VRc5+fhIGf4Go
         h0iQ==
X-Gm-Message-State: AJIora941cGIpuDdZCWzrpU1g/UHiWfdL6vVv2UQh/DTjyA8R2BXmSFY
        zuIfK6gH4jkB6sCU/uIV9QQ=
X-Google-Smtp-Source: AGRyM1sDqRaGFlheJz5uNsaWauO3gLtghdWVRpUDZAcjeMwTCZSkV+L1I3N9n18Qert/XL+9GEJ9qA==
X-Received: by 2002:a17:907:2cef:b0:72b:5b3e:3d7a with SMTP id hz15-20020a1709072cef00b0072b5b3e3d7amr4098469ejc.293.1657551799850;
        Mon, 11 Jul 2022 08:03:19 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906211200b006feec47dae9sm2758231ejt.157.2022.07.11.08.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jul 2022 08:03:18 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oAuwP-000vYZ-0f;
        Mon, 11 Jul 2022 17:03:17 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v6 0/7] trace2: dump scope when print "interesting" config
Date:   Mon, 11 Jul 2022 16:59:23 +0200
References: <cover.1656403084.git.dyroneteng@gmail.com>
 <cover.1657540174.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <cover.1657540174.git.dyroneteng@gmail.com>
Message-ID: <220711.867d4j7kuj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Teng Long wrote:

> Since v5:
>
> 1. [1/7] New commit, pre-clean the issues of the strings.
> 2. [2/7] Optimize commit subject (the word "retrieve").
> 3. [4/7] New commit, do not ignore ENOENT silently when fail to open file. 
> 4. [5/7] Replace "stat" to "fstat" in output string and let "cleanup" to
>    return -1 instead of an unaccurate error tip as "cannot open".
> 5. [7/7] dump corresponding scope-name when "interesting" config is print to
>    trace2 log.

I left some minor comments, another thing I'd just like to note, but it
largely pre-dates this series, so we can leave it for now is that I
found our mismatching reporting of the *.bitmap and/or *.pack kind of odd.

I.e. this bit (a diff on top):
	
	diff --git a/pack-bitmap.c b/pack-bitmap.c
	index 7e69093d5a8..8a8be5f6cad 100644
	--- a/pack-bitmap.c
	+++ b/pack-bitmap.c
	@@ -381,23 +381,25 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
	 
	 	bitmap_name = pack_bitmap_filename(packfile);
	 	fd = git_open(bitmap_name);
	+	free(bitmap_name);
	 
	 	if (fd < 0) {
	 		if (errno != ENOENT)
	-			warning("'%s' cannot open '%s'", strerror(errno), bitmap_name);
	-		free(bitmap_name);
	+			warning_errno("cannot open bitmap for pack '%s'",
	+				      packfile->pack_name);
	 		return -1;
	 	}
	-	free(bitmap_name);
	 
	 	if (fstat(fd, &st)) {
	 		close(fd);
	-		return error_errno(_("cannot fstat bitmap file"));
	+		return error_errno(_("cannot fstat() bitmap file for pack '%s'"),
	+				   packfile->pack_name);
	 	}
	 
	 	if (bitmap_git->pack || bitmap_git->midx) {
	 		/* ignore extra bitmap file; we can only handle one */
	 		warning(_("ignoring extra bitmap file: '%s'"), packfile->pack_name);
	+		/* ^^ because here we refer to the pack file, not the bitmap file */
	 		close(fd);
	 		return -1;
	 	}

As tha shows we sometimes talk about the path for the pack when
something is wrong with the bitmap, but other times the *.bitmap
associated with the pack.

It would be a tad simpler to always talk about the *.pack, as we can
free() the bitamp filename right away, but arguably we shoudl do it the
other way around. After all we have issues with the bitmap file, let's
mention it (or mention a filename at all).

Also a pre-existing issue: Why are we getting as far as opening a
*.bitmap file, if we then find that we have "bitmap_git->pack ||
bitmap_git->midx" already, and then ignore it? Maybe I've missed
something...

All of the same oddness applies to open_midx_bitmap_1, except with "path
to the midx" in place of "*.pack" above.

