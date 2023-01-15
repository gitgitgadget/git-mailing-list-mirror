Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B18C3DA78
	for <git@archiver.kernel.org>; Sun, 15 Jan 2023 03:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjAODOk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 14 Jan 2023 22:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjAODOj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 14 Jan 2023 22:14:39 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFCDF93CC
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:14:38 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id gz9-20020a17090b0ec900b002290bda1b07so4020989pjb.1
        for <git@vger.kernel.org>; Sat, 14 Jan 2023 19:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l23m/yCkI5haFlOupR8B6R0RbCS9Z2zCk92DrGILLpM=;
        b=lh1FrTDCxHjNOtf0VjLIGc/tFOI/28jZ477f7yNDcp47Fp0KLvFuWSuFEoMx25RaNj
         UKdO6/s1gmaDBnm9aLX3MbBVUzWHctfzPdkrwMf4wj8o+MDJ8bW2F/wO0UTEIBRHd9aS
         8dGRiaYiCw04MGSKgKvBJVE2u1yH4CIJ/sIJATwPsgdan0PxVXfj+q5koQbOwf+nViSO
         ep3RUdz36/TpfGW04gOHjAAFwbU5LXen34py0Z2FLeGoNOJEnfmlxZTCTd1dKhRmPeCs
         mrx5x0urixAigBBBsMgXZ37VDiqoRQNw6RWvfHttSSaKDZximREG2jClq9O5N9AECzQM
         uKBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l23m/yCkI5haFlOupR8B6R0RbCS9Z2zCk92DrGILLpM=;
        b=ybpcSew9PLEibfhXGsdTjXlAWDJJbNyhEtjJvy+eFpr63SkdB7CxZiCBwqJWNZ0WuO
         8gDHX1nPoFvw3fHW0BgEFtGC0vYz8Un4U9vvnmpHXOzWdwr/kFYxPSq24zre4el9d2Ij
         0qjkflEpqRuBoD27bx55QyHq5AE1/wt/8tcOMpOTOgWrxlw0XZvSnzcFxRReyRcAvFAa
         lPxWuZzAjlb/ETQZu7sRleBKj5O4vrpx24U/nsHZQWCLIG/I5hCsR52v8XVIWMzE5egN
         o+S5Ef9nb3FVEY2w5+Fyb/Ptk9IbCENPD5BYrmBcWuHFzywOeONMQhMnLiHR9SgXOw32
         LTWw==
X-Gm-Message-State: AFqh2koNTNzbtba9yBQh/xO6jEFx447uSUb87R9yC9Va4IgWB6xy6RoB
        ZQPscuYUkesdGf/TZ97BFmkDc9/4WxQ=
X-Google-Smtp-Source: AMrXdXvC9II8FL1n7no5FFl/FYaXoFdeURQOFGX4MVB34+w4mlUh2VNQeZyeGEBBWk5fE8mXFXmhVw==
X-Received: by 2002:a17:902:b58a:b0:186:def0:66f2 with SMTP id a10-20020a170902b58a00b00186def066f2mr86983381pls.11.1673752477981;
        Sat, 14 Jan 2023 19:14:37 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b00189ac5a2340sm16618176plh.124.2023.01.14.19.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 19:14:37 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Hans Petter Selasky <hps@selasky.org>, git@vger.kernel.org
Subject: Re: Gitorious should use CRC128 / 256 / 512 instead of SHA-1
References: <9c0fda42-67ab-f406-489b-38a2d9bbcfc2@selasky.org>
        <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net>
Date:   Sat, 14 Jan 2023 19:14:37 -0800
In-Reply-To: <Y8NB21PExmifhyeQ@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Sat, 14 Jan 2023 23:59:23 +0000")
Message-ID: <xmqqk01oij4y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> 3) Illicit contents may be present in binary blobs, which in the future may
>> be need to be removed without warrant and the only way to do that is by
>> rebasing and force pushing, which will break "everything". It can be
>> everything from child-porn to expired distribution licenses.
>
> This is a problem in every Merkle tree-like system.  Most repositories
> have some sort of code review or access control that prevents people
> from generally pushing inappropriate content.  For example, if somebody
> proposed to push any sort of pornography or other inappropriate content
> (e.g., a racist screed) to one of my repositories or one of my
> employer's, I'd refuse to approve or merge such a change, because
> that wouldn't be appropriate for the repository.
>
> I don't feel this is enough of a problem that using a Merkle tree-like
> construction is a bad idea, given the benefits it offers.

While I agree with the primary thrust of your argument, this one is
a bit tricky to reason about.  External rules change and can declare
what has been accepted as appropriate inappropriate on a whim, long
after you reviewed the material coming into your history and decided
it was perfectly fine, under the then-prevailing definition of what
is and isn't appropriate.

