Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34333C05027
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 16:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232360AbjBTQtN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 11:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjBTQtM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 11:49:12 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D156140E8
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:49:10 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id ay9so1152758qtb.9
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 08:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OTMUmldb8WNr/I4zYS6fdLuYsyOdwbKWArcNE6JLBJw=;
        b=Ib9F0/rPmQNF0coaLlOu4KC+DrGfUpwYHxcppPFQHs+pP6pdhB5MfyBlYjNS54HsKf
         uXLMDCtAUcdTgWVZHFD4kO4YJkbT2WuiZKDV2xRUujTWqESdaSKEFuIsaU3Wt5OEZGE2
         rsFYSYIWDWSvWYNZzeEc9OC91bvlk2Yb5GC99BYXcR4RIOI8edxRN/IiofI2rIVtvM61
         iNWKZpkwZCH1pLBA80Rnk8/YwlJv7JVqj00XlUoyUiXM6PyG5WClGWwT1ffhSnllVF8m
         E2rPYDHRFF66xd9ICJxHMc5DuGYxYdlgTPBxKU2sMACAcOuzI1DSuUZPn0l1Gd6rxLoo
         bSiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OTMUmldb8WNr/I4zYS6fdLuYsyOdwbKWArcNE6JLBJw=;
        b=fzgWoUYjHRwyKltPM7+/m+wsXxtPl64lk9+ntqqJEXpnYqSEJR9t4gonGIb6s/zj3b
         E+Am+NH7E1S/GfW64jSd1/J0K0/O5Sf+DMbaYXEiubJ9y2FeoEjeZ4WhfalTCarCuBuS
         Jm+qDmPvK5CspdHb9KqPhicM1xjeORm2gbj/OA5MuiRqwFS30Kojd/fbGiQw8rdqXb2+
         qE5QSW4mxAldW7FrwWe9F00EbUnq/diEfrONjpccQLrdldkzcVzgik6KKC8KNzedctlO
         H5z8ku//HF2kfJP9HbR72vMnNkgybkS6O7oUrCMDIj8gf4BXRaUZ8qdattZcY5JO8YCC
         A7Bw==
X-Gm-Message-State: AO0yUKUxTWMMEeQfGxM064sUtL/MHfg+dAFtGQO4OjlOzYZJhmQY/NBc
        K2qaucbQeMiuwqStiF6xmXAiYv84FlQ=
X-Google-Smtp-Source: AK7set/x4BbEwAy8sIEAT2DEW4dYELwh+82h3vBHvaHPw6gmiW8yavve8tzjA7dEmPr7KnxpZ6V+jQ==
X-Received: by 2002:a05:622a:1713:b0:3b5:87db:f979 with SMTP id h19-20020a05622a171300b003b587dbf979mr4094947qtk.5.1676911749729;
        Mon, 20 Feb 2023 08:49:09 -0800 (PST)
Received: from [192.168.1.211] ([2600:4041:4542:c100:8905:dad0:53aa:3ab7])
        by smtp.gmail.com with ESMTPSA id hf22-20020a05622a609600b003b85ed59fa2sm8987924qtb.50.2023.02.20.08.49.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Feb 2023 08:49:09 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] diff: teach diff to read algorithm from diff driver
Date:   Mon, 20 Feb 2023 11:49:08 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <47981D9E-9DC7-4C23-911D-13BA52A27040@gmail.com>
In-Reply-To: <CABPp-BGDi1VQXFdGw_Y8i0ZDBOoHJe9039fh4mO44qJ-nJE1ig@mail.gmail.com>
References: <pull.1452.v2.git.git.1676410819.gitgitgadget@gmail.com>
 <pull.1452.v3.git.git.1676665285.gitgitgadget@gmail.com>
 <b330222ce83bdf03c20085ff10fcff8a090474d5.1676665285.git.gitgitgadget@gmail.com>
 <CABPp-BFCMpA=nHtb5RuQL7ACbkhSEKtvmRxKwMuktcf24uQJtQ@mail.gmail.com>
 <EE7565DF-BE70-4C45-AF0B-95C85050DFA4@gmail.com>
 <CABPp-BGDi1VQXFdGw_Y8i0ZDBOoHJe9039fh4mO44qJ-nJE1ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On 20 Feb 2023, at 11:21, Elijah Newren wrote:

> On Mon, Feb 20, 2023 at 7:32 AM John Cai <johncai86@gmail.com> wrote:
> [...]
>>> I'm still curious if this should this also include warnings/caveats, =
such as:
>>>   * The diff attribute specified in .gitattributes will be ignored in=

>>> a bare clone
>>>   * The diff attribute specified in .gitattributes will be ignored if=

>>> it is only specified in another branch (e.g. on a branch "special-fil=
e
>>> diff=3Dpatience" recorded in .gitattributes, then checkout master but=

>>> run `git log -1 -p $branch`)
>>>   * When a file is renamed, the diff attribute for the pre-image name=

>>> is the only one the system pays attention to (thus adding "-R" can
>>> flip which diff algorithm is run for the renamed file).
>>
>> I would be fine with adding that--though originally I was thinking tha=
t these
>> can be inferred from the way that gitattributes are documented in [1].=
 Calling
>> these out would make it more clear though, so I could go either way.
>>
>>>
>>> Also, since I tested the three items above to verify they are valid
>>> warnings, I'm a bit confused.  I thought your intent was to use this
>>> server-side[1], so isn't the bare clone aspect a deal-breaker for you=
r
>>> intended usecase?
>>>
>>> [1] https://lore.kernel.org/git/7852AC7B-7A4E-4DD0-ADEA-CFFD5D16C595@=
gmail.com/
>>
>> yes, indeed. I was planning on adding bare repository support in a sep=
arate
>> patch series, since the additions in [2] allows .gitattributes to be r=
ead from a
>> bare repository.
>>
>> 1. https://git-scm.com/docs/gitattributes
>> 2. https://lore.kernel.org/git/0ca8b2458921fc40269b0c43b5ec86eba77d6b5=
4.1673684790.git.karthik.188@gmail.com/
>>
>> thanks!
>> John
>
> Oh, interesting, I didn't know about [2].  So, is the plan to take the
> --source option from that series and add it to diff (perhaps with a
> different name, since log tends to consume diff options and --source
> is already taken)?

Yep, that would be the general idea

>
> And do you expect to get the tree-ish from the two the users are
> already specifying to diff?  If so, which one do you use (the two
> commits being diffed might have differing .gitattributes files)?  If
> not, what does that mean for users of e.g. the GitLab UI who have to
> specify a third tree when diffing?

Good question! Since it seems that when `git-diff(1)` considers diff.<dri=
ver>,
it goes with the path of the first one. (might need some confirmation her=
e)

in diff.c:


static void run_diff(struct diff_filepair *p, struct diff_options *o)
{
	const char *pgm =3D external_diff();
	struct strbuf msg;
	struct diff_filespec *one =3D p->one;
	struct diff_filespec *two =3D p->two;
	const char *name;
	const char *other;
	const char *attr_path;

	name  =3D one->path;
	other =3D (strcmp(name, two->path) ? two->path : NULL);
	attr_path =3D name;
	if (o->prefix_length)

I was thinking we would just use the tree-ish of the first one

thanks
John
