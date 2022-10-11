Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E16C433FE
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 12:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiJKMrV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 08:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJKMrT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 08:47:19 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF85915F9
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 05:47:14 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id a67so10587050edf.12
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 05:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MSYC2f1RXuj9mR+y2heX7ZU3pXGMQSbN0QhJcokN3is=;
        b=EfsRQKYRJC5Ot59B1LTImVcFhLLwob9vaXjKWurN3Q9rFmPyPg04tiuarVbhgL1h3h
         0RjRWGobbHNS4ReylJzJy+Y90E69ZuqKpNufeOIYOZAVOeM2nwBNg5zDHw0nuX2SebNu
         GTXY+awoetbWcOV+pF3UOTCNwMlBX0VbCLSGbr9hCQBmq/40Hu5YLLrZMt2asDgtMpkL
         CqqVXKbrtQl86PiryVsrIs+kx9HO675h2kH6E3vDCUJx7Zl6HR1+BTwPaH6iAWGnlj/p
         2Tvzor7xtK8BZerFTUC6phk9wUjm9Zk/0vyXxT42SVqYN13wYbA9sHDFR3SUgRbJ8o4h
         V2xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MSYC2f1RXuj9mR+y2heX7ZU3pXGMQSbN0QhJcokN3is=;
        b=WM2Wp9wV2F4a5JBp1KoKc1SHwUGli+1BkRIiCsmtRWpagsM1OE/YCJ/tseL1ejXu2E
         xLWNv/owai2CgZJNkrdq4i6ZW8IbAXuimbMEFIMDYWb01BLvT158YzyBVuzYOxf3lfbr
         ozPRFHYe/TJjLPud+aOBkWLDk/s3zq7E9IKEiUAY5MqkBLCj7ocwxWh5+27Vs5psj/j0
         itdAVOAYUBQOySxCMsGypBGP22v28bFCjfHycR3TIS6lQWWNtEq0cEButYM7ps1ALBx2
         sjGgMOrDs4PE5x+8OOUO3kRcqQ6jcB57RntwL/C5ZRmlQSMsiIPID9zkA4d+9L1t7DjT
         xWyg==
X-Gm-Message-State: ACrzQf22S5bEkuLlqmnVm8xf0xW7gze6mtwkMMOS7hpcYd0t4fHpQuHb
        vaVFa8bvwpjlvIEzOgR8UiU=
X-Google-Smtp-Source: AMsMyM5cg5Fiwn+A9XsIGcP/vqLXic86wNaDN5szGA50L1Y7eRop4hBBZwRW9UctI+liullBj6FCIA==
X-Received: by 2002:aa7:c751:0:b0:459:b0e1:4ad7 with SMTP id c17-20020aa7c751000000b00459b0e14ad7mr22587527eds.193.1665492432786;
        Tue, 11 Oct 2022 05:47:12 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id g3-20020a170906594300b007815c3e95f6sm7046830ejr.146.2022.10.11.05.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 05:47:11 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oiEf8-003svv-2H;
        Tue, 11 Oct 2022 14:47:10 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] archive: deduplicate verbose printing
Date:   Tue, 11 Oct 2022 14:45:11 +0200
References: <af5611aa-8662-7508-4f00-7fcf4e9cbcc6@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <af5611aa-8662-7508-4f00-7fcf4e9cbcc6@web.de>
Message-ID: <221011.86pmeyo7ch.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Oct 11 2022, Ren=C3=A9 Scharfe wrote:

> 94bc671a1f (Add directory pattern matching to attributes, 2012-12-08)
> moved the code for adding the trailing slash to names of directories and
> submodules up.  This left both branches of the if statement starting
> with the same conditional fprintf call.  Deduplicate it.
>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  archive.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 61a79e4a22..cc1087262f 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -166,18 +166,16 @@ static int write_archive_entry(const struct object_=
id *oid, const char *base,
>  		args->convert =3D check_attr_export_subst(check);
>  	}
>
> +	if (args->verbose)
> +		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> +
>  	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
> -		if (args->verbose)
> -			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
>  		err =3D write_entry(args, oid, path.buf, path.len, mode, NULL, 0);
>  		if (err)
>  			return err;
>  		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
>  	}
>
> -	if (args->verbose)
> -		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -
>  	/* Stream it? */
>  	if (S_ISREG(mode) && !args->convert &&
>  	    oid_object_info(args->repo, oid, &size) =3D=3D OBJ_BLOB &&

This looks good, but when trying to validate it with our tests (I added
a BUG(...)) it seems we have no tests. I tried this on top of master:
=09
	diff --git a/archive.c b/archive.c
	index 61a79e4a227..ed49f6d9106 100644
	--- a/archive.c
	+++ b/archive.c
	@@ -166,18 +166,18 @@ static int write_archive_entry(const struct object_i=
d *oid, const char *base,
	 		args->convert =3D check_attr_export_subst(check);
	 	}
=09=20
	+	if (args->verbose) {
	+		fputs(path.buf, stderr);
	+		fputc('\n', stderr);
	+	}
	+
	 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
	-		if (args->verbose)
	-			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
	 		err =3D write_entry(args, oid, path.buf, path.len, mode, NULL, 0);
	 		if (err)
	 			return err;
	 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
	 	}
=09=20
	-	if (args->verbose)
	-		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
	-
	 	/* Stream it? */
	 	if (S_ISREG(mode) && !args->convert &&
	 	    oid_object_info(args->repo, oid, &size) =3D=3D OBJ_BLOB &&
	diff --git a/t/t5003-archive-zip.sh b/t/t5003-archive-zip.sh
	index fc499cdff01..3e61ba2f3ca 100755
	--- a/t/t5003-archive-zip.sh
	+++ b/t/t5003-archive-zip.sh
	@@ -153,9 +153,18 @@ test_expect_success \
	     'remove ignored file' \
	     'rm a/ignored'
=09=20
	-test_expect_success \
	-    'git archive --format=3Dzip' \
	-    'git archive --format=3Dzip HEAD >d.zip'
	+test_expect_success 'git archive --format=3Dzip' '
	+	git archive --format=3Dzip HEAD >d.zip 2>err &&
	+	test_must_be_empty err &&
	+
	+	git ls-tree -t -r HEAD --format=3D"%(path)" >expect.err.raw &&
	+	grep -v ignored <expect.err.raw >expect.err &&
	+	test_when_finished "rm -f d2.zip" &&
	+	git archive --format=3Dzip --verbose HEAD >d2.zip 2>actual.err.raw &&
	+	sed -n -e "s,/\$,," -e p <actual.err.raw >actual.err &&
	+	test_cmp expect.err actual.err &&
	+	test_cmp_bin d.zip d2.zip
	+'
=09=20
	 check_zip d
=09=20
=09
And it'll pass the test with/without the C change.

I'm not sure if it's correct, i.e. are there cases where we really need
that (int)path.len, it semes that the case in write_archive_entries()
really does need it, but adding a BUG() there also reaveals that the
--verbose version (but not non-verbose) is test-less.

