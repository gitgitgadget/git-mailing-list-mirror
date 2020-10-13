Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E25A0C433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6804620BED
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ARAxLqjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732398AbgJMUNG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 16:13:06 -0400
Received: from mout.web.de ([212.227.15.14]:37551 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727436AbgJMUNG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 16:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1602619976;
        bh=TaSJdUpjVLJMJQTAuca/UlpRR9/egu7T2e7/fp9OXNE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ARAxLqjwQg7zfeRCUVT28p6TGfTjWANNPv7TPU9s+EGtT+Dlt3ynOtjFo1rRI4B2o
         y5Outs+aN7pD+eMEVoDAdzWvfkwvUOS/4VthdabNV30GrEjPrlPTkMyAh9SRtvMWZS
         GtH4BLHd72hi/2e7n3CDViHirDhCyMQSo/sNk/Yo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.28.94]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MLijs-1kk62a14sa-00Hoim; Tue, 13
 Oct 2020 22:12:56 +0200
Subject: Re: [PATCH 2/4] blame: validate and peel the object names on the
 ignore list
To:     Barret Rhoden <brho@google.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20200925055954.1111389-1-gitster@pobox.com>
 <20200925055954.1111389-3-gitster@pobox.com>
 <40488753-c179-4ce2-42d0-e57b5b1ec6cd@web.de>
 <xmqqtuvkii1j.fsf@gitster.c.googlers.com>
 <32370477-c6e4-5378-fedc-c86b9ddf96bd@google.com>
 <1fa730c4-eaef-2f32-e1b4-716a27ed4646@web.de>
 <cd2c51da-55c6-cc5e-2da1-69db90aaf438@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <ea1f2a1e-c525-c735-bdf7-65d44771cb3f@web.de>
Date:   Tue, 13 Oct 2020 22:12:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <cd2c51da-55c6-cc5e-2da1-69db90aaf438@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E/TfAUlnt6roGkwjg3tR3j0QtFx15iE0FX1lQOUO+BsHLvdNjck
 XUAYQWbqyJjxuVOEUu0+dUfeclFsUPPPf3LCr1OfGLZZgE0J1iJeYZrghxjBTZIeMJ1BASq
 tZj0z5QEeHJwsTvPC+5BMzxiMWlNIrLNdaBmucNG3JJxDCXb60tsJ1FFQLUXzrjz5Sf77HJ
 4gB+bsHlcywsv+VVhsONg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JCFaEJsOML0=:1wKxLlQyuV5HEDueLyH7/a
 jNuP4sSYHoUDZ2D5YkenrJ2Qy8vihm1zKmx9R3vL64rb0EEWcK7ghV8dHIcQDdzVpF+IUXO2Z
 B3Jthb7XazPDv3kacoxxwbp5ss8Eose4wREkNrECPDnSK/hkm4Hxzb4op33otUIcr0YgT8QiM
 W+Gw99m4etwE9Yq6+eI+D7puboMCkfUp8PC2yOzx/iHLbTRH3FzUdeRDGQl2e6jnbgNaMQPPZ
 DkCRVMg9gi20zmJ+JgASNGqJLJQoSeDwtEEQfNkpof0gmJbZV06ctbXsX5u9f4UJWKcDdix3K
 8fZtr/hGC94j92EzAXDrOU4kHo9VWDAtF8NHZldkqEtKBd7pa5pBIZKLILkVYxHuOQ8e/FtO4
 ks0y2JTMSzsjI/xxzJrxHa3noV6qyRLx64AptNRvkSirCSiZRggdDt6FA2HISGJQWuahpLsdW
 y4wArBIcgiKvg0DUwMgkVkj2AlVYCCHhjHstZdaajYxGv0gwVc0j/z8SYmYsEHd7pYfdtjB4T
 FUCf8ntelT75vY3ziiGzKMQ4qzrIzeUEEVpSepXk/JLLb49y7Tpc9wgX3gBLgw02N9tFiFLq0
 SHmb6jIz1nEE1x2kA7EW35n9SsgQLqpIIAbP9vCBAvNDbsMbMLok0sHxT4e6n5HiM2aziyqel
 8NWFiJCdPWpU9Gkldwys+OXWI5/kRF9qStV1F7bY0ANmC5572bTswPsSkgwu45lkepi6ZKgSV
 Ampx/o+3bnQJQoU3PBGoBsJqX+hQ80oyJj7Sg8973yINQpB4gz5Km3o6FD04oQbHWMzfP8et+
 URXGw5fWJzBBy5pXAD3iAs4ovRTPLegbv/gvDJgelbSN7HUQVTolQ6ISgGjqNgtO1o1OoMMCx
 e8e23OxTgOdD+gApoa8eR/yYSZTYzCOEo+4WRKbWqp5+zdQYeBuhfzmujzGrd89iGoKUikmKL
 ZxYGzesTakKpWfB9vJhfOiDJQKSV1YF+T9O57MBnRnYo+QxJ3JTkiFHSoL9/Yj32OX3L9MHhA
 s3v5vRaMKL0eQbAU82UudRgGuG/3nkJteDdQTpQLUWZUGTcuBymHLCFO4iMovmz8YTboCsnim
 L0oOpJePWKrPkS4c9FpUG4WQRdsdHVPjPbYx89HMAy48b0f9LNNRMsCNF/85xRBPDU9R6kBS3
 +RJJ9Tl0S3GX6SIphunmuBtPkngQB2ymF6k8HPuYqhFT4+koVI25oc+9HknwklRyriPH4wazz
 G3HiP+phNwMqHms5j
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 12.10.20 um 22:39 schrieb Barret Rhoden:
> Hi -
>
> On 10/11/20 12:03 PM, Ren=C3=A9 Scharfe wrote:
> [snip]
>>> Any performance improvement would be welcome.=C2=A0 I haven't looked a=
t
>>> the code in a while, but I don't recall any reasons why this wouldn't
>>> work.
>>
>> Using a commit flag instead of an oidset would only improve
>> performance noticeably if the product of the number of suspects and
>> ignored commits was huge, I guess.
>>
>> I get weird timings for an ignore file containing basically all commits
>> (created with "git log --format=3D%H").=C2=A0 With Git's own repo and r=
c1:
>>
>> Benchmark #1: ./git-blame --ignore-revs-file hashes Makefile
>> =C2=A0=C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8=
.470 s =C2=B1=C2=A0 0.049 s=C2=A0=C2=A0=C2=A0 [User: 7.923 s, System: 0.54=
7 s]
>> =C2=A0=C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0=C2=A0 8.434 s =E2=
=80=A6=C2=A0 8.605 s=C2=A0=C2=A0=C2=A0 10 runs
>>
>> And with the patch at the bottom:
>>
>> Benchmark #1: ./git-blame --ignore-revs-file hashes Makefile
>> =C2=A0=C2=A0 Time (mean =C2=B1 =CF=83):=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8=
.048 s =C2=B1=C2=A0 0.061 s=C2=A0=C2=A0=C2=A0 [User: 7.899 s, System: 0.14=
6 s]
>> =C2=A0=C2=A0 Range (min =E2=80=A6 max):=C2=A0=C2=A0=C2=A0 7.987 s =E2=
=80=A6=C2=A0 8.175 s=C2=A0=C2=A0=C2=A0 10 runs
>>
>> That looks like a nice speedup, but why for system time alone?=C2=A0 Ma=
lloc
>> overhead perhaps?
>
> Hard to say.=C2=A0 Maybe page faults when walking the old ignore_list?

brk(2) calls.  strace -c says that rc1 has 21657 of them and the patch
gets that down to 8132.  They dominate system time in both cases.

>
>> Anyway, here's the patch:
>
> Looks good to me.
>
> Barret
>
>
>> ---
>> =C2=A0 blame.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
2 +-
>> =C2=A0 blame.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
5 +++--
>> =C2=A0 builtin/blame.c | 16 ++++++++++++----
>> =C2=A0 object.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 3 ++-
>> =C2=A0 4 files changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/blame.c b/blame.c
>> index 686845b2b4..6e8c8fec9b 100644
>> --- a/blame.c
>> +++ b/blame.c
>> @@ -2487,7 +2487,7 @@ static void pass_blame(struct blame_scoreboard *s=
b, struct blame_origin *origin,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Pass remaining suspects for igno=
red commits to their parents.
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>> -=C2=A0=C2=A0=C2=A0 if (oidset_contains(&sb->ignore_list, &commit->obje=
ct.oid)) {
>> +=C2=A0=C2=A0=C2=A0 if (commit->object.flags & BLAME_IGNORE) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for (i =3D 0, sg=
 =3D first_scapegoat(revs, commit, sb->reverse);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 i < num_sg && sg;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 sg =3D sg->next, i++) {
>> diff --git a/blame.h b/blame.h
>> index b6bbee4147..d35167e8bd 100644
>> --- a/blame.h
>> +++ b/blame.h
>> @@ -16,6 +16,9 @@
>> =C2=A0 #define BLAME_DEFAULT_MOVE_SCORE=C2=A0=C2=A0=C2=A0 20
>> =C2=A0 #define BLAME_DEFAULT_COPY_SCORE=C2=A0=C2=A0=C2=A0 40
>>
>> +/* Remember to update object flag allocation in object.h */
>> +#define BLAME_IGNORE=C2=A0=C2=A0=C2=A0 (1u<<14)
>> +
>> =C2=A0 struct fingerprint;
>>
>> =C2=A0 /*
>> @@ -125,8 +128,6 @@ struct blame_scoreboard {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* linked list of blames */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct blame_entry *ent;
>>
>> -=C2=A0=C2=A0=C2=A0 struct oidset ignore_list;
>> -
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* look-up a line in the final buffer */
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int num_lines;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *lineno;
>> diff --git a/builtin/blame.c b/builtin/blame.c
>> index bb0f29300e..1c6721b5d5 100644
>> --- a/builtin/blame.c
>> +++ b/builtin/blame.c
>> @@ -830,21 +830,29 @@ static void build_ignorelist(struct blame_scorebo=
ard *sb,
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct string_list_item *i;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct object_id oid;
>> +=C2=A0=C2=A0=C2=A0 const struct object_id *o;
>> +=C2=A0=C2=A0=C2=A0 struct oidset_iter iter;
>> +=C2=A0=C2=A0=C2=A0 struct oidset ignore_list =3D OIDSET_INIT;
>>
>> -=C2=A0=C2=A0=C2=A0 oidset_init(&sb->ignore_list, 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_string_list_item(i, ignore_revs=
_file_list) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!strcmp(i->s=
tring, ""))
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oid=
set_clear(&sb->ignore_list);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oid=
set_clear(&ignore_list);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oid=
set_parse_file_carefully(&sb->ignore_list, i->string,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oid=
set_parse_file_carefully(&ignore_list, i->string,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 peel_to_commit_oid, sb);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 for_each_string_list_item(i, ignore_rev_=
list) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (get_oid_comm=
ittish(i->string, &oid) ||
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 peel_to_commit_oid(&oid, sb))
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 die(_("cannot find revision %s to ignore"), i->string);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oidset_insert(&sb->ignore_l=
ist, &oid);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 oidset_insert(&ignore_list,=
 &oid);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 oidset_iter_init(&ignore_list, &iter);
>> +=C2=A0=C2=A0=C2=A0 while ((o =3D oidset_iter_next(&iter))) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct commit *commit =3D l=
ookup_commit(sb->repo, o);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 commit->object.flags |=3D B=
LAME_IGNORE;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 oidset_clear(&ignore_list);

Without this cleanup the number of brk(2) calls goes up to 24071 for
me, increasing system time beyond the one for rc1.

So it seems the improvement comes from allocating a few MB (the oidset)
and releasing it again to pre-size the heap and avoid thousands of
system calls that would otherwise extend it lazily.

The patch below on top of rc1 simulates this.  New day, new numbers,
this time with less background programs; here are the times for rc1:

Benchmark #1: ./git-blame --ignore-revs-file=3Dhashes Makefile
  Time (mean =C2=B1 =CF=83):      8.210 s =C2=B1  0.020 s    [User: 7.647 =
s, System: 0.558 s]
  Range (min =E2=80=A6 max):    8.182 s =E2=80=A6  8.258 s    10 runs

And here with the patch at the bottom:

Benchmark #1: ./git-blame --ignore-revs-file=3Dhashes Makefile
  Time (mean =C2=B1 =CF=83):      7.879 s =C2=B1  0.023 s    [User: 7.827 =
s, System: 0.052 s]
  Range (min =E2=80=A6 max):    7.859 s =E2=80=A6  7.936 s    10 runs

My conclusion: object flags won last time by cheating -- lookup speed
isn't really all that different, what matters is allocation overhead.
Extending the heap by just a few MB helps a lot.  Which is very likely
to be a platform-specific (system-specific even?) win.

So let's drop this.  But it shows that a better direction for
improving performance might be to reduce the number of allocations,
e.g. by using a mem_pool.

>> =C2=A0 }
>>
>> =C2=A0 int cmd_blame(int argc, const char **argv, const char *prefix)
>> diff --git a/object.h b/object.h
>> index 20b18805f0..6818c9296b 100644
>> --- a/object.h
>> +++ b/object.h
>> @@ -64,7 +64,8 @@ struct object_array {
>> =C2=A0=C2=A0 * negotiator/default.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 2--5
>> =C2=A0=C2=A0 * walker.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0-2
>> =C2=A0=C2=A0 * upload-pack.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 4=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 11-----14=C2=A0 16-----19
>> - * builtin/blame.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 12-13
>> + * blame.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 14
>> + * builtin/blame.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 12---14
>> =C2=A0=C2=A0 * bisect.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16
>> =C2=A0=C2=A0 * bundle.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 16
>> =C2=A0=C2=A0 * http-push.c:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 11-----14
>> --
>> 2.28.0
>>
>

=2D--
 builtin/blame.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/blame.c b/builtin/blame.c
index bb0f29300e..aa6970f452 100644
=2D-- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -845,6 +845,7 @@ static void build_ignorelist(struct blame_scoreboard *=
sb,
 			die(_("cannot find revision %s to ignore"), i->string);
 		oidset_insert(&sb->ignore_list, &oid);
 	}
+	free(xmalloc(10*1000*1000));
 }

 int cmd_blame(int argc, const char **argv, const char *prefix)
=2D-
2.28.0
