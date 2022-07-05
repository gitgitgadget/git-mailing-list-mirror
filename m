Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B176C433EF
	for <git@archiver.kernel.org>; Tue,  5 Jul 2022 09:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiGEJFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jul 2022 05:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiGEJFB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jul 2022 05:05:01 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D597388C
        for <git@vger.kernel.org>; Tue,  5 Jul 2022 02:05:01 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s27so10823205pga.13
        for <git@vger.kernel.org>; Tue, 05 Jul 2022 02:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Im8uoy/EF1i0CMP+ys0o381KvcwQy39t+T8lQHUMByk=;
        b=JADAazNl0cx8riq3tc/w+IFOoZBnYpODl4T0Xb2C/AlSGgrulg73fKtorHu2hgpJTb
         BDiiZUdK7vqDl3QTzXB071lSW3rRXIenWpN4CQaLTCjKVpzCUP70fE/5khI4LMgvUUEr
         oy8I5XcKJhcSKuZ22ByYR8zg9HGHUadCsjR9CKWsKjL8HOYdJAupj7faDTvlcqFWZTfy
         0EJJLuv8mkTq8KA0Nv5l9OY1W/JhFSKAaMXy2Om9/SVQK8SouJ/hyz5lk86FqZYQlKwM
         ntnO7+Syw5sJz8VKbJYYoMyK+Gbc4z3wAMxAsue8c01N9ZWZEi19fQue29cHJx3axXSk
         E3LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Im8uoy/EF1i0CMP+ys0o381KvcwQy39t+T8lQHUMByk=;
        b=F8x7VmeFwoqJ8qKal2dNM4CNQBDnni7DBN/JrypzWEJPW36cUqoKQHAY6LYmKlIP+I
         iNsUsZXp2CJ3xcBWa2aqd7mYXGgILnUAiPdUJ9NrhBhOnx6MBoI6f598svXQ7xP2zzkB
         rf2jkEqazaLLvwykzVyD1u0QTzKgfX1j2EL+F4ZbxpbC40y2FGTshXmSRqkpZII5eSem
         vm3Yje9jUN22H1M4buYLaq8gSDEGIzMFj8JlUrRly1llUWTFfQn6fZyxEAW3LS6FNQTo
         AlomaD5ALQyFuzcmYS2SG2P/4SQ90XvyX790ZUQ8BNm5VHticpJihR3lXUkVuoDSo1q7
         L/1Q==
X-Gm-Message-State: AJIora/91S5dAcS/trvabb4QmmtVyqCk0sb3QLrP5P3M8P0FCVoMQhbx
        94rJwYoz200CAEd60Yj6BC4=
X-Google-Smtp-Source: AGRyM1viLU6SHUCykdxHp/MUzQr+C8DlO25T3p4hVIabuW//lvxxac98Ss4zcVg25BgZ9dD0TlCFVA==
X-Received: by 2002:a05:6a00:3307:b0:527:cbdc:d7dc with SMTP id cq7-20020a056a00330700b00527cbdcd7dcmr38402991pfb.85.1657011900373;
        Tue, 05 Jul 2022 02:05:00 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.103])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b00168f08d0d12sm19960734plb.89.2022.07.05.02.04.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2022 02:04:59 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitster@pobox.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@jeffhostetler.com, git@vger.kernel.org, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v5 3/5] pack-bitmap.c: using error() instead of silently returning -1
Date:   Tue,  5 Jul 2022 17:04:54 +0800
Message-Id: <20220705090454.10686-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.677.gf3b87a33da
In-Reply-To: <xmqqmtdwk6li.fsf@gitster.g>
References: <xmqqmtdwk6li.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 28 Jun 2022 11:04:09 -0700, Junio C Hamano wrote:

> "stat" -> "fstat" perhaps?

Yes.

> Not a new problem, but before this hunk, we have
>
> 	fd = git_open(...);
> 	if (fd < 0)
> 		return -1;
>
> where it probably is legitimate to ignore ENOENT silently.  In
> practice, it may be OK to treat a file that exists but cannot be
> opened for whatever reason, but I do not think it would hurt to
> report such a rare anomaly with a warning, e.g.
>
> 	if (fd < 0) {
> 		if (errno != ENOENT)
> 			warning("'%s' cannot open '%s'",
> 				strerror(errno), bitmap_name);
> 		free(bitmap_name);
> 		return -1;
> 	}
>
> or something like that perhaps.

Yes.

It's more accurate here with your suggestion. At the same time I
found there actually exists many similar place like "ignore ENOENT
silently" in repo. And I think it's not worth to impove them right now
in this patch, if you want to do that it could in another pathset and
please tell me.

> > @@ -361,7 +361,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
> >  	bitmap_git->map_pos = 0;
> >  	bitmap_git->map = NULL;
> >  	bitmap_git->midx = NULL;
> > -	return -1;
> > +	return error(_("cannot open midx bitmap file"));
>
> This is not exactly "cannot open".  We opened the file, and found
> there was something we do not like in it.  If we failed to find midx
> lacks revindex chunk, we already would have given a warning, and the
> error is not just misleading but is redundant.  load_bitmap_header()
> also gives an error() on its own.
>
> I think this patch aims for a good end result, but needs more work.
> At least, checksum mismatch that goes to cleanup also needs to issue
> its own error() and then we can remove this "cannot open" at the end.

Yes, It's detailed here and I missed it, I will fix this in next
patch: return error() when checksum doesn't match and let "cleanup"
return "-1" but not an inaccurate error().

> "stat" -> "fstat"

Yes.

> > @@ -394,7 +394,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
> >
> >  	if (!is_pack_valid(packfile)) {
> >  		close(fd);
> > -		return -1;
> > +		return error(_("packfile is invalid"));
>
> Same "sometimes redundant" comment applies here, but not due to this
> part of the code but due to the helpers called from is_pack_valid().

Let me try to know about it, the "helpers" means the place where invoke
is_pack_valid() like here. In fact, in is_pack_valid() they already
return the errors in various scenarios, so it would be no need to
return another error.

> Namely, packfile.c::open_packed_git_1() is mostly chatty, but is
> silent upon "unable to open" and "unable to fstat" (which I think is
> safe to make chatty as well---we do not want to special case ENOENT
> in open_packed_git(), so "cannot open because it is not there" is an
> error).

"chatty" means the code that regularly gives information about its
internal operations. Did I understand it right because I'm actually
firstly know this description.

"cannot open because it is not there" is an error, but I think it will
also could be a BUG, actually I'm not very sure for clarify the
difference bwtween the use of the two, but I will look into it to dig
something out.

> And then, this "invalid" will become redundant and fuzzier message
> than what is_pack_valid() would have already given, so you can leave
> it to silently return -1 here.

Clear now.

Thanks.
