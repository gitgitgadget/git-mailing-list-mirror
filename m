Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AD4C7EE21
	for <git@archiver.kernel.org>; Thu,  4 May 2023 18:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjEDSYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 May 2023 14:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjEDSYL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 May 2023 14:24:11 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D4D72A2
        for <git@vger.kernel.org>; Thu,  4 May 2023 11:24:08 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f1411e8111so960483e87.1
        for <git@vger.kernel.org>; Thu, 04 May 2023 11:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683224647; x=1685816647;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=v2tLYZ4PShnsRQEAhntzeqHqj0ViAeZ7wqZh1GmbObw=;
        b=GJRoJps5aAdaFotnZoH6rjXzoEo5ajpibj2jR62N6QuZf1+MJJF6j92oUwHxOuRTZx
         sM54ZyTlcYNBgFH66LxDY0NkSboX69Ulb6aDoP5H6HJq6xfM39LGxfIr764SmO3mCiBl
         oTSEWuODSJwKEjYjV1jHRLAHwuks2FIg62xowj3QptUVTVeJXu8OJdm1i78oos/c3cnK
         i7ODI4fgta4JjoqmmloFiYi5ZeYB54gBy5G6U/WEiNbodUtr74c18A8vgsMP2qbnFtzN
         P5Hs/UNFVAzNmyn9OQOVq1TCy4EL192DTwvHLCfnajJ1BUFaoI4IQQeFlDN5MNr9xOoA
         pwZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683224647; x=1685816647;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v2tLYZ4PShnsRQEAhntzeqHqj0ViAeZ7wqZh1GmbObw=;
        b=QSkf/ul7Eeaint9F6bWMW2SGmGUir4k5J22CeYkCPSadCbhPBwtnWbtu101dS5ZDYE
         zWlXx+7Fw8u7szARFFv08VaNEOBSYX4PNeT1mXRMgt6ZWRdNIZlN9dH7agK5hFm/Bbrf
         /9tMCaSQdqICQu+nr9wsdRzo4Il1DjaFK27cyRAfcV4qQglLloCzp9MmXKMSF+lFjy/E
         nLiob2BogfCDRanHPajBxg3x0ZoqAPGuzLoPgi7P0wNveiSgyoU6gIPPrXMYV6smdtT0
         WqCmLEh/Rbo/8yxIiSkIJ6CS+ljobRKrbkHpYNpAXacX4zhrUUuHB/8AskQdUp19Aemd
         QcQg==
X-Gm-Message-State: AC+VfDzwRGDK0cfqCoqQzULCeq0K1VxgsbMs0aO+rZWS75dFcsr2kBrt
        9Nnr9KxOKsukTLo6eF9x/MRmYlzxLYM=
X-Google-Smtp-Source: ACHHUZ7XI3CZR6FFwc8cgznnK9kWi54KQ5eo3RnldD/udSUzCtFLvpvXqO2c2ty7kh23iOl70Rvt3w==
X-Received: by 2002:ac2:4e49:0:b0:4e8:44e3:f3da with SMTP id f9-20020ac24e49000000b004e844e3f3damr1941291lfr.39.1683224646713;
        Thu, 04 May 2023 11:24:06 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b10-20020ac25e8a000000b004eff1f7f206sm5319700lfq.9.2023.05.04.11.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 11:24:06 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] t4013: add expected failure for "log --patch --no-patch"
References: <20230503134118.73504-1-sorganov@gmail.com>
        <xmqqsfcdtkt0.fsf@gitster.g> <874jote2zl.fsf@osv.gnss.ru>
        <xmqqmt2lqofb.fsf@gitster.g> <xmqqttwskse5.fsf@gitster.g>
Date:   Thu, 04 May 2023 21:24:05 +0300
In-Reply-To: <xmqqttwskse5.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        04 May 2023 08:50:26 -0700")
Message-ID: <87o7n03qgq.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Sergey Organov <sorganov@gmail.com> writes:
>>
>>> No problem from my side, but are you sure?
>>
>> Absolutely.
>>
>> I've seen people just say "we document a failed one" and leave it at
>> that, without attempting to fix.  I am trying to see if pushing back
>> at first would serve as a good way to encourage these known failure
>> to be fixed, without accumulating too many expect_failure in our
>> test suite, which will waste cycles at CI runs (which do not need to
>> be reminded something is known to be broken).  I will try not to do
>> this when I do not positively know the author of such a patch is
>> capable enough to provide a fix, though, and you are unlucky enough
>> to have shown your abilities in the past ;-)
>
> I ended up spending some time digging history and remembered that
> "--no-patch" was added as a synonym to "-s" by d09cd15d (diff: allow
> --no-patch as synonym for -s, 2013-07-16).  These
>
>     git diff -p --stat --no-patch HEAD^ HEAD
>     git diff -p --raw --no-patch HEAD^ HEAD
>
> would show no output from the diff machinery, patches, diffstats,
> raw object names, etc.

[-s meaning "silent" at that time? If so, making --no-patch a synonym for
"silent", and then documenting -s a synonym for --no-patch sounds like
quite a twitch.]

Anyway, this seems pretty irrelevant to the test case. Even
if we spell --no-patch as -s,

 git diff -s --raw HEAD^ HEAD

should produce what? To me it should be the same as

 git diff --raw HEAD^ HEAD

as -s turns off everything, and then --raw is turned on. In reality this
is not the case though, and that's what the test case is about.

Notice that

 git diff -s --patch

does produce the patch output, whereas

 git diff -s --raw
 git diff -s --stat

produce none. Sounds like nonsense.

> And this turns out to be a prime example why the approach to ask
> contributors do more, would help the project overall. What I should
> have done, instead of asking for the test with its expect_failure
> turned into expect_success *and* a fix to the code to make the new
> test work, was to ask to see if it is really a bug in the behaviour or
> if the documentation is wrong. Then your reaction wouldn't have been
> "are you sure?". It hopefully would have been "ah, the intent is not
> documented correctly, and here is a documentation patch to fix it.

Yep, documentation then needs to be fixed as well to match the
intention, but this is unrelated to the test-case, see above.

> When a command does not behave the way one thinks it should, being
> curious is good.  Reporting it as a potential bug is also good.  But
> it would help the project more if it was triaged before reporting it
> as a potential bug, if the reporter is capable of doing so.  Those
> who encounter behaviour unexpected to them are more numerous than
> those who can report it as a potential bug (many people are not
> equipped to write a good bug report), and those who can triage and
> diagnose a bug report are fewer.  Those who can come up with a
> solution is even more scarse.

I'm afraid the solution I'd come up with won't be welcomed. If I'd start
to "fix" it, it'd be likely set of independent options:

 --patch --no-patch
 --raw   --no-raw
 --stat  --no-stat

and then

 -s being just a shortcut for "--no-raw --no-patch --no-stat"

Easy to understand, simple to implement, straightforward to document,
all intentions are perfectly obvious. But then these are to be new
options to keep backward compatibility, and... No, thanks.

Overall, as I neither able to make sense of the current set of
intentions, nor even figure out what they are in the first place, I'm
not the right person to fix implementation of these intentions, or even
figure out for sure if a fix is needed.

Thanks,
-- Sergey Organov
