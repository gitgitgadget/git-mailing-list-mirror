Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A46C4332F
	for <git@archiver.kernel.org>; Fri,  9 Dec 2022 23:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLIX6r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Dec 2022 18:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiLIX6q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2022 18:58:46 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC5D78699
        for <git@vger.kernel.org>; Fri,  9 Dec 2022 15:58:44 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id js9so5381444pjb.2
        for <git@vger.kernel.org>; Fri, 09 Dec 2022 15:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQ/x1qpmS4wxiODddEtddxGc8WYAp1b5tbOw5oi0ybw=;
        b=TD/xDvzXkuWrdvnP950qCzVGjqwTe+66f/27a1Nuv05q0BiXy+8Cbwiec4N+M042ni
         iPrwrjOnvpXv4QIKVMPUEBCUQyGY9QxnzuI9SdUIf/jAXJ/Yt8NLV3vlB4AOomCyfx+m
         tgNIAR0i4hs/fpZD0fGx5s8QlLh3qdoU5OOh8IN9x/snhYHEUE2eoPxdmZFvwJ5ArU9x
         31/HVYp3xHahSpQ8/iXtAv4vnxWzSO6c1ugeF4hKR74P4lKIIMreOxOjW/ZXzmjrfv69
         rEqMv4MUDo5ELhp19KYsGlrUkY6EnnnqhQuxKoh+5X7Py76s6etZvh4R/zkrsUvZUwul
         cz2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bQ/x1qpmS4wxiODddEtddxGc8WYAp1b5tbOw5oi0ybw=;
        b=HtLoJqfEXhc1DawBb3CJyTCIL3StFUX2LUrBtP1x6u3yHbNrB3KKKhxVZzH9J6iFB8
         Aog1f5HVeyWeeBbeMo0mwuL/AlLJ3WUF5f5nVLPUmryppPOvfszuDr2mLVPLtXchx7F8
         MjPF1Tm79akRNjAr/niKKlCsSnvuHAgsaKLiC3hex4TTFkzzr304Uz/cOLUY4wlEOqpc
         QoZjI4PSNOkf3g20YOBWlnTRIWVSOde+QXRCXOs7JPeVFzWFRGGMYLW2YJxJ5VZ6HFl+
         Bby2xxn5/wUqoMU8Jw+cDSJge05K7sucboMz0TtQO9t7Z2QnzdQYWadlpEw7377jst30
         382g==
X-Gm-Message-State: ANoB5pkFRTJj6eb/5zqEq3XJRj3tGuUICO3EC5Px+ZxAhwZJWR+Qrv9a
        LehLYXoeQYluBR6Vr6XQ3Fs=
X-Google-Smtp-Source: AA0mqf4zj2KUaYo59fHOm7/09jW6WkaeG3WvIDvKCTAJiXw7n45jD+iUt0QAXLBlPJRsSma6lPht/w==
X-Received: by 2002:a05:6a20:2aa4:b0:9d:efd3:66d4 with SMTP id v36-20020a056a202aa400b0009defd366d4mr12958294pzh.27.1670630324022;
        Fri, 09 Dec 2022 15:58:44 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id j7-20020a655587000000b00476d1385265sm1448597pgs.25.2022.12.09.15.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 15:58:43 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
References: <20221209150048.2400648-1-toon@iotcl.com>
        <20221209150048.2400648-2-toon@iotcl.com>
        <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
Date:   Sat, 10 Dec 2022 08:58:42 +0900
In-Reply-To: <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk> (Phillip
        Wood's message of "Fri, 9 Dec 2022 19:33:37 +0000")
Message-ID: <xmqq5yekyvrh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Toon
>
> On 09/12/2022 15:00, Toon Claes wrote:
>> Since it's supported to have NUL-delimited input, introduced in
>> db9d67f2e9 (builtin/cat-file.c: support NUL-delimited input with `-z`,
>> 2022-07-22), it's possible to pass paths that contain newlines. This
>> works great when the object is found, but when it's not, the input path
>> is returned in the error message. Because this can contain newlines, the
>> error message might get spread over multiple lines, making it harder to
>> machine-parse this error message.
>> With this change, the input is quote-formatted in the error message,
>> if
>> needed. This ensures the error message is always on a single line and
>> makes parsing the error more straightforward.
>
> Thanks for working on this. I'd previously suggested NUL terminating
> the output of "git cat-file -z" to avoid this problem [1] but quoting
> the object name is a better solution.

Hmph.  My knee-jerk reaction was that it is utterly disgusting if we
quote when we do NUL-terminated.  Is your "quoting is OK over NUL
terminating" because "-z" applies only to the input?  If so, then I
would agree that is OK, but shouldn't the quoting apply regardless
of how the input is formulated?  Why do we call the cquote helper
only under "-z"?
