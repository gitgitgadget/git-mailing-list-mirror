Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4143C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 15:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232389AbiKGPTS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 10:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiKGPTQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 10:19:16 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99EC23E
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 07:19:15 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id a5so18063818edb.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 07:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+ZQ49l47of+XDPhFPKOAlYUqVMWiMfahQQ96xnEx8xI=;
        b=mhTa5myrsn2BeBAVVfaZ0d6ZOR7YqItneMDwQtdTIuF/JR2FxTfGzh5T9Tn1JlKCjs
         eJtY8DSmGJ4nAg5RbT1B4XoekJOk8Ub71EoDMUwltc91BpQ+CbcHvdgZ9GEOefEUvdHS
         Ql2fPJSG/SePKxL73GLqlpMTwnPG1nD2vpw0PKEodlJWJgjK+QWH+uspyZJo1Ek88+i3
         Wm+mezwKB7FY/L5xwMovJEm5TQTKKDSy7VfeiLPmP52zSog4HfS3n8BWRYEzTJAThKva
         vyjsvytEk/3zXwFd8gseLiYrRzXFurseC8Ag/ZrygY3qTqA20sfypWA0IFbij1C5r/Uf
         pXoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ZQ49l47of+XDPhFPKOAlYUqVMWiMfahQQ96xnEx8xI=;
        b=zlqCHG2y2lJMEPb9X6EXtsUfRizv/RmRGPYKB9rJ1Zd5OsPr8twwooJaUI1n0EzOY4
         3zW8U2elL3NDrsWBDgbpQSE+wGM7pf/WALMeOnW5E6c9Zv4K+0GyyewzLo1g/f0kRtWh
         ZnqvflpWPl7ef3PXP3rduIU6zUT6A33hf3REtdKbZrFWznLMrqj3hwVfo7JNPN+d0sU/
         lawnQK2xW7AoG2z6OT0nLGeNT1/6B0xqrcwdwLsXx77NuYp1bwMVYUAW0wMPQqbPBSRI
         /3zJOqJeH4jTAAdrOUGCrBedoQ/9szjVyU9uNMMziIPBYUcMTO1zEMUb01ARW3adHDKV
         pi0w==
X-Gm-Message-State: ACrzQf1Cgua3e1JRdyO3lAzio6xRPLolWX1/azF5nqWNdPgILoynHLK8
        7iCAu+ugj80DGROhv5uDb34=
X-Google-Smtp-Source: AMsMyM4AxsYA83Hu8FndNrA6j+1XxbbhjtOB4iEDRuJW/dxbZTFb6t9hQnfClMDV6QrGHu1f3kAMzw==
X-Received: by 2002:aa7:c2ca:0:b0:461:89a6:2281 with SMTP id m10-20020aa7c2ca000000b0046189a62281mr52853484edp.260.1667834354366;
        Mon, 07 Nov 2022 07:19:14 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id bq3-20020a170906d0c300b007ad84cf1346sm3545562ejb.110.2022.11.07.07.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 07:19:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1os3u5-00095T-1X;
        Mon, 07 Nov 2022 16:19:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Mon, 07 Nov 2022 16:06:39 +0100
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
Message-ID: <221107.86v8nqvlla.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Teng Long wrote:

> From: Teng Long <dyroneteng@gmail.com>

Something I didn't notice on the first reading:

> @@ -619,7 +622,7 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>  		char *prev_buf = read_object_file(note, &type, &size);
>  
>  		strbuf_grow(&d.buf, size + 1);

Here we're growing it to add the size plus the \n.

> -		if (d.buf.len && prev_buf && size)
> +		if (blankline && d.buf.len && prev_buf && size)
>  			strbuf_insertstr(&d.buf, 0, "\n");

But now we're not going to make use of that "+ 1" anymore...

>  		if (prev_buf && size)
>  			strbuf_insert(&d.buf, 0, prev_buf, size);

..and here the prev_buf && size condition is duplicated.

I think the right thin to do is to just drop the strbuf_grow() here
altogether, since strbuf_insert() will handle it for us, but that would
make sense before this change, so maybe in pre-cleanup?
