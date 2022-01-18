Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F01AC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 16:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244556AbiARQR3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:17:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347092AbiARQRL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 11:17:11 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C0E1C06161C
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:17:11 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id b13so82069346edn.0
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=KyPo04poghsFxYq1knkcEU568guvSPZfBkTOvzLmQgY=;
        b=V4gmd0GCIrMmkjRhaXc9iLUE33I4SSbjurHfptRNBvLCzH3bkWte+1RnUoZCoNObks
         HNdkhXNimDhuda3+COvSTxonFCSRnp/zs5yB+o8nV9d2TtOQNLMW1DTUOe3sBK4ZT+Mo
         kq7ZIm/3Tcne+SqwHFbB5ubmXOjSkAue3F6UKuRf78zsByIflN26dSUiyPMs7nV224Wf
         Es/lm5BkDLWXZgV/cZWgFVPXKuslF0myuiTBYwn5bIaYbpLOWQGXNNlZAWZI9FKzclmu
         Duv96KKKiY73yyaMTgs8GRuaSlCeWp+kSqfHU42iBC0MuQrjyTt3bT5yRAZPRxhHL9/+
         m39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=KyPo04poghsFxYq1knkcEU568guvSPZfBkTOvzLmQgY=;
        b=Q2y1oh62xBgOLPwCUOIwQysjmtAtHR1G0h7e5wsXIlhz8MVoYdIFTBdKNE3l6KfXVg
         esJ9iCsso9QSl+rH0NEJYLrwoXaOPKeVfsfuFB6Y2Vi4hVPJj8rYc+Qdq4F6rk8wp18C
         sEKDrrppeq2oCxJ7+TnPXpvq/VhuI9RiOLk3dwe867Xj3ztmVWg9GAd9hgEdzh7Voc7l
         8nplr92QRrABMkI+nt/hr0hj6DojpuwUc7FLR1vxPnvDZtOELI73/zjClEZksNy3LegL
         LBx7XxGX3hbRpUKC9vMw+oQL/TXiGjeU9/28c7e8c1hql6kiOvjm6RzMWVUG8/Zodewn
         UkmA==
X-Gm-Message-State: AOAM531aLJzepCv7YcuX0jFeWz817lRgoYVRjMIOBfXOT50Gs0ERfZ2P
        zihdpsFKZWHlhctirhPkXGwpXBhBNgIG2w==
X-Google-Smtp-Source: ABdhPJxuPL/5wmHJS5v6BkI5VMXmz2N01azjP3a1DZFI+p1XvvzrQ5/esv9prRCln8R2I7bd0vAXMQ==
X-Received: by 2002:a05:6402:1343:: with SMTP id y3mr15316856edw.164.1642522629567;
        Tue, 18 Jan 2022 08:17:09 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lu2sm1048412ejb.43.2022.01.18.08.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 08:17:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9rAS-001erN-Jn;
        Tue, 18 Jan 2022 17:17:08 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v7 2/2] name-rev.c: use strbuf_getline instead of
 limited size buffer
Date:   Tue, 18 Jan 2022 17:09:37 +0100
References: <pull.1171.v6.git.git.1641423600.gitgitgadget@gmail.com>
 <pull.1171.v7.git.git.1641425372.gitgitgadget@gmail.com>
 <19e7bf965574652840c5e0cde6f3dd188bec82b0.1641425372.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <19e7bf965574652840c5e0cde6f3dd188bec82b0.1641425372.git.gitgitgadget@gmail.com>
Message-ID: <220118.865yqhow6z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 05 2022, John Cai via GitGitGadget wrote:

> From: John Cai <johncai86@gmail.com>
>
> Using a buffer limited to 2048 is unnecessarily limiting. Switch to
> using a string buffer to read in stdin for annotation.
>
> Signed-off-by: "John Cai" <johncai86@gmail.com>
> ---
>  builtin/name-rev.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 8baf5b52d0b..138e3c30a2b 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -623,14 +623,13 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>  	name_tips();
>  
>  	if (annotate_stdin) {
> -		char buffer[2048];
> +		struct strbuf sb = STRBUF_INIT;
>  
> -		while (!feof(stdin)) {
> -			char *p = fgets(buffer, sizeof(buffer), stdin);
> -			if (!p)
> -				break;
> -			name_rev_line(p, &data);
> +		while (strbuf_getline(&sb, stdin) != EOF) {
> +			strbuf_addch(&sb, '\n');
> +			name_rev_line(sb.buf, &data);
>  		}
> +		strbuf_release(&sb);
>  	} else if (all) {
>  		int i, max;

Maybe there's a subtlety with \r in newlines (Windows), but isn't this
doing the same thing as:

diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 138e3c30a2b..03dbf251450 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -625,10 +625,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
 	if (annotate_stdin) {
 		struct strbuf sb = STRBUF_INIT;
 
-		while (strbuf_getline(&sb, stdin) != EOF) {
-			strbuf_addch(&sb, '\n');
+		while (!strbuf_getwholeline(&sb, stdin, '\n'))
 			name_rev_line(sb.buf, &data);
-		}
 		strbuf_release(&sb);
 	} else if (all) {
 		int i, max;

After writing that I see this was changed on the basis of Junio's
feedback in https://lore.kernel.org/git/xmqqr19ofdo5.fsf@gitster.g/ :)

FWIW I think it's fine as-is, but it also seems that name_rev_line()
really doesn't care about lines per-se, but just that we don't split
OIDs across "lines" (as we'll tokenize get_oid() on them). So
e.g. splitting by ' ' lines (spaces) also works here, but not 'a' (as
that would split a [0-9a-f].
