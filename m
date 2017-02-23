Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5371C2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:06:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751228AbdBWTGe (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:06:34 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33574 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751210AbdBWTGc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:06:32 -0500
Received: by mail-pg0-f66.google.com with SMTP id 5so30218pgj.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 11:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CpapTQrr6xrpCwMmfOxbSyzyz7Fn+8rtBN4dmPvY+uc=;
        b=tiz1b2N+SLncRJ0SnbnLSfuJUMXYXmHxrHdRztsbBwLuzfVQoljiZoBY+/tB4kFybJ
         sB8ZIn+RffKnzhay7dU1NkX+T8GfyQJ/v1/+GR2sNco2Njz75bK9T7t4YyLKsd+vpv/A
         +95fTaXMxcDNmHpfDxQUDQV76QV1PX96RSQIZfutHc4sjZTCxC8UvfGvT7C1jNZf8GmS
         5udt1Z4BvurD4utLd0wjuNn5I+UodUbTQOxA77eCDpxJKmnoREknJBEhDEMpeHnTOSGv
         A1sHl6tF5fj1OPardPMHGzSYf/b3VWsfA+sL6uD2SlialiZdvPm9ayfE7Z+LxoeSnCX6
         u8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CpapTQrr6xrpCwMmfOxbSyzyz7Fn+8rtBN4dmPvY+uc=;
        b=irGWk0DOeIr143LVxNkTG5I52FPM2wS+Z6ofjNMRhYHMAgyslidj7CgVTT2xgMXbHe
         zsaKhrnjvOnxoLGBJDoox2DIR7omGzsvN9q4vRiw/uWWEpJ8tbnIZcT/T+gqpQPQAMne
         SqlpM9YwbZyr4GNDsbVshHOOx2Vh73E7W6y7vUOxS7+ASndIA3ZQIFCr7bVn/YnxK5Eg
         czfhD0QMbcGHg/ml/YbG+NaIppwshinniI+w4dlXdUr5TsmDUpNsWFVtJyqX1d9w2SsS
         wBNqPL3GxY0qNlObTUesUPUiOB6CitYZcaiOERztpVmJpDlCxlB9gomcSNaz1qZXo6ab
         lyyQ==
X-Gm-Message-State: AMke39k+nmZ9UFCnLaEV4mtb8U4IxPpTbn83KpkeFjlR9NvIeCsDq4YKYAFvm5ZSIJNwQA==
X-Received: by 10.98.24.7 with SMTP id 7mr43037774pfy.11.1487876782222;
        Thu, 23 Feb 2017 11:06:22 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:8829:f260:c132:141f])
        by smtp.gmail.com with ESMTPSA id u84sm11209896pgb.39.2017.02.23.11.06.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 23 Feb 2017 11:06:21 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>,
        David Turner <David.Turner@twosigma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "sandals\@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
References: <20170222173936.25016-1-dturner@twosigma.com>
        <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
        <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
        <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com>
        <20170222213410.iak43asq775tzr42@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702231806340.3767@virtualbox>
Date:   Thu, 23 Feb 2017 11:06:20 -0800
In-Reply-To: <alpine.DEB.2.20.1702231806340.3767@virtualbox> (Johannes
        Schindelin's message of "Thu, 23 Feb 2017 18:08:49 +0100 (CET)")
Message-ID: <xmqqbmts9177.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 22 Feb 2017, Jeff King wrote:
>> This patch drops the useless probe request:
> ...
>> but setting http.emptyauth adds back in the useless request. I think
>> that could be fixed by skipping the empty-auth thing when
>> http_auth_methods does not have CURLAUTH_NEGOTIATE in it (or perhaps
>> other methods need it to, so maybe skip it if _just_ BASIC is set).
>> 
>> I suspect the patch above could probably be generalized as:
>> 
>>   /* cut out methods we know the server doesn't support */
>>   http_auth_methods &= results.auth_avail;
>> 
>> and let curl figure it out from there.
>
> Maybe this patch (or a variation thereof) would also be able to fix this
> problem with the patch:
>
> 	https://github.com/git-for-windows/git/issues/1034
>
> Short version: for certain servers (that do *not* advertise Negotiate),
> setting emptyauth to true will result in a failed fetch, without letting
> the user type in their credentials.

The issue described in that page looks rather serious.

I believe that a "variation" has become the first part of a
two-patch series that appear in the downthread from here.  Perhaps
you can ask them to test it out (or even better if you have a setup
you can easily test against yourself)?
