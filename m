Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2022C6FA99
	for <git@archiver.kernel.org>; Sun, 12 Mar 2023 21:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjCLVZp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Mar 2023 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjCLVZo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Mar 2023 17:25:44 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85F82D165
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:25:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so15088287pjb.1
        for <git@vger.kernel.org>; Sun, 12 Mar 2023 14:25:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678656342;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cOTKoU6sWEdclKKah8oZh0ITddiz6xo5KU/0LQKdzXo=;
        b=MkdvvjWKAhYJTUERLdanGJgLQJvjQs0TAICBjOAgmY947SoEuzp6sXcaL2n7vcQ7I1
         9EIV9QhzOuhgqbn/2sL57cpCaB3Z6fpkvgndaDLOtcjR/0SjDGe0n8ufQ8Z9dtk/qF/b
         DDFmBTqoBNQwqX/5NEgFxFQJhEYYEvli6/5ULGdf/P8rggsMfBPQrrussn+UwWZFn0eg
         83bsd9CufCUsrSkgxocAU3wzr7/EgwSJ2WavG8qaeOokPR5ikLVAtgeFP1cLjdepwXSU
         ScFfuIMmxYayRdZdZPNfAqSCj6wY3jDRRtL7cukymPq0ltnkNR9pYLRN+xXQ/fG6jVP2
         Fqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678656342;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cOTKoU6sWEdclKKah8oZh0ITddiz6xo5KU/0LQKdzXo=;
        b=F2ivu4nbvWC0IQQ4qmkTpRRXeQRgsw5fsRQb/EsvvuttGOegG4BZe/fC8FufmMW9rL
         GIdeTEFJROvEGLIPsg/xy3uAuFgCjClOJQ43dWlPLm3iQWmLeH5Hgsy7Tjb2bFlCXz4W
         1z+2OW+xYiE0bUJYhG3qlQDNcq14YxxtJYUzl1mzX11DF4fT5l/HculAC01NEFScdbCe
         5J1C7aFknSHimCGDWDZpqkS1Lp5DIsEQBm0Sy/A3PW8HF70xGQMYWWahfoPrXIUzPVwP
         1lD58s3rqxUvYnLJgZjm52Zwr8GYEI1yd2ZPFn+0c6GodD/1ND4B+VMGaH6YfkbS4bPO
         fStA==
X-Gm-Message-State: AO0yUKUpB6pFKmCu1NSmgQGjEpNCaRmskqPZ1uuqIJ7XqPWYOnp4grOE
        k46K+q/bM3POkggSXwdaahY=
X-Google-Smtp-Source: AK7set++UFS40kjXCZcjc60hwCyUWKhl9FA6DWIszeSXJgNDmg5JhDc5pXu7i/44plpsvAGnKiK2Kw==
X-Received: by 2002:a05:6a20:a121:b0:cc:8a62:d0d4 with SMTP id q33-20020a056a20a12100b000cc8a62d0d4mr36267646pzk.38.1678656342188;
        Sun, 12 Mar 2023 14:25:42 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id n13-20020aa7904d000000b005a8512c9988sm3115592pfo.93.2023.03.12.14.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 14:25:41 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Cristian Le <cristian.le@mpsd.mpg.de>, git@vger.kernel.org,
        Matthias =?utf-8?Q?G=C3=B6rgens?= <matthias.goergens@gmail.com>
Subject: Re: Bug in git archive + .gitattributes + relative path
References: <42f13cda-9de6-bfc6-7e81-64c94f5640db@mpsd.mpg.de>
        <c7b21faa-68dd-8bd9-4670-2cf609741094@web.de>
        <8d04019d-511f-0f99-42cc-d0b25720cd71@mpsd.mpg.de>
        <70f10864-2cc7-cb9e-f868-2ac0011cad58@web.de>
        <xmqqcz5lbxiq.fsf@gitster.g>
        <d16c6a22-05d8-182c-97b4-53263d22eaa6@web.de>
        <xmqqo7p59049.fsf@gitster.g>
        <3da35216-ca42-9759-d4f9-20451a44c231@web.de>
        <xmqq4jqx8q6q.fsf@gitster.g>
        <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de>
Date:   Sun, 12 Mar 2023 14:25:41 -0700
In-Reply-To: <f7949f1b-4bad-e1bf-4754-f8b79e3ce279@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 11 Mar 2023 21:47:14 +0100")
Message-ID: <xmqqjzzly84q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

>> I offhand do not know how well it would mix with --strip-components
>> if we leave the leading "../".
>
> Not too well when entries from $PWD are shortened and mixed with ones
> from elsewhere that aren't.  But that seems like a strange thing to do.

Yes, it is a strange thing to do.

> If two sub-trees are needed then git archive should be started in a
> shared parent directory higher up.
>
>> But it certainly would be nice if we somehow:
>>
>>  * can keep the current behaviour where "git -C sub archive" records
>>    paths relative to "sub" for backward compatibility.
>
> Right.  That's what relative_path() provides in the patch.
>
>>  * fail loudly when "git -C sub archive <pathspec>" makes us use
>>    "../" prefix because <pathspec> goes above the $PWD for backward
>>    compatibility and sanity.
>
> Without the patch this fails, but are there really people that depend on
> it failing?  We could certainly forbid it, but do we need to?

I dunno.  It was an obvious way to avoid having to think about
interaction with --strip-components and "../", but there certainly
may be other solutions for it people can think of. 

Also on the receiving end, don't people get upset to see that their
"tar xf" escapes the directory they just created only to extract the
tarball?

>>  * with --some-option, make "git -C sub archive --some-option :/"
>>    act exactly like "git archive :/".
>
> Perhaps I'm reading this too literally, but it would be easier to remove
> "-C sub" from that command. Or to add "-C $(git rev-parse --show-cdup)".
> We could add a shortcut for that (see patch below).

More like

	$ cd some/deep/place
	... work work work
	$ git archive --full-tree :/other :/hier :/archy

is what I had in mind.  Without --full-tree, due to the first bullet
point above, paths in our archive are relative to some/deep/place.

Thanks.
