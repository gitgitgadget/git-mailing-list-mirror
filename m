Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 57C0E2013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932198AbdBOXT1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:19:27 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34444 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932187AbdBOXTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:19:25 -0500
Received: by mail-pg0-f66.google.com with SMTP id v184so114786pgv.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=iPfOQUTp7ZoA7s+9UF7c+V6PBaahjZZvAABsG5Lr6tA=;
        b=YpnGVT2CaVFKNltd56ZLHZbBUhPaw9G0GWMAHdfSj9FQ5rm57EsO1Cr5PtFWGXxzyn
         Wjn/LfVbdgN/20lvDierl3jic7v3B/O8Wc5JOt2eL2PIZkOUt5pr3z3WaKrzRX+BDOS5
         7rpO+LMuYzGim5eqfoxszWvoMLYD+4mfTXbYvPz+8wL8oEk5psk9ggqa1SvxBm1Hb6bi
         xgAZEt0PUqhTmvfojZa0uetKgxg4TmRvRJzCslrFopqGTzDGM2P+FHmkq+25hnlKnXK1
         xXHLHCnsZNCAE5i0a8jGaqJ15ABnjyZnk3oP0CkVgNfy/LkxFoCk9u3NCZIKobao3waX
         oPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=iPfOQUTp7ZoA7s+9UF7c+V6PBaahjZZvAABsG5Lr6tA=;
        b=BIFPiD6TBGcUtEEWiD/HgG5Tl6BKF+3sA+pu0Kh8EK3YIRpOcFsKe8P5/84aoLot5M
         pAz2n6DlwpcNRV3VZdUc5bPJWuQqXFU9Q8OwgOuhZMrEfvO6UeYlXIchmXeH8rKBz2KS
         +06v9lBkU2pXLEq9H1nHpUQIGRmxiF0MFXqT02HuNKXW5kRuH1lNpSo4A3v3mz9VsWbv
         wVCPKo+nGZ6kqnVKBw2DaWxAqZsxOtPL9hPLBa+4rypPCjrIH+7ZdZHnhN5WfiB0obWc
         eei1rfIpFDU1GSKPeKoLsVfuzq5u2itVoJg455yVWPWD/yPh0dzXtW4qbIbbPbmXfsLf
         cJcg==
X-Gm-Message-State: AMke39lFHyxHqioH1vAG7kHOruEXKOZo3dT8aLcRSf6Hlfb1dNV6Z0TqbNxJVnqElqPRPg==
X-Received: by 10.98.200.5 with SMTP id z5mr41187093pff.0.1487200750110;
        Wed, 15 Feb 2017 15:19:10 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id j185sm9451703pgd.35.2017.02.15.15.19.09
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 15:19:09 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 04/14] connect_work_tree_and_git_dir: safely create leading directories
References: <20170215003423.20245-1-sbeller@google.com>
        <20170215003423.20245-5-sbeller@google.com>
        <xmqqh93v48mv.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaX1URNvzp8QuFEFnJDzSW9nE971+nvhPLOQQx4aSyBkA@mail.gmail.com>
Date:   Wed, 15 Feb 2017 15:19:08 -0800
In-Reply-To: <CAGZ79kaX1URNvzp8QuFEFnJDzSW9nE971+nvhPLOQQx4aSyBkA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 15 Feb 2017 14:52:50 -0800")
Message-ID: <xmqqpoij11qr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Wed, Feb 15, 2017 at 10:22 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> In a later patch we'll use connect_work_tree_and_git_dir when the
>>> directory for the gitlink file doesn't exist yet. Safely create
>>> the directory first.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>
>> Among the existing two callers, the "absorb" logic in submodule.c
>> has safe-create-leading-directory (SCLD) immediately before the call
>> to this function, which can now be lost with this change.  The other
>> one in cmd_mv() has the target directory as the result of moving the
>> original directory, and I do not think there is any corresponding
>> call that can be lost from there after this change, but it is not an
>> error to call SCLD on a path that already exists, so all is OK.
>>
>> Is it sensible to let the code continue with just an fprintf() (not
>> even warning() or error()) when SCLD fails?
>
> I'll move the code from the absorbing here (i.e. lose the
> SCLD lines there) and make it a die(_(..)) instead of fprintf here.

OK.  I didn't actually meant to suggest the former (I meant that I
expect that would happen in the future steps of this series, or it
can be left as a follow-up patch after the series settles); the
latter may be worth doing.

Thanks.
