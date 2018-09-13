Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2E81F404
	for <e@80x24.org>; Thu, 13 Sep 2018 15:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbeIMUol (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 16:44:41 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39676 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727803AbeIMUol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 16:44:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id s14-v6so6406397wrw.6
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 08:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=W/kBbL5kPwYxTuKfR345+JJZ+Ke24y6+MSBxZfIqyNM=;
        b=MwzE7/QKarmlR74m8/vmTq3QaJWPGGCvMO67p6Xu40HZ68clxYedtIc2NWEKQ8kT+B
         Mso9bUJP1LvdnSe2gsLO25t2kwrQtGI69dUWjDtxzVNmMv4ijw0rbqm033yY6x4VcD1U
         oZcANuLc+kxYrLEzp+I7EVq3gD1695XQLDq+pfOnVRWQk2h4995GXgDuT8Wo6DqhGdbm
         oPMOEKipnMs5pFun6pt/egZQb6osTOI5kGG0HCuY7VI15oIpFDSXLwzY0HhMcMBUyBZp
         abmWbbEi9hMmgL2gxEOcE+SidBOBKvmO00GPlvONKTUfOIVGacrPWrq6ecDcY6+8kEDt
         A1hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=W/kBbL5kPwYxTuKfR345+JJZ+Ke24y6+MSBxZfIqyNM=;
        b=RkAg4HiMSY6eXhplVpTAxZa9rjL5jskjupizx2xSPsW6P+pJO37XzwMIwTYs/u5207
         M/Gw5twPbHV+GfYeUA9TcrSvAD2F0v5LUACDXB6A8h7Ha2y3s3aVBf5r6jOajKy+8/CJ
         x5Pn2IFZjpUb6yelOdlUzhmWX07a5dFyQZpljO3wKDOHCMsEAD1U8gEtt6pdSA3K1Mi7
         MNiENGdM/E8/LGqrCkeb5zkZGqz0DsmsJWSuDHvVrBNatjRKElMFsSX5O09DT0I3lu9D
         1rd7WnUfdjzPfZSqHlEoC8uJ7N3D0r5ew2ExKittnp51bJxWAvct7iWDNwVidSrsMV96
         CFlw==
X-Gm-Message-State: APzg51CPBihwT8OCOf0Sh2dAycBYRoP16MYQD0EqoWxTX6kvqz68FnYG
        +pGUfnU0y1On7M4BQiaq1QI=
X-Google-Smtp-Source: ANB0VdYsdV7NiBDb6eMSVP6sD+St7Ori13BybC5jAgg20rUzdRvNGO9/aqUvEwdlFs3K+jbNziPJTg==
X-Received: by 2002:a1c:b54b:: with SMTP id e72-v6mr5960003wmf.117.1536852878562;
        Thu, 13 Sep 2018 08:34:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v133-v6sm6220765wma.36.2018.09.13.08.34.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 08:34:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com, l.s.r@web.de,
        sandals@crustytoothpaste.net
Subject: Re: [PATCH 1/3] archive: use packet_reader for communications
References: <20180912053519.31085-1-steadmon@google.com>
        <20180912053519.31085-2-steadmon@google.com>
        <xmqqr2hxigw2.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 13 Sep 2018 08:34:37 -0700
In-Reply-To: <xmqqr2hxigw2.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 13 Sep 2018 07:58:05 -0700")
Message-ID: <xmqqa7olif76.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -	if (packet_read_line(fd[0], NULL))
>> +	status = packet_reader_read(&reader);
>> +	if (status != PACKET_READ_FLUSH)
>>  		die(_("git archive: expected a flush"));
>
> This makes me wonder what happens if we got an EOF instead.  We fail
> to notice protocol error here, but do the code after this part
> correctly handle the situation?

Sorry, this part of my comment is completely backwards.

We require they send a flush, not a 0-length data packet of length
4, and otherwise we die, even though we used to treate 0-length data
packet of length 4 just like a flush.

So this is making the code more strict than the original.  As long
as all the existing implementations correctly use flush here, there
would be no unintended regression, but it bothers me that we have to
even worry if these behaviour changes affect the already deployed
software negatively.

>
>>  	/* Now, start reading from fd[0] and spit it out to stdout */
