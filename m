Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6743AC77B60
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 21:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239935AbjDZVdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 17:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbjDZVdf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 17:33:35 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28BA40C8
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:33:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b5c4c76aaso5514567b3a.2
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 14:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682544811; x=1685136811;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gMgtE3xOuJbsHumMVABUcefMf1I0tc4AGw9a4IK87dc=;
        b=q+TAGgG17BlaKDhKlFEEtJOUiKVc7IUEKn+t0AP9Gst33vQNdKiJn5vdyW263MuqX0
         4OLyzCtc8UNawE5e8SWQI4ipNyyAgynv9Wq4TTvgIcHp8TUKaxH0B+Et2j/m5Bv+moEP
         4O4aXp3haXb1fVkkxIqiE/XUNMiS8uH/k+63BaaharsPui+nVuXYlzCix70AEzGLxA+t
         C0sAUbT8/eHInPgprGe+1KdNzjiNq+IXfOdsw8Ahlsu00sc0w1zG90q+02gqqr6eRXHb
         GLY9pGyU7elD3bBWJDCGeZ0DA/hNTT//RgEpwZIaWpzjfM/avxn0DZfawOLeIvwy7bDW
         zWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682544811; x=1685136811;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gMgtE3xOuJbsHumMVABUcefMf1I0tc4AGw9a4IK87dc=;
        b=BaR8kkp+rIA1BuU30Ya0DvDckj95GLE8vPBc+MDiEUCPt299yHZzkl/mSvKRUNWP5H
         FEISi0MB8qovhsS9IHXEHCUH5MkDq6FnNlpxJKzpaYYUoslocVKXzk9IToLu1aODLX3b
         32rtTiHagiYv4WTrYF7mr2EWL+xYm2zEinekRijASg04mWTCw96qCgo5W1VjxBFWBozN
         qzxGWkIkFvlvT9ZfpoqTawGruwhocgJJH4eQMRUQQLqgTuf3QHU+88bFi1M07HPaBtIP
         WY3I2p27VPIsNku9717YDyee5AX0nXehnv4y8b06FVlLydUMbcOfGCaPajThWBvnz+LE
         fL6g==
X-Gm-Message-State: AAQBX9eptZOn+4F1czgsxGVCVGptByXx68WrSjQ8WFF0m9N70iP3PJxr
        3vupfHNWFq3QMk7GGjkCZIE=
X-Google-Smtp-Source: AKy350ZdX7al8/iWulyhPg/mHylwLXCRgCHxVcLe2/e5TVVWqJTdgBZ/9H8Uz2bLNZI36GKD3FKgCg==
X-Received: by 2002:a05:6a00:b8b:b0:63f:1926:5bb8 with SMTP id g11-20020a056a000b8b00b0063f19265bb8mr22691895pfj.30.1682544811173;
        Wed, 26 Apr 2023 14:33:31 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id v7-20020a056a00148700b0063f534f8060sm6861564pfu.168.2023.04.26.14.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 14:33:30 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Adam Majer <adamm@zombino.com>
Subject: Re: [PATCH 2/2] Honor GIT_DEFAULT_HASH for empty clones without
 remote algo
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net>
        <20230426205324.326501-1-sandals@crustytoothpaste.net>
        <20230426205324.326501-3-sandals@crustytoothpaste.net>
Date:   Wed, 26 Apr 2023 14:33:30 -0700
In-Reply-To: <20230426205324.326501-3-sandals@crustytoothpaste.net> (brian
        m. carlson's message of "Wed, 26 Apr 2023 20:53:24 +0000")
Message-ID: <xmqqbkjaqqfp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>  `GIT_DEFAULT_HASH`::
>  	If this variable is set, the default hash algorithm for new
>  	repositories will be set to this value. This value is currently
> +	ignored when cloning if the remote value can be definitively
> +	determined; the setting of the remote repository is used
> +	instead. The value is honored if the remote repository's
> +	algorithm cannot be determined, such as some cases when
> +	the remote repository is empty. The default is "sha1".
> +	THIS VARIABLE IS EXPERIMENTAL! See `--object-format`
> +	in linkgit:git-init[1].

We'd need to evantually cover all the transports (and non-transport
like the "--local" optimization) so that the object-format and other
choices are communicated from the origin to a new clone anyway, so
this extra complexity "until X is fixed, it behaves this way, but
otherwise the variable is read in the meantime" may be a disservice
to the end users, even though it may make it easier in the shorter
term for maintainers of programs that rely on the buggy "git clone"
that partially honored this environment variable.

In short, I am still not convinced that the above is a good design
choice in the longer term.

Thanks.
