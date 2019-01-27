Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	URIBL_DBL_SPAM shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37B5C1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 04:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbfA0Esw convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Sat, 26 Jan 2019 23:48:52 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33580 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726404AbfA0Esw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Jan 2019 23:48:52 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so15068847qtp.0
        for <git@vger.kernel.org>; Sat, 26 Jan 2019 20:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kuO/si6K77O6Dm9ta3v+mQ3nToCFAWC1DSitZ+MYBNg=;
        b=VyPHJikYjTVBCngDpXcj0yxafh3swT8uL2ecSP0d0ZAC2gV7VybpNnTFeOw0EeMCgu
         vjhWDC/jMr58oK5ShT+F2xH7recLavWx5A83IdtXrYlpipk8IWSXLUs8J5xWcRsMjUUx
         R9DIEc4iT6i18nvJlqm/CjMsUd+k1Q84jEp0kZVDbPFBN83leAK7IfDB4FckZKc3lqLa
         vPCYlr61VXlICGL86GgSEIxvY1tNT0jlOSnNr3k17Hy8voLeuTOAWOUP+bWG1HDAabNf
         DL8l8lul8QYarZajRVpQa+qi6eAHm3bB72ZRJdSZJnF8bFQeJXZs4qKPoc0HfnTuwUiL
         g91A==
X-Gm-Message-State: AJcUukeHoTFoz5GJlHI82LZP07Y0oPlinnIN6tUGuJ7TEsOO80GUL60z
        m9W2uuD0off6H5M0s6YhZDY8PS4FufWoKSTnogk=
X-Google-Smtp-Source: ALg8bN7zaZ7gQTOtXKZQe9BfOXUeFhYA7cs72yLY+PZKGkMMKbHLiwGoIIKpt/edMAauVKcYqvfrt+1bkvSfMf9LoEU=
X-Received: by 2002:a0c:d29b:: with SMTP id q27mr16063884qvh.62.1548564531447;
 Sat, 26 Jan 2019 20:48:51 -0800 (PST)
MIME-Version: 1.0
References: <20190125215955.30032-1-williamh@gentoo.org> <20190125215955.30032-3-williamh@gentoo.org>
 <875zuc49uj.fsf@evledraar.gmail.com> <20190126010632.GA4000@whubbs1.gaikai.biz>
 <874l9v4x6p.fsf@evledraar.gmail.com>
In-Reply-To: <874l9v4x6p.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 26 Jan 2019 23:48:40 -0500
Message-ID: <CAPig+cQKKqL7QD_nwy8tvHaxuGqBXATVt2Mo+gELpif9aULc6A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] tests: add test for separate author and committer idents
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     William Hubbs <williamh@gentoo.org>,
        Git List <git@vger.kernel.org>, chutzpah@gentoo.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 26, 2019 at 3:53 AM Ævar Arnfjörð Bjarmason
<avarab@gmail.com> wrote:
> Which, looking at this again, you'd only want if a previous test in the
> file was leaking its state. That's not the case, so this isn't needed
> and you can just apply this on top:
>
>      test_expect_success \
>             'author and committer config settings override user config settings' '
>     -       sane_unset GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL &&
>     -       sane_unset GIT_COMMITTER_NAME GIT_COMMITTER_EMAIL &&
>             git config user.name user &&
>             git config user.email user@example.com &&
>             git config author.name author &&

Aside from future-proofing against a test being inserted before this
one which does set those environment variables, these invocations of
sane_unset() serve the additional purpose of documenting the interplay
of configuration and environment, and further indicate to readers that
the test author took this into consideration (rather than merely
slapping together the test without thought). As a reviewer and reader
of the test, I appreciate the additional context the sane_unset()
calls provide, thus think it makes sense to retain them.
