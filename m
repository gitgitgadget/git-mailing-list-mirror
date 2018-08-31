Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5B0C1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 18:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeHaWj4 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 31 Aug 2018 18:39:56 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:37733 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbeHaWj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 18:39:56 -0400
Received: by mail-qt0-f195.google.com with SMTP id n6-v6so15587034qtl.4
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 11:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Tomsf4T6jgXAZ3j5kNq6pufDBRLEsf/XcoEBR3UdVDM=;
        b=FOjOlIYSo+rCokPQa0iiY11+x/+Wi0HE5v5qpGU/y2yw96MeE1oOJivxV7puDZ3G39
         ElhPLVpqAH73ysQorjFUd7hSktIeZeo/8p1i09C6WJVfw9PuVAG3CCfLQ5QwVes26Ibb
         HjmvgYxfKkmfLzkfW4B4VIasN7vEhieM/mvB0AWXBFHqudSqUlJUGNu+ZDn1hCPRuuli
         hcUwyfavLsdS1ytvR1pxf9+YzANH0aZo39WbUd1Tp4CCU3siYLuTnlv11J/OwdSXxASm
         02Ud+1DiuBCARR37DHBJnEgPz3Gpz6Coh4EY8IwvaNDbOEQq4sOpPi7jzmdfUcdVol0s
         /Xrw==
X-Gm-Message-State: APzg51DlB5z81aa0OtAPtdGvCBC/ir9RmmQiXIGzYEyRDlEDmwTOJ5aC
        Qd2XkTKa1WgdDlcbB2PWYjSuotMlAnRUMdxtLmbFmGRK
X-Google-Smtp-Source: ANB0VdaeYutrhecZpt2ZzuTVSAlaMO6K753JR53KX3R9Y855AoO61kRdP/NmPrpjMn3AEB4nhwgWngZw/1OCfJNbvcE=
X-Received: by 2002:aed:24c3:: with SMTP id u3-v6mr17267797qtc.50.1535740272602;
 Fri, 31 Aug 2018 11:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20180805075736.GF44140@aiede.svl.corp.google.com>
 <20180831083342.34836-1-sunshine@sunshineco.com> <CACBZZX6uCQkCermt8O6v2XB2MnUkt5ER3_z5GYJtGdSk-9JNLA@mail.gmail.com>
In-Reply-To: <CACBZZX6uCQkCermt8O6v2XB2MnUkt5ER3_z5GYJtGdSk-9JNLA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 31 Aug 2018 14:31:00 -0400
Message-ID: <CAPig+cR5VdUjR3zNrNxfkwLnCEE3_KUD9HRhm+BR6LF8FCQ6QA@mail.gmail.com>
Subject: Re: [PATCH] config.mak.uname: resolve FreeBSD iconv-related
 compilation warning
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Renato Botelho <garga@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 31, 2018 at 7:54 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> On Fri, Aug 31, 2018 at 11:52 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > OLD_ICONV has long been needed by FreeBSD so config.mak.uname defines
> > it unconditionally. However, recent versions do not need it, and its
> > presence results in compilation warnings. Resolve this issue by defining
> > OLD_ICONV only for older FreeBSD versions.
>
> This seems sane, but just for context is FreeBSD ports itself just
> compiling without iconv entirely?
>
> I have little clue about how ports works, but just noticed that
> they're not monkeypatching in OLD_ICONV there.

My experience with FreeBSD ports is pretty limited too, but, as I
discovered in [1], they run Git's configure script, so OLD_ICONV is
determined dynamically, as far as I can tell.

[1]: https://public-inbox.org/git/CAPig+cTEGtsmUyoYsKEx+erMsXKm5=c6TJuNAgeky2pcgw18JQ@mail.gmail.com/
