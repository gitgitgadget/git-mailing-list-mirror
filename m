Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AAFC54EBD
	for <git@archiver.kernel.org>; Mon,  9 Jan 2023 20:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235434AbjAIUap (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Jan 2023 15:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbjAIUan (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2023 15:30:43 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB195E658
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 12:30:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id bg13-20020a05600c3c8d00b003d9712b29d2so10091268wmb.2
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 12:30:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cV2B3Fs1/6O7Uy4CRU0uLA7GJTkWAyuh3z7yR6u80Fo=;
        b=qSlXd4lPgqMgxz/j7/CDvaHkrFYYkMkm3p8SA+4hh5ytxFcoz5lLUroCWluyrFyHiR
         3jd2E+0wyXpLpa4oqFbh68YQfq7Dd/hnwvWO3nVQuj59KkJBShp1YAPLaFFmdamaSteJ
         fJdxcOfPL8gxdfv79TQR+K+bmPUEenHj/3W+/I+T5Wpf7dHB84+1LTHGFXVgNCRh0cXm
         s1uQTT6COLJKBTFc+IU2Y7wXfPt4hbqJrqyd2ZvSILgc+9iUesbeM+4tEI7YcdEmkBf2
         uLLZj3yQ853BfzBCRxhupcGMMi6cyeqrDdUwIXNBUC6H6VjNWUvKPOYT2DWanOqcq9m1
         VCRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cV2B3Fs1/6O7Uy4CRU0uLA7GJTkWAyuh3z7yR6u80Fo=;
        b=kqpF7QZsI19V1MnQiKkZyAjirjQMW6PFyw4HyIDg+nOPgtabmsXY6vsrc4uOiy2FEn
         4ekaEPge11W9/viewZwXG0/ssgM9PVNDu/eLBCJhJfqQ86q+FIZn6cQrvXWY+m8+Moeb
         DTVFG8YHPzTyRH7EiXd3ftyTVHMzzYAMm6ncodrnOmsGU9ubHGFnOR1qmhUaFMSdJ1wp
         ipTUkVJYshuhQ/fVBit9+ktPKW1R+qZBZ2JIkniwUTiOfoGfPMcd1QpmlEkv6xOLkpn8
         pFz/Jh09P6wtOaCt296V1Bk8D/bdMadXLU1DP9fSo1ey1QNLlsrAAvE6VnH266Z9u1E3
         IjpA==
X-Gm-Message-State: AFqh2kqQpO/AUFTV/rU+LlD8gxGXwOwWX0sX/bHbLntDPgYALaBfOfbj
        uEYhAWOX1iPZnZ0uWDbD7P4=
X-Google-Smtp-Source: AMrXdXv7V17hVWxQ6hsPGnebCsQ7ke4Qam3ZC3PynrU/i5qecInH4Lv4l/qSArqHGmk4skrHGzy8aQ==
X-Received: by 2002:a05:600c:3485:b0:3d0:761b:f86 with SMTP id a5-20020a05600c348500b003d0761b0f86mr47038283wmq.28.1673296238834;
        Mon, 09 Jan 2023 12:30:38 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id p21-20020a7bcc95000000b003c65c9a36dfsm12181465wma.48.2023.01.09.12.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 12:30:38 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pEymz-000Cpl-2S;
        Mon, 09 Jan 2023 21:30:37 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        demerphq@gmail.com, pcre-dev@exim.org, 60690@debbugs.gnu.org,
        gitster@pobox.com, git@vger.kernel.org
Subject: Re: bug#60690: [PATCH v2] grep: correctly identify utf-8 characters
 with \{b, w} in -P
Date:   Mon, 09 Jan 2023 20:51:00 +0100
References: <20230108062335.72114-1-carenas@gmail.com>
        <20230108155217.2817-1-carenas@gmail.com>
        <230109.86v8lf297g.gmgdl@evledraar.gmail.com>
        <d6814350-10a3-55c0-68da-7e691976cd45@cs.ucla.edu>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <d6814350-10a3-55c0-68da-7e691976cd45@cs.ucla.edu>
Message-ID: <230109.865ydf1mdu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 09 2023, Paul Eggert wrote:

> On 1/9/23 03:35, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> You almost never want "everything Unicode considers a digit", and if you
>> do using e.g. \p{Nd} instead of \d would be better in terms of
>> expressing your intent.
>
> For GNU grep, PCRE2_UCP is needed because of examples like what
> Gro-Tsen and Karl Petterssen supplied.

[For reference, referring to this Twitter thread:
https://twitter.com/gro_tsen/status/1610972356972875777]

Those examples compared -E and -P. I think it's correct that UCP brings
the behavior closer to -E, but it's also different in various ways.

E.g. on emacs.git (which I've been finding to be quite a nice test case)
a comparison of the two, with "git grep" because I found it easier to
test, but GNU grep will presumably find the same for those files:
=09
	for c in b s w
	do
		for pfx in '' '(*UCP)'
		do
			echo "$pfx/$c:" &&
			diff -u <(git -P grep -E "\\$c") <(git -P grep -P "$pfx\\$c") | wc -l
		done
	done

Yields:

	/b:
	155781
	(*UCP)/b:
	46035
	/s:
	0
	(*UCP)/s:
	0
	/w:
	142468
	(*UCP)/w:
	9706

So the output still differs, and some of those differences may or may
not be wanted.

> If there's some diagreement
> about how \d should behave with UTF-8 data the GNU grep hackers should
> let the Perl community decide that; that is, GNU grep can simply
> follow PCRE2's lead.

PCRE2 tends to follow Perl, I'm mainly trying to point out here that it
isn't a-priory clear how "let Perl decide" is supposed to map to the of
a "grep"-like utility, since the Perl behavior is inherently tied up
with knowing the encoding of the target data.

For GNU grep and "git grep" that's more of an all-or-nothing with
locales, although in this case being as close as possible to -E is
probably more correct than not.

>> 	$ diff <(git -P grep -P '\d+') <(git -P grep -P '(*UCP)\d')
>> 	53360a53361,53362
>> 	> git-gui/po/ja.po:"- =E7=AC=AC=EF=BC=91=E8=A1=8C: =E4=BD=95=E3=82=92=
=E3=81=97=E3=81=9F=E3=81=8B=E3=80=81=E3=82=92=EF=BC=91=E8=A1=8C=E3=81=A7=E8=
=A6=81=E7=B4=84=E3=80=82\n"
>> 	> git-gui/po/ja.po:"- =E7=AC=AC=EF=BC=92=E8=A1=8C: =E7=A9=BA=E7=99=BD\n"
>
> Although I don't speak Japanese I have dealt with quite a bit of
> Japanese text in a previous job, and personally I would prefer \d to
> match those two lines as they do contain digits. So to me this
> particular case is not a good argument that git grep should not match
> those lines.

I'm mainly raising the backwards compatibility concern, which GNU grep
and git grep may or may not want to handle differently, but let's at
least be aware of the various edge cases.

For \b I think it mostly does the right thing.

For \w and \d in particular I'm mainly noting that yes, sometimes you
want to match [0-9], and sometimes you'd want to match Japanese numbers,
but you rarely (or at least I haven't) want to match everything Unicode
considers X, unless you're doing some self-reflection on Unicode itself.

E.g. for \d it's at least (up from just 10):

	$ perl -CO -wE 'for (1..2**20) { say chr if chr =3D~ /\d/ }'|wc -l
	650

For \w you similarly go from ~60 to ~130k:

	$ perl -CO -wE 'for (1..2**24) { say chr if chr =3D~ /\w/ }'|wc -l
	134564

If all you're doing is matching either ASCII or Japanese text and you
want "locale-aware numbers" it might do the wrong thing.

But I've found it to be too promiscuous when casting a wider net, which
is the usual use-case with 'grep".

> Of course other people might prefer differently, and there are cases
> where I want to match only ASCII digits. I've learned in the past to
> use [0-9] for that. I hope PCRE2 never changes [0-9] to match anything
> but ASCII digits when searching UTF-8 text.

I think that'll never change.
