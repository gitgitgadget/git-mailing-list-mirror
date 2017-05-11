Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89312018D
	for <e@80x24.org>; Thu, 11 May 2017 05:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754759AbdEKFNU (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 01:13:20 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:33238 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754028AbdEKFNT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 01:13:19 -0400
Received: by mail-pg0-f68.google.com with SMTP id s62so2124944pgc.0
        for <git@vger.kernel.org>; Wed, 10 May 2017 22:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uG5B5D7G9r5ffiqW4h7X0KjIGdJ/q7viuPHFUMRdgJA=;
        b=tU9aUyhdduwFgJN9SjxoNUh54XEhzCYkYQMC1LbXhHfq5ohFwxkK3c/qxd2u8rkxtU
         NAhjFFkzXq+KM80yQOzdpCILuQ7KZHE1DdAPP2KwkZgDAfaaNVP22AbKlC3m0zZSXu67
         vMBvc+clrUWp76lQQAw1yaIVRRzKyHT4PoTJ9KEaoVmb4z0yxyc1tbmroFx/OfIcbPcj
         66VRIbR0ecATGFdlUqY07/rtSQB28ZlhmnXNbTmqIorVura8LeDNCaaLSg7XHSrIjJ6L
         /rEuA7m/VoERM+rFGP2QfU2mLMtSxfv/PQtDYMt0Aw5wmoFA8kqLn4/VCOb/ZhBXiLpp
         FgxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uG5B5D7G9r5ffiqW4h7X0KjIGdJ/q7viuPHFUMRdgJA=;
        b=Xg3QaV5x0Mg19lz3M2yuy9IKCKMyyD+HbQStwrj9ipUamhQvLhwulffG7j9XP2l3qt
         YuU9fN2IoQiYFfmdqDQ12iLVVXnX00r2k3vlay2Z+fbqsTAxR31LgU8HWJZYBHgPHIrA
         RWM1TJWMaI1tb30LYXFoog8zw1VLsmxw40ZkB6PZb56ansGzx5mJOv0HHSdfxBg6o89w
         TU2MOVsba4c10SryyJnsBdEjPD326zsfYQsEnK6638du03m7ChnSzMpLffFcsIlGuV3M
         uq/D7wLcoZYxE8U6T3jtyXoS7AGEoedm2CDvxc1W26rEc6iy2OyEkJRHAgLSu3c0igdL
         KhxA==
X-Gm-Message-State: AODbwcC8esd9PCABS8p5tml79XvrMbGDWvJZYTWq6E+UD+t6UQnsl60s
        Cu8nhuXJjih+Yw==
X-Received: by 10.99.111.140 with SMTP id k134mr10373092pgc.20.1494479599168;
        Wed, 10 May 2017 22:13:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:91c4:5195:150f:b3e6])
        by smtp.gmail.com with ESMTPSA id 186sm981598pfx.72.2017.05.10.22.13.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 10 May 2017 22:13:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 8/8] pathspec: convert parse_pathspec to take an index
References: <20170509191805.176266-1-bmwill@google.com>
        <20170509191805.176266-9-bmwill@google.com>
        <xmqq1srxxn72.fsf@gitster.mtv.corp.google.com>
        <20170510170226.GB41649@google.com>
        <xmqqh90sw4dr.fsf@gitster.mtv.corp.google.com>
        <dab1beaf-ca8d-2f3f-9fcc-22e6938a868a@kdbg.org>
Date:   Wed, 10 May 2017 22:13:17 -0700
In-Reply-To: <dab1beaf-ca8d-2f3f-9fcc-22e6938a868a@kdbg.org> (Johannes Sixt's
        message of "Thu, 11 May 2017 07:04:46 +0200")
Message-ID: <xmqqo9v0ascy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 11.05.2017 um 03:48 schrieb Junio C Hamano:
>> But perhaps you are right---it may be wrong for the contents of the
>> current index (or any index) to affect how a pathspec element is
>> parsed in the first place.  If the current code (before this series)
>> uses the_index only for error checking, we may want to separate that
>> out of the parse_pathspec() callchain, so that it does not even look
>> at any index (not just the_index).  And that may be a better change
>> overall.
>
> Just a reminder: if core.ignoreCase is set, the variant of a path in
> the index takes precedence over the variant found in the working
> tree. Hence, pathspec must be matched against the index that
> corresponds to the working tree. I guess that's the_index.

Yes, but that is what happens after a path from a working tree is
found to match a pathspec, to coerse its case into the one that is
in the current index.  The parse_pathspec() thing we are discussing
would have finished looooong time before that actual "matching" is
attempted.

Thanks.
