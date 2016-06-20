Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C82811FF40
	for <e@80x24.org>; Mon, 20 Jun 2016 17:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932372AbcFTRPX (ORCPT <rfc822;e@80x24.org>);
	Mon, 20 Jun 2016 13:15:23 -0400
Received: from mail-qk0-f173.google.com ([209.85.220.173]:33027 "EHLO
	mail-qk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551AbcFTRPT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jun 2016 13:15:19 -0400
Received: by mail-qk0-f173.google.com with SMTP id a186so170733432qkf.0
        for <git@vger.kernel.org>; Mon, 20 Jun 2016 10:14:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kpi+RXJ6PfcefYppJNwBTgoT2TMc3gAsHUUObcMwISc=;
        b=IrhoAYIQvGN5iV/4aGJ742ti23w65MrscKXcS+LdwNU/fSTx8CXE1A0HFs1vS92DIL
         4gKekBSKtkzuOdP9k+IlIeWRPzFrhOSJ2ZFSvLQC62KZzq8Ger/nJCHpogm8za47Fu/J
         6ARVXAYFPiNjsS3zccoUAAtsTvTlnXVf59rvooeOpzK4rBDO6Hs8DpbZCCgHfu8fWaSX
         0RFj8xB3gnWOXVlBvmDpAtZldMSlSQbphmx3Mz+LGlarFqODoT1UsG3+bJCabgyCzDSD
         RglSrw1GXC7K4SADp8yYHvEQvaPgB/iqwCX0byalAsp0IrwAieWvfRxhgGhxGdeO10IW
         Li6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kpi+RXJ6PfcefYppJNwBTgoT2TMc3gAsHUUObcMwISc=;
        b=L35DjJeW5Pxp3a1wTRGdcQcHhf5UlpNeZy0qEWyi+VyY8jW3aFlb9NC/41EFiqG+kd
         EYAw0t3eP6FqJtv2VlCPg86W5POhX/9/oOKMdSfyV9XLrd0u7tZqNfinWI2yPovwMlfM
         F8fBCxyo6bZt9Z3JwYm42AGDBUzeKzJTFqiLV6uUeuILAG+4AIUS3RYDoxeG8bg4+2lP
         iys3XROBXfCB7FsoXiacerquQngYqVJT3Mu3Bm1Xk72L3L3H4xWjSnswitMvaVVoaWjl
         WtSZrndJV94UWKObKenZH5CpdRXhXdIQwsSAmnDjYW/ctQAw8KpsnpdqsINJbJ+rnsd7
         IA0Q==
X-Gm-Message-State: ALyK8tLR30w0D+BabLCQZayy+ySkrIyqzjkphuoVTcJz3+15Vn3N35pBKwcGEe/TDPUrFJavrBX9SKTATFgInJhy
X-Received: by 10.55.207.74 with SMTP id e71mr23767303qkj.64.1466442888161;
 Mon, 20 Jun 2016 10:14:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.237.42.226 with HTTP; Mon, 20 Jun 2016 10:14:47 -0700 (PDT)
In-Reply-To: <20160620171312.GA1880@sigill.intra.peff.net>
References: <xmqq7fdkx5oz.fsf@gitster.mtv.corp.google.com> <1466441998-18896-1-git-send-email-sbeller@google.com>
 <20160620171312.GA1880@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Mon, 20 Jun 2016 10:14:47 -0700
Message-ID: <CAGZ79kbKoch0odOOz2QWhoGoSOBOgYyQ_QgbxPXy2iJJVqP6Vw@mail.gmail.com>
Subject: Re: [PATCH] shallow clone to not imply shallow submodules
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Vadim Eisenberg <VADIME@il.ibm.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 20, 2016 at 10:13 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Jun 20, 2016 at 09:59:58AM -0700, Stefan Beller wrote:
>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>
>> Hi Junio, Peff,
>>
>> I thought about this patch squashed into
>> "clone: do not let --depth imply --shallow-submodules" will actually test
>> for the regression.
>
> Yep, it looks good to me.
>
>> +test_expect_success 'shallow clone does not imply shallow submodule' '
>> +     test_when_finished "rm -rf super_clone" &&
>> +     git clone --recurse-submodules --depth 2 "file://$pwd/." super_clone &&
>> +     (
>> +             cd super_clone &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 2 lines
>> +     ) &&
>> +     (
>> +             cd super_clone/sub &&
>> +             git log --oneline >lines &&
>> +             test_line_count = 3 lines
>> +     )
>> +'
>
> This follows the style of the other tests, so it's the right thing here.
> But as a style suggestion, I think:
>
>   git -C super_clone/sub log --oneline >lines &&
>   test_line_count = 3 lines
>
> is nicer than the subshell. It's more succinct, and it saves a process.

which we would want to refactor to in a follow up, but not merge it
through to 2.9.1.

Thanks,
Stefan

>
> -Peff
