Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE7C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 13:10:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjBFNKv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 08:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbjBFNKu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 08:10:50 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2492144B6
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 05:10:49 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id w11so1619206qvs.7
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 05:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/m2Dlhl4PG0O0SZXURyeyx/Ve0hReVBJXfPg1ZD2IQ=;
        b=CZoR17Z+g6DMPqGaPNFNUUr0Pm25lXou2FI6x+aSHFZ9TaxarRFhPn23OLq8A4z2Yk
         PPqpK7CXNe3XyDNvei7Hews3AvcAETN7GMM9UPv982ln1AiUHnaF9vh/wPxECN/3IuAW
         GFxqw9CSG1C3bVpWHnaAtdvwDstrbzd9JgtasNPXYXjCC8b8/FZoe8aIToilOwevCoiO
         nTYJq+ehywztF1YDmxOpyxDMQYsXb+WFvtaYagWM6XNguXqrbd3zicV3norXRFAJaENq
         awlY1JlLyVDO7CD+l5IdQOGBjDqOy4McGaFWE6rSy/vWsScwDrDFhAoWdBH72SBdtDJf
         2tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/m2Dlhl4PG0O0SZXURyeyx/Ve0hReVBJXfPg1ZD2IQ=;
        b=CUIH7ihcJ07Dj0wBx84LzHoMTixnV+l2o/x9BAmXck299urb88669NUF5ecrweLy4y
         pnmN8ptDHQMxEPJPcvygz+dHUIjalhg8r77nRuLM8kSw6gg+mKdlpdCbtzmevsYVR6ma
         Qg2H02bTl8HVRj9jsrjCQwlVez3WyJwrUEqjotqOTtXkmdEBKwpQoxRdBH3/eKSQkynX
         LXoeXG1sZwOC232BRwM0ictHfPsFjYVt67H0/3SRw2misEirLGN2SzDc7n2U4qegy79X
         9jURAv9vQcUW/4dwSQSsE1bhSlbNUEZgjhJMu9oFxDzaAmbWKwwOuvr0/6CZRnFCiqw0
         kP0g==
X-Gm-Message-State: AO0yUKUZtnBktjN/9QBT4BZ3sulKWNnVjOzbJHHqz3me3aGGP6MUBEgC
        4iDsbDCl/MrHfcONBNDkZGk=
X-Google-Smtp-Source: AK7set/ruBJoISL3eyww7uzSeHWVVFYG61e+RFDr5DNWyhQjSHMTpBc+wpS0IfJX0Yj3EqdaQksVrA==
X-Received: by 2002:ad4:4ea3:0:b0:539:aae2:8dc4 with SMTP id ed3-20020ad44ea3000000b00539aae28dc4mr34046018qvb.4.1675689048819;
        Mon, 06 Feb 2023 05:10:48 -0800 (PST)
Received: from [192.168.1.211] ([2600:4041:4542:c100:884c:b5e0:e532:e79b])
        by smtp.gmail.com with ESMTPSA id k1-20020a05620a414100b007112aa42c4fsm7397478qko.135.2023.02.06.05.10.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Feb 2023 05:10:48 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] diff: teach diff to read gitattribute diff-algorithm
Date:   Mon, 06 Feb 2023 08:10:47 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <52A25839-3564-45D8-AF43-866ADDED983B@gmail.com>
In-Reply-To: <CAPig+cQNoX1-DN1=aFEX=MxEvoYhdu0NxPyhH++B4_1G2Dmp8w@mail.gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
 <8e73793b0db3e84366a9c6441cc0fdc04f9614a5.1675568781.git.gitgitgadget@gmail.com>
 <CAPig+cQNoX1-DN1=aFEX=MxEvoYhdu0NxPyhH++B4_1G2Dmp8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On 5 Feb 2023, at 12:50, Eric Sunshine wrote:

> On Sat, Feb 4, 2023 at 11:47 PM John Cai via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> It can be useful to specify diff algorithms per file type. For example=
,
>> one may want to use the minimal diff algorithm for .json files, anothe=
r
>> for .c files, etc.
>>
>> Teach the diff machinery to check attributes for a diff algorithm.
>> Enforce precedence by favoring the command line option, then looking a=
t
>> attributes, then finally the config.
>>
>> To enforce precedence order, set the `xdl_opts_command_line` member
>> during options pasing to indicate the diff algorithm was set via comma=
nd
>> line args.
>>
>> Signed-off-by: John Cai <johncai86@gmail.com>
>> ---
>> diff --git a/diff.c b/diff.c
>> @@ -3652,6 +3652,27 @@ static void builtin_diff(const char *name_a,
>> +               if (!o->xdl_opts_command_line) {
>> +                       static struct attr_check *check;
>
> `check` is declared static...
>
>> +                       const char *one_diff_algo;
>> +                       const char *two_diff_algo;
>> +
>> +                       check =3D attr_check_alloc();
>
> ... is allocated here...
>
>> +                       attr_check_append(check, git_attr("diff-algori=
thm"));
>> +
>> +                       git_check_attr(the_repository->index, NULL, on=
e->path, check);
>> +                       one_diff_algo =3D check->items[0].value;
>> +                       git_check_attr(the_repository->index, NULL, tw=
o->path, check);
>> +                       two_diff_algo =3D check->items[0].value;
>> +
>> +                       if (!ATTR_UNSET(one_diff_algo) && !ATTR_UNSET(=
two_diff_algo) &&
>> +                               !strcmp(one_diff_algo, two_diff_algo))=

>> +                               set_diff_algorithm(o, one_diff_algo);
>> +
>> +                       attr_check_free(check);
>
> ... and freed here...
>
>> +               }
>
> ... so the reason for the `static` declaration is not clear. Am I
> missing something obvious?

No, you are correct. No reason for the static declaration. `check` is not=
 used outside of the scope of this
conditional. I think this made it in from an earlier iteration and I didn=
't catch the oversight.

thanks
John


