Return-Path: <SRS0=IFun=BX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B82C433DF
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 936E120855
	for <git@archiver.kernel.org>; Thu, 13 Aug 2020 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="L02WtK2X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgHMRRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:17:35 -0400
Received: from mout.web.de ([217.72.192.78]:41543 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726384AbgHMRRc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Aug 2020 13:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1597339041;
        bh=gwz5YxlaaHp76LjWcZSBjIPJmTAbok+5PnN+eESf7Hs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=L02WtK2XT4cVNX+jSrqtAksOwPG9AnUNk8E785JVgjNTs7+qdKfABTO+xZpCv6gng
         svZ12l6OaxohyNsu41Ey3uhvPjLpVOzHET9eFhG0GjTMW7AKbl9l1GEfwazi7fpDy1
         KAqE0usFnMsVcYOB0OcKJzTWN34Y6c6/WMF51Hew=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M5g0a-1kuvZR0WYS-00xeSD; Thu, 13
 Aug 2020 19:17:21 +0200
Subject: Re: [PATCH] fast-export: factor out print_oid()
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
 <20200813151856.GE2244@syl.lan>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <3ddf0a14-77ac-7546-e03a-704432305bdb@web.de>
Date:   Thu, 13 Aug 2020 19:17:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813151856.GE2244@syl.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HYHF1HEuKhaC9xtT7dXPUqYkF+gKsa0WEGcjNjSuIOl/zwT7X8L
 KmdeqPiFQ1ZpKBVDx/TPc+fTswmDHrP6TN6ypE3uiRbU0ZlSfH+t/999iuix8jvajiG5NqP
 Wsx+F+qfLafBUYoDOI1Un6Siy/5dTjbtjxvSJ2cGqh6Eq9YX9hntn8hgUCyx1wBn80x2es0
 KvgfrIl6fOF5GbwTewY9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xVF7X6mHlLk=:JWwtOrKFQIuxtzY5AbMnkg
 aAEFXiqf7E5Lw/Um0ajVSTBLH/F6d+rQRuBYp5u1FPczOR0bRAVSfwvMplSGM0azIssCV9aH+
 T0WdhmaviPCwyc61oiIHxAJlPq4Lv6L82A0BLKZCbgNkaD850YP0J3ZaJx3OYmwmpn345l9t2
 tpFxLIC6kVaadCpRrEZnZDb+DjTfkkhsvr1fXTDcJbsxCvMIhQX9+Mpz4agNDZUPlkka/UVLv
 hb9VmWm5FrMw1YRhJnqTbpUmH+VYhUk+UprjV0p5nHqJi1f+QEFK7miSC2CFATZ7mD+Hrmm/F
 aJENXcdpBA5Bds6QzxlgJxCkr9kQtAD3nRfRJM8xgGMm80LxLdj44t+F5UdG7UnGelvzq7G0X
 kTFRedjRAk5nn9cOAr6/0xC3F/oyD6ZOMw3jSj76Qd/PtGlp2klTEXnWsNjoBN5vPT8+RJ+kY
 sAnoXaAbRaiGFqWK7Tt1Pf8rLvWRq6G9luD6lLymTq0sCkcu6sxgB7yM9ZzQDZk2Gt4f4g/oa
 /RSeHRNyDCn1r4HqpQRAznSM/PFY6vX0gUDxSYhTeipVvw3pECtGZQfCvgFjnXPKWk5zXDyLx
 L8xDGG1d/iOKego0Aa+Kj4mUfbe65ZVTNcXkHj6vvKtkCiYsd3tHNZtMO7MAgc07GVLDEbhfW
 eRol/g5wQLVlOFwqnUEwZPBK6HnJIlw76+/giAIbynI5GfX+Dt5bwSZtw8ZOWoLI23f9Qw8s3
 KFCSD1JSyb7LmzESJ+oztcaanJFmFV28pjPC9RAyUwTSPaaqLxYv0I42CbxBnam7KE0v+zqBd
 jeR29F1tShuah3fU8FEwIwDmRWgqLaMjBHYUCjLdw6R2lpQDKpWPnTLxkk2wSgKnvwlD9pqvt
 YcMpwOhZDMUU5+rfPEx3Cen0XLvPB1kHoeIGibO0ACEK8f27Kd0mQRRW48ynqA3ceuG9yRJfS
 tgYrtn+ZDFblGm/Yu4FIP9QDwpkTIbtgds6mGfdflQQhvBMw3DYhqgLxRIhStgI6v8mR/3VqQ
 oe7tmpMEVjISVnjfrd1igx/ph9Uqoi/lF3O8DntJ9CMg+ttv63Z1ql7NE4O1HU/g4zh9D1v7o
 3BTfQZMDG2ndQKMgrN0hk2vaDDHeFL5ffpIzYo5ViuNazYNePp1+fgOMLkbExjzPK0LsGAjFi
 tkd4cZHDbs/eahOYGhL0ymD7sk3h13XEC08tBzTwbTIjZnFl/spUOx5eOeowE2WoDClbiYDyf
 TM6Tr9KN12P4y4ovl
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.08.20 um 17:18 schrieb Taylor Blau:
> On Thu, Aug 13, 2020 at 01:11:18PM +0200, Ren=C3=A9 Scharfe wrote:
>> Simplify the output code by splitting it up and reducing duplication.
>> Reuse the logic for printing object IDs -- anonymized if needed -- by
>> moving it to its own function, print_oid().
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  builtin/fast-export.c | 26 +++++++++++++++-----------
>>  1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/builtin/fast-export.c b/builtin/fast-export.c
>> index 9f37895d4cf..49bb50634ab 100644
>> --- a/builtin/fast-export.c
>> +++ b/builtin/fast-export.c
>> @@ -420,6 +420,14 @@ static const char *anonymize_oid(const char *oid_h=
ex)
>>  	return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
>>  }
>>
>> +static void print_oid(const struct object_id *oid, int anonymize)
>> +{
>> +	const char *oid_hex =3D oid_to_hex(oid);
>> +	if (anonymize)
>> +		oid_hex =3D anonymize_oid(oid_hex);
>> +	fputs(oid_hex, stdout);
>> +}
>> +
>
> The fact that this calls fputs makes this patch (in my own opinion)
> noisier than it needs to be. This is because of all of the factoring out
> of the other printfs. I'd expect that this looks something more like:
>
>   -				       anonymize ?
>   -				       anonymize_oid(oid_to_hex(&spec->oid)) :
>   -				       oid_to_hex(&spec->oid));
>   +				       anonymize_oid(anonymize, &spec->oid));
>
> without moving around all of the other printf code.

Moving that part to anonymize_oid() would reduce the line count while
still getting rid of the duplication.  But the function would need a
new name.

=2D- >8 --
Subject: [PATCH v2] fast-export: deduplicate anonymization handling

Move the code for converting an object_id to a hexadecimal string and
for handling of the default (not anonymizing) case from its callers to
anonymize_oid() and consequently rename it to anonymize_oid_if_needed().
This reduces code duplication.

Suggested-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/fast-export.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 9f37895d4cf..fcc3208727f 100644
=2D-- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -413,10 +413,13 @@ static char *generate_fake_oid(void *data)
 	return hash_to_hex_algop_r(hex, out, the_hash_algo);
 }

-static const char *anonymize_oid(const char *oid_hex)
+static const char *anonymize_oid_if_needed(const struct object_id *oid)
 {
 	static struct hashmap objs;
+	const char *oid_hex =3D oid_to_hex(oid);
 	size_t len =3D strlen(oid_hex);
+	if (!anonymize)
+		return oid_hex;
 	return anonymize_str(&objs, generate_fake_oid, oid_hex, len, NULL);
 }

@@ -476,9 +479,7 @@ static void show_filemodify(struct diff_queue_struct *=
q,
 			 */
 			if (no_data || S_ISGITLINK(spec->mode))
 				printf("M %06o %s ", spec->mode,
-				       anonymize ?
-				       anonymize_oid(oid_to_hex(&spec->oid)) :
-				       oid_to_hex(&spec->oid));
+				       anonymize_oid_if_needed(&spec->oid));
 			else {
 				struct object *object =3D lookup_object(the_repository,
 								      &spec->oid);
@@ -726,10 +727,7 @@ static void handle_commit(struct commit *commit, stru=
ct rev_info *rev,
 		if (mark)
 			printf(":%d\n", mark);
 		else
-			printf("%s\n",
-			       anonymize ?
-			       anonymize_oid(oid_to_hex(&obj->oid)) :
-			       oid_to_hex(&obj->oid));
+			printf("%s\n", anonymize_oid_if_needed(&obj->oid));
 		i++;
 	}

=2D-
2.28.0
