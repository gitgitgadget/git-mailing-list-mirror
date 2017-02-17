Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54FA2201A9
	for <e@80x24.org>; Sat, 18 Feb 2017 00:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750855AbdBRAAc (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Feb 2017 19:00:32 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35786 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750762AbdBRAAb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Feb 2017 19:00:31 -0500
Received: by mail-pg0-f68.google.com with SMTP id y6so4937957pgy.2
        for <git@vger.kernel.org>; Fri, 17 Feb 2017 16:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UH/rTlZBEHT5Yq679OhbmLASWRrWxu1iaWCVat/CThM=;
        b=buJM+scllsSgspFGrjtVceR7TxBRWVsGF6CQFyh8RITO2LXGRPwrcqvHzHD7N7eTho
         7lceRMsUdpAJGsdce281TUfCU+TgU2Algbw5OcigRRmf1p++dNm1knWirTWNTScp2/rL
         4sAJIZxPTlhlaW1uO1a2GPnyboSGADv5Z3D+DNu8FDf5CudXAqEgCsjZl7L447FjWVlD
         IboTN2N3keIouUkaLDrk6eoHtNntKsBB/ZbpPg7C9Ioq93R0VHDNePnbg6b7BAzYLwkr
         o/HFpaOFGSzHPF6UTN1fYYDQFu2z4YA50mtPyLEaLISSFvwmmIYQ2osp/VxZL3Nk/ffw
         vz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UH/rTlZBEHT5Yq679OhbmLASWRrWxu1iaWCVat/CThM=;
        b=W/hFa5cIPuxczyeAt0CMCqcUKctjDx5Jc1XqYRdCyg5+i8NTF/+kK0Xw0n+0L2bchG
         G08BOU9I2xWN+7BMTCrQppQJzROynGYMrkPZJitrseJqYgErD2w6fMVWvDhnO+1vWNVZ
         dDNGly4BxSQR2zq9ygpyyLiQMkoI+p3cGGdiJuWQX3xjks7cvI9mxLMD66RWDZfnG0ZJ
         G+SUwjGn31By4KTDsH7KrCbh+DBnQv6EBFl6UoPHHTQQyvzeS2V8JFJMfJIvFw/qnTMd
         wnMTYTq4VcMeEIEan6sjBey7dJG6bKUGSCAcmEQeS8VUz0RTkExlnF9fohnd5hPNqhw8
         gE0Q==
X-Gm-Message-State: AMke39ktVnQXNsspyHJEMEtw2O8DwSm9VqLLpmSz7b+rZWocPNZccWCxQEauH238qoBaWQ==
X-Received: by 10.99.158.69 with SMTP id r5mr13230195pgo.153.1487375558055;
        Fri, 17 Feb 2017 15:52:38 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3130:38b1:b121:8f0d])
        by smtp.gmail.com with ESMTPSA id n70sm21522220pfg.34.2017.02.17.15.52.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 17 Feb 2017 15:52:37 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?Q?J=C3=A1chym_Barv=C3=ADnek?= <jachymb@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tempfile: avoid "ferror | fclose" trick
References: <20170216213140.xqw7gzjimhvg7tcm@sigill.intra.peff.net>
        <923e328c-7fea-a9e4-1059-3bd6b8e58164@alum.mit.edu>
        <20170217080759.2357wzdiuymcyosw@sigill.intra.peff.net>
        <64eedabd-c0de-a7e0-8d98-ad23a9625b45@alum.mit.edu>
        <20170217205442.wnldfsxbj3dnnqvj@sigill.intra.peff.net>
        <xmqq37fcsejx.fsf@gitster.mtv.corp.google.com>
        <20170217212106.bew6krtb7pqpi3rr@sigill.intra.peff.net>
        <xmqqy3x4qyte.fsf@gitster.mtv.corp.google.com>
        <20170217221019.wjuaxmaatqtx2olt@sigill.intra.peff.net>
        <xmqqzihkphkc.fsf@gitster.mtv.corp.google.com>
        <20170217233952.56h2z3l76orn4zht@sigill.intra.peff.net>
Date:   Fri, 17 Feb 2017 15:52:36 -0800
In-Reply-To: <20170217233952.56h2z3l76orn4zht@sigill.intra.peff.net> (Jeff
        King's message of "Fri, 17 Feb 2017 18:39:53 -0500")
Message-ID: <xmqqr32wnznf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I'm also not sure that it's all that useful to distinguish errors from
> fwrite() versus fclose(). In practice, errors will come from write() in
> either case, and the caller does not have much control over when the
> flushing happens. So any error saying "error closing file" is probably
> assuming too much anyway. It should be "error writing file".

Yes.

>> We _could_ clear errno to allow caller to tell them apart, though,
>> if we wanted to ;-)
>
> Hmm. So basically "errno = 0" instead of EIO? That at least has the
> advantage that you can tell it apart from a real EIO, and a caller
> _could_ if they chose do:
>
>   if (commit_lock_file(&lock)) {
> 	if (!errno)
> 		error("error writing to file");
> 	else
> 		error_errno("error closing file");
>   }

Exactly.

> But I am not sure I would want to annotate all such callers that way. It
> would probably be less bad to just pass down a "quiet" flag or a strbuf
> and have the low-level code fill it in. And that solves this problem
> _and_ the rename() thing above.
>
> But TBH, I am not sure if it is worth it. Nobody is complaining. This is
> just a thing we noticed. I think setting errno to EIO or to "0" is a
> strict improvement over what is there (where the errno is essentially
> random) and the complexity doesn't escape the function.
>
> So I think that "easy" thing falls far short of a solution, but it's at
> least easy. I could take it or leave it at this point.

Well, I already said that earlier in this thread, and ended up
queuing your patch on 'pu' ;-).
