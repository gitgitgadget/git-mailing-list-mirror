Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA59C433EF
	for <git@archiver.kernel.org>; Fri, 24 Dec 2021 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353517AbhLXUJv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Dec 2021 15:09:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353499AbhLXUJv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Dec 2021 15:09:51 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFD9C061401
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 12:09:50 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id v19so7197820plo.7
        for <git@vger.kernel.org>; Fri, 24 Dec 2021 12:09:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rp6G+pcA/+6oEq4Le2Ax8ieSLDso+4imP2kUPS3iw6k=;
        b=cZ65qTJYBdYCiMfRdmKY5PxF7mk5h7aZ7QfvhhQnRM+M+iggGRtUuRIfGSdnfhsQyQ
         OEF5JjTWNGOgDq3vsnYLzJ39RqDnLrfHfmh+V4kIojfEHfeFRA7YepK7FHYR+HC/BVrn
         Ty6AZFfcJUPwbBoNSCrEG4Zq5DxjSSDcMYhLo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Rp6G+pcA/+6oEq4Le2Ax8ieSLDso+4imP2kUPS3iw6k=;
        b=N0/JNQtGWxmNzFNzadLgaaVEPy1dnS9RnPsvBfiRNACOnrcZiBKdANOJ1/XSLFKWD1
         5zih/5cqndoQD8pI2NHoFXHtGZwCtkaXztxI2NmB82FVYHv0wriCAtX5LwCc7goC+jXr
         xFPNArp9QfOL2WpNB3QIuWjY3Z/sn8vsjS5LcJVjWoXZvJsmgZIB4cKWr5oBW54vjP6T
         MKwJtDyCu2w9keG+uuZIgatZT9IDv5hlQQdCxqz7XHXIeEXCe9HBobU9J8rkTzIfAePA
         a/ChD9hnchPEdJzWCJ1zl1KwxZ8CePLRdgul5o+m7utihQlpJJ5L/a13HGZl9jeRTqWl
         tc3Q==
X-Gm-Message-State: AOAM53210kbxCUNVD8ju/7iFqAm+ha5yJDYQhvv6urCPVe24Uct2WUfd
        Or4OJOqbMEluEzLEMHa7kUZvQC+T30yVq3Xm
X-Google-Smtp-Source: ABdhPJxIggw9ifvHMYmhQmSmicZXEiPILC6b0xeqXlZbdfJeU1qRBs2qKYRJLd8BdSOZKQo1QGw5VA==
X-Received: by 2002:a17:902:e541:b0:149:35bd:b260 with SMTP id n1-20020a170902e54100b0014935bdb260mr7874717plf.41.1640376590268;
        Fri, 24 Dec 2021 12:09:50 -0800 (PST)
Received: from smtpclient.apple ([2601:642:4700:fe2:b8a6:9c03:e911:7f00])
        by smtp.gmail.com with ESMTPSA id j13sm10349821pfu.22.2021.12.24.12.09.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Dec 2021 12:09:49 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: bug: git name-rev --stdin --no-undefined on detached head
From:   John Cai <jcai@gitlab.com>
In-Reply-To: <xmqqk0ft3i3g.fsf@gitster.g>
Date:   Fri, 24 Dec 2021 12:09:46 -0800
Cc:     Erik Cervin Edin <erik@cervined.in>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E45DFA88-3D4D-46DD-9706-C090536CA702@gitlab.com>
References: <CA+JQ7M-ORVCj6teGjVy01SF=f0=PdKKYdHNU9ruK9XUAX9F8Ag@mail.gmail.com>
 <DA9B4728-C45D-4CA0-A40D-4A81665AB0E6@gitlab.com>
 <xmqqk0ft3i3g.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On Dec 24, 2021, at 11:42 AM, Junio C Hamano <gitster@pobox.com> =
wrote:
>=20
> John Cai <jcai@gitlab.com> writes:
>=20
>> It seems like this bug can be generalized to =E2=80=9Cgit name-rev
>> --stdin=E2=80=9D does not work with --no-undefined nor --name-only
>>=20
>> The --name-only case seems clear to me that we should fix
>> it. It=E2=80=99s misleading to return the sha instead of =
=E2=80=9Cundefined=E2=80=9D
>> for a rev without a symbolic name, as a sha could be a symbolic
>> name.
>>=20
>> I think we can also make the argument that --no-undefined should
>> also die in --stdin mode when given a rev without any symbolic
>> names.
>=20
> Hmph, the manual page documents:
>=20
>    --stdin::
>            Transform stdin by substituting all the 40-character SHA-1
>            hexes (say $hex) with "$hex ($rev_name)".  When used with
>            --name-only, substitute with "$rev_name", omitting $hex
>            altogether.  Intended for the scripter's use.
>=20
> It is unfortunate that the way this option works is confusingly a
> bit different from what we learned to expect from the --stdin option
> other subcommands like "git pack-objects --stdin" takes.  In short,
> these are not equivalent:
>=20
> 	git name-rev [<options>] $string
>        printf "%s" "$string" | xargs git name-rev [<options>]
>        printf "%s" "$string" | git name-rev --stdin [<options>]
>=20
> The first two are supposed to be the equivalent, but the third one
> is different by design.  Its `--stdin` mode is expected to read
> something like this [*]:
>=20
> 	$ cat sample.txt
>        A revision that exists 2ae0a9cb82 is shown here,
>        and its full name is 2ae0a9cb8298185a94e5998086f380a355dd8907
>        while its tree object is =
70d105cc79e63b81cfdcb08a15297c23e60b07ad
>        which probably is undescribable hexdigits.
>=20
> and its designed use is to annotate its input into a more reader
> friendly from with refnames where possible. =20

No wonder! This elucidates why I found the user experience of the =
--stdin=20
mode a bit unexpected, as it would simply echo back the input when it =
couldn=E2=80=99t find a=20
valid object or refname rather than return an error message. I think I =
totally missed=20
the verbiage in the documentation that states its meant to =
**substitute** text in stdin.
Makes sense to echo back the input if nothing useful could be found.

> Here is what we get:
>=20
>        $ git name-rev --stdin <sample.txt
>        A revision that exists 2ae0a9cb82 is shown here,
>        and its full name is 2ae0a9cb8298185a94e5998086f380a355dd8907 =
(master)
>        while its tree object is =
70d105cc79e63b81cfdcb08a15297c23e60b07ad
>        which probably is undescribable hexdigits.
>=20
> I notice a few things.
>=20
> * An abbreviated commit object name is not affected;
>=20
> * A 40-digit string that cannot be described with a reference is
>   left alone, without "undefined".
>=20
> It might be debatable that the latter may want to be annotated with
> "undefined", but as the command does not molest other noise strings
> like "its" "full" name" in the input, I think the current behaviour
> is preferred over appending "(undefined)" after a string we do not
> recognize that happens to be 40-hex.
>=20
> When used with --name-only, we see this:
>=20
> 	$ git name-rev --name-only --stdin <sample.txt
>        A revision that exists 2ae0a9cb82 is shown here,
>        and its full name is master
>        while its tree object is =
70d105cc79e63b81cfdcb08a15297c23e60b07ad
>        which probably is undescribable hexdigits.
>=20
> So, as far as I can see, it is working as described.  If there is
> any bug in the things I saw and shown here, it is that it is
> misleading to claim that this behaviour is intended for scripter's
> use.  It clearly is not scripter friendly when you want to run
> "name-rev" on unbounded number of object names you have, which may
> not fit on the command line, as that is not how it was designed to
> be used.
>=20
> Two possible things we can do to improve are
>=20
> * Fix the documentation; it is not for scripters but for annotating
>   text with object names.

Makes sense to update the documentation to make it clear what --stdin =
mode is
meant to do.=20

>=20
> * Possibly add --names-from-standard-input option that would behave
>   more like "we cannot afford to stuff all object names on the
>   command line, so we feed them one by one from the standard input"
>   mode the "--stdin" option of other subcommands use.
>=20
> I do not think the latter is so important, as it is perfectly OK to
> use xargs to split the large input into multiple invocations of
> name-rev.  This is unlike "pack-objects --stdin" where the command
> needs to see _all_ input in a single invocation.
>=20
>=20
> [Footnote]
>=20
> * The sample input was produced with
>=20
>        $ cat >sample.txt <<EOF
>        A revision that exists $(git rev-parse --short HEAD) is shown =
here,
>        and its full name is $(git rev-parse HEAD)
>        while its tree object is $(git rev-parse HEAD:)
>        which probably is undescribable hexdigits.
>        EOF
>=20
> if you want to try it at home ;-)

