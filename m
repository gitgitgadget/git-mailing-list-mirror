Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78828C433ED
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F8CB6108C
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 12:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236257AbhDQMgb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Apr 2021 08:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236058AbhDQMga (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Apr 2021 08:36:30 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098CDC061574
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:36:03 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id e14so45956726ejz.11
        for <git@vger.kernel.org>; Sat, 17 Apr 2021 05:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=yotYPzrGwxi3vX8HfzA3tIHXA5BFilQjcr55GVWQd4Y=;
        b=gJVHi4lR9OZg5Ah4GBjjjypcUxA3zBtt+BpgCdjeYpzsB1ftCI+VucraI35ZTcZUg5
         fZo3Rta01c4guS5w1m4DurBQ4No1s6Sr5ASFvF4kCBhCV7nn0yjpVYm+E/CdwoI8NEzZ
         4Tdg5QXVn5xYMwufWJMeYtloM5zVVF8+wY0aqM5OLmvBAegIEBP7LBAoHa0+9KGpaVMR
         I0HS4cFUdUptzo0OVacfG/LdfSvE1Is51miRfxOcLYd82G06Fbf/01Zli+C8p5+4NJKS
         0ohw204gOvS0qBg0VqZr+s2VAVbHbTnsrLnXE0K4lYeF0OpwTz8uFQbnMbCRAbHqPgvE
         tqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=yotYPzrGwxi3vX8HfzA3tIHXA5BFilQjcr55GVWQd4Y=;
        b=udstJHBpmeI2l/infUHFhejKTntvzNKph6r4pz29rFpTdWbA2uvYSX1hb8Nj5aR2+g
         Q6ANu+yXUL6wSeJr+HV76x/f3uyzTBCql/aHslgWe4GyBQ175AlMs+5kRo6seV5UKrVY
         3aoDAHuJfxObsF1QYh2s9ydN/pZYsL7zbOcqIFbLT4Vn9ZCwn/ytPAjSTakdyZB8n6yF
         Onzrc9XOIuua2olS9Nff2/bejMRxQbbug3QQHz4Fl6RrkHV1YaC56u7aNw47UG6XwUZ2
         10F5YhUWY9dHuwGq1LrptDOIW0t1ghvglALjTcKh3mxzgb2KHejPtTM4ZFFbFpdwH9Kd
         kjEg==
X-Gm-Message-State: AOAM5329RnW0Ok+XwmDzOkO7Qw3BwqNmebCjBBlJvNVPkUBBtOWW4ibl
        Kec/fKdUHRzHVucqlx0eVWfwElqm3KmzmQ==
X-Google-Smtp-Source: ABdhPJx9zBvY53vYpwxjvWCbeA2BB5+TCCGeKhlN0SaQ2/XZsUwfXAzEs391IrvzbQXQ4Unqwh41DA==
X-Received: by 2002:a17:906:4407:: with SMTP id x7mr12793735ejo.546.1618662961784;
        Sat, 17 Apr 2021 05:36:01 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id 9sm5732426ejv.73.2021.04.17.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Apr 2021 05:36:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] CodingGuidelines: remove suggestion to write commands
 in Perl/SH
References: <patch-1.1-83266f30b67-20210417T084346Z-avarab@gmail.com>
 <bcc64c2d-3469-38ab-3234-fa8984a3d0f9@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <bcc64c2d-3469-38ab-3234-fa8984a3d0f9@gmail.com>
Date:   Sat, 17 Apr 2021 14:36:00 +0200
Message-ID: <87r1j91427.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Apr 17 2021, Bagas Sanjaya wrote:

> On 17/04/21 15.43, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Since then the consensus changed to having no new such commands unless
>> necessary, and existing ones have been actively migrated to C.
>
> What I implied that when we need to implement new commands, it must
> be directly written in C (steeper learning curve and more tedious
> than implemented in shell script), so I'm against this proposal.

I updated the v2 of this to note that I'm not really proposing anything
new, but just bringing the document in line with reality. For a long
time now we've rejected any new non-C things being imported into the
tree, unless those that fall under the "such as an importer to convert
random-scm-X" language that's still retained in the CodingGuidelines.

I think that even if you or someone else wanted to write a new thing in
Perl or SH we'd want a new way of doing that now anyway,
e.g. git-send-email.perl should really be a helper for a C program
rather than a stand-alone thing.

I.e. even if the main logic is still in the *.perl that code would
really benefit from first doing the command-line parsing etc. in C, so
that it would behave the same as everything else in that regard, ditto
for its config parsing.

