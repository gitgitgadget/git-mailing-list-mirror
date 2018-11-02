Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C45A1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 17:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeKCCfe (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Nov 2018 22:35:34 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:42911 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbeKCCfd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Nov 2018 22:35:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id l2-v6so1052729ywb.9
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 10:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0qyEGv1Rzp0KW8roRz1gI0SyN211ERie7+C+JT81/Fg=;
        b=B5dgpRdAk0+iTMpzeShXiEr+NDfFe0XoXqmtpeL+Jz2BzqtLL98sv0pqKj7waRYRs4
         cuUl8/N8fJRAXl4TRP+dLBi0tDXLJEz3kaqza44qtwUPDe8BVrNBqBuogIpSNgFZqK24
         ECxHYCoHixmUqrVQiVcUXme8O5ry8vIdhvQJiuLb0pS749MOmh2+T5SqVZuZe4AfcbSD
         jnXZDZG9KKv3gQa5HhWazvtcwbCYV+P/KVw0azyqN0BMM5MedaS+iqQI9a/Dbvq7IHaM
         YpWyvPi/a0faykbF8Uxeic+Rso0tsptAkqJ9mmHOcRWFkDfv888zESyEQ2fHtWP9S6MD
         Q3GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0qyEGv1Rzp0KW8roRz1gI0SyN211ERie7+C+JT81/Fg=;
        b=uG+lTfO35mTRxMh9GWAgQvCjXqWawrs3gsmgFr6mbubEEQ2lDPPvcaOxJo4gm6lWQk
         ohFfs92jgNc/Czm0Mwr1osJ6993wFL/1hjqXfyp0X2l9TJuXN9Z47+HLkz4aWACwtMAv
         4YPWMVA9YWsnK8JVB2CADSTdW+9EKkYwfNkUu+5rflEdG3peNF9ImYnqGb7pU8tyt8Yc
         sNZINzTmXVYkN5yuRhpPD/CofdLoORFiDKogUirbZk4LgFapFVsTc/mfbAeCILLuoTpr
         ruZkFplriWDRM64tvrL8860d9Q9NMzTeXO7SlNvrFFp7x2mB5sAQtTF5Y1++84xwDrHM
         5doA==
X-Gm-Message-State: AGRZ1gJE1Y//CRCSaOKROW5mo6uJ+II5QxJeHgab1+tAbqNLC/cVcQ9V
        uodtIgI9whpGGY50nKeENkA=
X-Google-Smtp-Source: AJdET5dZnz8mlrsZf730f5zwqz54t2IYF1yOedFRRx072W1IoNC41jpP65x6P8pltMt8Q0jCZvJRNA==
X-Received: by 2002:a0d:d4c1:: with SMTP id w184-v6mr12148142ywd.254.1541179658673;
        Fri, 02 Nov 2018 10:27:38 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id q2-v6sm17863027ywa.24.2018.11.02.10.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Nov 2018 10:27:38 -0700 (PDT)
Subject: Re: [PATCH 19/24] submodule: use submodule repos for object lookup
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <20181030220817.61691-1-sbeller@google.com>
 <20181030220817.61691-20-sbeller@google.com>
 <127add9b-d58c-ee46-73de-41bfe915589b@gmail.com>
 <CAGZ79kZV9AZLHiSz19jx_Z5PnqO1V+-ngL9ACGhr21umn6UQVQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <1db4a22e-466d-3d21-1899-7b2d32363114@gmail.com>
Date:   Fri, 2 Nov 2018 13:27:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZV9AZLHiSz19jx_Z5PnqO1V+-ngL9ACGhr21umn6UQVQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/2018 1:23 PM, Stefan Beller wrote:
> On Fri, Nov 2, 2018 at 6:03 AM Derrick Stolee <stolee@gmail.com> wrote:
>> On 10/30/2018 6:08 PM, Stefan Beller wrote:
>>> This converts the 'show_submodule_header' function to use
>>> the repository API properly, such that the submodule objects
>>> are not added to the main object store.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> A couple tests are broken in 'pu' when run with GIT_TEST_COMMIT_GRAPH=1,
>> including t4041-diff-submodule-option.sh. The failure bisects to this patch.
>>
>> Here is a verbose output of the first failure in that script:;
>>
>>
>> expecting success:
>>           git diff-index -p --submodule=log HEAD >actual &&
>>           cat >expected <<-EOF &&
>>           Submodule sm1 $head2..$head3 (rewind):
>>             < Add foo3 ($added foo3)
>>             < Add foo2 ($added foo2)
>>           EOF
>>           test_cmp expected actual
>>
>> + git diff-index -p --submodule=log HEAD
>> + cat
>> + test_cmp expected actual
>> + diff -u expected actual
>> --- expected    2018-11-02 12:58:43.429262380 +0000
>> +++ actual      2018-11-02 12:58:43.429262380 +0000
>> @@ -1,3 +1,5 @@
>> -Submodule sm1 30b9670..dafb207 (rewind):
>> +Submodule sm1 30b9670...dafb207:
>>      < Add foo3 (hinzugefügt foo3)
>>      < Add foo2 (hinzugefügt foo2)
>> +  > Add foo1 (hinzugefügt foo1)
>> +  < Add foo1 (hinzugefügt foo1)
>> error: last command exited with $?=1
>> not ok 9 - modified submodule(backward)
>>
>> I've been looking into the patch below to see if there is an obvious
>> problem, but the best I can think is that open_submodule() creates an
>> alternate 'struct repository' and somehow the commit-graph feature is
>> interacting poorly with that struct.
>>
>> Stefan, do you know what's going on?
> Sure, see the last four patches of this series
> https://public-inbox.org/git/20181030220817.61691-1-sbeller@google.com/
> (to which you also reply to? Junio did not queue this one, yet).

Sorry! Got a bit mixed up looking at everything. I didn't realize that 
the current 'pu' didn't have your latest. Thanks!

