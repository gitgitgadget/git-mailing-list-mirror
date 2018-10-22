Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD3CC1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 03:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbeJVLl2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 07:41:28 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43057 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726999AbeJVLl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 07:41:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id t10-v6so1625216wrn.10
        for <git@vger.kernel.org>; Sun, 21 Oct 2018 20:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Vok9IfdJKljHIpiIvvSsJUw/YbbZfjyRErsFwQIWh4k=;
        b=sMZIM3pqet8P06ujlf+epnrsE/pZFhvP4iCgy+ZGLwzTT1y3cg70rww/fcoW3DHlPa
         FIa9EMj1sJrrMpKrRlFqEkJKCs0k6EJ2HPYAQY7hV6pbJRP8sE9DN3PjPtbz2kIGxbrf
         2aT1NJk587TCHaOx3qDLYt/OlmgAVG+wzP0GT1qgK7ixeB1JeLzaCv9hwRv57iT5g7ys
         GwQ8TR0IouqRokSy2lZJZoxJJfIInPCIEBrbHQXJ1YVL5EybiTpS5YnAiT3hW7pddEds
         Ct33j4N6rwDTGM85NbAMrzMM/G0IfSGVGXIkGKCHwalNXdZgx/D7pvVUmyOIRIQErove
         rVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Vok9IfdJKljHIpiIvvSsJUw/YbbZfjyRErsFwQIWh4k=;
        b=rSt5Q7mrn2c3ilpeR8SQ6JmYJQF+QSC9pBdWVwg9AHGWRmhc0uETwKd1Kc37YyT+wv
         O32fQBdsSfrPIiVpq3Pan0BntEo2rFa8SON+UQBw2bOP6FvnUBbT7nVMNF39+Sv07yH4
         +u6ciGMG6O04ttCZSexSIjugaZVQSdRmKv49mR0uxqvpHuRFp96AatcQJJqgR31DLhIr
         SUbzi09muqS5ztCZhw2W0ZUBOsx2TleewTguc9rDlYGsuydxc6ToRNZvdO5A7MbX9Gca
         z2rUP4TnRM74YbeHQHPaipQzxHR/I9S0Jz5q6wk+OArAOeSOrq4/dVeC1UrPWCksSgyy
         PKmw==
X-Gm-Message-State: ABuFfogFIiloFevuPsnzhuIbv/F82nE+/83V9kjt96BA5FurX1yH6C10
        YK5KW88lRv1d4DR6fmE/dxw=
X-Google-Smtp-Source: ACcGV62owDgdA+k3lS8GYaFedUUDI7YVZacNl/hxZp9XWhC2pq1qD82QvpZP6Dfp1UytDaa9QAVhMw==
X-Received: by 2002:adf:c00e:: with SMTP id z14-v6mr43551320wre.268.1540178686562;
        Sun, 21 Oct 2018 20:24:46 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g186-v6sm10773842wmf.19.2018.10.21.20.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 20:24:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     steadmon@google.com, git@vger.kernel.org
Subject: Re: [PATCH 1/1] archive: init archivers before determining format
References: <cover.1539990488.git.steadmon@google.com>
        <b1f8e288dde9a9dd46386524189da66c7ad2c333.1539990488.git.steadmon@google.com>
        <20181019235945.GB7326@sigill.intra.peff.net>
Date:   Mon, 22 Oct 2018 12:24:45 +0900
In-Reply-To: <20181019235945.GB7326@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 19 Oct 2018 19:59:46 -0400")
Message-ID: <xmqq4ldey876.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 19, 2018 at 04:19:28PM -0700, steadmon@google.com wrote:
>
>> diff --git a/builtin/archive.c b/builtin/archive.c
>> index e74f675390..dd3283a247 100644
>> --- a/builtin/archive.c
>> +++ b/builtin/archive.c
>> @@ -45,7 +45,10 @@ static int run_remote_archiver(int argc, const char **argv,
>>  	 * it.
>>  	 */
>>  	if (name_hint) {
>> -		const char *format = archive_format_from_filename(name_hint);
>> +		const char *format;
>> +		init_tar_archiver();
>> +		init_zip_archiver();
>> +		format = archive_format_from_filename(name_hint);
>>  		if (format)
>>  			packet_write_fmt(fd[1], "argument --format=%s\n", format);
>
> Hrm. This code was added back in 56baa61d01 (archive: move file
> extension format-guessing lower, 2011-06-21), and your example
> invocation worked back then!
>
> Unfortunately it was broken by the very next patch in the series,
> 08716b3c11 (archive: refactor file extension format-guessing,
> 2011-06-21). I guess that's what I get for not adding regression tests.
>
> It's probably worth mentioning those points in the commit message.
>
> Does this work with configured archiver extensions, too? I think so,
> because we load them via init_tar_archiver().
>
> Can we avoid repeating the list of archivers here? This needs to stay in
> sync with the list in write_archive(). I know there are only two, but
> can we factor out an init_archivers() call or something?
>
> We also should probably just call it unconditionally when we start the
> archiver command (I don't think there are any other bugs like this
> lurking, but it doesn't cost very much to initialize these; it makes
> sense to just do it early).
>
> Other than those minor points (and the lack of test), your fix looks
> good to me.

Thanks for a patch and an excellent review.  Looking forward to the
finalized version.

Thanks, both.
