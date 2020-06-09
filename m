Return-Path: <SRS0=lPKc=7W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE03C433E0
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 03:33:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7C7207C3
	for <git@archiver.kernel.org>; Tue,  9 Jun 2020 03:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="CLNAJ3ft"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgFIDdL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgFIDdL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Jun 2020 23:33:11 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D973C03E969
        for <git@vger.kernel.org>; Mon,  8 Jun 2020 20:33:11 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 185so9674505pgb.10
        for <git@vger.kernel.org>; Mon, 08 Jun 2020 20:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=3KRbf/A4XaIfi4hGHgJtDJio2hLFpLnmc1YnBRPFpNA=;
        b=CLNAJ3ft+eRIKPQU2VaOhPJVo6SgnrjDHtbBg5n9XcegpujGt29Fbwe4fsQhLP4fpS
         UoTYYiYeVGBc/9qII3/NQJ5jIcMbPY2AX7YQHCqsitRxvFicQ0obytgHGO3fZK4rdTme
         dOUQLI5ZTq317dGHl99SC9fI8SUb+0eWT03sY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding:thread-index:content-language;
        bh=3KRbf/A4XaIfi4hGHgJtDJio2hLFpLnmc1YnBRPFpNA=;
        b=WFeKcSB4ur8+m2qvAJsr9amYDgMIi0jrAfrbyCKdxmf5WmWATIu1KUvfV8KacxBtBy
         88mhXiEsWlgoQ3beG20danU5vMwZTtbKY/OvAyGDXjcH0t1FRn2B5MrkBtH+Yn5vohsa
         vNOV+1nPnbPq9+qWh4hzrTOqvYlGMylDCPO4XVXVfRHd6971wRnZps/Jleg2/E29AVdH
         TS/YYR8/9/xR8uQvL4MLhzOdopcS4CgeoQCjqXBwUTkMVHNSP6gM98DMKg2lgISkMYIK
         +wFFCpxNY6ewPCz/JvpWgO0NcTNvZLN8Y1pHSrkT4UiCxMQ1oyCFyggho6lR2RxSuTw8
         7Orw==
X-Gm-Message-State: AOAM530MAD+N9BijLtCFKgL9lUEx7Je/dABRTSuBGyc+bT6T0m3wUyKG
        qMdB9dEyeiWTeJVkB8n2QbRlK4/gNvxTMJl/Ak55kRCb3xsL4xpzq88Lgde88w98A9tvJj6jr/A
        S5cc3qOpEI9vLwL2jO3a6DCh8AHbW+xVybLAboOyO29xJn9w8Vvzh0lVOYly3
X-Google-Smtp-Source: ABdhPJx++t5fYU/c2XQlwr8vMfEch7FFAqdpG0A3QQBmB5OOxBHWEA5lYtqLhoYGa5Wv3yiSad86OQ==
X-Received: by 2002:a63:f854:: with SMTP id v20mr23420378pgj.0.1591673590186;
        Mon, 08 Jun 2020 20:33:10 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id f200sm8515814pfa.62.2020.06.08.20.33.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jun 2020 20:33:09 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Pratyush Yadav'" <me@yadavpratyush.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
Subject: RE: [PATCH v2] Enable auto-merge for meld to follow the vim-diff beharior
Date:   Tue, 9 Jun 2020 11:33:05 +0800
Message-ID: <311401d63e0e$b1ffe490$15ffadb0$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdY+Dq2gkD+SYjqlTCy+7U+/wexvoQ==
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Pratyush,

Yes, you're totally right, it's my typo, and it's fixed by my last =
commit [PATCH v2].=20
I tried git merge-tool with meld and found there is "auto-merge" option =
for better experience.
The "auto-merge" was added since meld 1.7 (Year 2012).
Here're some documents for it.
https://meldmerge.org/features.html
https://lukas.zapletalovi.com/2012/09/three-way-git-merging-with-meld.htm=
l

Regards
Lin
-----Original Message-----
From: Pratyush Yadav <me@yadavpratyush.com>=20
Sent: Monday, June 8, 2020 17:50
To: sunlin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org; sunlin <sunlin7@yahoo.com>; lin.sun =
<lin.sun@zoom.us>
Subject: Re: [PATCH] Enable auto-merge for meld to follow the vim-diff =
beharior

Hi Lin,

I'm not familiar with the code so I'll let someone else comment on that. =

But...

On 08/05/20 01:25AM, sunlin via GitGitGadget wrote:
> From: "lin.sun" <lin.sun@zoom.us>
>=20
> The mergetool "meld" does NOT merge the no-conflict changes, while the =

> mergetool "vimdiff" will merge the no-conflict parts and highlight the =

> conflict parts.
> This patch will make the mergetool "meld" similar to "vimdiff",=20
> auto-merge the no-conflict parts, highlight conflict parts.
>=20
> Signed-off-by: Lin Sun <sunlin7@yahoo.com>

... your name and email in "From:" and "Signed-off-by:" should be the =
same. So either use "lin.sun" <lin.sun@zoom.us> in both places or use =
Lin Sun <sunlin7@yahoo.com> in both.

--
Regards,
Pratyush Yadav

