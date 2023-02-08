Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA2FCC05027
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 07:50:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjBHHuZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:50:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBHHuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2023 02:50:24 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D337CCC1B
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 23:50:22 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id p9so3125603ejj.1
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 23:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rhlF6fhUFv1Drc5GBkyZ2KpFY098QLdD5g6IDRljKj4=;
        b=kXizL6bTQNN9I6MV+/0uyDIlCFAy29XP3YKFUc9elw1D7EHOLqFvvSoPagcNYNSGJY
         iUb59j6YMnA8gZa1CMKf0GR6NdHeW4nfUs+6dqJ7MySYjkTTZJQfqZ3fUBWrICkzyrv4
         bD0PJC2eEkSWf0NIDyjIZx9JpFxfPq9v1b206L0ovdTuK/pP+PZJdMX0+us0Y8OsTgS2
         /OpezfYJ47/XVN3tJf5wt7sxvfX0AGABsB89pvuzLxsQBkE+e28b5BCR6+E/ujkcYVlG
         DXMU4acr13dqP89hjVJ9W6FFDF804n/1Q5M7cVBSfSyQdZFQePblVgXi9ktQ7EuMaKB6
         pK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rhlF6fhUFv1Drc5GBkyZ2KpFY098QLdD5g6IDRljKj4=;
        b=tiEMfdYT4R6po/Mc37J78Y4fndwlZMqUHH22ggdyoChhYi26/AaOiRFsCcGzZsAbD3
         gSGUhmUgQ33CoxF/NZu2FMMb4bU1f2o3XXEpKrg+hS+Pk7wq/AAHCdMGaBblhofCbFzv
         LrF2VdQL7aicF3lJZrewLuKIwKSzVVjs8qAJhK/35HQA4lxeV26y6/HZumFmHxH1y/1X
         QTzcicxbCyrr+QIJjoVrTcpi20Q9C3s0/CKuhju+Ur1qabPrLdgQzW2IzEiqbqPbhvTR
         JBd6t+7evp+DwnLe0gvdNSXGajd6TVy1+2B/xwTXM63jmoLiDT57KmiHjAws3I8FPLNs
         iSIg==
X-Gm-Message-State: AO0yUKUFN9nvZ5r69udqvdGodvys3bLBD6tlPH83T/gvzXYipodJyUnd
        H/cV7DXBaojTe8rikegPktHPVZCJbxHDJBJy
X-Google-Smtp-Source: AK7set8THZVVQ7Oc24ImbAdT50uAU17DF/J4po2ZCHGoRYgcAgZ81/194XviWH5oF13vAPdfZdcj3w==
X-Received: by 2002:a17:907:3fa9:b0:889:794d:f412 with SMTP id hr41-20020a1709073fa900b00889794df412mr7897943ejc.10.1675842620738;
        Tue, 07 Feb 2023 23:50:20 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id u20-20020a1709064ad400b0087329ff5922sm7867473ejt.139.2023.02.07.23.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 23:50:20 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPfDf-001AmO-1b;
        Wed, 08 Feb 2023 08:50:19 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Shuqi Liang <cheskaqiqi@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v4 3/3] t4113: put executable lines to test_expect_success
Date:   Wed, 08 Feb 2023 08:44:50 +0100
References: <20230205145245.11078-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-1-cheskaqiqi@gmail.com>
 <20230206211823.8651-4-cheskaqiqi@gmail.com> <xmqqlela2z3p.fsf@gitster.g>
 <CAMO4yUGmQ371hLCSTODQct+CzY2mqywfLzZO6fsgqN2=1cWGrw@mail.gmail.com>
 <230207.86h6vx51x3.gmgdl@evledraar.gmail.com>
 <CAMO4yUEcweeGZDCBm-y51TQ0fgze_geKr95RXBpEEpH4AyYJuQ@mail.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <CAMO4yUEcweeGZDCBm-y51TQ0fgze_geKr95RXBpEEpH4AyYJuQ@mail.gmail.com>
Message-ID: <230208.865ycc1tqc.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Feb 08 2023, Shuqi Liang wrote:

> On Tue, Feb 7, 2023 at 3:12 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <av=
arab@gmail.com> wrote:
>
>> But this is almost certainly that you're trying to insert leading
>> whitespace into a line that's in a <<-EOF here-doc, the "-" part of that
>> means that your leading whitespace is being stripped.
>>
>> A typical idiom for that is have a marker for the start of line, and
>> strip the whitespace with "sed". See this for existing examples:
>>
>>         git grep 'sed.*\^.*>.*EOF'
>
>
> I try to use Z as the marker in front of 'a' and 'b' and use sed -e
> "s/Z/ /g" in order to replace Z with white space but it still can not
> pass the test.
>
> Then I realize even if I don't add tab in front of the line but with
> space in front of 'a' and 'b' like the original test script. It still
> says it can't read "b" and "c=E2=80=9D =EF=BC=9A
>
> test_expect_success 'apply at the beginning' '
> cat >test-patch<<\EOF &&
> diff a/file b/file
> --- a/file
> +++ b/file
> @@ -1,2 +1,3 @@
> +a
>  b
>  c
> EOF
>
> echo >file 'a
> b
> c'&&
> git update-index file&&
> test_must_fail git apply --index test-patch
> '
> Maybe the error is not caused by whitespace?
>
> Then I try to change:
>
> echo >file 'a
> b
> c'
>
> To:
> echo >file "a
> b
> c"
>
> Then everything passes the test. I think double quotes allow for
> variable substitution and command substitution, while single quotes
> preserve the literal value of all characters within the quotes. In
> this case, the string contains no variables or commands, so either
> type of quote would work. Is there something wrong with my idea? Is it
> good to modify code like that?
>
> Looking forward to your reply!

I'm not sure because you're just posting snippets, if you have problems
in the future it would be best to post the full diff to "master" that
you're having issues with, e.g. an RFC per Documentation/SubmittingPatches.

But I think this is because the test itself is using '-quotes, so you
need to use '\'' if you want to single quote, and " for double quotes,
and \" if the test were in double quotes.

But the issues you're having here aren't with Git, but the very basics
of POSIX shell syntax.

I think it would be good for you to read some basic documentation on
POSIX shells, their syntax, common POSIX commands etc. Your local "man
sh" is probably a good place to start, but there's also books, online
tutorials etc.

In this case the syntax you're trying to get working is something we
usually try to avoid in either case, i.e. even if it involves an
external process we usually do:

	cat >out <<-\EOF
	a
        b
	c
	EOF

Rather than:

	echo "a
        b
	c" >out

If you are using "echo" I saw another change of yours had e.g.:

	echo x >f &&
	echo y >>f &&
	echo z >>f

It's better to e.g. (assuming use of "echo", or other built-ins or
commands):

	{
		echo x &&
		echo y &&
		echo z
	} >f
