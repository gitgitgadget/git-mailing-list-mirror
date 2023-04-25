Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829B5C6FD18
	for <git@archiver.kernel.org>; Tue, 25 Apr 2023 16:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbjDYQ0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Apr 2023 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjDYQ0N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2023 12:26:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D881816F09
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:25:38 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1a66888cb89so47952995ad.3
        for <git@vger.kernel.org>; Tue, 25 Apr 2023 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682439936; x=1685031936;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Zk7kzrDRtBMi2c4Bu2LzirjGOH2GjsryrTEUcyl26E=;
        b=hTYB9DLt5myug7hnRlpJRXRJ0UvBk2GRZY0E/QkO0sGqwTuB7Iq6hAyPj0DNvz3Myb
         x33+EIzqNi4Se48TI4Koj0WG7g0jb3oag2yZU5Spz/ZUEgmUipsU86z0pVL3FxR6//QN
         kxaqiS2Zr+icHFY46cR1DdLQyR2JV3Kl7VXyqhihtf1spnEG8rHWeGd30s+2CsHlrV47
         hCV716Etui7I3KDi6cRHGwKQgR4wzmbXlZqR4/B+0ELBpjcIVe48P/Gy4RS6t72chGv4
         JhnNVxirlJQRsHCCy4mpxWpDytzinhwaDJnFd7JgVj5NUxUggPEWE11wdQw64Rb03v3U
         bpFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682439936; x=1685031936;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Zk7kzrDRtBMi2c4Bu2LzirjGOH2GjsryrTEUcyl26E=;
        b=UcJmV1JRxV0YOsDUMUE9ql/gDaBXUjNS4XpjagioL8CiG3ehr5qZiMOi9uCw8zIZzc
         dQHCvm2Lm4JLZvSsdD7rL6Kh53SfT5s4iwm2T+TodpeADe2dOc5VdpWG9MSK6862OvUz
         Ey6x5PQuH5nJgYMH1Ei3zv3ZEkoLm3LX/qP8i4K0keCVT2aX4Bn/O1N2pC74LzIRQ+nR
         bzYqOuPQIp3w+m03/g2NC7NcGEQoQ4qArJFXJSoM7GaKEyDIAoX/4nkvaQs87xw1XJ6R
         8Pv4vVHOLy6DpG+ze/Cq7ICIh4Xj2dONf82g7MWsEdph0hmpftpVYKMHJ3HZS2KyBj4v
         UGEA==
X-Gm-Message-State: AAQBX9cBdo0aF22sARX53G4rbiOHnWumf35s9TKWbO3nz9FSUbYmy+uz
        go+/ubx5jI0whFEaeYaTDws=
X-Google-Smtp-Source: AKy350YsQiJ/WyET62xQ8wNXXUxWeD4VRLkceGw20i0IQp83fdD4ClkipMkAA76/jSGrm821ZEfyqQ==
X-Received: by 2002:a17:902:ecc8:b0:1a6:f5d5:b809 with SMTP id a8-20020a170902ecc800b001a6f5d5b809mr23468621plh.1.1682439936386;
        Tue, 25 Apr 2023 09:25:36 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id jm23-20020a17090304d700b001a1faed8707sm1635766plb.63.2023.04.25.09.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 09:25:35 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 3/6] t3321: add test cases about the notes stripspace
 behavior
References: <cover.1682429602.git.dyroneteng@gmail.com>
        <6dfb5bf294dd4038290a4945706c81aececc6d4d.1682429602.git.dyroneteng@gmail.com>
Date:   Tue, 25 Apr 2023 09:25:35 -0700
In-Reply-To: <6dfb5bf294dd4038290a4945706c81aececc6d4d.1682429602.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 25 Apr 2023 21:34:38 +0800")
Message-ID: <xmqqjzy03p4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  t/t3321-notes-stripspace.sh | 291 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 291 insertions(+)
>  create mode 100755 t/t3321-notes-stripspace.sh

Looks quite thorough.

> diff --git a/t/t3321-notes-stripspace.sh b/t/t3321-notes-stripspace.sh
> new file mode 100755
> index 00000000..7c26b184
> --- /dev/null
> +++ b/t/t3321-notes-stripspace.sh
> @@ -0,0 +1,291 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2007 Teng Long

It's 2023 now.

> +test_expect_success 'add note by editor' '
> +	test_when_finished "git notes remove" &&
> +	cat >expect <<-EOF &&
> +		first-line
> +
> +		second-line
> +	EOF
> ...
> +test_expect_success 'append note by specifying multiple "-m"' '
> +	test_when_finished "git notes remove" &&
> +	cat >expect <<-EOF &&
> +	first-line
> +
> +	second-line
> +	EOF

Inconsistent indentation confuses readers if the author meant
something unexplained by the difference between the two.  Stick to
one style (I personally prefer the "indent to the same level as the
starting 'cat' and ending 'EOF'" but it is OK to pick the other one,
as long as it is consistent within a single test script).

> +	cat >note-file <<-EOF &&
> +		${LF}
> +		first-line
> +		${MULTI_LF}
> +		second-line
> +		${LF}
> +	EOF

This is a bit misleading, as there are TWO blank lines before the
"first-line" (one from the here text itself, the other is from
${LF}).  

I do not think it matters too much, because the point of stripspace
is to remove any number of leading or trailing blank lines, and
squash one or more blank lines elsewhere into one, so having two
blank lines at the beginning or at the end of the file is just as
good an example as having a single blank line.  I am mentioning it
primarily because I had to spend some time thinking about ways to
make it less misleading.
