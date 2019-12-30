Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B651CC2D0C3
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:38:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80BAE20722
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 20:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPbW2304"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbfL3UiI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 15:38:08 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44392 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbfL3UiI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 15:38:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id u71so34491796lje.11
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 12:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4e5K5RxOt3FcX1IRl/W2RyNlMZyTKx+u/CvppzGx6p0=;
        b=BPbW2304BXZalYM1mRi3mt/r8nFNpMf4/BJlBtJDNJ2ul8zjheHHAeoe24EdlgEtQ9
         tjL2uG0rCd66A+lPZ5+zj8bLbiwoPZROBsu/nhHtb+Du6RILFHoyxYFtacqg+zOvtKkz
         qk3FDYx+OMat/sO6Bmy5H4GUZyUReWEG0tEFZM1kLFGoO1RgkeJ49AW6lwOJ2fc3bVna
         U+eo55v1E2b+SdIhbb2cE2j76DFcoOIoeETqUqhK0FkRwDzqr2rwroxYWvN7cBfgAQ5r
         X7H4HGCst0Y+zSiY+mW/7fKDf1Lp8Zk0RItNX/M9LE7TgcFHDMYV8haWGZZVshPDr3XG
         xaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=4e5K5RxOt3FcX1IRl/W2RyNlMZyTKx+u/CvppzGx6p0=;
        b=ix3SQjURKKyM2ekVZbvENFBsYSTMrQf6tHrNCUsV8WeYTrVErraqOaYVkSujGgzTc7
         23jF4+BJMuI0iL/iMu6zXh8L16RPBIVElNmAv26LkBUYUN+BwY6oakm1Oiuq9hPF3nIr
         09jgNTBQDz7x3I1Ce7DavUHjCnf888L9QqB+8rlKEuWhGoUBL09+/P+NXFADm2Um8ouw
         +tPXWEvbgis9BRTq0EAU4XXnwUV4hdv8lOiqRG6fCIgOhNyw//l6xWFMQekhCyL0zMNL
         rBI/7I5DZU7WAYecx2ATj+eB4QP1i6QWEbf3b4tTb8H45+lCU0c2oKgnrVz/f+ixvfJp
         Ixdw==
X-Gm-Message-State: APjAAAUmVoyJWp8eGKUQCBYj+JZ6rW+ntlG63NOaeiHyGAQhWNB1QWmc
        KOskhS+rcedkxpUsQ9+fZfFktAgBpYU=
X-Google-Smtp-Source: APXvYqwOAFxjl65NUdljRogz/rKQ6wpLsjJR2MwGSzNI8CgtHpAiDXXYraUlybYTMQQavHaHVgmVhg==
X-Received: by 2002:a2e:9e16:: with SMTP id e22mr21605919ljk.220.1577738285657;
        Mon, 30 Dec 2019 12:38:05 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id t20sm12523706ljk.87.2019.12.30.12.38.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Dec 2019 12:38:04 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 08/16] t3310: extract common no_notes_merge_left()
References: <cover.1577454401.git.liu.denton@gmail.com>
        <68eb05e10edf1f4b09bc4e02587ac5b15fd2c6e3.1577454401.git.liu.denton@gmail.com>
        <CAPig+cTaph9Mc1cdL6eNPnTF006YCZ14oLX+xKN9VTVYs7X2_A@mail.gmail.com>
Date:   Mon, 30 Dec 2019 21:38:04 +0100
In-Reply-To: <CAPig+cTaph9Mc1cdL6eNPnTF006YCZ14oLX+xKN9VTVYs7X2_A@mail.gmail.com>
        (Eric Sunshine's message of "Sat, 28 Dec 2019 02:20:11 -0500")
Message-ID: <86eewl35xv.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:
> On Fri, Dec 27, 2019 at 8:48 AM Denton Liu <liu.denton@gmail.com> wrote:
>> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge=
-manual-resolve.sh
>> @@ -32,6 +32,11 @@ verify_notes () {
>> +no_notes_merge_left () {
>> +       { ls .git/NOTES_MERGE_* >output || :; } &&
>> +       test_must_be_empty output
>> +}
>
> This function name leaves me thinking that it's talking about
> directionality (left vs. right) and gives insufficient clue that it's
> talking about a .git/NOTES_MERGE_* file. A name such as
> assert_no_notes_merge_files() or notes_merge_files_gone() would make
> the intention more obvious.
>
>> -       # No .git/NOTES_MERGE_* files left
>> -       test_might_fail ls .git/NOTES_MERGE_* >output 2>/dev/null &&
>> -       test_must_be_empty output &&
>
> On the other hand, the original in-code comment was not confusing,
> probably because it was obvious it was talking about an actual file,
> due to spelling out .git/NOTES_MERGE_* explicitly and due to actually
> using the literal word "file", plus the code following the comment
> made it very obvious what was happening.
>
> These observations may not be actionable since someone actually
> working on this script will know that it's dealing with
> .git/NOTES_MERGES_*, but as a reviewer not familiar with this
> particular script, reading the patch from top to bottom, I found the
> function name confusing.

The problem with clarity of meaning is enhanced by the fact that during
refactoring the "# No .git/NOTES_MERGE_* files left" comment got lost.
It could have been added in the new function, as first line; or
rephrased as this new function description.

Best,
--=20
Jakub Nar=C4=99bski
