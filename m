Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3812C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 22:58:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232831AbiKGW6K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 17:58:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbiKGW5s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 17:57:48 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88D132CCAC
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 14:56:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id q9so34242216ejd.0
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 14:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yol0wnU/m/LKjPAiNLLgPp8x+1WSr/lhaFiW7i5EDQQ=;
        b=GaC/cb873lsZAhj/n7JCWXZdWZUQjMyaTmcpw0dg7am3iKnU8ky9crSswKISgifM+K
         kLL7NTQ5aaSbM9QkGK7rstMVJDLtrHhIgjmrYuCOot/dtAj/iwcjuAzSW4Z4PBM90lFh
         qKXqYLFfgsG3zYFwR2jCyI+Z6VTcWBsrsFb6oeVm98MRSdoOtNjaNbokht/JyGyQdW7z
         45EO7Iy8hL26n0BAkpNDp8BEtlRyQ428Ed8l3IKPLvW9yqPXyPMp3aScnOhHIaIlyZJQ
         JaPiK3e6zG9skvbYM1skB8RasMem9dZfVzO9xydFUZH94RH9pdEUTSTXaXq1bviEoHE5
         f2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yol0wnU/m/LKjPAiNLLgPp8x+1WSr/lhaFiW7i5EDQQ=;
        b=5DeYloCZwsemTEqJWkFc/qrv4KudvHyECSgZ52IGJcO1UPgEXe6tj4mwpQqVr18Vnc
         NRft4sn/wBmTzdmAQcVGcBdYplQbLXR+41c+7Q0ImQ2dl6QlTE+6mdIJqx9TSC3sT0cy
         5IP0vtAzQ0js6VHxJpoEJI7HKppJwuyhoTotaoK/09jZHg4HTssDieXZjbJxNNBrIROz
         odeq8N0N1dt9wTKhIH4wRCnyJvEHatKVyP2HktLjJDHudk099GfnSWjXFPPlrmtOp/zg
         0pfH1WC/3bc6cCLSFaQAPadQGKMn5eWo5eJHB3q3UfsQPeiCmTbXtvnxsdpO9ckrzau/
         CdIQ==
X-Gm-Message-State: ACrzQf3dqJJpSz0mggWGCn4hDraK2fRk+AgpbQtX59kOxHBSwxxbT9Sa
        VlzWAQEgHthLTfrmBHzM4SM=
X-Google-Smtp-Source: AMsMyM7JrTWBCkzLCQpIhyVmT9g0LuCwSea0IEnySHVN0Y4ssGkfwSIrK6IhF0wE4RhZ7P4NGkLkSg==
X-Received: by 2002:a17:907:a4c:b0:77b:ba98:d3e with SMTP id be12-20020a1709070a4c00b0077bba980d3emr50964348ejc.13.1667861782485;
        Mon, 07 Nov 2022 14:56:22 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090630c900b0073de0506745sm3887906ejb.197.2022.11.07.14.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 14:56:21 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1osB2S-000Nb1-36;
        Mon, 07 Nov 2022 23:56:20 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v2 1/3] notes.c: introduce "--blank-line" option
Date:   Mon, 07 Nov 2022 23:36:58 +0100
References: <cover.1667828335.git.dyroneteng@gmail.com>
 <2381947abdd6b965c02e114af297fc908ed3132b.1667828335.git.dyroneteng@gmail.com>
 <221107.864jvax1hz.gmgdl@evledraar.gmail.com>
 <CAPig+cS+8ER=K9byUZs9+MxZ1x9zVxnGKrKm8CGs1zJvvCoSEQ@mail.gmail.com>
 <221107.86a652vfth.gmgdl@evledraar.gmail.com>
 <Y2l8xhB+PGS+jBmQ@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2l8xhB+PGS+jBmQ@nand.local>
Message-ID: <221107.867d06tluz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 07 2022, Taylor Blau wrote:

> On Mon, Nov 07, 2022 at 06:22:34PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>>
>> On Mon, Nov 07 2022, Eric Sunshine wrote:
>>
>> > On Mon, Nov 7, 2022 at 9:56 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>> >> On Mon, Nov 07 2022, Teng Long wrote:
>> >> > When appending to a given object which has note and if the appended
>> >> > note is not empty too, we will insert a blank line at first. The
>> >> > blank line serves as a split line, but sometimes we just want to
>> >> > omit it then append on the heels of the target note. So, we add
>> >> > a new "OPT_BOOL()" option to determain whether a new blank line
>> >> > is insert at first.
>> >> >
>> >> > Signed-off-by: Teng Long <dyroneteng@gmail.com>
>> >> > ---
>> >> > diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.=
txt
>> >> > @@ -159,6 +161,11 @@ OPTIONS
>> >> > +--blank-line::
>> >> > +--no-blank-line::
>> >> > +     Controls if a blank line to split paragraphs is inserted
>> >> > +     when appending (the default is true).
>> >>
>> >> Just make this:
>> >>
>> >>         --no-blank-line:
>> >>                 Suppress the insertion of a blank line before the
>> >>                 inserted notes.
>> >>
>> >> Or something, i.e. when adding a "true by default" let's add a "no-..=
." variant directly.
>> >
>> > This is the exact opposite of Junio's advice[1], isn't it?
>> >
>> > [1]: https://lore.kernel.org/git/xmqqsfjsi7eq.fsf@gitster.g/
>>
>> I read that as him mainly talking about what we name the variable (which
>> I agree with, but didn't comment on here). I'm talking about what
>> interface is exposed to the user.
>
> Having --blank-line as an option is convenient for scripting, so I'd err
> on the side of the original interpretation of Junio's suggestion.

I see from re-reading my reply that I was conflating two things. What I
*meant* to suggest is this:

When an option is not the default, and we provide a way to turn it off
we usually document that as:

	--no-foo:
		Don't do foo.

See e.g. "git commit --no-edit", and "git clone --no-checkout".

But this is orthagonal to what you call the option in the source, and
whether your variable is "inverted". I.e. in both those cases we have a
"--edit" and "--checkout", but when we prepare the options for
parse_options() we do (or the equivalent of):

	int no_checkout =3D 0;
	OPT_BOOL('n', "no-checkout", &option_no_checkout,

And:

	int edit =3D 1;
	OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),

So, I'm (now) saying I don't care which form we use in the sources, but
that' it's useful to document things as e.g.:

	--no-checkout::
        	No checkout of HEAD is performed after the clone is complete.

Instead of e.g.:

	--no-checkout:
	--checkout:
 		Do we do a checkout when we clone (doing a checkout is
 		the default).

Because the former convention shows the user at a glance which of the
two is the default.

> We can clearly support '--[no-]blank-line' and allow latter arguments to
> override previous ones.

We'll support both either way, i.e. parse_options() detects that the
name starts with "no-", so the negation of a "no-checkout" isn't
"--no-no-checkout", but a "--checkout".

> The documentation is fine as-is.

I think the above form would make it a bit better, but just my 0.02:

	--no-blank-line::
		Don't add an extra "\n" between the body of the commit
		and the note.

Or something...
