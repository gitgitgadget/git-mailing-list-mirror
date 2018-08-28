Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 372A61F404
	for <e@80x24.org>; Tue, 28 Aug 2018 14:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727579AbeH1Sow (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 14:44:52 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:40527 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbeH1Sow (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 14:44:52 -0400
Received: by mail-qt0-f169.google.com with SMTP id h4-v6so1990249qtj.7
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 07:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uJ5PbtnoTYXZ8+1LyamO0vIfe3RU6g30IA7ti7Ktd2Q=;
        b=gOnf0AXYfTetKTv32wTju9gEFv7YagvSNbjENFVq8oX4BnNeS77ZsmRCo0WyFI52Qk
         lXS0vh4nwH3NA28V9mXRWE83Z1UxR0C1tylsn1QOruolIgR2CDr9wuQK+HykgfvMZFDO
         WL515Jo6e5Fe16aRIcRL0aL19qsDX7v/4PNYGHjZjQiHaCtKY+rJn4tGhTUnDMckRZmN
         Ru07fxFrrfIZa9pUSTrsWBvkozrhJKJr7D8wfH/MhPjJbPoB3y2zm5vQqwLfD82944nv
         aQoUkok4/nl1GDK45cGXD+OFJHOzmaVPbeLVI68mPc02LVSror+d0Y9wq/tu9E633Upw
         BTfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uJ5PbtnoTYXZ8+1LyamO0vIfe3RU6g30IA7ti7Ktd2Q=;
        b=WBG65n+TYgc4jIlvfGK7ZQmoVXWSyK/wc6ZUtKA1OASpCO+ei/m21dNh7WCt/DMw0c
         6PEaEetBoD9PccH0BOengp+T96N093CIZgBkdJ9hrm1cRzvHPKl+hbf+IrrSGwuOVw1V
         eVXDn48NARkT12R1Qwj4uwQtgGCvbV7AyWMIpSz+HDhuKM8X00HqzTwcJXFYRgOR0hqT
         e5p9olHo/8Uk9k7l9ZxtPxu7trKkEHhXGgtXeZsxL4xamveUes+WI+rAlBnrDWk9vXgL
         geQ7JIAvXiILkOKF0qZc0oyeZqMLLimkbFQqCwygTqhXy687yWsoc7KV9vn9wC3ZskBY
         oS2Q==
X-Gm-Message-State: APzg51AvIgQWKdPyp85ZYlZgxRKBuvJ2nFKQZzGpPLgLpp4gFhxcNbRA
        tRmUcIm00O9yAaKWRONjxo0=
X-Google-Smtp-Source: ANB0VdYXtpIVI2pO2uMo0pfTA44V7zk3kmxi37+IAc4YDDHlPs/QwBkWkAxlAAXHeVX+UPD8S9bcdg==
X-Received: by 2002:a0c:ae15:: with SMTP id y21-v6mr1874958qvc.233.1535467969456;
        Tue, 28 Aug 2018 07:52:49 -0700 (PDT)
Received: from [192.168.1.142] (70-33-148-226.unassigned.ntelos.net. [70.33.148.226])
        by smtp.gmail.com with ESMTPSA id a185-v6sm690794qkg.57.2018.08.28.07.52.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 07:52:48 -0700 (PDT)
Subject: Re: [PATCH v1] read-cache: speed up index load through
 parallelization
To:     Duy Nguyen <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>
Cc:     Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <CAGZ79kbXfPPvcQ1rnUdiOqWs5wC2qccGCnf8DvCVnp8QV126MA@mail.gmail.com>
 <CACsJy8Cnxz0w0g53Gb=_iXEdbSUFgssTozfxea0H52mWJ-RmTg@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <00c3b1de-4fcf-ba03-0f8d-9ea2540ba657@gmail.com>
Date:   Tue, 28 Aug 2018 10:53:34 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8Cnxz0w0g53Gb=_iXEdbSUFgssTozfxea0H52mWJ-RmTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/24/2018 2:40 PM, Duy Nguyen wrote:
> On Thu, Aug 23, 2018 at 7:33 PM Stefan Beller <sbeller@google.com> wrote:
>>> +core.fastIndex::
>>> +       Enable parallel index loading
>>> ++
>>> +This can speed up operations like 'git diff' and 'git status' especially
>>> +when the index is very large.  When enabled, Git will do the index
>>> +loading from the on disk format to the in-memory format in parallel.
>>> +Defaults to true.
>> "fast" is a non-descriptive word as we try to be fast in any operation?
>> Maybe core.parallelIndexReading as that just describes what it
>> turns on/off, without second guessing its effects?
> Another option is index.threads (the "index" section currently only
> has one item, index.version). The value could be the same as
> grep.threads or pack.threads.
>
> (and if you're thinking about parallelizing write as well but it
> should be tuned differently, then perhaps index.readThreads, but I
> don't think we need to go that far)

I like that.  I'll switch to index.threads and make 'true' or '0' mean 
"automatically determine the number of threads to use" similar to 
pack.threads.
