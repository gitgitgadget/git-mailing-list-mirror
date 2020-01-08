Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0899AC282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:14:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CED1320705
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 19:14:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5OPOfne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgAHTOl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 14:14:41 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33355 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726363AbgAHTOk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 14:14:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so3743323qto.0
        for <git@vger.kernel.org>; Wed, 08 Jan 2020 11:14:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qSb3bNJzzyRPH9cGqhXv/8V9m60TnGLGfI5++q/rk3M=;
        b=l5OPOfneBsu8AUXVgYqcI04kgHuVbG6V6pqPHcey5CFoiwT6WIgKbKBUEUdbNevs5B
         Y3IvYETsIlZWECOvpHapnXWnSWo0qvFEN2IJJq3gSPx+Iy8mACmY9wV72wJF/eMR3LtV
         X/6oc3QSUrYHVxdg14fNXC5QsF+0NAJ1iUv87A6yqCaHbHOrID1ybUCu7o50m8SyRfM1
         7JsVG/j1dKn2NVCpGjS/x3VeFXwnmdVbBWS7BhkgRArp305h+gpXS5fwOYkG0zn5cn91
         eJDUR7rHmNDrXpug2dwlI743EAA25I98N+wF39fQpjx8uNAQ7RlgWCwjBhmWyXgC8Dyv
         cB9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qSb3bNJzzyRPH9cGqhXv/8V9m60TnGLGfI5++q/rk3M=;
        b=UkHJgAxQ4QSPNNAY6X1/ScLwy/wuKNTvc1to+F8Wu7lT0bs+Nseohu8XaWG0Fa+Opp
         NZZcAHvHnr+Z6Jb6LVfhgF7NKKLxtuTbx51CI+IAj1xttpZR5bXJy3W/MnO3OkrjUzUf
         UH+fLusIY849BQbij69jq+8/TIWrKPdD4/Gc32svH6NArSE+Int+q7mcd5NK2XzEtE0e
         Ni91rPh+acwBN7YB1pG+oWBxTtiklBuQRXrOKRYCi4llx2PiJJlej7WTZl5POBL5Yw6+
         mJiuz0QHehyjh48PVVNnt1+dZKQquNwn4aoHsKx6vKtvhMPL4BOn4YVf8pUZ/8tt+gjT
         MehQ==
X-Gm-Message-State: APjAAAWhRyUO6HPV0Ow/CYh/7ZAsQligm+OtS9wBRIqBMmm6ifuvtLeQ
        qGfVsX4NRKzlpq/uFlQHrDw=
X-Google-Smtp-Source: APXvYqwpv/ZaZ8djblOUxVBtIEcGrfryWwS6jXXH2P/kX4OznWt4NRKPyM8sOEGJ0LHgBS0OYAgFvQ==
X-Received: by 2002:ac8:3a02:: with SMTP id w2mr4677011qte.351.1578510879351;
        Wed, 08 Jan 2020 11:14:39 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:3d10:d3f7:2db7:a1e2? ([2001:4898:a800:1010:ee45:d3f7:2db7:a1e2])
        by smtp.gmail.com with ESMTPSA id t42sm2142183qtt.84.2020.01.08.11.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jan 2020 11:14:38 -0800 (PST)
Subject: Re: [PATCH v2 1/2] graph: fix case that hit assert()
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, brad@brad-smith.co.uk,
        sunshine@sunshineco.com, James Coglan <jcoglan@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.517.git.1578408947.gitgitgadget@gmail.com>
 <pull.517.v2.git.1578432422.gitgitgadget@gmail.com>
 <c05fe2c37a87b254157eec1c8a0f8ca206e1cd31.1578432422.git.gitgitgadget@gmail.com>
 <xmqqd0bv3pin.fsf@gitster-ct.c.googlers.com>
 <xmqqa76x3l8o.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c7df7e59-9e37-72eb-e1b0-aa21bb6045dc@gmail.com>
Date:   Wed, 8 Jan 2020 14:14:38 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqa76x3l8o.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/8/2020 12:34 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>> Subject: Re: [PATCH v2 1/2] graph: fix case that hit assert()
>>>
>>> A failure was reported in "git log --graph --all" with the new
>>> graph-rendering logic. The code fails an assert() statement when
>>> collapsing multiple edges from a merge.
>>>
>>> The assert was introduced by eaf158f8 (graph API: Use horizontal
>>> lines for more compact graphs, 2009-04-21), which is quite old.
>>> This assert is trying to say that when we complete a horizontal
>>> line with a single slash, it is because we have reached our target.
>>>
>>> This assertion is hit when we have two collapsing lines from the
>>> same merge commit, as follows:
>>>
>>>     | | | | *
>>>     | |_|_|/|
>>>     |/| | |/
>>>     | | |/|
>>>     | |/| |
>>>     | * | |
>>>     * | | |
>>
>> I was sort-of expecting to see
>> ...
>> near the beginning of this commit, though.
> 
> Will do this locally before using them in rc2.

Sounds good to me. Sorry for the delay in doing it myself.

-Stolee
