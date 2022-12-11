Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77FE4C4167B
	for <git@archiver.kernel.org>; Sun, 11 Dec 2022 03:34:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbiLKDeW (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Dec 2022 22:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiLKDeT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Dec 2022 22:34:19 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1604812AE6
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 19:34:19 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id k7so8774068pll.6
        for <git@vger.kernel.org>; Sat, 10 Dec 2022 19:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V1C9qIdtgFH5aXJC3cOMfLfZ4glP9RPJOiGaul6aM7I=;
        b=o3jKXAI8Ovtguk/YegkQXjXIXsiN+oW2ucFu58jRNT6VHCN3B+pU8MuJapvpqVu+nZ
         IO/07vwT2hFxDCKLQXcNb/ut/uhRmOGiSKfE23t9KCsD+MYnIvW6i5+wwwPlaitGFxZ3
         U2qCVAhNRNXyMp+RqNKVb2U49Ut+WOox5kCZ9i+wPeUU+Tsj+NBsiyqwoWDURFbPXDs+
         iuJve5LQal3sAMqQS49vYCKgqzbFXICvgh0s1nbr8kNzPPpz+UYo/97nR7ovDyuLabTY
         ZfwOVCO/2C0LH+D1aXipXjLf+y16uNeO/Lj/hTml8z/n8Lng7/Fhbw3vRHYBu5jqrFyU
         hGiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V1C9qIdtgFH5aXJC3cOMfLfZ4glP9RPJOiGaul6aM7I=;
        b=aIp7BBMkifrFFMblmWqbxwc9fuCikiDJ1Gpc06jcQ7JGahJ1eXTGPXrqKdOVdfgB5S
         84L4cmh/qp0UNfWg7bc0P+D9dxwX6SzoU/WZh5mI+2bIDuVVNBz1cpYwOvs0aVH5EW42
         exxhnfvNaXyKU0pIx5JX1Bd1jkuoLMN5MOwwpick7DcmKMtXc8gvtGSYReiUHxuW1goq
         8YeJ7HUuy2nIEpXgp3zMdbZfEM7+uSdpoSj16D5ljliI4dF7zUWBnVozQeoPnYPNbzon
         BCNHLU4vfVRFy9+74sxCT4KEAoPpbsXeQ1ZjlpWfGz00PTuf1SOZUh7UGJTBxoXX/4tA
         KlkQ==
X-Gm-Message-State: ANoB5pnDdTPXFU0Eit+3c9qL8IkNTX1Ma+/n0ylGzkGa+JQYLZOXE1/N
        VS8E0gcwSNg/fuOQTqhmUbALW6hjW2O5mw==
X-Google-Smtp-Source: AA0mqf6uojzlDu3vKcnh4a3TmxF9zMaYtVfXIYCoSdQy4dMofScsYHHCrVOolE/gYmdEAMLdBoaKQQ==
X-Received: by 2002:a17:902:f646:b0:185:441e:224a with SMTP id m6-20020a170902f64600b00185441e224amr11031018plg.69.1670729658399;
        Sat, 10 Dec 2022 19:34:18 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id i2-20020a17090332c200b00189e7cb8b89sm3612942plr.127.2022.12.10.19.34.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 19:34:18 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Kellogg-Stedman <lars@oddbit.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3] line-range: Fix infinite loop bug with degenerate
 '$' regex
References: <20221205193625.2424202-1-lars@oddbit.com>
        <20221211015340.2181837-1-lars@oddbit.com>
        <xmqq5yeiwr6x.fsf@gitster.g>
Date:   Sun, 11 Dec 2022 12:34:17 +0900
In-Reply-To: <xmqq5yeiwr6x.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
        11 Dec 2022 12:32:38 +0900")
Message-ID: <xmqq1qp6wr46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Lars Kellogg-Stedman <lars@oddbit.com> writes:
>
>> When the -L argument to "git log" is passed the degenerate regular
>> expression "$" (as in "-L :$:line-range.c"), this results in an
>> infinite loop in find_funcname_matching_regexp().
>
> Is "matching an empty line" the only way a regular expression can be
> a "degenerate" one?  If not, perhaps being a bit more explicit would
> help the readers, e.g.
>
>     ... a regular expression that matches any line, even an empty
>     one, such as "-L :$:line-range.c", this results in ...

I forgot to point out that the above comment on "degenerate" applies
equally to the commit title (which matters more).  Also, please do
not upcase the first word after "<area>:" on the title line.

Thanks.
