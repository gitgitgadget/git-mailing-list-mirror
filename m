Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB0D91FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:20:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752318AbdBNSUA (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:20:00 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34010 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdBNST7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:19:59 -0500
Received: by mail-oi0-f54.google.com with SMTP id s203so74980265oie.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zFFPUgnIGXrfr8FJKOTGanjG7UhzK1cXRGFXyhPkQhw=;
        b=jlAEOAPJg5dC9JjyzOoUsPy+7h8Z7p976NwrOiCgRvklaGmEnwTWhYmxo0d57HjYxz
         t8FD3/MVnhmgvFQkwntQbVXAurwok+OE1m02Uqnht0wGGkXuyeUYw3qtx39ySAyexG/5
         4iTB83kmDGpruXi6i0Cgn9NJajsOxoTewn53WyuUlddXIZz2HI1QLFyTEdB0AGIW+xn1
         9PpFUkgSWA9m2AApb2MXxm35xAe+zxlVoVVOODGtEJPpkGYipvYZQpqlVUJZkoaS5d5P
         HJZOLfL7kFdP3OJI0QpnZZY/CGZLrUkk+N6LgkTlf8nsLisAGto7/oGo/nNplxZDlte/
         QTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zFFPUgnIGXrfr8FJKOTGanjG7UhzK1cXRGFXyhPkQhw=;
        b=pHZweW3hwgPa4c2akbe++v6Q71DwQTYGrAGmMar99u+oySS5I2JLCoPN33uxXHVjEX
         FfXckiPieBCSHXs2bKoR8loEiobDf9/854Y0EIvUvSdZinam0vd/vIp4IkMFL7p4E04s
         jVGVEAQhxKmE1DTveYWYCAqVS6EuwE88qMBVrbw8YtGOzqdwEQ1RnF8tbwGq7AUwPN2A
         PAty6wgnY12E2ulATQkbKAKV7pXoaID5dsxO5vpXfudfaN2AXRjuIkcLIl0cFGI1NpIe
         0yHB+/YV97iDUbr1ZlNJ1R2LZKGBVcGO0bdUufVWvlwqGDONlV21FtTJxBpzODqfY2uZ
         GlVg==
X-Gm-Message-State: AMke39l8U3WMSQTErXQ6Sj2MMxxdQq5K9cJBWX0JTMrmKX1adZkmhMPJJ5qaXhjrgEfEafSj
X-Received: by 10.84.217.153 with SMTP id p25mr35257159pli.164.1487096397902;
        Tue, 14 Feb 2017 10:19:57 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:55a2:e20d:aab0:fd6b])
        by smtp.gmail.com with ESMTPSA id 2sm2575513pfv.100.2017.02.14.10.19.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Feb 2017 10:19:57 -0800 (PST)
Subject: Re: [PATCH 6/7] grep: avoid resolving revision names in --no-index
 case
To:     Jeff King <peff@peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
 <20170214060729.v4r24y5tuaov3jrh@sigill.intra.peff.net>
 <eef97cc4-d616-b298-bc99-b2772b757190@google.com>
 <20170214180453.tpze2hdv3eytxfju@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <82212eaa-76d2-3357-8e06-5e4d56028c2e@google.com>
Date:   Tue, 14 Feb 2017 10:19:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170214180453.tpze2hdv3eytxfju@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02/14/2017 10:04 AM, Jeff King wrote:
> On Tue, Feb 14, 2017 at 08:53:04AM -0800, Jonathan Tan wrote:
>
>> On 02/13/2017 10:07 PM, Jeff King wrote:
>>> diff --git a/builtin/grep.c b/builtin/grep.c
>>> index e83b33bda..c4c632594 100644
>>> --- a/builtin/grep.c
>>> +++ b/builtin/grep.c
>>> @@ -1176,6 +1176,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>>  			break;
>>>  		}
>>>
>>> +		if (!use_index) {
>>> +			if (seen_dashdash)
>>> +				die(_("--no-index cannot be used with revs"));
>>
>> There is a subsequent check that prints "--no-index or --untracked cannot be
>> used with revs." - maybe we should just expand this part to incorporate that
>> case. (That is, write `if (!use_index || untracked)` instead of `if
>> (!use_index)`.) This also allows us to preserve the error message, which
>> might be useful for someone using a translated version of Git.
>
> I wasn't sure if we wanted to treat "untracked" in the same way.
> Certainly we can catch the error here for the seen_dashdash case, but is
> it also the case that:
>
>   echo content >master
>   git grep --untracked pattern master
>
> should treat "master" as a path?
>
> -Peff

It is already the case that it cannot be treated as a rev:

   $ git grep --untracked pattern master
   fatal: --no-index or --untracked cannot be used with revs.

So I think it would be better if it was treated as a path, for 
consistency with --no-index. I'm OK either way, though.
