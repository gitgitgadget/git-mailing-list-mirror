Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93B831FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 21:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbdBPVZg (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 16:25:36 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33588 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932975AbdBPVZf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 16:25:35 -0500
Received: by mail-pf0-f193.google.com with SMTP id e4so2413899pfg.0
        for <git@vger.kernel.org>; Thu, 16 Feb 2017 13:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=w6J0BDVsIuOUUVFybWLBoiZs3pW55kmpY16IdE2q5LY=;
        b=GbWon89UFPfWDOLzSbT5MCc65Ps4o4eiECxH+5ooWbRPZ+Uc8WihfrN9E2wvxR5jbE
         ZdPWlKilg7PfwYOpJcY8+d8niqS6lNSd9D9BiPjtd6LP6+c67MXdWYLGSsKnmfKKFXQB
         qZvB4gaU7cESq6HcWIDgg0cTquLKPLJHIrIJwmmXa5N80Ch1AJzuuUjppu+IIvYwkwAY
         qM6Ptk+C4ck+yWP2hCdqq/a6V+9gHQkGkDc/h53sr+G5YoZQYWgZ/Qx5uw1NuvrU5Eam
         Z3c0KGsISI4uPR7x64KKns8GyvIGpnt08CbF7oXx+JTD1/my35awZPLtZUe/wGPGXTRQ
         QezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=w6J0BDVsIuOUUVFybWLBoiZs3pW55kmpY16IdE2q5LY=;
        b=LFDhEPVEYbKVbMzj9vR4WUrwbOW1rOu1uMyyZyborRZ350uyyvvhk6Qg4GEpy0O0nM
         JI47p5C1GfK7F1PEqQGBV1NOuXkW/bBRXlU3ti17SYt5Sh8t0BWXXT3dOXAhqyCWnW/P
         +WDnxx70fUOmgQkEAeorjSyrHuUVNXSuzz7h+0GNIp/k8+5ZzDpk8PVTAr7BV6R9tk21
         MW+bOIT37Ho8I4EuKqk3l9o20+9YuliHFFmCTo+RSRZZrFu86/UfiOkl0ekBxL3+JffD
         YqnVF71KpR0fwcy+0z0J1m/Mu6b3B6cSBuP60v3YU9SoAtPFcXtpTpvVewhwt1ay4/18
         AagQ==
X-Gm-Message-State: AMke39lpe0Uxi4uREy+lLSDyL7lhH+DzZpqK4HBc5sxF0OpbLkFggrT3iUx+l1abdZ9qaw==
X-Received: by 10.99.245.21 with SMTP id w21mr5454103pgh.117.1487280334970;
        Thu, 16 Feb 2017 13:25:34 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:9476:4c5c:6ee4:ba3])
        by smtp.gmail.com with ESMTPSA id u29sm15357912pfl.17.2017.02.16.13.25.33
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 16 Feb 2017 13:25:34 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 05/15] connect_work_tree_and_git_dir: safely create leading directories
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
        <20170216003811.18273-1-sbeller@google.com>
        <20170216003811.18273-6-sbeller@google.com>
        <xmqqh93tx3f3.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbMmPQ1ZxtdaoFof36g1An-xsAx85etiskirJfY4tGHaQ@mail.gmail.com>
Date:   Thu, 16 Feb 2017 13:25:33 -0800
In-Reply-To: <CAGZ79kbMmPQ1ZxtdaoFof36g1An-xsAx85etiskirJfY4tGHaQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 16 Feb 2017 13:16:34 -0800")
Message-ID: <xmqqtw7tvnea.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> The above does somewhat more than advertised and was a bit hard to
>> grok.  Initially I thought the reason why pathdup()s were delayed
>> was perhaps because you pathdup() something potentially different
>> from the given parameter to the function (i.e. new code before
>> pathdup() may tweak what is pathdup()ed).
>>
>> But that is not what is happening.  I suspect that you did this to
>> avoid leaking allocated memory when the code calls die().
>
> That is not what is happening, either.

That's a good sign that you need a bit more in the log message.
