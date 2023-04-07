Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 065D2C77B6C
	for <git@archiver.kernel.org>; Fri,  7 Apr 2023 23:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDGXrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Apr 2023 19:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjDGXrH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Apr 2023 19:47:07 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB69E19A
        for <git@vger.kernel.org>; Fri,  7 Apr 2023 16:47:06 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id la3so6881plb.11
        for <git@vger.kernel.org>; Fri, 07 Apr 2023 16:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680911226; x=1683503226;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rai72OjBlZMOTTM5HvKbxcK2nTHtZ82Bzre739bTFk=;
        b=qzOCeh3nuHR5s3UXzNVA/L3rjrn8llPFjHGLlWW8BiMNZJeXoLUVlE4TeL/URdCBEs
         +LKfiIWbUHq8dxrJ3UwdgCYaeKuyuE//ND4zzInHZPM3OAA6LwXsSL2PapmtcIMZWtOo
         n9Bj6Pr6ZvXWGEn48YCtO0WbWiyPUgN43pD95IQLR9MZf7pEWN0cep8UmqGIIZQ3X8Py
         z/THVSaXMSQiyTTwhUZ5Lbk3NqT5wrAoEzoMUooFXsmEvEByhJQHKZrGM0HNC0vV6XMj
         zR/Rb5aH+bfHDZhGh5GG2GxfGohvlQORblv8P254EwmtsZO4EWNl0CLyUSxn+mxJU3Pu
         bN1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680911226; x=1683503226;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/rai72OjBlZMOTTM5HvKbxcK2nTHtZ82Bzre739bTFk=;
        b=vrBWeqipirEIODMD7BxQOG4ysuaY8DmUmOIx69H28RuEH8Jj9brlB1uU4D5wUMsiKt
         6U9iHUempihsG8Amt9Zv8j/UvpvG5GnvWv6GOrmDUQHvqPP4KdgBcDF+JfNkEfy7UqEn
         3Zx4OAwKcKr6kr+TvzwhGkVZmF+qEbc8ofVopTK6GJ0MKF9Ri+9ZOIR8gHgGysJNMevD
         wucjCorn0mbN8MXvBKY2NSLnhodnwVaAa7qs2YVuBScQuJT5RG0uS4/2DszWmG7mQu0w
         qX0oX/ktBRPWU6zGZ82/Z1IaLYTlUZM4VC37qbS0tKvtd8hhe/PcipMzIWB7f6+3Ljvq
         vDMA==
X-Gm-Message-State: AAQBX9cVSSfp/HTAQ2+ytHnljupbd1qHuurf2tD9qAubGMlHiESXPdBs
        PzH2a1cEG4MlzTBpqeWJlok=
X-Google-Smtp-Source: AKy350bRDzw6Foaw+XYIB0f4CqiiOu/4XzaD2WCRa1Dsq/DCb25DuT7CFHX99GkObyNXzqfWid0W7Q==
X-Received: by 2002:a05:6a20:8c30:b0:e8:e34e:f893 with SMTP id j48-20020a056a208c3000b000e8e34ef893mr3147502pzh.0.1680911225654;
        Fri, 07 Apr 2023 16:47:05 -0700 (PDT)
Received: from localhost (254.80.82.34.bc.googleusercontent.com. [34.82.80.254])
        by smtp.gmail.com with ESMTPSA id m6-20020aa78a06000000b006255a16be2fsm3555260pfa.132.2023.04.07.16.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 16:47:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] usage: clarify --recurse-submodules as a boolean
References: <ZDCWrl4GhgYKYFYG@google.com>
Date:   Fri, 07 Apr 2023 16:47:02 -0700
In-Reply-To: <ZDCWrl4GhgYKYFYG@google.com> (Emily Shaffer's message of "Fri, 7
        Apr 2023 15:18:22 -0700")
Message-ID: <xmqqcz4fi7bd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <nasamuffin@google.com> writes:

> `git switch` `git checkout`, `git reset`, and `git read-tree` allow a user to choose to
> recurse into submodules. All three of these commands' short usage seems
> to indicate that `--recurse-submodules` should take an argument. In
> practice, ...

Did you add 'git switch' at the last minute in so much of a hurry
that you forgot to put a comma after it, or rewrap the paragraph?
;-)

I do agree with you that "git checkout -h" and "git reset -h" that
list

	--recurse-submodules[=<checkout>]
	--recurse-submodules[=<reset>]

are being unnecessarily confusing by not saying anything about what
these placeholders are to be filled with.  

This however is a breaking change.  Even though there is no hint
that <checkout> and <reset> placeholders above take either Boolean
true or false in the documentation, they may have picked up a habit
to use the undocumented form from some random website.  I am not
sure it is safe to change the behaviour right under them, like this
patch does, and I wonder if we should do this in two steps, with its
first step doing:

 * "--[no-]recurse-submodules" from the command line gets no
   warning, as that is the way we recommend users to use the
   feature.

 * "--recurse-submodules=$true" and "--recurse-submodules=$false"
   (for various ways to spell true and false) get warning that tells
   the users that versions of Git in a year or more in the future
   will stop supporting the Boolean argument form of the option and
   instructs them to use "--[no-]recurse-submodules" instead.

We may have to also mention in the documentation that historically
the code accepted a Boolean value as an optional argument for the
option by mistake, but we are deprecating that form.

And after the second step, the code will end up looking like what
this patch shows.

Thanks.
