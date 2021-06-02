Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2BCC47083
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A02D60FF0
	for <git@archiver.kernel.org>; Wed,  2 Jun 2021 20:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhFBUcw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Jun 2021 16:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbhFBUcu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jun 2021 16:32:50 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C8DC06174A
        for <git@vger.kernel.org>; Wed,  2 Jun 2021 13:31:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g17so2810754qtk.9
        for <git@vger.kernel.org>; Wed, 02 Jun 2021 13:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KQZhTEQnYOJTNKgTgpbcN0/rHxGY8Q4W3PPO66Zejo0=;
        b=ngnAOg3cbdrR5xMY+X3zK3hWhxHWLYzn55RJBhSkf33ovLL+TilMzkMiGO48Gsz7Of
         Bu5XvVnxt0aC39VscLkqGUZk0Pcb/TUoxL+UUw7OAIW/6c9tU4D9RztaRqgZ9AouQav8
         h1xvYH4xsQ0HA8Uka0UcekCo+ngKajYGAK28B7LQFmMjcZzEcGuqRcO3wHlB01Z05B13
         zM0WeS39OL0LxrHxQO9zYCwJrvJ5D9p98iHyHzt6Kmatv4chtxavVNDraAIFNmo+SwT1
         4aV6Q2z/BZo0YSLkkTHl/rbrMvLHtePw8qJv3HXUYXMG0I2nL7v7xsMOl+FebG+gXv+E
         I27g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KQZhTEQnYOJTNKgTgpbcN0/rHxGY8Q4W3PPO66Zejo0=;
        b=kAVO0TvN82sbv/aRgVB8fbFqAo039o44/FO0SIt/zVDw9d6UNpD135H8Roi6rHse+e
         MmQeR1T4bpg9u/ClUk3JLTB717GE5jDO+1NrOknYtKJohN0xEmt7RCPu/wHabhS/MvuE
         RDXyqRnytVckomKDPOGBYhLMzkx6zny8VnMKKaCSaBOHk6ZwbYVMnoUTzMI14tZHQkph
         WNw5rSclwH5YHUt0bjqCR4NAZE5cdLLkB8RXgMPUsFzI//QOenYdDEsGIYXiQNpjrdxR
         dyxHxudgpB0Obvf434f6NbrgWVS/nag0bCsCIqfUgqQ1HzXoUdTgk0tr6coHcnsWNBda
         vrnA==
X-Gm-Message-State: AOAM532nBJUFTgKu+e3kUf8Jwvgg6hQzz0aoHZr3M7EjALaF0vf1DilH
        dIrFldR+35ZerIrd467mLZHcaA==
X-Google-Smtp-Source: ABdhPJx4PArF/ist4nVoXyZ7RpYb5hEIaKvS9pZZR+SWbQE55mfwbIEwuEOQ/D6Onmrwdgv7IZlC4A==
X-Received: by 2002:ac8:4698:: with SMTP id g24mr26249751qto.112.1622665865838;
        Wed, 02 Jun 2021 13:31:05 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9178:81cf:a7f0:8e5d])
        by smtp.gmail.com with ESMTPSA id s18sm459019qtk.85.2021.06.02.13.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 13:31:05 -0700 (PDT)
Date:   Wed, 2 Jun 2021 16:31:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Ilias Apostolou <ilias.apostolou.zero@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Request feature: =?utf-8?B?4oCTbm8t?= =?utf-8?Q?submodule?=
Message-ID: <YLfqiLbpPXWXHlBi@nand.local>
References: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c5709df6-c357-56b4-f0e0-673bc8b4e668@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 02, 2021 at 01:31:11PM +0300, Ilias Apostolou wrote:
> Hello Git community.
>
> As you already know, git ls-files command lists all of the tracked files,
> but submodule names are included.
>
> My team would like a –no-submodule switch to exclude those.

In all honesty, though this seems like a niche request for ls-files to
fulfill, ls-files already has quite the collection of options, so I
wouldn't be sad to see it learn how to do this, too.

The change boils down to having builtin/ls-files.c:show_ce() avoid
printing out submoudles in when '--exclude-submoudles' is given).
Something like this:

--- >8 ---

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 45cc3b23dd..09d76fd068 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int show_fsmonitor_bit;
 static int line_terminator = '\n';
 static int debug_mode;
 static int show_eol;
+static int exclude_submodules;
 static int recurse_submodules;
 static int skipping_duplicates;

@@ -230,6 +231,9 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
 	if (max_prefix_len > strlen(fullname))
 		die("git ls-files: internal error - cache entry not superset of prefix");

+	if (exclude_submodules && S_ISGITLINK(ce->ce_mode))
+		return;
+
 	if (recurse_submodules && S_ISGITLINK(ce->ce_mode) &&
 	    is_submodule_active(repo, ce->name)) {
 		show_submodule(repo, dir, ce->name);
@@ -662,6 +666,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_SET_INT_F(0, "full-name", &prefix_len,
 			      N_("make the output relative to the project top directory"),
 			      0, PARSE_OPT_NONEG),
+		OPT_BOOL(0, "exclude-submodules", &exclude_submodules,
+			N_("avoid showing submodules altogether")),
 		OPT_BOOL(0, "recurse-submodules", &recurse_submodules,
 			N_("recurse through submodules")),
 		OPT_BOOL(0, "error-unmatch", &error_unmatch,

--- 8< ---

I'll leave it at that to decide if others think this is a good idea or
not.

Thanks,
Taylor
