Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE0FC636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 19:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbjBET1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 14:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBET1e (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 14:27:34 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340CC18AB4
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 11:27:33 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id y2so3789881iot.4
        for <git@vger.kernel.org>; Sun, 05 Feb 2023 11:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LOq6yBEOUF05hVScF1qFrXM7OWO/m2ftHVVgOwQ2CQo=;
        b=AfSzueC+12YmWM/45UYoKiOAl35Lo7kAm+LoV4MfJY6/75HfVqdgVpoqbsSX4vuKp2
         XeylWkux8QTSeb/C9Mrdz0WGeXZujsyXuXCjgRsIVisrt8fMCApwdu66Usosk1IVUplD
         YuoQb0ZrgeKha2ZBg/JKnLGJmnDm0aXUxOrfZzzpyMdb8Li/mV7B166KlbKJeVE/n93g
         wQCvYkFVf2iK0MVDrS8ztWItiUgCGlL+xFzhfB06ezUS7YCOEpT8HweLJV4ieqKL9be8
         Ug2nzZEA27VtbNyiG0PA8x8L1FvkmO22wPOa2crNILBoVe/iFACatlasfcmY6rZ/h5ds
         YYAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LOq6yBEOUF05hVScF1qFrXM7OWO/m2ftHVVgOwQ2CQo=;
        b=YACfCExngRLasJQOW405bN6Ac1+g894yUzpN+uI0ivUSvg0GdrnjDlgORugef0HTZM
         /9gRg36bHKHdNpRAxi5vntcKUhFbSou0mBIrnVxVNOXfEo/oc0XseWoXNQUNrzUyVpGh
         NhbNg3lQAHe/fRh8lG1SpxA0woWhOCNIorYibHG8yZZddUxtS/BwFk0jmSOS3vfmRMSs
         DkKovf3DwUHMoSb6p3aLhXErJHZ8SL+ySwZP+81N/4oGFksTK9gXxmGmev0tCI5MmKp4
         gYXpEbPb4o5kRuOuwdH+33gZBULXTcjm5BvhZvOUJ/NCULsrtCdwxRajBbICui2zNu4n
         xFYA==
X-Gm-Message-State: AO0yUKVtymi8Rfyd3tQzF3ucYrLMSGdI14C5OnSyF8ZjcWiP/8ZBSEt+
        WVKDvAZ9/d+bzm6Kthys2lSQ/EvbIAxkQDm2I9M=
X-Google-Smtp-Source: AK7set/S5EfOB0/LM/kCiMqmtwXec2yuNzXZIzJsOZpd1XNl6HhvEWkKeAknyOCqZWSFofEwDvK8oQ==
X-Received: by 2002:a05:6602:1606:b0:716:596a:1ce9 with SMTP id x6-20020a056602160600b00716596a1ce9mr16239721iow.15.1675625252419;
        Sun, 05 Feb 2023 11:27:32 -0800 (PST)
Received: from [10.4.18.48] ([191.101.157.6])
        by smtp.gmail.com with ESMTPSA id v19-20020a6b5b13000000b007046e9e138esm2611273ioh.22.2023.02.05.11.27.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 05 Feb 2023 11:27:31 -0800 (PST)
Message-ID: <6ca6ebf0-b357-e1d0-4866-dd04a5f987ad@gmail.com>
Date:   Sun, 5 Feb 2023 20:27:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
From:   Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v2 0/3] userdiff: Java updates
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        git@vger.kernel.org, Tassilo Horn <tsdh@gnu.org>
References: <877cwxvl3a.fsf@gnu.org>
 <20230204134329.251451-1-rybak.a.v@gmail.com>
 <45830cf4-41c1-0bc1-3e4e-26b9f713f452@kdbg.org>
Content-Language: en-US
In-Reply-To: <45830cf4-41c1-0bc1-3e4e-26b9f713f452@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023-02-05T11:09, Johannes Sixt wrote:
> Am 04.02.23 um 14:43 schrieb Andrei Rybak:
>> On 04/02/2023 10:22, Tassilo Horn wrote:
>>> Thanks for including me being the last contributor to java userdiff.
>>> The patches look good from my POV and are safe-guarded with tests, so
>>> I'm all for it.
>>
>> Thank you for review!
>>
>> I've realized that I've been writing modifiers "abstract" and "sealed" in a
>> technically correct, but not the conventional order.  Here's a reroll with the
>> order of modifiers following the style of original authors of
>> https://openjdk.org/jeps/409.  It doesn't matter for the purposes of the test,
>> but it will be less annoying to any future readers :-)
> 
> I've looked through the patches and run the tests, and they all make
> sense to me. By just looking at the patch text I noted that no
> whitespace between the identifier and the opening angle bracket is
> permitted and whether it should be allowed, but the commit messages make
> quite clear that whitespace is not allowed in this position.

There is some kind of misunderstanding.  I guess the wording in commit
messages of the first and second patches could have been clearer.

In Java, whitespace is allowed between type name and the brackets.
It is permitted both for angle brackets of type parameters:

	class SpacesBeforeTypeParameters         <A, B> {
	}

and for round brackets of components in records:

	record SpacesBeforeComponents      (String comp1, int comp2) {
	}

The common convention, is however, to omit the whitespace before the
brackets.

The regular expression on branch master already allows for whitespace
after the name of the type:

	"^[ \t]*(([a-z]+[ \t]+)*(class|enum|interface)[ \t]+[A-Za-z][A-Za-z0-9_$]*[ \t]+.*)$\n"
	                                                                          ^^^^^^
so I didn't need to cover this case.  Note that it requires a non-zero
amount of whitespace. This part of the regular expression was left as
is (v2 after patch 3/3):

	"^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*([ \t]+|[<(]).*)$\n"
	                                                                                   ^^^^^^


That being said, I guess it would be an improvement to also allow
the name of the type be followed by the end of the line, for users
with fairly common code style that puts braces on separate lines:

	class WithLineBreakBeforeOpeningBrace
	{
	}

or `extends` and `implements` clauses after a line break:

	class ExtendsOnSeparateLine
		extends Number
		implements Serializable
	{
	}

even type parameters:

	class TypeParametersOnSeparateLine
		<A, B>
	{
	}

Something like the following:

	"^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*(([ \t]+|[<(]).*)?)$\n"
	                                                                                  ^               ^^
perhaps? Technically, the following is also valid Java:

	class WithComment//comment immediately after class name
	{
	}

but I'm not sure if allowing it is needed.  If so, we might as well just do this:

	"^[ \t]*(([a-z-]+[ \t]+)*(class|enum|interface|record)[ \t]+[A-Za-z][A-Za-z0-9_$]*.*)$\n"
	                                                                                  ^^
