Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B3EC636CD
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 17:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjBJRnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 12:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjBJRnB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 12:43:01 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90448901A
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:43:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gj9-20020a17090b108900b0023114156d36so10129527pjb.4
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 09:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AriyJeJ3mdRFVaAF243rti1tDPiQPFSGDsYr6W6Qog=;
        b=P1x26/NzKVfHZKbbpe5ZjcZiU0hrWcQrEmprEx8YQDpqEMQeDjjWPuxK1uu4W6unQb
         5eWpXYIue+zu93Zep7kTIQHCxQXIGyaMXtht67r665v4aUNT7UNhhMtMwU9fQ6LAhH/u
         diSsyjj07jT0OwCSltnkVNUI9xT9AfoPuGy+mMIJeMooObr6RYbfiRMk84K/KNMhlnpe
         6BD5QF1fvX++lICtc5Dop7bb2PYYNwhA3/LsuzHg6IMU04tx08edAa7ASjUOAl2cYKlK
         kAUTqvMGIcMBz5H4BEaxqYBTpru+0v4HC/Hv//BV8tr3YCAvAOoAOj4pYULiPXq7YwYG
         qGHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7AriyJeJ3mdRFVaAF243rti1tDPiQPFSGDsYr6W6Qog=;
        b=0NzKcXPb+Qj8BJad6jLc33DaKeQOg1WkYtC1nXlDQnz2/4vbsOc2Pt3GNWvqXSnAaz
         ym/RhKshjbJEakavw/R8H529zEoehGOQ6Un4eW6NOs1ZgjFO2ZpCjRWNLVMOBhH8Th2M
         DACcFZaiPsXDQS7j/ooocR0qLTPQpnS9bOJYe8yfaskEIJ+Bc9Nu57EFyGmVV5AQgbx6
         dThoctzoMJmBe+LAzioNJe4gBMeDvANRe/dLxQg0RLfqpNOpZD4sZVXrxyko/XJd2rYW
         TeaqVf/EkyHTQs2V813+FEHx0hVhgwC8dYUsDT5wTqOPG3KSjXuKUhwPPN78gEhGcQED
         HBgg==
X-Gm-Message-State: AO0yUKUvrwvalN+sASIR52vJcD0ICs/0fF0dJ03TLzGXBE2zrkDM+qQY
        thx899+jQGlL+tKDUCz+fxcdTv5ZKxw=
X-Google-Smtp-Source: AK7set80ArJB1InBJ86NqE5eea/pkbr4rxGGMMLmnO0CksgfljBJ1780tunp+1tYImS928zQNW6moQ==
X-Received: by 2002:a05:6a20:6728:b0:bc:fe7e:cfd9 with SMTP id q40-20020a056a20672800b000bcfe7ecfd9mr13279511pzh.18.1676050979890;
        Fri, 10 Feb 2023 09:42:59 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id m3-20020a632603000000b0049f77341db3sm3238895pgm.42.2023.02.10.09.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 09:42:59 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Calvin Wan <calvinwan@google.com>, git@vger.kernel.org,
        chooglen@google.com, newren@gmail.com, jonathantanmy@google.com,
        phillip.wood123@gmail.com
Subject: Re: [PATCH v8 0/6] submodule: parallelize diff
References: <20230207181706.363453-1-calvinwan@google.com>
        <20230209000212.1892457-1-calvinwan@google.com>
        <xmqqwn4qmxds.fsf@gitster.g>
        <CAFySSZAy=k+hgvg9r2NmroUs=BviZjS_KMW_+yO2nPs1dUsc-A@mail.gmail.com>
        <230210.86sffdveio.gmgdl@evledraar.gmail.com>
Date:   Fri, 10 Feb 2023 09:42:58 -0800
In-Reply-To: <230210.86sffdveio.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 10 Feb 2023 14:24:33 +0100")
Message-ID: <xmqq7cwpju1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> Welcome to the club :)
>
> This came up before when I'd been sending mails like this for years,
> without realizing the difference:
> https://lore.kernel.org/git/nycvar.QRO.7.76.6.2103191540330.57@tvgsbejvaqbjf.bet/
> & https://lore.kernel.org/git/xmqqr1k9k2w7.fsf@gitster.g/

The organization makes it easier to identify the cover letter,
mechanically from the thread structure without relying on the
subject line [*], and that is one of the things that the procedure
to prepare the "What's cooking" report needs to do.

	Side note: When the "What's cooking" report is updated, it
	knows individual commits on a topic, and the message ID of
	the patch for each of these commits (they are recorded in
	refs/notes/amlog).  But the message ID of the cover letter
	is not recorded anywhere because it does not become any
	commit, so it looks at these messages to find references
	and/or in-reply-to.  A flat "everything including cover is
	reply to previous cover" organization would not help to find
	the cover of this iteration at all.

In Documentation/SubmittingPatches, we give unnecessary either-or
recommendation.  We should clearly spell it out instead, perhaps
something like this.

 Documentation/SubmittingPatches | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git c/Documentation/SubmittingPatches w/Documentation/SubmittingPatches
index 927f7329a5..af7f2a4045 100644
--- c/Documentation/SubmittingPatches
+++ w/Documentation/SubmittingPatches
@@ -346,8 +346,9 @@ your code.  For this reason, each patch should be submitted
 
 Multiple related patches should be grouped into their own e-mail
 thread to help readers find all parts of the series.  To that end,
-send them as replies to either an additional "cover letter" message
-(see below), the first patch, or the respective preceding patch.
+send them as replies to an additional "cover letter" message
+(see below), which should be a reply to the "cover letter" of
+the previous iteration.
 
 If your log message (including your name on the
 `Signed-off-by` trailer) is not writable in ASCII, make sure that
