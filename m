Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2C21FC46
	for <e@80x24.org>; Fri, 10 Feb 2017 22:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751748AbdBJWF2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Feb 2017 17:05:28 -0500
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34231 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdBJWF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2017 17:05:27 -0500
Received: by mail-qk0-f178.google.com with SMTP id s186so54112586qkb.1
        for <git@vger.kernel.org>; Fri, 10 Feb 2017 14:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wLU8jpw7YGncU0h5aOpD5qhgZAvno5ene6Yi0bsPLSQ=;
        b=MV7r9sjouJFC4S5s5gjOn3or5kBHnv7mJ2PTDeeuGy7WSMSfMqAnOz90Q/PMd6imW2
         a73FO4TlSJUdBLtypTw2WZ+lL9gNNMK17hG/r4zBKQODGcbms1OZ6IsuV1XElstlPQFW
         PXmWxopFjNJ2TdgUZEArBr6/w8YOQQT+/G8Io=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wLU8jpw7YGncU0h5aOpD5qhgZAvno5ene6Yi0bsPLSQ=;
        b=dDOopwLm9ZmwxX+Cdqf/Tz92isQ7ys5O9kHlQhrW8E0ekW840Ue0hOgeotshL6X18e
         Kp4BmxXwyx0PkOfFCW5WR7CpQ851yfcjwRGKs+Sblv7VO3xFJwMxz0lZsF4LM8qNfbku
         W+FmG4M1Pr33KmTM/S+4mD1CC9Ei8BRTx9q8V32UYYICBfMWDmGfqnAkZ267IzowVE0z
         X/bAFo87HEkUt+C++vbgLv4n49hcHHsXY2iGJvG3lIxCEa4N1ncQohDqVS+kIe+f39ON
         TRvePX1D0TCDVzqpespN8QdDcPNUmAIaNGm3cp2pcnKSFAM3SypvFEdG7oHszY9/crbV
         DYBg==
X-Gm-Message-State: AMke39lSZBTym94nY6nEVE/FoE/3LLH26rZ4z0dr/s8r5JFe0bvVp2VM9ggzVlSQvDsb65pUdzp5LpzUiuNPvw==
X-Received: by 10.55.209.203 with SMTP id o72mr10398468qkl.281.1486764326719;
 Fri, 10 Feb 2017 14:05:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.237.62.179 with HTTP; Fri, 10 Feb 2017 14:05:26 -0800 (PST)
In-Reply-To: <xmqqfujnlyru.fsf@gitster.mtv.corp.google.com>
References: <CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com>
 <20170209150656.9070-1-larsxschneider@gmail.com> <xmqqfujnlyru.fsf@gitster.mtv.corp.google.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 10 Feb 2017 22:05:26 +0000
Message-ID: <CAE5ih78xRAOFb+MC53qzNJyZ_d7j+87UYEt5Ku6JrkFhgHdD7w@mail.gmail.com>
Subject: Re: [PATCH v2] git-p4: fix git-p4.pathEncoding for removed files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9 February 2017 at 23:39, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Schneider <larsxschneider@gmail.com> writes:
>
>> unfortunately, I missed to send this v2. I agree with Luke's review and
>> I moved the re-encode of the path name to the `streamOneP4File` and
>> `streamOneP4Deletion` explicitly.
>>
>> Discussion:
>> http://public-inbox.org/git/CAE5ih7-=bD_ZoL5pFYfD2Qvy-XE24V_cgge0XoAvuoTK02EDfg@mail.gmail.com/
>>
>> Thanks,
>> Lars
>
> Thanks.  Will replace but will not immediately merge to 'next' yet,
> just in case Luke wants to tell me add his "Reviewed-by:".

Yes, this looks good to me now.

Luke
