Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 787601F97E
	for <e@80x24.org>; Sat,  6 Oct 2018 23:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbeJGGtf (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 Oct 2018 02:49:35 -0400
Received: from mail-wr1-f41.google.com ([209.85.221.41]:33128 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbeJGGtf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Oct 2018 02:49:35 -0400
Received: by mail-wr1-f41.google.com with SMTP id e4-v6so17033032wrs.0
        for <git@vger.kernel.org>; Sat, 06 Oct 2018 16:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=0DMjDc4BcK5J//hSBw8rb7FvpGkZrUIP1/KexQ30En0=;
        b=t0UuxMI12XaFhRS4gzHFa0u15YdJjJl18/gLu3SWqyDihtBYlDSDXrFNs/0vbhgDYt
         MIvBV5DsfhKhdO6olyh/ymaZhop06B+9ZzAHiT9p2nqmXfwlisptECVnchDzLemDQK7p
         /drmxWPJygnNEsautZkuvISvAcVdmQxy436r2VhdiXLtzEamxxePhJBuzjtpBCw7xquU
         RO8viVK3B1H5fpbsFuW5frEmrdG0wxtaQjnpbjgkjtMQGqtPKMEEEp6ZnbDWnPSa6vMC
         7iGT0MnM2+0ohYCYtIyHWrYvDweFYFfSQfG+quXy306tL9awO8lLq++1CdNirWYlScd7
         8fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=0DMjDc4BcK5J//hSBw8rb7FvpGkZrUIP1/KexQ30En0=;
        b=tOQ0bl38145HKXt5jmEsXpWH3Y03ldSADL5uoMmGappHjpfbXc0FEdw0RD0Mw8sPVl
         M2sN+EiUkOAYMTaVZqs31Nl2rLCB/4isMV6+7LDovO628Isx5TkcBK2m+qnz81RDuho2
         NrAFZ6Zd80BZU3egPOm6Qqt0KVzSB1r3i/x2Ur/3r0ZdQgx+z3CUFnmcnCzW/rCD6bvK
         bOL0L/Vtb5ldXpdWm6MDzzYImOYRpa5VIzsiuJ9fFWgUvZD1L21j2Bckhq7tNKb2fnw/
         AGvtBGkheAyTBnrdgI6zyMXR/vlgmDeNGT1r0gg3PuGzYzugbFaz1fO/oyioduV+libO
         enTA==
X-Gm-Message-State: ABuFfoi2I7/B0KmPz7XuTRMo/nivoO2n4WKKcd6pUEpogM1Yk+KwfSNI
        8OzTNSGALxF7+qxG7DZu36M=
X-Google-Smtp-Source: ACcGV62VzOEBYQHmgLUR1zfYC+CaX+XiD6Ve/1xRmqsOWz0f+xVxdnCa1094sET7poCT6CWDatn8Rw==
X-Received: by 2002:adf:ac13:: with SMTP id v19-v6mr12712656wrc.135.1538869463395;
        Sat, 06 Oct 2018 16:44:23 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 204-v6sm5216389wmh.25.2018.10.06.16.44.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 06 Oct 2018 16:44:22 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Antonio Ospite <ao2@ao2.it>, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 08/10] submodule: add a helper to check if it is safe to write to .gitmodules
References: <20181005130601.15879-1-ao2@ao2.it>
        <20181005130601.15879-9-ao2@ao2.it>
        <CAGZ79kbaeRVBLhYiqzisADHs+Af+c2giXcsCySAEe4jue_rWwA@mail.gmail.com>
Date:   Sun, 07 Oct 2018 08:44:20 +0900
In-Reply-To: <CAGZ79kbaeRVBLhYiqzisADHs+Af+c2giXcsCySAEe4jue_rWwA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 5 Oct 2018 16:50:10 -0700")
Message-ID: <xmqq36tiwsh7.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>>  static int module_config(int argc, const char **argv, const char *prefix)
>>  {
>> +       enum {
>> +               CHECK_WRITEABLE = 1
>> +       } command = 0;
>
> Can we have the default named? Then we would only use states
> from within the enum?

Why?  Do we use a half-intelligent "switch () { case ...: ... }"
checker that would otherwise complain if we handled "case 0" in such
a switch statement, or something like that?

Are we going to gain a lot more enum members, by the way?  At this
point, this looks more like a

	unsigned check_writable = 0; /* default is not to check */


to me.
