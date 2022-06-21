Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E53C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 16:00:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353450AbiFUQAc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353549AbiFUP7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 11:59:48 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215AC2CE2B
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1655827133;
        bh=KlH12UTP94FfgTThhtAHWOm4HAIBJR7b8Qk0VH1W7es=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=U2WXEDgw1FQe/1Ry7sRv6gIZsoKoOAJyE3la5qkKHA+KDrv6QZ8eI/NlOWbYWV7Pj
         K8PL3vC6iL2sbmC6zqJxk/q5pZ6rgv18kPU8LJn21tI9Jgn2SL9+SevOUZuLKvvQWE
         1aBlQj9TE71+UN38tTg42tsvkI2JhcXRwoWqx2sg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.27.15]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Ma0Pm-1o96CH0WnM-00WHir; Tue, 21
 Jun 2022 17:58:53 +0200
Message-ID: <95d7609e-4cb5-c87e-0120-144f1f094241@web.de>
Date:   Tue, 21 Jun 2022 17:58:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] combine-diff: abort if --ignore-matching-lines is
 given
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
References: <a6a14213-bc82-d6fb-43dd-5a423c40a4f8@web.de>
 <patch-1.1-f7fd645468c-20220523T182954Z-avarab@gmail.com>
 <xmqqleusqaff.fsf@gitster.g> <220524.86leurw3my.gmgdl@evledraar.gmail.com>
 <xmqqmtf6hgae.fsf@gitster.g> <220524.86v8tuvfl1.gmgdl@evledraar.gmail.com>
 <49bcadd1-7dc2-d5ee-36a5-59456450aeca@web.de> <xmqqedzijago.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqqedzijago.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H9eRWELFQuZSsydYhNt5ww3rO0yorj0qKUbZs5rx1k289J/rEzb
 KzY+onjYh5iAogDYnXu0RqEnoMousSGtXigPlUGUDdruv++zxC90pezL2tk38marFx9fPiL
 FgXsDWmcFV9v27A39H8vuvpGa5NKbUySj6h5RmIE3Xy7fo6+W3hlyZXH5VzI01toTWiuclO
 5vPCMNRhWIjSsTICFs19Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tWF9yDChA9E=:PEOr/uATjlYW99i67es2hr
 Sk5YAC7LY60SKobmzPNoRGCsnaq4uJ6ND+cbE2os3C4u3meRg1qS89EYJR6oGjWJD8IQsgBZo
 3KkcGGFv5FuqEht00qC/zp9A/hS/nZbzrEx/w9VESFpY3eoghW+6or41cFYD58LBSykY2Yty4
 l3lsG51AIcuOlH4HljOdnwoKgTPE/8/WxvF1QjbZrnB1xekdoREdNaYALf8iek8ibpQ6wZQhq
 LgsDPxVUbIu0YovsjKgiEFFgARDH/7CAWfzO2pfJgl/Ti65qgzb9YgGVZR9hkyPgjfZ/+2Imy
 tEfciDrVbAqX+eTgZ838X8sd4FwNa10WzAZMJTizmMSk+tsthDEiPeCnEAVfow0sSeV1YITJ8
 RZsQ17K2qsMisC4Az3lfuEmCGTlc4z3ZRl7SwpZDgjK+sBpDy2+Gx2SlNyuM0d+yef/C9KeDA
 LU+8GqMd+ItMxkliNQipCa0YqJO4LaFaIgRiDC3Na4er+MhiEImMRE1fWRiBhriTJMKTx9SJ/
 MJhQe9yQ8JfaW7BYgg7RslalNy+HHkdw/X8MxE45zMKlwZ4n/Pprye67X85aBZ/BY6IW+uvPF
 2zq0GnoRANHc9FTCn2CQBph61ggcPGLq8X2IBmfIMrtW8akpFRglylB0sWcpDuPLYmRkg7lUd
 tP/wbLV0FnkjFNQ0uY2njItgMwQjbBBNTp4ClHLSPpvfY7kcuHNP7zid2r8oUVgfjGxVpks35
 LZmekqCzDEoLN18LMPoIZv2/Zj0Tshai/24QR4VRtipA45XpsJMWnZo2kUAfk7NirMhl7io7G
 pQcVdAfdDGgFSKcg33RRNV6LBCtGYrDQmiYGmKLVvcks9vZDMRBMx47p0rEFWVSfBdR/NRJQD
 I12L2YEEn6+BBHcsU+gf3UMcSP2SihvhFTME9bHCbniTvHeF5KDXOqLTzZqwmQ9E2F9IkTKJ/
 8NBAZghclVJwc+/EjWQcQkacBl6EAm3H2m7lmK1P0YINZvj/lqyK4nzZ3RZ/YYc9ANDGtIvNG
 Ro+4VRNDPj8TQSfRNdtaxeZAHhVG+GTrLtXSsB26k9+qhyYSf8Mx7wshvXHnkohsYxk95Fb/1
 0pY+a4c8r0V76oA3eAeBPxoYQQR2msGZD+j
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.06.22 um 17:35 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> The code for combined diffs doesn't currently support ignoring changes
>> that match a regex.  Abort and report that fact instead of running into
>> a segfault.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  combine-diff.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>
> Makes sense.
>
>> diff --git a/combine-diff.c b/combine-diff.c
>> index b724f02123..11df1d7f39 100644
>> --- a/combine-diff.c
>> +++ b/combine-diff.c
>> @@ -1498,6 +1498,10 @@ void diff_tree_combined(const struct object_id *=
oid,
>>  	int i, num_paths, needsep, show_log_first, num_parent =3D parents->nr=
;
>>  	int need_generic_pathscan;
>>
>> +	if (opt->ignore_regex_nr)
>> +		die("combined diff and '%s' cannot be used together",
>> +		    "--ignore-matching-lines");
>
> "X cannot be used together _with_ Y" perhaps?

Not sure, but that type of message was recently unified (most common
case: "options '%s' and '%s' cannot be used together") and "with" is
only used in an untranslated BUG:

$ git grep -e "cannot be used together" --and --not -e options '*.c'
builtin/add.c:                  die(_("'%s' and pathspec arguments cannot =
be used together"), "--pathspec-from-file");
builtin/am.c:                                      "cannot be used togethe=
r"),
builtin/checkout.c:                     die(_("'%s' and pathspec arguments=
 cannot be used together"), "--pathspec-from-file");
builtin/clean.c:                die(_("-x and -X cannot be used together")=
);
builtin/commit.c:                       die(_("'%s' and pathspec arguments=
 cannot be used together"), "--pathspec-from-file");
builtin/commit.c:               die(_("reword option of '%s' and path '%s'=
 cannot be used together"), "--fixup", *argv);
builtin/commit.c:               die(_("reword option of '%s' and '%s' cann=
ot be used together"),
builtin/describe.c:             die(_("option '%s' and commit-ishes cannot=
 be used together"), "--dirty");
builtin/describe.c:             die(_("option '%s' and commit-ishes cannot=
 be used together"), "--broken");
builtin/rebase.c:                                         "cannot be used =
together"));
builtin/reset.c:                        die(_("'%s' and pathspec arguments=
 cannot be used together"), "--pathspec-from-file");
builtin/rev-list.c:             die(_("marked counting and '%s' cannot be =
used together"), "--objects");
builtin/rm.c:                   die(_("'%s' and pathspec arguments cannot =
be used together"), "--pathspec-from-file");
builtin/stash.c:                        die(_("'%s' and pathspec arguments=
 cannot be used together"), "--pathspec-from-file");
revision.c:                     BUG("--single-worktree cannot be used toge=
ther with submodule");
upload-pack.c:          die("git upload-pack: deepen and deepen-since (or =
deepen-not) cannot be used together");

So there doesn't seem to be a fully consistent style amongst these
special cases.  How about this?

		die(_("option '%s' and combined diffs cannot be used together"),

>
>>  	/* nothing to do, if no parents */
>>  	if (!num_parent)
>>  		return;
>> --
>> 2.36.1
