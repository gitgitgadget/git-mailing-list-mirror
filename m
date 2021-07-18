Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D27C636CA
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 08:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C455610CB
	for <git@archiver.kernel.org>; Sun, 18 Jul 2021 08:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhGRILK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jul 2021 04:11:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbhGRILJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jul 2021 04:11:09 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67EC061762
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 01:08:10 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id t2so18662674edd.13
        for <git@vger.kernel.org>; Sun, 18 Jul 2021 01:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=acjbVErNi/sQmWOjrum9ux2U0Y24/CfDg9qvAJhS5S0=;
        b=j3O6E/8fDEYs6BPw3W0R70qu5tfbrIEgBllxiDNF6LhfgV8jaZFkSr8BwkviLkpfJ9
         /ATvHHQubIo91oSwMxs4uFkKbzbAKAxR0bOTuOAzmQM+78qY5kNOVvzrQXnZUA2lPv1k
         HH5N0dFwMsJNR39FNIotUWtlOyGbcr59NJISOQMjzxFLbjYjN19ITJt6cC/9aimrIr+p
         yhtOm9p8PqM3biekEOwDDNZoahPQRZf4yHSLRzSsgbnUkaeserVZ313e8enLKsBBUCHh
         uPL3YG8f1px1MC0Aawws86zPtULGidK5xlpz8lqXgm9UUHTh+vq+ZK2B4VgQS+NclRwn
         WEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=acjbVErNi/sQmWOjrum9ux2U0Y24/CfDg9qvAJhS5S0=;
        b=sTPqbqFAIuAdWItWzT+RAeBBtZJkSE48NN12r+6+zcqQ9kZR8Hm+XthgQwZhQY2cEW
         VsorzpsetxXN9K/61MLq+wGd7EdryuSyaZH+aH6v/tEnsF99W7LiC3+TIri7N3Wpu3g8
         u2UlLoxBc7NzpjszzZ04xDMHs3YvjWrortrhW4q9CeVYo/Et38Us1zIV8L3yKMqfq44I
         bgytRVrDgqz4PR4RkkXToO6wiWjXTJyFJUhtfxuTFsVjKjbIKh6+lwklmgkL3ZhSZn0N
         CY/EWB0d62Ti6F6KTNhY/p1Rth/UA/4sTqCFe45ZvQGe8FStP/FaUohoVOcebuk1t6oc
         Af3A==
X-Gm-Message-State: AOAM531KIRg2to/DFGCRJVevcfq+PHmapgo6Rbf2KdGW3Iu8AKP1LJn9
        pi6ILGdP/jW17CXWvIBXl9s=
X-Google-Smtp-Source: ABdhPJw/B7kxqCyts+xHN6aKM2Sa8xQR0IbK/ZW9yXTqpx9X1sLxR9bezVxwTktREe75FLSEYNRMrA==
X-Received: by 2002:aa7:cd96:: with SMTP id x22mr27607298edv.102.1626595688453;
        Sun, 18 Jul 2021 01:08:08 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n2sm6098811edi.32.2021.07.18.01.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jul 2021 01:08:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Fabian Stelzer <fabian.stelzer@campoint.net>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: progress test failure on fedora34
Date:   Sun, 18 Jul 2021 10:05:44 +0200
References: <49498ed0-cfd5-2305-cee7-5c5939a19bcf@campoint.net>
 <87a6mo29dp.fsf@evledraar.gmail.com>
 <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAMMLpeQ5Lh8xfqTZoM74f616wE7ZhqWArL1WgGiMtiJSfrYcYg@mail.gmail.com>
Message-ID: <87h7gsvybx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Alex Henrie wrote:

> On Wed, Jul 14, 2021 at 9:39 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>>
>>
>> On Wed, Jul 14 2021, Fabian Stelzer wrote:
>>
>> > Hi,
>> > The test t0500-progress-display.sh in current master fails on latest
>> > fedora34.
>> > The break was introduced with:
>> >
>> > 83ae1edff7ee0b7674bd556955d2cf1706bddb21
>> > ab/fix-columns-to-80-during-tests (2021-06-29) 1 commit
>> >
>> > Kind regards,
>> > Fabian
>>
>> I have not been able to reproduce this, it seems the below E-Mail was
>> word-wrapped by your mailer, which is especially bad here since getting
>> to the bottom of this requires looking at the whitespace.
>>
>> Is there a way you could tar that up and send it (to me personally is
>> fine, or some pastebin or whatever).
>>
>> I am able to reproduce something that looks like this if I
>> s/COLUMNS=3D80/COLUMNS=3D79/g in the test-lib, but given that we set it =
to
>> 80, and that the progress.c code just ends up with an
>> atoi(getenv("COLUMNS")), and we do our own wrapping (with no other fancy
>> logic) in progress.c, I'm not seeing right now how this could happen...
>
> This test also fails for me when using QTerminal or Konsole, but it
> passes on XTerm and LXTerminal.

I tried this on Debian 11 with QTerminal 0.16.1 and can't reproduce it,
resized the window etc., always get COLUMNS=3D80 if I add some printf
debugging.

Do you mind testing with an ad-hoc patch like this on top? It will fail
right away, but should say COLUMNS =3D 80 in the output.

The only thing I can think of right now is that some terminals are doing
some evil trickery to LD_PRELOAD or whatever and intercept getenv() for
COLUMNS and the like, but that's an entirely unfounded hunch.

diff --git a/progress.c b/progress.c
index 680c6a8bf9..dca254b515 100644
--- a/progress.c
+++ b/progress.c
@@ -144,6 +144,7 @@ static void display(struct progress *progress, uint64_t=
 n, const char *done)
                        size_t progress_line_len =3D progress->title_len +
                                                counters_sb->len + 2;
                        int cols =3D term_columns();
+                       fprintf(stderr, "cols =3D %d\n", cols);
=20
                        if (progress->split) {
                                fprintf(stderr, "  %s%*s", counters_sb->buf,
