Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC1CCA0ECA
	for <git@archiver.kernel.org>; Tue, 12 Sep 2023 08:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjILIDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Sep 2023 04:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232198AbjILIC6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Sep 2023 04:02:58 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5571049FA
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 00:59:28 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502934c88b7so8474041e87.2
        for <git@vger.kernel.org>; Tue, 12 Sep 2023 00:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694505566; x=1695110366; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tmnO62HXyWk0kpVFR1NKFDlZyW+dvO0lRtX/OSi88os=;
        b=CzQgjNNFiWV6MOIbSVYd8EYnBlcJ1L+1MZJj32luOBPaYSffJuGUhqIwklcMfJNPVj
         eqtuutaxt7KCpf6DEWbm2EWJW26IeWQI8SmzHjGmSBe0iRLtdSpI1Yyy2IHq0Zk+mzzo
         LVqV/ub7yv1DKTau6w6jMBuH1YgWTKylTe6CkzZ7oUR2AoMhn3H79mUiGRlZtF0mNXYp
         nzy2CjaOhUc2mOIfgj3h1LZZ+m/VgwIBR5kNm1q77ew/FFpeXVGgbGLh0vRqEqryPQ+l
         7TeB8JD4FDyiF52esnZ7USdyZExWX5ptfFr0xznm5wfSCCD5BjC6hrtc3WU1V4h5SQOx
         RLEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694505566; x=1695110366;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tmnO62HXyWk0kpVFR1NKFDlZyW+dvO0lRtX/OSi88os=;
        b=S/LvQgtXFfIHvCrTQkNFmLDMAMqDhn5jd9Espqi7Dfs07a93XolyLWTuMz2hEKgN+W
         DcEJEUwPkezweqMmLR3GYmhzYjJ2i9QCIK32csjBBhsZ0UtNXjvv/LJZgbrok0iSr8v5
         uBV5DrujNNkvEn7QuCAIpEeWjiRt+a7aO34SglrnHkp/wUTUiQaRZK/4vaYGI4ZcgsTo
         B8qcLxtS0yrjaNWsGb4CVMkvLQbL9lL/ECrvBGHj7s+v61kvgeZ5zqXWS7tAmoMbLyOm
         9lKVVQki28LQ6xNKwiKReouuCh32AndYGGwFgVBpGwQg43xJbT9yHH+9aGEPI/JARhaY
         vzcg==
X-Gm-Message-State: AOJu0YzvQxX99Vu7IliSoLgohro7Kwx4UggOqIq9p+TPBCVABMiY0rKr
        Ji/aSiDCJlj+8DoEUU0WRzhIDoLMzCU=
X-Google-Smtp-Source: AGHT+IFIE7u216akzRzf0GPh5bZWQthV6O3Oq6po5IQgkQATEXZKfbVNIyy/USA+sn+0C3ecuw/bZA==
X-Received: by 2002:a19:384b:0:b0:4fb:772a:af12 with SMTP id d11-20020a19384b000000b004fb772aaf12mr7419436lfj.21.1694505565990;
        Tue, 12 Sep 2023 00:59:25 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id k24-20020ac24578000000b00501c8959f6asm1665975lfm.98.2023.09.12.00.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:59:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff-merges: introduce '-d' option
References: <20230909125446.142715-1-sorganov@gmail.com>
        <20230909125446.142715-3-sorganov@gmail.com>
        <xmqqtts0tof8.fsf@gitster.g>
Date:   Tue, 12 Sep 2023 10:59:24 +0300
In-Reply-To: <xmqqtts0tof8.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
        11 Sep 2023 14:01:15 -0700")
Message-ID: <87o7i7hler.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> This option provides a shortcut to request diff with respect to first
>> parent for any kind of commit, universally. It's implemented as pure
>> synonym for "--diff-merges=first-parent --patch".
>>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>
> Sounds very straight-forward.
>
> Given that "--first-parent" in "git log --first-parent -p" already
> defeats "-m" and shows the diff against the first parent only,
> people may find it confusing if "git log -d" does not act as a
> shorthand for that.

It doesn't, and I believe it's a good thing, as primary function of
--first-parent is to change history traversal rules, and if -d did that,
it would be extremely confusing.

Also, --first-parent is correctly documented as implying
--diff-merges=first-parent, not as defeating -m.

> From the above and also from the documentation update, it is hard to
> tell if that is what you implemented, or it only affects the
> "diff-merges" part.

If we read resulting documentation with a fresh eye, -d is similar to
--cc, and -c, just producing yet another kind of output, so I think all
this fits together quite nicely and shouldn't cause confusion.

>
> Other than that, the patch looks quite small and to the point.

Thanks,
-- Sergey Organov
