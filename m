Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A3101F424
	for <e@80x24.org>; Thu, 26 Apr 2018 16:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754582AbeDZQsF (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 12:48:05 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:40818 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754544AbeDZQsE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 12:48:04 -0400
Received: by mail-vk0-f51.google.com with SMTP id x204so16472008vkd.7
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 09:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=98RAIjjAryfJnGRRMn6G90EAjdTYent8emnjoc7p8CY=;
        b=rFWoF0duTqGQjcflUwFfPBzyppCMV5byuTIMDkjPp2W81Tkpeh4/6NfwGFV1HAzyH6
         mKAfN4tOT90A2GylNdPuKhFKhT2Ctxj8B5O1m4ICBnzOyBZ/ne2NcvoHT5aYOBsxKU2q
         axF1W+2LjGkEAiJCWQ8bJ4/bbe0MhY/n9Ukrriju4jwrpUNRKmbuDINPM2y8q6xzCCb6
         Z96bATq3PcZ6KKjeeM+9EyTfpbZzKuPeKlEcMG9tvZ+6aL1ibEfy9/4EDSoT7G5PuhXv
         Q0dyrfHmN4nTubnzetfx/pf6o4apWrhkHCPigT6s+tAROV6IX359pJibwQ6kbDe65RIO
         y5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=98RAIjjAryfJnGRRMn6G90EAjdTYent8emnjoc7p8CY=;
        b=Ktsd/7iPf9Gvgsdnk3uDCcytvA4/sEDWqdpyJqK+SbOKLCbu33Qwd8cB7BfdnU7r63
         6YljbCbDPlWJ0yuAdsTX3WCGWneUrf83nLp/IMuSoK/3+4tUUxbGy9HpHw6RhqdYOTK7
         pDK/agIEusayusBTRGwpikmJ0lcQ4aeiL1wbNf5YrmfVSezRAq6JItAlw5PAjnXiOZW9
         7xboGlPWO4FQ/TJXojH3K99GEKy6KQRlzr0PMfC1FHbaLqhdyZj0ho4cEOflX79GDI0i
         VgNiwsOu6xsCFi6GOodrVAPF1ovzNRT3d6x6vhLBvkg5NiWh6yBKRx23Gpp+NdYK80Oz
         E8WA==
X-Gm-Message-State: ALQs6tDJQmddKw30BDTPiAJBADlDX57sJSvqq8Nz17T4tByS22+VUJ7f
        UdAoN4/Dj6Rx8h2akJTu6NCSgtNDEB8NOFiHuXejWg==
X-Google-Smtp-Source: AIpwx4+G3+k9bhwoKBf8fDP1JREo3KOj/oM/nfBrX3igYf3+dY1rFnWC/AN4PtH+YflAM8l2q8FNlptpr4j8eIYW5RE=
X-Received: by 10.31.193.85 with SMTP id r82mr23861675vkf.76.1524761283726;
 Thu, 26 Apr 2018 09:48:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 09:48:03 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 09:48:03 -0700
Message-ID: <CABPp-BEe+BK6Ew0ZLnkgCn=1J6kyJa5VTaibuJOEVeDdgLd_Ow@mail.gmail.com>
Subject: BUG report: unicode normalization on APFS (Mac OS High Sierra)
To:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On HFS (which appears to be the default Mac filesystem prior to High
Sierra), unicode names are "normalized" before recording.  Thus with a
script like:

    mkdir tmp
    cd tmp

    auml=3D$(printf "\303\244")
    aumlcdiar=3D$(printf "\141\314\210")
    >"$auml"

    echo "auml:          " $(echo -n "$auml" | xxd)
    echo "aumlcdiar:     " $(echo -n "$aumlcdiar" | xxd)
    echo "Dir contents:  " $(echo -n * | xxd)

    echo "Stat auml:     " "$(stat -f "%i   %Sm   %Su %N" "$auml")"
    echo "Stat aumlcdiar:" "$(stat -f "%i   %Sm   %Su %N" "$aumlcdiar")"

We see output like:

    auml:           00000000: c3a4 ..
    aumlcdiar:      00000000: 61cc 88 a..
    Dir contents:   00000000: 61cc 88 a..
    Stat auml:      857473   Apr 26 09:40:40 2018   newren =C3=A4
    Stat aumlcdiar: 857473   Apr 26 09:40:40 2018   newren a=CC=88

On APFS, which appears to be the new default filesystem in Mac OS High
Sierra, we instead see:

    auml:           00000000: c3a4 ..
    aumlcdiar:      00000000: 61cc 88 a..
    Dir contents:   00000000: c3a4 ..
    Stat auml:      8591766636   Apr 26 09:40:59 2018   newren =C3=A4
    Stat aumlcdiar: 8591766636   Apr 26 09:40:59 2018   newren a=CC=88

i.e. APFS appears to record the filename as specified by the user, but
continues to allow the user to access it via any name that normalizes
to the same thing.  This difference causes t0050-filesystem.sh to fail
the final two tests.  I could change the "UTF8_NFD_TO_NFC" flag
checking in test-lib.sh to instead test the exit code of stat to make
it pass these two tests, but I have no idea if there are problems
elsewhere that this would just be papering over.

I dislike Mac OS and avoid it, so I'd prefer to find someone else
motivated to fix this.  If no one is, I may eventually try to fix this
up...in a year or three from now.  But is someone else interested?
Would this serve as a good microproject for our microprojects list (or
are the internals hairy enough that this is too big of a project for
that list)?


Elijah
