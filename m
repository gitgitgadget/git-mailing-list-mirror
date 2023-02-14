Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C57C61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 06:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbjBNGpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 01:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjBNGpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 01:45:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76667EB79
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 22:45:08 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id w5so16041020plg.8
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 22:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfBp1yN3mRjElKMSfNA+JyhujldEBqwiyyfS/nAhVRo=;
        b=gdVJ8njO0+pdq5XH2ZiqRkRfykCSm0y3z5M6cciOwGwobKj19iaLJR2JxOvug4xX+a
         Rv9yfk5XqiruZPXlsKk4AFHhFBJvF7Xvb2Srgzgo5AwBCpHSBXVNW1Cu2ALcGTTVqMRU
         7U+ZR0T2MZ5ef9PhckA/uZMALch4Bn+iZrT6MY2fMqPQKOwwCUTuh3+NHS32QWfy6pqn
         GxegKaZIkpt+XSmPHXwQAg4ZD2z1JkE1WdRaSzuWGA0vADnC64Y4H9dlJ4KlcF91MJTr
         sYnnAWvTuBJOiiYEdCmhT8hw+lL5XOw85vVnHZuwp5aaPz021if4qm3BAE0AdOD3Y2XM
         wOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfBp1yN3mRjElKMSfNA+JyhujldEBqwiyyfS/nAhVRo=;
        b=xg94517UbEXcT+1Vx2UvNbgz7TsBk5YJDtN55oNKNrXY9DRx5XyaW+e+uliR2Gp6VJ
         iVcCYF6Ic9SZSLExBX6GGd+aGiVbEdkXjjVelCKOZ+D367ZAajJmEy5CTltDfbHovDXw
         1tDwqV4ijH4VlUb68y3B9/I8kA0jweS6lM4B2mp7VEf8sWghBgK59Qvt9NtbrZPXHPW+
         qkdVrxAiTLaPN/g9WXTITVk9Z/2J2GBfYT0VQBzb557yJgLRxEPJN7AqfQq2QUerk1w2
         D1P8bebZfUy2n/IcvsC5nnpyLP/0jMmc2VHF+MfQJJtiSrxX70Niqbt8cssTxfiy8xSq
         sntA==
X-Gm-Message-State: AO0yUKVHs2Si8PPrkA68i3YjGp0/kdra+KcVIpfmNkXCkFbZvmW2+nyM
        bGpQSQI6niYJ+j7gjTSq5dc=
X-Google-Smtp-Source: AK7set/w7PPRqFG0yT70dxMGksyy/d18s6VF0M5gziqiU6ulznIXoxIWh70bOX7Lg1FHf1fu6xZwoQ==
X-Received: by 2002:a17:902:c944:b0:198:f753:7b23 with SMTP id i4-20020a170902c94400b00198f7537b23mr2060853pla.66.1676357107818;
        Mon, 13 Feb 2023 22:45:07 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id iw3-20020a170903044300b0019ab3308554sm1070585plb.85.2023.02.13.22.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 22:45:07 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
        <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net>
        <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
        <Y+rmNvfjIA/u81em@coredump.intra.peff.net>
        <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
        <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
        <xmqq7cwk955b.fsf@gitster.g>
        <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
Date:   Mon, 13 Feb 2023 22:45:07 -0800
In-Reply-To: <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 14 Feb 2023 01:05:20 -0500")
Message-ID: <xmqq3578924s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Using (presumably) valid LANG codes results in the buggy truncated
> output, but "LANG=C" produces the correct result:
>
>   $ for i in C en_US fr_FR de_DE ru_RU zh_CN; do printf "$i: " &&
> LANG=$i.UTF-8 git symbolic-ref --short HEAD; done
>   C: 测试-加-增加-加-增加
>   en_US: 测试-?
>   fr_FR: 测试-?
>   de_DE: 测试-?
>   ru_RU: 测试-?
>   zh_CN: 测试-?

Interesting.  

So the system cares more than just "is this a valid UTF-8 sequence?"
but somehow knows that the given sequence is a valid Chinese and not
valid English?  ---oh, no, zh_CN is rejected, but your earlier zh-CN
somehow was accepted?

Now, it is beyond my ability to guess what macOS is internally doing
wrong X-<.

