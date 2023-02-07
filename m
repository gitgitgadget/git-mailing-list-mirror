Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8406C636CC
	for <git@archiver.kernel.org>; Tue,  7 Feb 2023 22:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjBGWzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 17:55:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjBGWzh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 17:55:37 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1412B3EFF1
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 14:55:30 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id sa10so16364205ejc.9
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 14:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j76Il7y9Qd29hopnIBbccec2ogCESrh/wSouNEeowgI=;
        b=bnPFOX2v8X9iJmnZXXcf043IijucaQwWdBr7IgN7ap2LFHRMrDer3/VSeS0ZD8BzJb
         o631vJ9FPJZb+JNHAm+yTmQoy6sBFcm7jAkPbhfMNvglVucOgI+6f7bmJyMSBOwMUwPm
         KJxQbOgGx9z4848UM6FkX2R5kOa8rRFThBpeuTjkt78TjZmVF3JZzkvgjBDYG6fdz+gU
         7RibTOg/AYMaw1SrzxlIO9KOl+YMuRkzS4qQmwLGQBs4lLh/LzLpcXtHfqu7+hcZmP4D
         vWi1nKiS5C4/uU50XrjbqBWVp8kqCvW3gpMCGhPqQDtYt9RQNRkgyIj08K1G0ZBHGimz
         uj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j76Il7y9Qd29hopnIBbccec2ogCESrh/wSouNEeowgI=;
        b=bkbo2gss5C+49j+XdLzruOMvR8updjpdgR7sY1HcEll6Jm87xvOi7hN/VfMPFKGsgI
         74Y8qTqbKYeX2cCr6yG+dTe5lh5pnr6UPpSJfxJbjB8SnkIyFL+d4VXVs2S/7+JQQ/lV
         A8TgsJFHAxy+2qJCmh5oKGSanA2n6VboAlPTBEivhNx611lXz5zTztgPSHCnhyBy8hmU
         yDcRsz+ctD4F4h/PDDCFeZC+J7U8e0BLCFh/T8H9V3C1//Mch7LztdnM29LiHfxf/G/K
         oIau3RSBde1iWO9bdKcSMs+xREzrozmMfHVUJV/q6cZMv8p/+6JJ/jaAoFOEuxLPCNYr
         rsOA==
X-Gm-Message-State: AO0yUKUBWy9l5+JLHol99da1P9Cub+Xg2C6A8smnHblaV3SBfLnvMhTn
        5A1KAIhwcTrk4fXVPa7lOb9xdCWStDNcBruJ
X-Google-Smtp-Source: AK7set9qRl/lY2BGO7aN7Q7Npu9leLKdqjFSz6v1xzRWghqhuKWFHwd9WaYLUxuWpfLe47oS6ctQ1Q==
X-Received: by 2002:a17:906:4bd0:b0:882:cdd4:14d9 with SMTP id x16-20020a1709064bd000b00882cdd414d9mr4731212ejv.46.1675810528240;
        Tue, 07 Feb 2023 14:55:28 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id d4-20020a1709063ec400b0087bd2ebe474sm7368930ejj.208.2023.02.07.14.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 14:55:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPWs3-0014Ar-0c;
        Tue, 07 Feb 2023 23:55:27 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, newren@gmail.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v7 2/7] submodule: strbuf variable rename
Date:   Tue, 07 Feb 2023 23:47:53 +0100
References: <20230117193041.708692-1-calvinwan@google.com>
 <20230207181706.363453-3-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230207181706.363453-3-calvinwan@google.com>
Message-ID: <230207.86ttzx13xc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Calvin Wan wrote:

> A prepatory change for a future patch that moves the status parsing
> logic to a separate function.

Ah, I think I suggested splitting this up in some previous round, and
coming back to this this + the next patch look very nice with the move
detection, thanks!
>  	fp = xfdopen(cp.out, "r");
>  	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
> +		char *str = buf.buf;
> +		const size_t len = buf.len;
> +
>  		/* regular untracked files */
> -		if (buf.buf[0] == '?')
> +		if (str[0] == '?')
>  			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;

I'll only add that we could also do this on top:
	
	diff --git a/submodule.c b/submodule.c
	index c7c6bfb2e26..eeb940d96a0 100644
	--- a/submodule.c
	+++ b/submodule.c
	@@ -1875,7 +1875,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
	 	struct child_process cp = CHILD_PROCESS_INIT;
	 	struct strbuf buf = STRBUF_INIT;
	 	FILE *fp;
	-	unsigned dirty_submodule = 0;
	+	unsigned dirty_submodule0 = 0;
	 	const char *git_dir;
	 	int ignore_cp_exit_code = 0;
	 
	@@ -1908,10 +1908,11 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
	 	while (strbuf_getwholeline(&buf, fp, '\n') != EOF) {
	 		char *str = buf.buf;
	 		const size_t len = buf.len;
	+		unsigned *dirty_submodule = &dirty_submodule0;
	 
	 		/* regular untracked files */
	 		if (str[0] == '?')
	-			dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
	+			*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
	 
	 		if (str[0] == 'u' ||
	 		    str[0] == '1' ||
	@@ -1923,17 +1924,17 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
	 
	 			if (str[5] == 'S' && str[8] == 'U')
	 				/* nested untracked file */
	-				dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
	+				*dirty_submodule |= DIRTY_SUBMODULE_UNTRACKED;
	 
	 			if (str[0] == 'u' ||
	 			    str[0] == '2' ||
	 			    memcmp(str + 5, "S..U", 4))
	 				/* other change */
	-				dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
	+				*dirty_submodule |= DIRTY_SUBMODULE_MODIFIED;
	 		}
	 
	-		if ((dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
	-		    ((dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
	+		if ((*dirty_submodule & DIRTY_SUBMODULE_MODIFIED) &&
	+		    ((*dirty_submodule & DIRTY_SUBMODULE_UNTRACKED) ||
	 		     ignore_untracked)) {
	 			/*
	 			 * We're not interested in any further information from
	@@ -1949,7 +1950,7 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
	 		die(_("'git status --porcelain=2' failed in submodule %s"), path);
	 
	 	strbuf_release(&buf);
	-	return dirty_submodule;
	+	return dirty_submodule0;
	 }
	 
	 int submodule_uses_gitfile(const char *path)

Which, if we're massaging this for a subsequent smaller diff we can do
to make only the comment adjustment part of this be a non-moved line.
