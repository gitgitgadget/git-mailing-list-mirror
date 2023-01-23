Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11431C38142
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 14:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbjAWOD3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 09:03:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjAWOD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 09:03:26 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA0625E22
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 06:03:11 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id kt14so30765756ejc.3
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 06:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FPY7Z8MoF37bzgUxzaLOsmkprLnXuNDb/rhAYZ+Ze4M=;
        b=DZZg7defs4Xf5JvhqGpNcZSMA4q+ainvCT6dMXBp0DMpxOF2uL/SQw57ljVzl2NHmo
         G5Y4Ca8L2fibBvwFSIstQ73fSyFUzIKe0tHHWkbMa0T5CnD2/57DOeluCxfsMhBMxJtD
         zxVRhXtiWUvz3gHnyYLwx27Gh2dG4Bd4MSMHnrSQFCIOQvaH3loeKpgzaQhKQ2Dws3/e
         sYgDCd4yIkG3QjOJKP00DAjWJn/jrKt2q5IkS3eHtpIBxo8ioWiybhHFyHZb5LVXUZil
         2kgOSbZzGGENEXS/1V2iaRQRXQoqHW4PQBRVtWsEHjjkRcD6X5mQ8GupnNlBDvgU0mf/
         Enlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FPY7Z8MoF37bzgUxzaLOsmkprLnXuNDb/rhAYZ+Ze4M=;
        b=pRFmuHS2zEVPskT80gpt7nf8i/I2m7sVHNPbM/IyrnrMYqel6nFyuzDkfvPYbchesS
         5ukNcZtZgpVQoa1QHs74iR3AgXmzqQEOJY34HAboYRW6prHC8mHS/w2sc31CeovV+sWS
         hTxTNL0AkYfzB7COVk98cyraCBX+T2JQ3NfTOZ4VhGjf4wsZGiv5tvxySPE9eAbvwRYX
         J6+sz10baXNB1nAiWqIGY2+XKVmjb809azHnEFuM8abxHVStGvFWfMTttx0cOUw9vLMM
         XpQN+chWQAvYJDDufQCknOQB9ZsxwFj7Vr5EzIQjCr9fzMdtYrWREV7Vca48Ip8L1KNx
         inoA==
X-Gm-Message-State: AFqh2koQoOLIPKcvhSDqAKJ2gItJZncrzIV4R4XIVerxhViKXzZiUYb3
        ctiy7KRm60LH5KEpwsJJV5wVA4J4Ol4=
X-Google-Smtp-Source: AMrXdXvFauj+k0ob0bOc120tBZoVoqh3UjI0tUfltRNKfxqeqH4wz8nXqxcqGsRiOzf+jF3cxnCaGg==
X-Received: by 2002:a17:906:f750:b0:86a:e72d:dd15 with SMTP id jp16-20020a170906f75000b0086ae72ddd15mr25657198ejb.71.1674482590272;
        Mon, 23 Jan 2023 06:03:10 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906614400b008512e1379dbsm18977680ejl.171.2023.01.23.06.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 06:03:09 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pJxPh-000AZk-14;
        Mon, 23 Jan 2023 15:03:09 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Michael Strawbridge <michael.strawbridge@amd.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v9 0/2] send-email: expose header information to
 git-send-email's sendemail-validate hook
Date:   Mon, 23 Jan 2023 14:51:28 +0100
References: <20230120012459.920932-1-michael.strawbridge@amd.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <20230120012459.920932-1-michael.strawbridge@amd.com>
Message-ID: <230123.86wn5ds602.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 19 2023, Michael Strawbridge wrote:

> Thanks to =C3=86var for an idea to simplify these patches further.
>
> Michael Strawbridge (2):
>   send-email: refactor header generation functions
>   send-email: expose header information to git-send-email's
>     sendemail-validate hook
>
>  Documentation/githooks.txt | 27 +++++++++--
>  git-send-email.perl        | 95 +++++++++++++++++++++++---------------
>  t/t9001-send-email.sh      | 27 ++++++++++-
>  3 files changed, 106 insertions(+), 43 deletions(-)

Thanks for the update. Aside from any quibbles, I still have some
fundimental concerns about the implementation here:

 * Other hooks take stdin, not this sort of file argument.

   We discussed that ending in
   https://public-inbox.org/git/20230117215811.78313-1-michael.strawbridge@=
amd.com/;
   but I probably shouldn't have mentioned "git hook" at all.

   I do think though that we shouldn't expose a UX discrepancy like this
   forever, but the ways forward out of that would seem to be to either
   to revert a7555304546 (send-email: use 'git hook run' for
   'sendemail-validate', 2021-12-22) & move forward from there, or to
   wait for those patches (which I'm currentnly CI-ing).

 * Aside from that, shouldn't we have a new "validate-headers" or
   whatever hook, instead of assuming that we can add another argument
   to existing users?...

 * ...except can we do it safely? Now, it seems to me like you have
   potential correctness issues here. We call format_2822_time() to make
   the headers, but that's based on "$time", which we save away earlier.

   But for the rest (e.g. "Message-Id" are we sure that we're giving the
   hook the same headers as the one we actually end up sending?

   But regardless of that, something that would bypass this entire
   stdin/potential correctness etc. problem is if we just pass an offset
   to the the, i.e. currently we have a "validate" which gets the
   contents, if we had a "validate-raw" or whatever we could just pass:

	<headers>
	\n\n
	<content>

   Where the current "validate" just gets "content", no? We could then
   either pass the offset to the "\n\n", or just trust that such a hook
   knows to find the "\n\n".

   I also think that would be more generally usable, as the tiny
   addition of some exit code interpretation would allow us to say "I
   got this, and consider this sent", which would also satisfy some who
   have wanted e.g. a way to intrecept it before it invokes "sendmail"
   (I remember a recent thread about that in relation to using "mutt" to
   send it directly)

=20=20=20
