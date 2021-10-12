Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF36AC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D70A26101D
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 13:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbhJLNC0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 09:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233883AbhJLNC0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 09:02:26 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 582B8C061570
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:00:24 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ec8so31098147edb.6
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 06:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=L08kvvGxMnG53LPYhhnwPMNDy8DX8/GozPoaYyhm9Gs=;
        b=FYfU+qSWZcC43RO9utQnDGLY4wvDJ2PNqChXyAHd6F9tD1qIsAs33Wx6FewpcbZPF3
         v2/8537E8crDbIdIqwHDwGkZ+T/VXMspWubQGDkMee3Yx8SlIu928boAIWvNgEFx/eRW
         krvmOZe8P/Xo7eLrvN1R6fl/maez0xHF6k+Vn+hqQs2joJcG/T12PwcGtEf5ADC0xH0Q
         VnVXdczit/ikNzuAxATuOGhpxQx++GCSl2U7ChCImUToY2WvKZHT2BXqlpVLwc82Vwk/
         bvCXmoOa4cWtPBf+S5R9dPs+foMd/zx9+JW2FfKSnal9fZKySXz8L5gCFshBrXH2OgbS
         si4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=L08kvvGxMnG53LPYhhnwPMNDy8DX8/GozPoaYyhm9Gs=;
        b=FWZ6yw8W6ABoTBs4+0tlT8/gMHi+Sw3OxZHrJDsKfamwPUVB5Kgr3Jvvn0IYv/kH0d
         11cHgz7ERq2k8Pa7cIKWhqn8SDfc2iJXdbuONz5eaWu0cSlucgWK/qBfEYHZ52aalaIk
         HieYcmvltSMMUM3FFQApcsl1U1bhzkWueC4Knnb4PDf8ik7RdLajdkOtnb3v+FyVxJ9S
         74SLLXsqFu8cPjejrDZ337UcDjTSgRBpfuoFNl2q1WVep7ygcC/DLiK5w/hOjqlCfRgw
         dP9blOKvTEa7ao9xJwkUX5gDQjNbIWnqW2VmfWqaSzzWk0JGHoSJj7JSOLaoqGohdQv2
         U/Rg==
X-Gm-Message-State: AOAM530jRpIwBLmhmerEKiyjW9QwLhCQNbtf6skx2g367L+W1izOQduS
        T8FYz+yDZrU71mQOtOqpFcA=
X-Google-Smtp-Source: ABdhPJy+jO/nd4CZarP0Zr30dFVomGANWiWAL0qxKJU5DbPdiMNiHwsgxoD2X9itrqXCj/9z86tXqg==
X-Received: by 2002:a05:6402:90c:: with SMTP id g12mr10890017edz.140.1634043621446;
        Tue, 12 Oct 2021 06:00:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id yz9sm4929311ejb.51.2021.10.12.06.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 06:00:20 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: ab/config-based-hooks-N status (was Re: [PATCH v5 24/36]
 run-command: add stdin callback for parallelization)
Date:   Tue, 12 Oct 2021 14:59:45 +0200
References: <cover-v4-00.36-00000000000-20210803T191505Z-avarab@gmail.com>
 <cover-v5-00.36-00000000000-20210902T125110Z-avarab@gmail.com>
 <patch-v5-24.36-bb119fa7cc0-20210902T125110Z-avarab@gmail.com>
 <87a6jmiezr.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <87a6jmiezr.fsf@evledraar.gmail.com>
Message-ID: <87lf2yjt3v.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 06 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Thu, Sep 02 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> Emily, there's a...:
>
>> diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
>> index 7ae03dc7123..9348184d303 100644
>> --- a/t/helper/test-run-command.c
>> +++ b/t/helper/test-run-command.c
>> @@ -32,8 +32,13 @@ static int parallel_next(struct child_process *cp,
>>  		return 0;
>>=20=20
>>  	strvec_pushv(&cp->args, d->argv);
>> +	cp->in =3D d->in;
>> +	cp->no_stdin =3D d->no_stdin;
>>  	strbuf_addstr(err, "preloaded output of a child\n");
>>  	number_callbacks++;
>> +
>> +	*task_cb =3D xmalloc(sizeof(int));
>> +	*(int*)(*task_cb) =3D 2;
>>  	return 1;
>>  }
>
> Probably trivial to solve failure here in t0061-run-command.sh if you
> compile with SANITIZE=3Dleak. This failed in combination with my[1] (but
> for anyone reading along, this patch has been ejected from "seen" a
> while ago).
>
> More generally: The equivalent of 01-07/36 of this series is being
> merged into "next". As described in a plan to submit this topic
> incrementally I was hoping to do 08-20/36 next, i.e. up to "run-command:
> remove old run_hook_{le,ve}() hook API". See [2] for that plan.
>
> You've been inactive on-list recently, it would be nice to time this so
> that by the time it gets to 21-36/36 (which I was planning to split in
> two per [2]) that you'd have time to review/help with outstanding issues
> etc, for eventually re-submitting your "config based hooks" on top once
> this all lands.
>
> 1. https://lore.kernel.org/git/patch-02.10-9a8804e1d9a-20211006T094705Z-a=
varab@gmail.com/
> 2. https://lore.kernel.org/git/875yut8nns.fsf@evledraar.gmail.com/

Since I had a reason to look at this again, this fixes it. I've squashed
it into my "base" branch, but it won't be in the next batch I submit (I
have the cut-off point before this commit):

diff --git a/t/helper/test-run-command.c b/t/helper/test-run-command.c
index fa25bcbbc0d..e9b4214d163 100644
--- a/t/helper/test-run-command.c
+++ b/t/helper/test-run-command.c
@@ -61,11 +61,21 @@ static void test_consume_sideband(struct strbuf *output=
, void *cb)
 	fclose(sideband);
 }
=20
+static int task_free(int result,
+		     struct strbuf *err,
+		     void *pp_cb,
+		     void *pp_task_cb)
+{
+	free(pp_task_cb);
+	return 0;
+}
+
 static int task_finished(int result,
 			 struct strbuf *err,
 			 void *pp_cb,
 			 void *pp_task_cb)
 {
+	task_free(0, NULL, NULL, pp_task_cb);
 	strbuf_addstr(err, "asking for a quick stop\n");
 	return 1;
 }
@@ -438,7 +448,7 @@ int cmd__run_command(int argc, const char **argv)
=20
 	if (!strcmp(argv[1], "run-command-parallel"))
 		exit(run_processes_parallel(jobs, parallel_next,
-					    NULL, NULL, NULL, NULL, &proc));
+					    NULL, NULL, NULL, task_free, &proc));
=20
 	if (!strcmp(argv[1], "run-command-abort"))
 		exit(run_processes_parallel(jobs, parallel_next,
@@ -452,12 +462,12 @@ int cmd__run_command(int argc, const char **argv)
 		proc.in =3D -1;
 		proc.no_stdin =3D 0;
 		exit (run_processes_parallel(jobs, parallel_next, NULL,
-					     test_stdin, NULL, NULL, &proc));
+					     test_stdin, NULL, task_free, &proc));
 	}
=20
 	if (!strcmp(argv[1], "run-command-sideband"))
 		exit(run_processes_parallel(jobs, parallel_next, NULL, NULL,
-					    test_consume_sideband, NULL,
+					    test_consume_sideband, task_free,
 					    &proc));
=20
 	fprintf(stderr, "check usage\n");
