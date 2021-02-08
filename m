Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9204C433E0
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 02:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A413664E3F
	for <git@archiver.kernel.org>; Mon,  8 Feb 2021 02:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbhBHC0q (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Feb 2021 21:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhBHC0o (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Feb 2021 21:26:44 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C64C06174A
        for <git@vger.kernel.org>; Sun,  7 Feb 2021 18:26:04 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id y11so12839375otq.1
        for <git@vger.kernel.org>; Sun, 07 Feb 2021 18:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=RUZOo7EzVX8iSq4VaRfQlqMam7PZKasI9SobMF45IP4=;
        b=PlXKT4GDs8n+BeigphYkITlZiZ5q03piGR9OkUh39u3tsZhaxatymDU7AZoU9dmCUf
         umxz/bwa8Lv8NlMnhiGIUTYcB6D1/rV9+TzhA54sbProRpGBdHVNZqXf5wYkiB5jx/tp
         zkCZ6FRDerymGPGHayOLw8UyTRDeQcP+xZ6cNYM+hMsyKRuj3zGHQag2J3BXnVaXTmXT
         9IPaPQJ+G1aa0RFHT00nLubXXCjHVzQ9Ji7E8yjXuFUCx/i7L6l7smQwm6B511sbn1Lf
         g/AqPvgNd6JWUtuTqbN5r9+6gEf/TU1O1tQVnAZmnlbdHWbiErHOV40iwWl4FE9sMWZJ
         4hbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RUZOo7EzVX8iSq4VaRfQlqMam7PZKasI9SobMF45IP4=;
        b=p7vtdMPhqlp/BPuSWMIC6Gw0/0mbaRfE8NGZJ7/oaKYp1c1cjAQLMwQLjO0usv+MEO
         iaE7eyqPR26z9OBddygHIyYCutQkvwUm28TMt4lH0483qTQ5MO2lw++/qsf5q5tO5hZK
         Cdqc4gkW+4WRDwnDBuuQsFKfTH/NHspsLzEOr1ifAtVFeMzPNX3tusqSUGUnlYgCzZra
         2f28ImXe0nwiDLKQaO48r1+YzCTTQSvcIA/wKj0uQArcFu6y0y2LO+2/5425yBkyFG7d
         8+Na+yGMwWg4omy5I9aSfwVWOjL1o40NB1lFRh9rsraAdUy8kjDjFXQIep4KpVWIIGg8
         Gkxw==
X-Gm-Message-State: AOAM533phzUuKFZF0tcfScVv9wbeLiP72dRjjqnFcj0UIFjqK8dOfJhn
        KRFykQsIz2HrpBduLKq3TOhd7SaN/zSaXw==
X-Google-Smtp-Source: ABdhPJyAdnD/CArtVIdb9uhODlvEliNCJhsr1xnEdXNTqp/PPkVmwxdSuLU1IFHFTpl1tlFG7JwDqA==
X-Received: by 2002:a9d:1d64:: with SMTP id m91mr10950476otm.290.1612751163580;
        Sun, 07 Feb 2021 18:26:03 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:b91a:dd2f:a591:6ed1? ([2600:1700:e72:80a0:b91a:dd2f:a591:6ed1])
        by smtp.gmail.com with UTF8SMTPSA id h18sm3504729otk.26.2021.02.07.18.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Feb 2021 18:26:03 -0800 (PST)
Message-ID: <c19b6e23-96cd-fd0a-163d-826b46b51da0@gmail.com>
Date:   Sun, 7 Feb 2021 21:26:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:86.0) Gecko/20100101
 Thunderbird/86.0
Subject: Re: BUG: commit-reach.c:66: bad generation skip
Content-Language: en-US
To:     Filippo Valsorda <valsorda@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
References: <CA+2K_KotVrV=rjE6fcd_FfxxS0sewkywvO0EMVZdoHbSiqJTQw@mail.gmail.com>
 <CA+2K_KqH=Gn=Yx-UYzMBO+gZje3G3PJ_3-5HeO81wyZKvVwOSA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CA+2K_KqH=Gn=Yx-UYzMBO+gZje3G3PJ_3-5HeO81wyZKvVwOSA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/7/2021 5:31 PM, Filippo Valsorda wrote:
> 
> On Sun, Feb 7, 2021 at 11:28 PM Filippo Valsorda <valsorda@google.com> wrote:

>> [System Info]
>> git version:
>> git version 2.30.0

_This_ is interesting. I haven't heard of this problem happening
in a released version of Git.

I'm CC'ing Jonathan Nieder who recently saw this happening, but that
was on a newer version than 2.30.0 with a topic that is not part
of 2.30.0. But maybe the version shipped internally is versioned
without extra information on top of the latest tag? (I see your
@google.com email, which makes me think you have an internal version.)

>> What happened instead? (Actual behavior)
>>
>> BUG: commit-reach.c:66: bad generation skip     ad18 >        7 at
>> be28e5abc5ddca0d6b2d8c91b7bb9c05717154e7

This was recently reported, but it was thought to be due to an
in-process topic branch. If you recently had that version installed,
then your data would have needed a rewrite anyway.

This hints towards more problems with generation numbers across
split commit-graph layers. (The child has generation number 7, so
it is likely part of a thin layer.)

This might be sufficient evidence to convert this BUG() to a
warning with something like:

  warning: The commit-graph file has incorrect reachability index
  warning: information. Results may be incorrect until commit-graph
  warning: is rewritten with 'git commit-graph write'.

This could also be a die() instead of warning(), as that command
itself might return incorrect results.

> I was able to workaround this bug with a "git gc" invocation.

Yes, this will delete (and possibly replace) your commit-graph file
where the bad data lies.

To better understand your situation, could you please run the
following commands?

	git config --get-regexp graph
	git config features.experimental

I'm specifically looking for values of fetch.writeCommitGraph and
gc.writeCommitGraph.

Thanks,
-Stolee
