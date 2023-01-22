Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF07CC25B4E
	for <git@archiver.kernel.org>; Sun, 22 Jan 2023 16:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjAVQVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Jan 2023 11:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjAVQVr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2023 11:21:47 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6E531E28E
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:21:46 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id bj3so9720733pjb.0
        for <git@vger.kernel.org>; Sun, 22 Jan 2023 08:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBwsIz4My5C0hDxtnZaDcyzPwZa5Te/4YBMZUDWEP6E=;
        b=ILlnMQWgnEh1zLSPc0oyAELoTwmizeP0FnaJoS5DYPuJ+W8RNrhCHyVeFIjwk9hmqH
         yfPhAY8DzvL2RDCdkecsNKLObwfYm919Si6P0OmPrATXrCHwuBvSudspftlR9Uf73CoZ
         TWs+ZaKqGfjwwTTRxK8ixBlpZgJG+EJc9zJg8laNc1/pzbjEgXVQLnAwgPuUvPtwIpmS
         ceM0+8gzOHLoGe8CrFGEdV+3clEFBHyjWKoYKCSzFRBNnFXue+Z6ygwAk18MrQyf0/vI
         oGzNzFXlFsijgGd6++HvGMA6AYMoqM0NtgvrmJ7FPMzHHgRm8FoibOf8X68Oq3q+6cGd
         Pd2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OBwsIz4My5C0hDxtnZaDcyzPwZa5Te/4YBMZUDWEP6E=;
        b=MBhNSEuOSQaHtdtEqKS9HIVERM2/0EoOJafusMOvQA+67NkqEH4/MtN+2rRn6Io0UJ
         KdupMNw/vfqwCby5o6jdMtRf3lKaRhXI2+e0ptGmZAwK4fSXXHqED4Hni393wwCHnImA
         YMW6/ejkfEwq8VJJ9n6CNY9arat01YD+5gdfpp9HFY/EICYgNkBkhMPwVGWqk+rl5x4f
         QKIS7EoKvcWqiCMbLB+M7oTySnzzhKRd/ixGuEMVFlj62oV/3IeuxmCrNEneiLcvX5dv
         scwu72jgiMHeSvLKQt0cCOa8s8XAlUT5bPwmOsBgvcj1lIKc5ba5VscNZ61NVoDl352Z
         7MYg==
X-Gm-Message-State: AFqh2kpr6N9hobRK9D5KbfsMxqdI0YR2w0T2UETaFwOuyDijdijjBYnq
        bFC/0m8IH6HJPjY/gpakK182XDYHQIQ=
X-Google-Smtp-Source: AMrXdXuY8j3W7HlDAb0vWBp4+e+k97FAOsPzLBWYO/PcYOuVTOUrYyDpqL5Vqa8GMrcxBD0u41rb5Q==
X-Received: by 2002:a17:90b:2347:b0:228:f6d0:f14d with SMTP id ms7-20020a17090b234700b00228f6d0f14dmr22334469pjb.32.1674404506108;
        Sun, 22 Jan 2023 08:21:46 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090a5e4200b0022a1df960e7sm4996636pji.57.2023.01.22.08.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 08:21:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/1] t0003: Call dd with portable blocksize
References: <20230122062839.14542-1-tboegi@web.de>
Date:   Sun, 22 Jan 2023 08:21:45 -0800
In-Reply-To: <20230122062839.14542-1-tboegi@web.de> (tboegi@web.de's message
        of "Sun, 22 Jan 2023 07:28:39 +0100")
Message-ID: <xmqqtu0isfom.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten Bögershausen <tboegi@web.de>
>
> The command `dd bs=101M count=1` is not portable,
> e.g. dd shipped with MacOs does not understand the 'M'.

Very good piece of information to have here.

> Use `bs=1048576 count=101`, which achives the same, instead.

I'd locally tweak (read: no need to resend) it to

    Use `dd bs=1048576 count=101`, which ...

and downcase "Call" on the title line.

A tangent.  I wonder how portable 

    dd bs=1024x1024 count=101
    dd bs=1kx1k count=101

are in practice.  "Two or more positive decimal numbers (with or
without 'k' or 'b') separated by 'x', specifying the product of the
indicated values" is from POSIX, but I haven't used it myself (I
know GNU dd groks it).

In any case, thanks for the update.
