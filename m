Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE40C7EE23
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 01:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjFFBB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 21:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233247AbjFFBB4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 21:01:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0945100
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 18:01:55 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b021cddb74so26675195ad.0
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 18:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686013315; x=1688605315;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQW/DHYETFKq0pa8CGYSW3v0oJO7vPB00kmkXT7vgAo=;
        b=haYTny3RyhW1aBJzkfioLypAMeRWtU9Faw12ZV3jFupK1D7B+IvJxrohQ2N8SFi/Z6
         e8hmGDYuDwm9CyZdMP968XDYVy9zR4UHK/QtoffRkG9fQ2kL6z8zZKYuh4HFd0+KceLL
         cdcI6s/mCftwlclc7S3+VCeTlIB+CwVZouYgTjUwh6ayi2GNVHyCm0V3yXes2rPA2NY1
         oH126Lyvu6/ciu9glXrpF3zI5w0j+/N+InZbTjZ88OXS0KikEH0wC8js1rLP7HXlGZ+m
         SoZtKdOowfJAPUlLbYpPhuCVB767i3bpIwgGW23aEDlBjk/fE+Q+7QmakT6zp9B24Qn1
         rCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686013315; x=1688605315;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SQW/DHYETFKq0pa8CGYSW3v0oJO7vPB00kmkXT7vgAo=;
        b=IIozhMa3/sqXNWNQXju2B8s75luIQHQRaeIbXl0wl5w+jbcmUJwBj59GdSF8VeNuII
         Xr2hoAls9jZPB3+v1HEoXLeaKay8zz+MFguYKMFgITJdGd/76bs/AtWppFqgELQC0Tw1
         3y8hGezbR6GxrTXGEjmV4LCM50GCyfokDu7wsf/SbLi+BqJtOP8iS611pMktYjEtQ0OZ
         GJ8IMtxtscIW37Wxn7uCRu4vH0EhadhwKObH5woiZKh+qbjlNUYfOBBKUicp+qP3W44d
         KhvA+yKG/76f7fY4Ue3C6tN+4NQsE6eR3l9VQr7j7x48AUejhZe28Ixjgc4Q5DYvWTVd
         CrMQ==
X-Gm-Message-State: AC+VfDy40HEd5u0mK4WV6PNNL1zpRD1TBtSoRB/Qhmn9V0bVZXF3YXd6
        pEQvcg6gxWbya7z0QnF0fvQ9a3NzsyQEmw==
X-Google-Smtp-Source: ACHHUZ4ap1ClTD75R3oijh4DXglMwqgsejmMYV5cW9ye10GaZEmPL+UN8HqtJkwQxQAQ4mKQO6JYRg==
X-Received: by 2002:a17:902:d38d:b0:1af:cabb:87b6 with SMTP id e13-20020a170902d38d00b001afcabb87b6mr391946pld.19.1686013315088;
        Mon, 05 Jun 2023 18:01:55 -0700 (PDT)
Received: from localhost (217.195.118.34.bc.googleusercontent.com. [34.118.195.217])
        by smtp.gmail.com with ESMTPSA id f23-20020a170902ab9700b0019719f752c5sm7182465plr.59.2023.06.05.18.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 18:01:54 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] add: check color.ui for interactive add
References: <pull.1541.git.1685994164018.gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 10:01:53 +0900
In-Reply-To: <pull.1541.git.1685994164018.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 05 Jun 2023 19:42:43
        +0000")
Message-ID: <xmqqsfb54d4u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +test_expect_success 'colors can be skipped with color.ui=false' '
> +	git reset --hard &&
> +	test_when_finished "git rm -f color-test" &&
> +	test_write_lines context old more-context >color-test &&
> +	git add color-test &&
> +	test_write_lines context new more-context another-one >color-test &&
> +
> +	test_write_lines help quit >input &&
> +	force_color git \
> +		-c color.ui=false \
> +		add -i >actual.raw <input &&
> +	test_decode_color <actual.raw >actual &&

It is a minor thing, but for expected output that _wants_ to be
indented in a non-standard way, it would be prudent to protect the
lines from "git apply --whitespace=fix" and in-transit corruption,
perhaps doing something like ...

> +	cat >expect <<-\EOF &&
> +	           staged     unstaged path
> +	  1:        +3/-0        +2/-1 color-test
> +
> +	*** Commands ***

... this.

	sed -e "s/^|//" >expect <<-\EOF &&
	|           staged     unstaged path
	|  1:        +3/-0        +2/-1 color-test
	|
	|*** Commands ***

Although this patch does not add such lines, the same principle
applies to expected output lines that _wants_ to have trailing
whitespaces.

Thanks.
