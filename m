Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDEBC433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 10:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbiJMKfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJMKfp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 06:35:45 -0400
Received: from mout.web.de (mout.web.de [212.227.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEB019AC0A
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 03:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665657337; bh=qiTCUGGAzUYuur4x4m5yyZZ0UnR2WU7b/wWFx1V/4ds=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=uYuBEQPKUMwdaUA9NnA9v+K1++ZAuPhdt35eLkRAUpmvpM9IfQzMXYB+1Du6/sj53
         7pV/q73Ey1/TeVCiOZLh0p9L+OSxlFRSzoDdFUeBzk+zi/O2TYyfVjnTT+0a/rZq5Z
         /SIzF9aIKA8wXyBAfrevZdUmL3jU1VNXjl0WNw9OYegvn4dtnIx12WpWv/zOwANW3N
         OLbT9+k7zFUYDwEJMl/5zxo7m/VNRWP5tYfZ03tGTfhAP2SjQo5MoFyUAC2OW1Tuwm
         ef/oTOEtoJe0OLJuiFY/2RcTt/o3obRcosmLxBHgWNcy0hvXB8vgm+i5irEFjV2uW7
         6EP8eKGZKNhGg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MOUxo-1oWDxf33xW-00QD8S; Thu, 13
 Oct 2022 12:35:37 +0200
Message-ID: <27ec1253-4d34-1de2-caee-12bcf1dac03e@web.de>
Date:   Thu, 13 Oct 2022 12:35:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Subject: Re: [PATCH] archive: deduplicate verbose printing
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <af5611aa-8662-7508-4f00-7fcf4e9cbcc6@web.de>
 <221011.86pmeyo7ch.gmgdl@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <221011.86pmeyo7ch.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HHn8RiXpg3mdIKtrDuBNph7b/aOe6jokATZttx2tzO1Qm0d4JJ9
 oGWMwbOY9B8SY30kWxJLovDQuveOVL6JJvXQ3GxBVdVLncijHM69V/N97EFMbu5OtekzUnG
 1FAFI/xA6e8qWceqCnpjQdnp7zV3d9pa1SQfkwtXrfy9gH3jHRP80cvO88SdhWQcZVpr/U7
 E7u8skCb3XKL9rwGR4ayA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k3XXEucepdc=:3kjxl7OeweTm6sOgIk7FCE
 Om78uyqnQy6xtFfFztIKFxcfHx4duSJmSHqB0PHj3rLpbfume1CJPyOGe3hXRNNrPbLtMVhqU
 1Kf44tK7Op3XI2TQQRDAcdUzMd2gO4EszhnuQSzDpbt3fJ1DQR4D3r4sxrhgdd01xLVVgBsBc
 c+AW6Pkud6pqGHk6D/Urlb1PVtwGAY6mOabwcNcErvgZAuOzDJdl7HjYo6g9zap0KtGiS75R7
 CMVG8JW9T9V06JjNi7moG0t7CyNKX9otHyQnn+mmD/umFgUla+QBRajXU8CyzrLdqSvAg0JzL
 NquTmanmh5DjwpNNLezCkfwSpgPCKPqO6g/OpfDaM3A/WXj+q1Ks/haHnJvHn3wjdTxZGetIf
 a/+tnsY/sAR8TN6xhLDENPphKoa9MmAFY2Soeb62AYP2HbxAZyeJnGIVxXP6gpv0z8xcQVK0W
 MRakAT40oyK5wLUQA99/PDIvbJB46cyyAaSKsET67yJmttfX3K91j0qsE+tGzjYwf7gaJoVc1
 NAypHRdb1ziuzTiiUaC2ydiNmQBWMrIWSEQqnX4jpqCpzEKjLYGdFupIDoNmXkFlzbPuXa1s4
 vaNTidFY22t/Irey1y9ouqSsYq5yrzMHIMl/H4XqDZFhArBaq84XOd1zZ5NM6cNgKTkCUJhFo
 +kZFvJZAf+GscM/LgT5IKmbkIOiI7WoaLJJWNrPuiX3y8CKPF++HqdqqoTRQKl5xtka//UPxe
 uHjUhZE4fI+QFEsc+XeG30Hx2fm/3cY5BAeuLNkoP8Gm0ugG+YiBYT91zU5+8s65+pjHP36ka
 UY7P95MxO5PZq5L/7gPBs4/UxPrMJo+ZEf8lZAUzN2/OXRTpLPtJ9CW6A003TChsn78zTqmD1
 DPPcWF7HDvVhSQDtHuLE0UusTtccnHhjOuo1uGYHZ/msnkek0ZT0DO14Ozo9ME1gLsyobjIJG
 UqASTJPa/q4Z8QpltAi6YO0ZLze2j791ACuEx5V70wVKeWqJI0UFhyZoL4uBBQMdfz3vs2iJm
 PvRYVO/5WEb5U2gHpCIcQv8C/EObfRn7kOpC8sBXrihoC70OqAThfTHlZtbPidQ9yOKfKOK7c
 rNLCJjeG9cFrPFYIAbN+oUGWQsTQnnurW6bh6ck0E+kTdrsZGTKQ920Zujxh+pPv0IMwaQH9A
 Z9zyqqbkE25WJhY1T9Xl5FivA6VB2uSuCGvJW4hDGCJd70gd87neeXJUHAoh/nk0xCL7YhUZy
 vMEiu/sa96W315aQY3prnvqSNwawhxC7l0XjFdK55aR8KF6XdND8YPBdiOKC8PFvSWiPWI8ie
 E9wGBRRK3EWWv8x+7RnS4cf6MoZoT8kv/XoRBdGCElRO7EnfW9qG+Ba52Kv6BYKt7IlNl8bdr
 CuECnQpbI67XwHbx5XwC0rs6hAqhFJY8njBp2RU4brgSLIdGXDg1UBs3vRzC0830bevEEX+8w
 Fcn+eUHfoEbMmOZQ0eZ80bRDSbtxnyP2klZUldi6TNXKbOVA86tUtfQ1100YNQ4h7m42rPLY1
 pJ58AMSpu55KaOWHOwU46rFxlHdgrCY/OmJsMMyqSjreI
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.10.22 um 14:45 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Tue, Oct 11 2022, Ren=C3=A9 Scharfe wrote:
>
>> 94bc671a1f (Add directory pattern matching to attributes, 2012-12-08)
>> moved the code for adding the trailing slash to names of directories an=
d
>> submodules up.  This left both branches of the if statement starting
>> with the same conditional fprintf call.  Deduplicate it.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>>  archive.c | 8 +++-----
>>  1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/archive.c b/archive.c
>> index 61a79e4a22..cc1087262f 100644
>> --- a/archive.c
>> +++ b/archive.c
>> @@ -166,18 +166,16 @@ static int write_archive_entry(const struct objec=
t_id *oid, const char *base,
>>  		args->convert =3D check_attr_export_subst(check);
>>  	}
>>
>> +	if (args->verbose)
>> +		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>> +
>>  	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
>> -		if (args->verbose)
>> -			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>>  		err =3D write_entry(args, oid, path.buf, path.len, mode, NULL, 0);
>>  		if (err)
>>  			return err;
>>  		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
>>  	}
>>
>> -	if (args->verbose)
>> -		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>> -
>>  	/* Stream it? */
>>  	if (S_ISREG(mode) && !args->convert &&
>>  	    oid_object_info(args->repo, oid, &size) =3D=3D OBJ_BLOB &&
>
> This looks good, but when trying to validate it with our tests (I added
> a BUG(...)) it seems we have no tests. I tried this on top of master:
>
> 	diff --git a/archive.c b/archive.c
> 	index 61a79e4a227..ed49f6d9106 100644
> 	--- a/archive.c
> 	+++ b/archive.c
> 	@@ -166,18 +166,18 @@ static int write_archive_entry(const struct objec=
t_id *oid, const char *base,
> 	 		args->convert =3D check_attr_export_subst(check);
> 	 	}
>
> 	+	if (args->verbose) {
> 	+		fputs(path.buf, stderr);
> 	+		fputc('\n', stderr);
> 	+	}
> 	+
> 	 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> 	-		if (args->verbose)
> 	-			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> 	 		err =3D write_entry(args, oid, path.buf, path.len, mode, NULL, 0);
> 	 		if (err)
> 	 			return err;
> 	 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> 	 	}
>
> 	-	if (args->verbose)
> 	-		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> 	-
> 	 	/* Stream it? */
> 	 	if (S_ISREG(mode) && !args->convert &&
> 	 	    oid_object_info(args->repo, oid, &size) =3D=3D OBJ_BLOB &&
> 	diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
> 	index fc499cdff01..3e61ba2f3ca 100755
> 	--- a/t/t5003-archive-zip.sh
> 	+++ b/t/t5003-archive-zip.sh
> 	@@ -153,9 +153,18 @@ test_expect_success \
> 	     'remove ignored file' \
> 	     'rm a/ignored'
>
> 	-test_expect_success \
> 	-    'git archive --format=3Dzip' \
> 	-    'git archive --format=3Dzip HEAD >d.zip'
> 	+test_expect_success 'git archive --format=3Dzip' '
> 	+	git archive --format=3Dzip HEAD >d.zip 2>err &&
> 	+	test_must_be_empty err &&
> 	+
> 	+	git ls-tree -t -r HEAD --format=3D"%(path)" >expect.err.raw &&
> 	+	grep -v ignored <expect.err.raw >expect.err &&
> 	+	test_when_finished "rm -f d2.zip" &&
> 	+	git archive --format=3Dzip --verbose HEAD >d2.zip 2>actual.err.raw &&
> 	+	sed -n -e "s,/\$,," -e p <actual.err.raw >actual.err &&
> 	+	test_cmp expect.err actual.err &&
> 	+	test_cmp_bin d.zip d2.zip
> 	+'

I'd expect the tar format to be better suited for such a test because
its lack of compression makes it cheaper.  And I wouldn't want trailing
slashes to be removed from the output -- tar(1) prints them as well.
Comparing to the output of "tar t x.tar" would be nice and easy, but
won't work with old versions and long filenames.  Find my minimal
attempt below.

>
> 	 check_zip d
>
>
> And it'll pass the test with/without the C change.
>
> I'm not sure if it's correct, i.e. are there cases where we really need
> that (int)path.len, it semes that the case in write_archive_entries()
> really does need it, but adding a BUG() there also reaveals that the
> --verbose version (but not non-verbose) is test-less.
>

Not sure what you mean with "need".  strbufs are NUL-terminated and I
think filenames that contain NUL won't work, neither with archive nor
the rest of Git.  So using %s or fputs(3) in write_archive_entry()
should be fine.  But you can't prove that with tests, only disprove it.

I'd tend to use fwrite(3) instead if fprintf(3) would have to be
replaced, but I don't see any performance differences and the more
compact and familiar fprintf(3) seems good enough.


=2D--
 t/t5000-tar-tree.sh | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index eaa0b22ece..91593a5de3 100755
=2D-- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -169,11 +169,22 @@ test_expect_success 'remove ignored file' '
 '

 test_expect_success 'git archive' '
-	git archive HEAD >b.tar
+	git archive HEAD >b.tar 2>err &&
+	test_must_be_empty err
 '

 check_tar b

+test_expect_success 'git archive --verbose' '
+	git archive --verbose HEAD >verbose.tar 2>err &&
+	test_cmp_bin b.tar verbose.tar &&
+	find a -type d | sed s-\$-/- >verbose.lst &&
+	find a \! -type d >>verbose.lst &&
+	sort <verbose.lst >expect &&
+	sort <err >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git archive --prefix=3Dprefix/' '
 	git archive --prefix=3Dprefix/ HEAD >with_prefix.tar
 '
=2D-
2.38.0

