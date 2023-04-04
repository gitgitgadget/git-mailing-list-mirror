Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F848C6FD1D
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 06:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbjDDG5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 02:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDDG5J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 02:57:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA862D48
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 23:57:07 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l10-20020a05600c1d0a00b003f04bd3691eso4462377wms.5
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 23:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680591425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L+z/XBfmEv3ffS4KRALIKDiiP+nzelhlbDnf7JG/2/I=;
        b=Ze/kUqG1BDVhp1NkyRxsa/Sz5NYonV2JetzPVy1toCgdoSwnGFOi6SQTTuEyOTMwfz
         Za3jS1ahSOYwF0IL7PrRmRf4y5hk3AJkNzK64/m1SxIOEEAXHQKz/4s8D0dSQrwr/w1p
         1vwwN2h5nQzQUOezT8K1n9TGi89eSeD4gF/YXYRMGWQVbvqUbWvgZOilDOkgat8Kdmd1
         qinheoZJ7UV1x9GfL1TwUpIbBHC9+gfjuHNA1w7DDAMPJcuQOqDi1C5coOKVBziS49Wa
         tjPUAeZO/g4N/Kk93xXtpRwR8eH0xNWMHRZVLjaksTWkyAEtg/vLty+oX/o2eLpod49V
         pH8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680591425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L+z/XBfmEv3ffS4KRALIKDiiP+nzelhlbDnf7JG/2/I=;
        b=btjb1OI/h9N3h90VkIb+6QKkJ8GceulCIYmgC9XbIx+2wNsgssZAEkpCo9uSgRhjBc
         yZ88KgQB0dIDWSJpLyZujKcEeIjAvv0O2qmPX4jSw/8iGL2KDs5mWR0b17UNoGTVhDs1
         huwZO8hjdeWL4qUjJfbqSgo5Pq7MGlZffYd4qm5/npAR6ahsGGnUoxO2P6aaSG7OQv0p
         TmizgTZNJ48U2E/g68H49S7kbNRhJ5YFqwl+B8CURGDWmf9WKZUZTG4KfnKbAO/lxjA4
         cy8MtfcXVw0oq/g9dBp5oQ0OXmDnwaAMwDWF7gu3tIM6HW6n/nAXVKNEGfX4UEhhU7uq
         Kt/w==
X-Gm-Message-State: AAQBX9ccMS7oeRpXfLB2CVNfzuLR9itCRy3Ohf+IYpfk+UruwWSYNz4Y
        FSWD6jO4g7yEaKlFHhHJ25SZWXAg0zabRqFsh1U=
X-Google-Smtp-Source: AKy350bAChGT+QnAeagE/UnDfrmPXehjEhK9ou4j99vXGkjQ8Wy0ipglwG7z086+Es08phDNXXTYt68GbK8Kvg8EzJc=
X-Received: by 2002:a05:600c:2202:b0:3ed:6979:3ab with SMTP id
 z2-20020a05600c220200b003ed697903abmr464916wml.4.1680591425352; Mon, 03 Apr
 2023 23:57:05 -0700 (PDT)
MIME-Version: 1.0
References: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
In-Reply-To: <2554712d-e386-3bab-bc6c-1f0e85d999db@cs.ucla.edu>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 3 Apr 2023 23:56:54 -0700
Message-ID: <CAPUEspj1m6F0_XgOFUVaq3Aq_Ah3PzCUs7YUyFH9_Zz-MOYTTA@mail.gmail.com>
Subject: Re: -P '\d' in GNU and git grep
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     60690@debbugs.gnu.org,
        =?UTF-8?Q?Tukusej=E2=80=99s_Sirs?= <tukusejssirs@protonmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        mega lith01 <megalith01@gmail.com>, demerphq@gmail.com,
        pcre-dev@exim.org, gitster@pobox.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 3, 2023 at 2:38=E2=80=AFPM Paul Eggert <eggert@cs.ucla.edu> wro=
te:
>
> In researching this a bit further, I found that on March 23 Git disabled
> the use of PCRE2_UCP in PCRE2 10.34 or earlier[6], due to a PCRE2 bug
> that can cause a crash when PCRE2_UCP is used[7]. A bug fix[8] should
> appear in the next PCRE2 release.

Presume PCRE2 is a typo and should have been "git" here?

FWIW the PCRE2 fix[1] has been released already with 10.35 and
backporting to the Ubuntu 20.04 package that crashed in the original
report would also solve the crash with 10.34.

Carlo

[1] https://github.com/PCRE2Project/pcre2/commit/c21bd977547d
