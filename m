Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15896C433EF
	for <git@archiver.kernel.org>; Sat, 22 Jan 2022 10:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233833AbiAVKla (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jan 2022 05:41:30 -0500
Received: from mout.web.de ([212.227.15.14]:54535 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233790AbiAVKl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jan 2022 05:41:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1642848064;
        bh=rHbd5ntIKRePzVHwL5ZXIs3cNxauLLAWWVaFt7G5WcY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=SonugYL7Sgkv4RBl7k9fLp2UpnwlRvzv4bSH2XYMJbC+K1OVniXuUqowEmPcHPj42
         h32dDkjszw+SGCHyTMMtlBZkbXF4jmAXn+F64BiNUeNVNWow5lF5pMbxwDkrpYhzxm
         TF6nQ6oA9pLHFsY8QzhubeB3QC6Txe8dSxv+gjqk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MCXZf-1n1d3b2WRf-009Sty; Sat, 22
 Jan 2022 11:41:04 +0100
Message-ID: <f31dd12e-6d27-a070-77e4-ad53fb319735@web.de>
Date:   Sat, 22 Jan 2022 11:41:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH v3 2/2] wrapper: use a CSPRNG to generate random file
 names
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, rsbecker@nexbridge.com,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-3-sandals@crustytoothpaste.net>
 <220118.86zgntpegy.gmgdl@evledraar.gmail.com>
 <3a2b17ac-6ce2-cc29-6993-a9718df61741@web.de> <xmqq7daxt0pk.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq7daxt0pk.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j4xQQIrtjvlC3fJtK4FgYzbS6mBngBjbokZTud/BVopQkeYD6iK
 CfmbPM8oMVeMEOlpf5rnhMEZfknM/wYrE5kzEVWkbwcuRdiW1sLTEnpluX00Wl3F6mEPA1Q
 ViYL1CFnXN+VT0U30lwmXr70VviMDzoBOdW1vNGTVqjQPte7ofJKbUrzyJKvc+aiJmoDVQJ
 +lVG+kNhbPZNKXyBA0VnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uA8qA3Gkq3Q=:6tnJTDrnWWudu96zdwSMkh
 Kg4GKfy+ldIoIw7YV/lFOfVqhhG0RcYLBFxZ9BNLSotc476YBLTO1rgA70+twGr4HIZpZuIUB
 xmdCDA9OU6ZIfnRTJjavTjjBJMOKj+VS2NLwUO7zLhbtZtGtwLhP5BRk4qHyE/F0YOF3hvgjY
 F58sb0SLKqvuFfFw/Ocaw5lvCpJvLKKavAYBV6d4x7+IOtyMOyOKfkyO2L4QRQ//Ovs6GeBXy
 L4MxKN90zxyQggM4wMtBApieGsnbzvwIBk2aYp/ofakAjeT/x4wkM6FYxetMigWNmb9UxQQCK
 IlJIBTBkpbViv7Jrj1Os3CqfSOHYa5Y4Pmtcsxbs0xrrXRpykblGS6QsfungdGFcnyfFX7Evl
 tZGm2rR/tlLdCo11FH5wg/rHYInL0GUBap2Pxrr1yK5uSHFK8TTORIebqxF67jdSSlSL29LNz
 kHWJU5SkUhT11DLZRi7El2Dvf+MyY3WJix2HAyfHqnT9pMrHeqM/wH58wrxJd5oA+Moy4JISY
 Ptes6bXNWbA2xZ8k84q804ED5hQ4u8jIR17oZcFjGBHRgz0LUJ0UmNV6fNhi7RPnbM4iRH4/h
 kJijrPP40eNwXm9VHI1KBqCUhE0WnSydcw07RE4gXha4yToJG+IYzd4J8no+65ZMxYXtbxNpB
 UmwOM0r7G8mofm6iEjAqKRowAiIKjGeeKoIWdiFOUpEy7qC1yZuVSqnu+PoC5bGQ3vcMCja6l
 VVg/iJaPUcSrWhVXBAtp45NMlGyJ0ZWvcJpm/T2N07qRNLKGbDK3FFuO2hhG22JxaG7T0lkL6
 OZXzwUjtvUSD+3NgYCWFDCuwn3Jvl4aGtkd0hhoBYXnyyKhU06P3Mmu+rutihkWCV9n4Wfg42
 LXj1jTsJFfwOMLX6M5mWBykshuiy2JD/AzfRcaGNXJGbze5XeHxphiH0/USDtirYjlG4yXbAt
 3sQ2NwBLlQ/k3UWdJoU6l6y/F9NrJ26rEBQYxE6Mk9p7C6XorswcZqf0EwAxpo+FiuPtFog+Q
 3Juv9mjemPGHFDcB0x9HRl6tW6WscqdwXIgdv+5tS9Fa93wwpJv8Nt0RRcsIiPDelg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 18.01.22 um 18:25 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>>> This series really feels like it's adding too much complexity and
>>> potential auditing headaches (distributors worrying about us shipping =
a
>>> CSPRNG, having to audit it) to a low-level codepath that most of the
>>> time won't need this at all.
>>
>> Good point.  Please let me think out loud for a moment.
>
> Yeah, I agree you and =C3=86var that the topic may be over-engineering
> the solution for problem that we shouldn't be the ones who solve.
>
> I agree with your analysis that the "diff" tempfiles do need suffix,
> we SHOULD create them in $TMPDIR (not in the working tree or
> $GIT_DIR) to support operation in a read-only repository, but we can
> create a unique temporary directory and place a file (even under its
> original name) in it as a workaround.

I forgot one crucial aspect, though: umask.  The "m" variants of the
tempfile functions set a mode, with umask applied.  git_mkstemps_mode()
does that by passing the mode to open(2), which applies the umask
internally.  Neither mkstemp(3) nor chmod(2) do that for us, so a
replacement needs to call umask(2) to get it and again to restore it,
which requires two system calls and is racy if multiple threads do this.

Diff doesn't need a custom mode, so we can still use mkdtemp() there and
thus make the suffix feature of git_mkstemps_mode() unnecessary.  But
a replacement for git_mkstemp_mode() with two umask(2) calls looks less
attractive to me than fortifying git_mkstemps_mode() with a good source
of randomness.

Ren=C3=A9
