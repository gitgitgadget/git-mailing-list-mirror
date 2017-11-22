Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBBE320954
	for <e@80x24.org>; Wed, 22 Nov 2017 18:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751888AbdKVSSk (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 13:18:40 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46263 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751640AbdKVSSj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 13:18:39 -0500
Received: by mail-qt0-f194.google.com with SMTP id r39so24896734qtr.13
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 10:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=BE6RHCOJaqW3xPNP1fSCkYp+jV2rtOnIba1wE3Za6xQ=;
        b=ZGI1fv6DJh9IwXDvTdQ+htgpoX1AwwriUQwv8p5dkHvPuwtjwRiIxUGYXqXa+xyRKE
         S4ylbD5YSz2kE7G8CafmnKq6MTEnTbvMBodxppLCtU12JxkVGVf6I2SpYMc0ohco0//q
         yFw17zmtI7ut6VK3+MPQ3lLiViB4qgaH+4AJLzp+kL3I74pgB7jJTOkXxwUVOB59oTSh
         vEobAqEZiZo6VDQVbO+AgrQwOIWHzAA5Vs2GwC0dVvgc4DdKXCkfAF1xXnhxFd027m7h
         yqwHn5gDungC/9yAyj2nQLEQuEMoNVfOjDiYZRI4NmELtEx4aEDco3qUaReLNLZox1Fe
         S86g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=BE6RHCOJaqW3xPNP1fSCkYp+jV2rtOnIba1wE3Za6xQ=;
        b=aB0UKQUGPVVsRSoJSyzho3sg89LhH3kqd3tPjfGXCLkoSPDGAvUNj9+Bh3YS3ZyokC
         EeJ5V5SUlKKtu49vNw1eYb5rKoOrWzZHQOGPrt+r3ghBapDmmKHRSc4y1SA7nZOVcPfJ
         LPmbxGJfAEJSi0Y6wf0rs5jFDWXL2eWXGMJsoLQEKHPC1ItMS+wQYKzS4/0nKIx3CxeW
         iefSHtJoXHaKPfWyq+ef+h3hgARR0fuiiAQ0CMjRkzCEUv2P0L59+d9HZdzv/QuyWpAG
         /w4q51kQY9GFBoocteIKoIN7Zguj66K26SCLWy/u5gwNiyhRvKaIvhKd09ofPIGZ7bNl
         8E7Q==
X-Gm-Message-State: AJaThX7N1uom0Xfhrz/eY96yaHCFEMKgeSMoPZcWsRVh2Ziu5V5T+hzy
        GO3pC1LhvoFgOsTy65q4PB9vmdG/fYAmqE3rOSs=
X-Google-Smtp-Source: AGs4zMYFLjYI/vXb+PftVGxBS/Qfu36wyAYr1Bx2kooCd1e/zS7KNQzzTqoB6EIkRBE1s/M8Hd6CiUl4j6+8TwnvWFE=
X-Received: by 10.200.39.104 with SMTP id h37mr33826332qth.114.1511374718970;
 Wed, 22 Nov 2017 10:18:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Wed, 22 Nov 2017 10:18:38 -0800 (PST)
In-Reply-To: <20171122133630.18931-2-avarab@gmail.com>
References: <20171122133630.18931-1-avarab@gmail.com> <20171122133630.18931-2-avarab@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 22 Nov 2017 13:18:38 -0500
X-Google-Sender-Auth: Q_COCDkrYTp_0gKIedrCvV_ovDQ
Message-ID: <CAPig+cS_R5wcJQNavGSgNQXtbXNbDsTDhj8cbSZ5BBxRqU8yRQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] grep: fix segfault under -P + PCRE2 + (*NO_JIT)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 22, 2017 at 8:36 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> Fix a bug in the compilation of PCRE2 patterns under JIT (the most
> common runtime configuration), any pattern with a (*NO_JIT) verb would
> segfault. This bug dates back to my 94da9193a6 ("grep: add support for
> PCRE v2", 2017-06-01):
>
>     $ git grep -P '(*NO_JIT)hi.*there'
>     Segmentation fault
>
> As explained ad more length in the comment being added here it isn't

s/ad/at/
s/here/here,/

> sufficient to just check pcre2_config() to see whether the JIT should
> be used, pcre2_pattern_info() also has to be asked.
>
> This is something I discovered myself when fiddling around with PCRE2
> verbs in patterns passed to git. I don't expect that any user of git
> has encountered this given the obscurity of passing PCRE2 verbs
> through to the library, along with the relative obscurity of (*NO_JIT)
> itself.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
