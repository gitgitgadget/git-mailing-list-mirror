Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEFBC4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 13:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbiKUNIu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:08:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiKUNIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 08:08:46 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1CBDF1C
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:08:44 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id w15-20020a17090a380f00b0021873113cb4so10803583pjb.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UoC4XEzIEqK+R6N3JKeuNyMSVa9FCwFInZSR8lfDL78=;
        b=BuLnZH3N0efetP11t+VhJU6broJuJS+K4bKmicsjHxSmoW525EBmWOmMAalDNPtjFE
         pcRYJb1lVUDtR3M21b32ZCS7nwQiOuoCluchnsU5bQgBUdXflllve9fuf6CrvGRXx8Q4
         e+BjalDp/HD7bsALpY+fXlsLng8FDqCix7y3hQVXD9N5yWsOILp+2DXhn3OcGF3rPhkd
         aSbpqGYOGOtzslse90fTT3ioLO51yb6Vsm6UM40pIG+eU7r8MAqWvzqE6V++Mj02QDCO
         ZjcDgYrvbIT+7A+/mHQ+IhT50YiZdeHVDEC3FD2kDdDSyNYm+vZLEljiRA2/BxR2YD2f
         6hgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UoC4XEzIEqK+R6N3JKeuNyMSVa9FCwFInZSR8lfDL78=;
        b=aGY7prx2wVD7uQeZ/fDUyqS/WDBsAObZPpVoDyzaFVePctymX+sFvXBESM0QgR6qqS
         FsxACeuR7E88ACGcOTcby2b3ThaibXo48iI+imlc2bu26sSbHi7fbk6RCoV+kqjMtpeG
         8q+GyJnuGICTfDZk4Lay5+hEdSVklQz6bL0yOf/H71BB7XHBZz2o9/9Dkr4uQkun+R5n
         zRg+PVAA5VFpfTW6I60r8se8KS/dycrL9x5vRXqpwqM/OsttHLyluC30IQapxw2ppakc
         vM9h28OGhDOIit1r0hm18t5eyonZUy4CuMHfP8QilbTViPiBkYI7Zz7biQhc9dTDsWj3
         Cyfg==
X-Gm-Message-State: ANoB5pkTwKWAdXaWW21aVxqH99anpos93bt0JAZez/3rkO2G9xhA3J3t
        U7B4juryuRbnqwyDooCjGa8=
X-Google-Smtp-Source: AA0mqf71uF+jhzYjkECQg+qcGHQpb/Ryyym2Kc6B8JxKb9Wgw+Bh3l0RzQzAr7ux4/oSZZQVWplWlw==
X-Received: by 2002:a17:90a:5c85:b0:20a:92d2:226a with SMTP id r5-20020a17090a5c8500b0020a92d2226amr8871020pji.155.1669036123526;
        Mon, 21 Nov 2022 05:08:43 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id r12-20020a635d0c000000b0043b565cb57csm2698827pgb.73.2022.11.21.05.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:08:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] prune: quiet ENOENT on missing directories
References: <20221119201213.2398081-1-e@80x24.org>
        <xmqq5yf8yhe0.fsf@gitster.g> <20221121104427.M268307@dcvr>
Date:   Mon, 21 Nov 2022 22:08:42 +0900
In-Reply-To: <20221121104427.M268307@dcvr> (Eric Wong's message of "Mon, 21
        Nov 2022 10:44:27 +0000")
Message-ID: <xmqqpmdgv4it.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Good question, perhaps this could be a followup:
>
> diff --git a/builtin/prune.c b/builtin/prune.c
> index 2719220108..041c45ecbe 100644
> --- a/builtin/prune.c
> +++ b/builtin/prune.c
> @@ -188,7 +188,6 @@ int cmd_prune(int argc, const char **argv, const char *prefix)
>  				      prune_cruft, prune_subdir, &revs);
>  
>  	prune_packed_objects(show_only ? PRUNE_PACKED_DRY_RUN : 0);
> -	remove_temporary_files(get_object_directory());
>  	s = mkpathdup("%s/pack", get_object_directory());
>  	remove_temporary_files(s);
>  	free(s);

I actually was hinting at making the remove_temporary_files()
recurse, so that you do not need the separate invocation in pack/
subdirectory.

Or make 256 calls for each of the fan-out subdirectory, in which
case the ENOENT silencing you did would really matter and shine.
