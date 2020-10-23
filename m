Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9313C4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 01:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71EE42177B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 01:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9fdngKL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S374391AbgJWBqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 21:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S374345AbgJWBqb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 21:46:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71383C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 18:46:30 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z33so2951290qth.8
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 18:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QX7SHDj5rm30NNgBQ3VDn/ZYx8P+t23W1kzO90uT558=;
        b=V9fdngKLTx7OLxFQ2RcJs3VjoqqItnzsRzysK54Ri8NgpyPHGUWzmc9KIGpwawMMcH
         ITf+W/JnKkBIha49HHWkbB2UF9qiiOaN6le3Quy8bDVBwSSkXIIgazN1N3F0wJbDivD/
         E8aEeqb4G8WTisDxlXHQpFsr4fEf78OyHU7HQuS8aUh3GND6YtGzZjH4odkfXm1xVFZf
         l6ZxVQxkJ7lWt4hjbnHNVVhMU+csO30waBSuaTSlUK/lev8fU+cKP6M/8cpSVdEM/3Pj
         jdFv2GjEdPPF+aaBnqLq8RQm8Y8Iq0tAXD88Hlw6FwW+Hd6QzdlAyHPZCCUaItOiw3Z3
         qoGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=QX7SHDj5rm30NNgBQ3VDn/ZYx8P+t23W1kzO90uT558=;
        b=XwfveyKC1afW/3Yjong3DALQhUzy3EwCVRNm673FegVuPJxlIAft8GhnhKGJgzTkIG
         PwDqfGcQSMQVqZrKyXPc+5C7btA9jEhkTSgmwCzMV9LGnDP8RrbeRMEIHyDbvCLoGiBc
         c0y7pxIdgGEIUanuah7m4exrluqdOb7MbNsz0ZcpPLvz4crmsR9TeXvw6RJMesKAgof9
         z9S8XnHy8ylO1u/zf2HlTUtvCAEGDyzoV44qQX2Om5N8m0YbXm046qlEe1/0Lr7Sfru9
         Erf4JoRDFKUX5GNAEw8BDt9TpdxCJhZlilAAioYfnia0KRo/QGZViQCY5vxkuMoiL4jg
         dqjA==
X-Gm-Message-State: AOAM532ENVEoYbcKGY/wBcQ/P14fWG6heor8622YpwnwR8/XruLiO6dV
        DADU+Sgc8dSKlC0g9k2TQeY=
X-Google-Smtp-Source: ABdhPJycblQyzAsP2KTGGr/RNGzQe4cXZL3wz8AwCTWEih+o8uth7m2IWBfZy8zMib7srHXmErIB0w==
X-Received: by 2002:ac8:5141:: with SMTP id h1mr4797277qtn.139.1603417589607;
        Thu, 22 Oct 2020 18:46:29 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id h8sm3678qto.46.2020.10.22.18.46.28
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 22 Oct 2020 18:46:28 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v4 1/2] ref-filter: handle CRLF at end-of-line more gracefully
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqq8sbxlq62.fsf@gitster.c.googlers.com>
Date:   Thu, 22 Oct 2020 21:46:26 -0400
Cc:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <FFAF7079-C759-43F3-96AA-CAF3B73B55B4@gmail.com>
References: <pull.576.v3.git.1602526169.gitgitgadget@gmail.com> <pull.576.v4.git.1603335680.gitgitgadget@gmail.com> <03b2d7d78a15d15130a68ed1e6092072aa0807cd.1603335680.git.gitgitgadget@gmail.com> <xmqq8sbxlq62.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> Le 22 oct. 2020 =C3=A0 20:52, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>=20
>> The ref-filter code does not correctly handle commit or tag messages
>> that use CRLF as the line terminator. Such messages can be created =
with
>> the `--cleanup=3Dverbatim` option of `git commit` and `git tag`, or =
by
>> using `git commit-tree` directly.
>>=20
>> The function `find_subpos` in ref-filter.c looks for two consecutive
>> LFs to find the end of the subject line, a sequence which is absent =
in
>> messages using CRLF. This results in the whole message being parsed =
as
>> the subject line (`%(contents:subject)`), and the body of the message
>> (`%(contents:body)`) being empty.
>>=20
>> Moreover, in `copy_subject`, which wants to return the subject as a
>> single line, '\n' is replaced by space, but '\r' is
>> untouched.
>=20
> Honestly, all of the above signal, at least to me, that these
> objects are designed to use LF terminated lines and nothing else,
> whether Windows or DOS existed in the same world or not.  There is
> no such thing as commit objects that use CRLF as the line
> terminator.  They are commit objects whose payload has CR at the end
> of each and every line.  Just like there can be commit objects whose
> payload has trailing SP on each line, or even has binary guck, these
> things can be created using the "commit --cleanup=3Dverbatim" command,
> or the "hash-objects" command.  It does not mean it is encouraged to
> create such objects.  It does not mean it is sensible to expect them
> to behave as if these trailing whitespaces (be it SP or CR) are not
> there.
>=20
>> This impacts the output of `git branch`, `git tag` and `git
>> for-each-ref`.
>=20
> The answer to that problem description is "then don't" ;-).  If you
> do not want to have trailing whitespaces, you need to clean them up
> somehow, and we give an easy way to do so with the default --cleanup
> action.  Setting it to verbatim is to decline that easy way offered
> to you, and it makes it your responsibility to do your own clean-up
> if you still want to remove the CR at the end of your lines.

I agree with you on that : if you are creating the object yourself,
you should let the default cleanup take place.

But as a lot of projects use GitHub, GitLab or similar services
to accept contributions, and let these web systems perform the "merge"=20=

(or rebase or whatever) operation to integrate these contributions;
maintainers sometime choose to not always have complete control
on all objects that become part of the canonical history of their =
repository.=20
And as I wrote in [1], GitLab was creating commits using CRLF up until =
9.2... [2].
So for these poor projects that are now stuck with these CRLFs in their
merge commit messages, I think it's good that Git handles these =
correctly.

> Having said all that.
>=20
> Here is how I explained the topic in the "What's cooking" report.
>=20
>     A commit and tag object may have CR at the end of each and
>     every line (you can create such an object with hash-object or
>     using --cleanup=3Dverbatim to decline the default clean-up
>     action), but it would make it impossible to have a blank line
>     to separate the title from the body of the message.  Be lenient
>     and accept a line with lone CR on it as a blank line, too.

Just for the sake of searchability, I think it would be good to have=20
CRLF spelled out in this topic description (since I gather this is what=20=

ends up in the release notes). But I don't feel that strongly
about that.

> Let's not call this change a "bug fix".  The phrase you used in your
> title, "more gracefully", is a very good one.

It was your suggestion ;)=20

> In the meantime, I've squashed your "oops forgot ||return 1" change
> into [PATCH 2/2].

Thanks for squashing it in.

Cheers,
Philippe.


[1] =
https://lore.kernel.org/git/63755050-10A5-4A46-9BB3-8207E055692C@gmail.com=
/
[2] https://gitlab.com/gitlab-org/gitlab-foss/-/issues/31671=
