Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660F9C6FD18
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 15:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjC1PyT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 11:54:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233956AbjC1PyE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 11:54:04 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0285C49E0
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 08:54:04 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id ix20so12122855plb.3
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 08:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680018843;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+iJmi506CTj95b3d0rRt3cLBKyR782GvrdpTvp7KbFk=;
        b=HkW/+ICVsI7a4DpVyAMscfNOoARJ8yZHvurMbVJmAl6hI1q+jgwSiZS+WySkRxhGTS
         l3W2xNdRBYjWd1MO0mu1WYn58ky1wNg+W+Znyjx/ksVD1M5DLczJ9Fi6cxw9wn37MGDu
         WmM0lsgJqR34gF/gZiguh1iQFZgWj80LUm0AybMwcOS1MzEpGUlnZQJ+5AHRsD8tU5SM
         FyN8iigll2YCFEcp9D+iwb/Jz3m25rtMkWI44iMYYAr5NUo0w6vx7PWv3z9lYO+e0zjP
         0LDJ3XftWRQjp0uJvn3RMXFwr2tBK/r05XWvt2HIINqpOGlJn20yBJ5y/JeOr78pzCO3
         RKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680018843;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+iJmi506CTj95b3d0rRt3cLBKyR782GvrdpTvp7KbFk=;
        b=JoitzrIn9sLCYILKf8C4k0f1YGLSJOx8u9tu7/IdT9pYbsXHGbFwj/WJiNXsSa2taW
         biMLsypx2lsyaYAB8sGyudHTC3ZkR+N/iHpIs3LOtx2Vtd/PrDx8OFGOW/Ury8hzfnNc
         0XaVdsRJURdRoLVI3pDdt1whxUrNORKynUjsmSrrW4PZ5nLi0OGjQanJ8hH/DIlfVvzH
         Lrsmgxu4UgipVoBwbWJiFVTdWBIMdl/8kIzEtuwNHsyZulc25KcZiTIeUUzEIRTItslk
         q+LUiF7oEr1tReSicQCf/V14OzYZmLZf9nXCBb8udHY1PJ/EHu0bZcTt9FsKueWTM9Jg
         ukIQ==
X-Gm-Message-State: AAQBX9ff4yTndxdc4/t9k2qTpH8+Pv16D7IFHbjukcd4slaeh9zAgoTz
        KO5Sr2cMYsfSzg22r300Uek=
X-Google-Smtp-Source: AKy350aXvpGQUM0Eetm3WrqvjP1PVqNytmlaj+Ku6ZEVoahZ2C1dCkeWvBXIbmwe/L2adi11s0n0Lg==
X-Received: by 2002:a17:90a:be0c:b0:23f:5a76:506 with SMTP id a12-20020a17090abe0c00b0023f5a760506mr15760036pjs.46.1680018843266;
        Tue, 28 Mar 2023 08:54:03 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090a49c200b0023b3a9fa603sm6185990pjm.55.2023.03.28.08.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 08:54:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     avarab@gmail.com, git@vger.kernel.org, sunshine@sunshineco.com,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v7 4/4] notes.c: don't do stripespace when parse file arg
References: <cover.1680012650.git.dyroneteng@gmail.com>
        <b9d12f0c5f31d11f89993e476d461fe3f13de705.1680012650.git.dyroneteng@gmail.com>
Date:   Tue, 28 Mar 2023 08:54:02 -0700
In-Reply-To: <b9d12f0c5f31d11f89993e476d461fe3f13de705.1680012650.git.dyroneteng@gmail.com>
        (Teng Long's message of "Tue, 28 Mar 2023 22:28:47 +0800")
Message-ID: <xmqqsfdog9d1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> From: Teng Long <dyroneteng@gmail.com>
>
> The file maybe is a binary and it could contains multiple line

"could contain"?

> breaks, if we do the stripespace on it's content, the notes will

"stripspace"?

> be different to the original content.

If a file is "binary" then by definition there is no "line" and no
"line break" in it, so while I can see what you are trying to say,
this needs a bit rephrasing to make it easier to follow for future
readers.  Perhaps something like...

    The file given to the "-F" option could be binary, in which case
    we want to store it verbatim without corrupting its contents.

But I do not necessarily agree with the logic here, regardless of
how it is phrased.  Existing users are used to seeing the contents
fed from "-F <file>" get cleaned up, and to them, this unconditional
removal of stripspace() will be a regression.  Besides, don't they
expect that 

	-m="$(cat file)"

be equivalent to

	-F file

for their text file?

A --binary-file=<file> option that is incompatible with -m/-F and
"append" action may make sense if we really want to have a feature
to help those who want to attach binary contents as a note to
objects.

