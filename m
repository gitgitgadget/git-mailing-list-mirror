Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8EE1FF40
	for <e@80x24.org>; Thu, 17 Nov 2016 18:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754853AbcKQSgY (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Nov 2016 13:36:24 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:34642 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754694AbcKQSgV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2016 13:36:21 -0500
Received: by mail-qk0-f176.google.com with SMTP id q130so233469033qke.1
        for <git@vger.kernel.org>; Thu, 17 Nov 2016 10:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Eo3VBMVIGpcOOI5nBGZNgjV978ye1hIa7rJlNAclMJE=;
        b=Y3hfBOi0UrV84LVSZj1exva78niyAazqt0r1Db23hopeUf0sOoZ4BCdaujrxa+CkqW
         ivMaaOxFU3yAxPMgzqCsTmYFytraBe0DPd1T9ex55i6nw1iHLo4m8g2fltMSlz4iw+9d
         jwDPTc5Y1mGNKcMNv32AvM/XycolwyQJEoVQUWl8iMB4o4tyA5pJad4mHvpqJpdeUd4q
         0rPfsLK3k9LxoJeFq2nlvbOLoJWe2LKWfw5GPg22vJObl64bOpgviX5UgjxCR1s/229W
         /jMbr7Zh96HhRMQ4QhNX7+5smRxhncYoqLuEXb7L1BO89TwNyo5hlJFfz3C/3UcBwtSH
         QqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Eo3VBMVIGpcOOI5nBGZNgjV978ye1hIa7rJlNAclMJE=;
        b=DSwVvQfBEgorSdp0lRygyaAfvjwWlaQXg+cxGukHsIoTQu1/8hm85lnIj5oOlQu2x5
         B1+3w0gwIAVBKWZ2/BbJt5Mc+Oqk/X7Om27vl4pv6vydZ9sDeFlBl14wqsaS3/eaRhf0
         v5m9afDvW9y9uht/ZAyG/YPh6tfi42eQUtjn57Aj/SyYN1VoKnHa93lD+qditRUBBk01
         sjUkyxoZognN+22gypfMtMlGVqc2Zzjfr/qCav8cpLlYUjcbVZl4DxN+kpv06B3aZ1R6
         I77UPASLFQQh1wYhdR3Gjfw2n80a/O1gllnDWcXMJgWzbGyXzBrqkKOLgLrWXl8CsfYu
         pykA==
X-Gm-Message-State: AKaTC006i62qPwDnnOlOZXJLl/L3Jj7sNdbt1yxfOCwDkbh+mi3KLvycLL3W3KQpdUHzQeDn1kN0sIQ03bV1YpRq
X-Received: by 10.55.16.147 with SMTP id 19mr4989952qkq.255.1479407780311;
 Thu, 17 Nov 2016 10:36:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.134.65 with HTTP; Thu, 17 Nov 2016 10:36:19 -0800 (PST)
In-Reply-To: <xmqqwpg3p7rm.fsf@gitster.mtv.corp.google.com>
References: <20161115230651.23953-1-sbeller@google.com> <20161115230651.23953-3-sbeller@google.com>
 <e19fbbca91d5446e8fe308e847f53ae3@exmbdft7.ad.twosigma.com> <xmqqwpg3p7rm.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 17 Nov 2016 10:36:19 -0800
Message-ID: <CAGZ79kbStcBguwuoTD4bXch4NmAaSLuEPTLW_hGM=PLe2g9upQ@mail.gmail.com>
Subject: Re: [PATCH 02/16] submodule: modernize ok_to_remove_submodule to use argv_array
To:     Junio C Hamano <gitster@pobox.com>
Cc:     David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "bmwill@google.com" <bmwill@google.com>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "mogulguy10@gmail.com" <mogulguy10@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 16, 2016 at 11:03 AM, Junio C Hamano <gitster@pobox.com> wrote:
> David Turner <David.Turner@twosigma.com> writes:
>
>>> -            "-u",
>> ...
>>> +    argv_array_pushl(&cp.args, "status", "--porcelain", "-uall",
>>
>> This also changes -u to -uall, which is not mentioned in the
>> commit message.  That should probably be called out.
>
> Or not making that change at all.  Isn't "-u" the same as "-uall"?

Yes it is.  My original line of thinking was to have it spelled out
clearly in case
it changes in the future, but then we could argue that the --porcelain parameter
ought to keep the default of -u to "all".

I'll undo that change then.

Thanks,
Stefan
