Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA63C433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 01:01:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbhLJBFE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 20:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbhLJBFD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 20:05:03 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995EAC061746
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 17:01:29 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id y13so24758293edd.13
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 17:01:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=xDFfXMfKYauy2YJ3kboX2BfZY8wIXrY5hhZ6bDKptaU=;
        b=hyfxQf9rbsujUQ8pEvdb1jddS39u1kHyS4trr/ZzyI/pYq3Emo5yj5KjfaF7FY/kD2
         Yc61gaHCeMWuA4gHD4FNvWAFoiePapmjemQavMbjaGdQZ4xzoANtsiBmrN7BqrKVGN3i
         l8bQHgSHEqJPy55yUZsbezDFcP5evCIRMd3RQiA15U77PCk9PrF/EFjZ+1rxhU0tchXO
         C9lsR9gDlO+VuKfJzPxYQ1xQdzuFnDsynG616aWfE/fUUdh5645szrJAdI7IGTxj1CFi
         ZUap1kd6IuV/I8r4fW2WvGEkf/07iln4GstDH+Aum0V97qiINAXn6pzSddy6/oHOfrpH
         iZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=xDFfXMfKYauy2YJ3kboX2BfZY8wIXrY5hhZ6bDKptaU=;
        b=5UQz98oTvWma1xE2ajmQnjW+eIvsoRgtTXNiBEufFa1iAM7Z5ekKVKes5ZoPfWkvud
         Mpu98d6Q5eoT7tgYSIFknh+50nPcjlxvdHYdl/7ORbiG6oBQcBIbcvB6f0d9QNbVJ2or
         niXHMM33xX0coEKU1EJ3wdkXguF3fRP1fmXaYN7WPXNzx/ZihS3wjQAqnc3yhAYRTBib
         lYI+IYBhvQUYhbESDCGQ4LeixFhJNwQ7t5gkoqR15bC3i8CBzcHxUQ/N+tPKzoiEgTOI
         YLEKLqNCK0z3qtAIzy4JA+ZYaJ9UBuKHipDYfuwx2DExNEoAuBC0EL/yi905bvOkXhVW
         VzEw==
X-Gm-Message-State: AOAM530GQ7HxVYevXw/T8pqG4VqwVWOV415fS4F8/p4KlKCkxpxOGhf2
        vb4Q9VyYdwm+GmYViVGoekBOsmlGL1IEWw==
X-Google-Smtp-Source: ABdhPJxETvMbcWzKwKB1OQouD3CKb3fk4N4WBWzKGH4UF5IYpQ3CFO8lZpv5aFLBXOt2hrcCyJ1T7Q==
X-Received: by 2002:a17:907:7f8c:: with SMTP id qk12mr20105573ejc.169.1639098087873;
        Thu, 09 Dec 2021 17:01:27 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id h7sm680125ede.40.2021.12.09.17.01.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 17:01:27 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mvUHt-0007KY-83;
        Fri, 10 Dec 2021 02:01:25 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, chooglen@google.com,
        emilyshaffer@google.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
Date:   Fri, 10 Dec 2021 02:00:36 +0100
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
 <cover.1638859949.git.steadmon@google.com>
 <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
 <211207.86mtlcpyu4.gmgdl@evledraar.gmail.com>
 <YbKLL2cQCxXQeQ5J@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <YbKLL2cQCxXQeQ5J@google.com>
Message-ID: <211210.86mtl9e0ii.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Dec 09 2021, Josh Steadmon wrote:

> On 2021.12.07 09:57, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>=20
>> On Mon, Dec 06 2021, Josh Steadmon wrote:
>> ...in English you've got one dog, then dogs, so =3D=3D 1 and >1, but in
>> various other languages it's:
>>=20
>>     git grep Plural-Forms -- po
>>=20
>> Anyway, this is easily solved, and even with less verbosity, see:
>>=20
>>     git grep -E -W '\bQ_\('
>>=20
>> For examples of how to use the magic of libintl to do this for you.
>
> Thank you for the pointer. I looked specifically for dealing with plural
> forms in our docs, but the referenced "Preparing Strings" gettext docs
> were not helpful for this. (Although I see now I should have read
> further in po/README.md to find the relevant advice).  I may send a
> separate change to po/README.md to make it easier to find in the future.

Thanks, that would be really helpful.

>> > +	string_list_append(&remotes, remote);
>> > +	return install_branch_config_multiple_remotes(flag, local, origin, &=
remotes);
>> > +	string_list_clear(&remotes, 0);
>> > +}
>> > +
>> >  /*
>> >   * This is called when new_ref is branched off of orig_ref, and tries
>> >   * to infer the settings for branch.<new_ref>.{remote,merge} from the
>>=20
>
>
> Thanks for the review!

Happy to help, cheers!
