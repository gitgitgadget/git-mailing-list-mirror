Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D553D2027C
	for <e@80x24.org>; Tue, 30 May 2017 23:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750928AbdE3XRQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 May 2017 19:17:16 -0400
Received: from mail-pf0-f172.google.com ([209.85.192.172]:33515 "EHLO
        mail-pf0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbdE3XRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 May 2017 19:17:16 -0400
Received: by mail-pf0-f172.google.com with SMTP id e193so487855pfh.0
        for <git@vger.kernel.org>; Tue, 30 May 2017 16:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=paR9wja175bwiP3a7Xincg70DFBCfeoDenK4ByZaqes=;
        b=tb0Y9ys4/R1V5xyEJZcAYjzSAD+oJzXaCiuPHjjEQhVUGB4ITWq/JowL6xZznAdN1q
         IpJxK7OsgAVXJN9tlXCoNfm9lsFg5wqx1C4ExN8gvo7kQ7yE7xKdScgMhNlkphy9mCQT
         gAkzePRJeMl0U3QRoufUwuBz5c+pdVvRikOBrEO98ABPSUjX4wdtYc1aw3/J2QSCZJgu
         eyhutuI5STW/HGyJrOj5K79CHd8M1N/6d7UbOX/EAEsXmZVxgHtw+D31MIWwrlnht2BX
         O7XqGZbF6w1eGTW1jjDvKGXG2GFphL1NgtmtDKi99IH6D7e2tvTaxlpkuyeKi38PsSVv
         elMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=paR9wja175bwiP3a7Xincg70DFBCfeoDenK4ByZaqes=;
        b=rkg2GRbshJcOt1fpBEDlQhQSVX3TqLvXm75NagRws35s5F4+pDxtcwQomlTQIgTgay
         nSeMvEMYKPjfLmtoIBD3UH3xrX7wd5EXTvlSzOqgF08zKYkitJRVgjgaFzlz3VZfLDTN
         kFlyFAQ9iUaJhI94C73AKnNYYjGztsC92qSrZPk/jboyONvnwNNZa9jGXOYkSKtdnRTz
         Sx9b06y17NSlDR57hOHxeaBBS6LM+hMTXeg4cjC4aGroQv0a1me9YnORYt+3rk159Kjj
         YlAPUHyTsmTVi+KGLAuRfflhut24wkyXEnE5knFQA/wkwP5mjO1cbPI1Hx8FR1YHJwbg
         C/Hg==
X-Gm-Message-State: AODbwcAFXwjEeCiQqHHeFNe9QSkqsDxSzyUxiZg/LyjlHOBIkUFkz6VC
        mb9LaWsumn2Ejw==
X-Received: by 10.98.32.132 with SMTP id m4mr26795345pfj.131.1496186235488;
        Tue, 30 May 2017 16:17:15 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:d156:5238:7809:132c])
        by smtp.gmail.com with ESMTPSA id p13sm28550786pfl.52.2017.05.30.16.17.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 30 May 2017 16:17:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH v3 13/13] is_missing_file_error(): work around EINVAL on Windows
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
        <20170526033510.1793-1-gitster@pobox.com>
        <20170526033510.1793-14-gitster@pobox.com>
        <CAGZ79kZC4WM=aXPO9Rk1GQ7+XKUhoWUZefjM6Trk-11QcrhBYA@mail.gmail.com>
Date:   Wed, 31 May 2017 08:17:14 +0900
In-Reply-To: <CAGZ79kZC4WM=aXPO9Rk1GQ7+XKUhoWUZefjM6Trk-11QcrhBYA@mail.gmail.com>
        (Stefan Beller's message of "Tue, 30 May 2017 12:13:18 -0700")
Message-ID: <xmqqk24y9bph.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Thu, May 25, 2017 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> When asked to open/fopen a path, e.g. "a/b:/c", which does not exist
>> on the filesystem, Windows (correctly) fails to open it but sets
>> EINVAL to errno
>
> errno to EINVAL (as of now it sounds as if it is a EINVAL = errno,
> which makes no sense to me)
>
>> because the pathname has characters that cannot be
>> stored in its filesystem.
>>
>> As this is an expected failure, teach is_missing_file_error() helper
>> about this case.
>>
>> This is RFC,
>
> cc'd people knowledgeable of Windows.

This has been resolved I think with J6t/Dscho's patch yesterday.

Thanks.
