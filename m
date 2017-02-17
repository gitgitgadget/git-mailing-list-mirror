Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93FE201A9
	for <e@80x24.org>; Fri, 17 Feb 2017 22:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964794AbdBQWkY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 17:40:24 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34650 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935084AbdBQWkW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 17:40:22 -0500
Received: by mail-pg0-f65.google.com with SMTP id v184so5928134pgv.1
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 14:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=o/OARQ5abt8mfGM6NjAfA6r0ylthxV1UvZq7E5KugIA=;
        b=tc0FUF1Pt9KFaZlVAfqqDRkU1K4WO6/UV8pxH6SNJDiFfno8zis17jIL0CQs3LTxMF
         4TMd3eimRT3LN4P/bEwk6zPIHiM8OYsz8i9l6mJJTR1TbovZsz35TcLEFQvpV+Xr1GaH
         vosm8eNOe7NSXmZNq7mFO6GEuS5Qn0yA547ICIzE/j09UV2pqLb7V0zQtBCSYMFukP35
         ZoAq2USmFci+n0I1Bg5Y/qQyPYOCP9mRFA87yaMOGCrBRSIiMsFb6cBDaxzyqn9lH4vQ
         PFWBtnb3n+Y9x5JdGUFQ7Nv8bX5QmCwdV9Jl15Qo5Aoul4D/CpcZUboG/v33S1tM2IVf
         DXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=o/OARQ5abt8mfGM6NjAfA6r0ylthxV1UvZq7E5KugIA=;
        b=FfqznHGo1jp5VBjsrdkcUx/UsTBuiY0w9jN8XdsaY+Sv21wRyJErT10CEUiaZ6BwoK
         DYKkz4MS+ba/JqDRf0o5R1ZJkqtMxbRliMHITKT+h34bAf9s1F7ME/utydKEIuVx2fNZ
         IiuKrDJua0NfiGGJbrcHHY0DFDrxFhiNevYgr+7Gh7+HFqT4dytSLqK3GUQMzosYEclT
         toQzUHpertBuN6G4ZaAqVNX3AMu7EVR++/UVcR70rydq8Zg52/H+XP9a6MesNWOH8ytN
         HtDLD48Uyi3Osyo6HdNXsiTxZiJxozRYPQcjOx2sQhLGKSrOxwPQbJPostayUK533RRp
         TLwA==
X-Gm-Message-State: AMke39n02VsTtkOlqqYVKPiA4xee9BKE+QDLoZD/MwEFQrgyOl0dHLEOW1XMh3zl+a4qYA==
X-Received: by 10.98.111.194 with SMTP id k185mr11984444pfc.83.1487371221411;
        Fri, 17 Feb 2017 14:40:21 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id j7sm21364419pfe.84.2017.02.17.14.40.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 14:40:20 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?Q?J=C3=A1chym_Barv=C3=ADnek?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
References: <87tw7uv439.fsf@linux-m68k.org>
        <20170216164359.k2ab7laqqvusfsm2@sigill.intra.peff.net>
        <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
        <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
        <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
        <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
        <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
        <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
        <20170217212106.bew6krtb7pqpi3rr@sigill.intra.peff.net>
        <xmqqy3x4qyte.fsf@gitster.mtv.corp.google.com>
        <20170217221019.wjuaxmaatqtx2olt@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 14:40:19 -0800
In-Reply-To: <20170217221019.wjuaxmaatqtx2olt@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 17:10:19 -0500")
Message-ID: <xmqqzihkphkc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> If we are trying to make sure that the caller would not say "failed
>> to close tempfile: ERRNO" with an ERRNO that is unrelated to any
>> stdio opration, I am not sure if the patch improves things.  The
>> caller did not fail to close (most likely we successfully closed
>> it), and no matter what futzing we do to errno, the message supplied
>> by such a caller will not be improved.
>
> Right. EIO is almost certainly _not_ the error we saw. But I would
> rather consistently say "I/O error" and have the user scratch their
> head, look up this thread, and say "ah, it was probably a deferred
> error", as opposed to the alternative: the user sees something
> nonsensical like ENOMEM or EBADF. Those are more misleading, and worse,
> may change from run to run based on what other code runs or fails in
> between.

My point was actually not what errno we feed to strerror().  In that
example, what is more misleading is the fixed part of the error
message the caller of close_tempfile() used after seeing the funcion
fail, i.e. "failed to close".  strerror() part is used to explain
why we "failed to close", and of course any nonsensical errno that
we did not get from the failed stdio call would not explain it, but
a more misleading part is that we did not even "failed to close" it.

We just noticed an earlier error while attempting to close it.
strerror() in the message does not even have to be related to the
closing of the file handle.

>> If the caller used "noticed an earlier error while closing tempfile:
>> ERRNO", such a message would describe the situation more correctly,
>> but then ERRNO that is not about stdio is probably acceptable in the
>> context of that message (the original ERRNO might be ENOSPC that is
>> even more specific than EIO, FWIW).  So I am not sure if the things
>> will improve from the status quo.
>
> Yes, that's I suggested that xfclose() is probably not a good direction.
> The _best_ thing we can do is have the caller not report errno at all
> (or even say "there was an earlier error, I have no idea what errno
> was"). And xfclose() works in the opposite direction.

I think we are in agreement on this point ;-)

> The only reason I do not think we should do so for close_tempfile() is
> that the fclose is typically far away from the code that actually calls
> error(). We'd have to pass the tristate (success, fail, fail-with-errno)
> state up through the stack (most of the calls indirectly come from
> commit_lock_file(), I would think).

We _could_ clear errno to allow caller to tell them apart, though,
if we wanted to ;-)
