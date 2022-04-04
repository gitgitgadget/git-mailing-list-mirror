Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 469D0C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 06:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377318AbiDDGM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 02:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377394AbiDDGMu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 02:12:50 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498F934B9F
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 23:10:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so10518530ejd.9
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 23:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=ggYzU+Ci8NRVtLylDrVLbdGGDEeZywaIj9QtlBZYVnI=;
        b=aka/pIgOzgq/t08e/gx9Ws8HMfXnZhwyzbMovDorzSclioSuxzTJ0XS8ZTnR4qBG4U
         wPzras6mMWwRiqoDGuLapnYkqYGsBvoGvlDlbTUJptq3abJtXJRp4lzfZ5L414AiXFPz
         RzVfC2cKZo6GaCznQ2MVcMQqbSdB8iAoA5cCJT2/96Ybe+McrgZwiFTt9TfUB+UUQkau
         8vrnFDiDT5T9a6+mUVvfRFxv8vDohvQ8Q5y1aUBISgm76aPrGwwR6UqIBrlQZzEzBFYE
         aJwdRFw8ID+mM2EWUPGLx1YSEuro40AIEfw58V9PRGF+1jiLxnG73uIyQyZNLFNSQ3lF
         VdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=ggYzU+Ci8NRVtLylDrVLbdGGDEeZywaIj9QtlBZYVnI=;
        b=Lxq1Ig6DpH24pAQNVwN0SP0YmXtb+lwz3AvVksh/VlddazQOZdC7BQaTwNEuoiUTGF
         b8Tl83UKoSnxFjKSImK9D4v7OD8rIX7ui/PT0iDbf3ug5V7E5V4RKpG+Obp+O5anBAxm
         4t6EmW8RAw0xXt1gM1aT87CLrqSltZmFqcOcqybKKGYX1Op7pQnFidHa2K97x3zdxo7y
         o2IdcGei8oqjL7iiS4sNMYFDn/wCIjRZGl0uvwhGQHb92zKpESkUHFA7n6sK8NZW//MV
         2IHJ+1UpVW6LuC99RRdXa3c3OlxIomH6gORGQ3tHCF+S5x7nJ9PVNZ9dgJUY1dj6zJ9q
         7v9g==
X-Gm-Message-State: AOAM530VUSJPeGkI5IzwobfO9yDbXEwWZE5l1J6J28MTU9jSnVjmBRP8
        a2hSu5E8nNWXDI7miSy231hBVoudFeg=
X-Google-Smtp-Source: ABdhPJylZLtLNCgmwxRZ4WO1vkIVVyv/r0JxcrMIy1kOpL45Wkmf2ng6oUxw2X9Do60VjexZpaRGog==
X-Received: by 2002:a17:906:4408:b0:6da:bec1:2808 with SMTP id x8-20020a170906440800b006dabec12808mr9327028ejo.543.1649052653487;
        Sun, 03 Apr 2022 23:10:53 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id yy18-20020a170906dc1200b006d6e5c75029sm3913849ejb.187.2022.04.03.23.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 23:10:52 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nbFvP-002JII-Sz;
        Mon, 04 Apr 2022 08:10:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, prohaska@zib.de, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Subject: Re: [PATCH] convert: clarify line ending conversion warning
Date:   Mon, 04 Apr 2022 08:06:30 +0200
References: <20220404055151.160184-1-alexhenrie24@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220404055151.160184-1-alexhenrie24@gmail.com>
Message-ID: <220404.867d85l6ok.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Apr 03 2022, Alex Henrie wrote:

> The warning about converting line endings is extremely confusing. Its
> two sentences each use the word "will" without specifying a timeframe,
> which makes it sound like both sentences are referring to the same
> timeframe. On top of that, it uses the term "original line endings"
> without saying whether "original" means LF or CRLF.
>
> Rephrase the warning to be clear that line endings have not been changed
> in the working directory but will be changed on the next checkout, and
> explicitly say which line endings the file currently has in the working
> directory.
>
> Example commands to trigger the warning on Linux:
>
> git config core.autocrlf true
> echo 'Hello world!' > hello.txt
> git add hello.txt
> git commit -m "Add hello.txt"

Just eyeballing this, while there might be some improvements here one
thing to consider is atht now %s isn't at the end of the line.

It's fine for hello.txt, but consider longer paths, before:

	LF will be replaced by CRLF in /home/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello.txt.

V.s.:

	LF will be replaced by CRLF in /home/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello/hello.txt the next time you check it out.
