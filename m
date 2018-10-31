Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 60AF81F453
	for <e@80x24.org>; Wed, 31 Oct 2018 04:23:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbeJaNUT (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 09:20:19 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55618 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbeJaNUS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 09:20:18 -0400
Received: by mail-wm1-f66.google.com with SMTP id s10-v6so13741920wmc.5
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 21:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=akGvxyLQa3qJPyD1U006Xt+6E2njZIBWDLbQ0RM7w7A=;
        b=mAkSVNUjAUht4CjltYBK9itzxxJsYwVKkiv+PFhgvkXWw7q4a8jXTA4HB65p7PMMHq
         ll0TGeQeu1X3xIOqL/GzQPr/BULXYBMQJBF78eQE+Ns6KE5Wm9vRZh/SIM6ihBq0xscC
         z90auL+Mkk4H+zTnxNPcrcwbEs3W1P/mSMGkE0+c/TpDeZGYWIR2cWCV8+DuVT8ay8g0
         g5v+KdMtGMoMC3wltqEe5ITI5P7e/o/YUG8hjAxcyECsEQgDiMQm29O5FRbNP4BAbuF7
         TUYJKUYloZgNxIj27a9TkRrvEDVed9MqexxA4lpvX+o5PxbPGCic8CuGs3FbfcDSSZX+
         5J3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=akGvxyLQa3qJPyD1U006Xt+6E2njZIBWDLbQ0RM7w7A=;
        b=Q1I0N1CcniMfkmkOrocvyGVBfrdRwa8E02LjGti6DDdbKI/QNpiJwdns/5Azh7Pp+j
         xLlCzohm8fBTTPvfNmEavytyaw0DXyLiHEWIKhXOffAA0CQmThwn7HU+aErUW1YDS5UT
         5Idb9uwQpiBWOOmpv6QmMaIIgTdVOs0HkY2+d3AE316oDwi/+KP/WVh6p6pcs4sIEUse
         C/g07LpLXBZ+roiVuvFbIzBLIchNpe95Bv+4KWpCkOAwrmuC0UGNdt6lMkjamF/K9R/L
         m2XlPzAQ3Gu5fqfydOcy2bh91vA5wNHS60ecIYZqZlykhCtimvBhNRxTX1WrwNX0PwKt
         xCfw==
X-Gm-Message-State: AGRZ1gJAxvvyqm2yLBylJS014TVsbiFMn896ybrQ4oQkwe3q2SkqQoHi
        Wt7CuKblcR0Mc4h4w7zeCSg=
X-Google-Smtp-Source: AJdET5dzr/0Jqt8BkG98mrb3ndYjRaP92muCvL1H4iq0TUwBfCGsCW/I5vVRGioPlv5o7/ilbBnyow==
X-Received: by 2002:a1c:adce:: with SMTP id w197-v6mr1030633wme.11.1540959835894;
        Tue, 30 Oct 2018 21:23:55 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2070697wre.82.2018.10.30.21.23.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 30 Oct 2018 21:23:55 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        John Szakmeister <john@szakmeister.net>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH 2/3] check_stream_sha1(): handle input underflow
References: <20181030231232.GA6141@sigill.intra.peff.net>
        <20181030232312.GB32038@sigill.intra.peff.net>
Date:   Wed, 31 Oct 2018 13:23:54 +0900
In-Reply-To: <20181030232312.GB32038@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 30 Oct 2018 19:23:12 -0400")
Message-ID: <xmqqpnvqyc9x.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The bug comes from commit f6371f9210 (sha1_file: add
> read_loose_object() function, 2017-01-13), which
> reimplemented some of the existing loose object functions.
> So it's worth checking if this bug was inherited from any of
> those. The answers seems to be no. The two obvious
> candidates are both OK:
>
>   1. unpack_sha1_rest(); this doesn't need to loop on
>      Z_BUF_ERROR at all, since it allocates the expected
>      output buffer in advance (which we can't do since we're
>      explicitly streaming here)
>
>   2. check_object_signature(); the streaming path relies on
>      the istream interface, which uses read_istream_loose()
>      for this case. That function uses a similar "is our
>      output buffer full" check with Z_BUF_ERROR (which is
>      where I stole it from for this patch!)

See 692f0bc7 to find who did the fix you stole from, and for what
kind of breakage the original fix was made.

By the way, a very similar loop for pack_non_delta istream iterates
while total_read is smaller than sz, but it does not have the same
check upon BUF_ERROR to see if we've read everything.


