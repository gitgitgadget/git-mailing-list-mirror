Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D81AC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208EA613B9
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbhGNXXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 19:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbhGNXXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 19:23:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA46C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:20:16 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id hd33so5969571ejc.9
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=OZ3myiLCjpn/iZzL21zP1z4HoeRg9ml1JQHWV2Qo8Zk=;
        b=jdz5fFVLZcxEQd2tVLiYA6vzV7DRRqFGpyjcNyhP+qpGQzQPa4oTwWs3W5tebHG8iL
         dxgx1tJcs9+zd/SVRzrGvsXKr0B28hKBDO9uQU0k7gifSs18NH0f2Cpzj7+z4QHopPfb
         OXcrF8ws6cZ0Fk1uLaKfUq4VKSC1TTjDL9Db8lYefq11PvbcH4k5CmYFXvfYqsBXW5U/
         2nWq41AWZNvD2BV5Lt1kKo3gONHB7daJqyzGYUatsXNaAHVcMaV1gs9+9psYOZoFDeJm
         7+bFYoZ36vh60wufzSL4bSH6rP1zNQWmBzAA5hNSZMd7dU8ZiGEl75u8RB3ynUqP6V2k
         HqRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=OZ3myiLCjpn/iZzL21zP1z4HoeRg9ml1JQHWV2Qo8Zk=;
        b=qfzvyKZzYRXx1qBy+T/VVsYUPkwMU6ZFFkzL2MnNvQUqV1grsdGBYOEl4r9kdl1c8V
         c6b4VYLeuzIW4e/C41S+Ee9dE6OGJTGr1lcswA5UPuacKIIB3JJ6K+p4kBCp6NCrK7Ib
         9Z9Xf7T3VtuA/JSGHDlZhDDiFrelns94uz2MWnXUdkcWjskrDAmB+P7P5DpBh2SgEI7C
         x4Ot4TwdAYsBG4XqVLL+0thS8lhy6ARWtITNwq/sCHPyYaKH1PTXmVI0/yTmfOMcY2c3
         f6AMVhYe31/7yzgTbcie7A0O8yPNRZQcQKQ6j13FA3e28PbIBvNWJkEQ7VS2/wzlrv71
         I3Cg==
X-Gm-Message-State: AOAM533oL4Yo8XOIhtHxLVNO3Ye0epZHUdvCSU62mjTNuCDZp54e6Rij
        9RHUzhUgU17oueic9n+0R7F8XWbuh7sMi3v4
X-Google-Smtp-Source: ABdhPJyUu7emRfA4d5h/stLnZhsX7cwJ/VmrlADiokB8wEBG7pgNDqtOoSDgXayIaQqQNmEdSqJtNQ==
X-Received: by 2002:a17:907:397:: with SMTP id ss23mr697207ejb.470.1626304815227;
        Wed, 14 Jul 2021 16:20:15 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jg9sm1210180ejc.6.2021.07.14.16.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:20:14 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Luke Shumaker <lukeshu@lukeshu.com>,
        Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 1/1] completion: graduate out of contrib
Date:   Thu, 15 Jul 2021 01:17:04 +0200
References: <20210710234629.17197-1-felipe.contreras@gmail.com>
 <20210714202344.614468-1-felipe.contreras@gmail.com>
 <20210714202344.614468-2-felipe.contreras@gmail.com>
 <87bl74zdtb.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <87bl74zdtb.fsf@evledraar.gmail.com>
Message-ID: <878s28zdmz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jul 15 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Wed, Jul 14 2021, Felipe Contreras wrote:
>> [...]
>> @@ -2399,7 +2399,7 @@ test_expect_success 'sourcing the completion scrip=
t clears cached --options' '
>>  	verbose test -n "$__gitcomp_builtin_checkout" &&
>>  	__gitcomp_builtin notes_edit &&
>>  	verbose test -n "$__gitcomp_builtin_notes_edit" &&
>> -	. "$GIT_BUILD_DIR/contrib/completion/git-completion.bash" &&
>> +	. "$GIT_BUILD_DIR/extra/completion/git-completion.bash" &&
>>  	verbose test -z "$__gitcomp_builtin_checkout" &&
>>  	verbose test -z "$__gitcomp_builtin_notes_edit"
>>  '
>>
>> diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
>> index bbd513bab0..784e523fd4 100755
>> --- a/t/t9903-bash-prompt.sh
>> +++ b/t/t9903-bash-prompt.sh
>> @@ -10,7 +10,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>>=20=20
>>  . ./lib-bash.sh
>>=20=20
>> -. "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
>> +. "$GIT_BUILD_DIR/extra/completion/git-prompt.sh"
>>=20=20
>>  actual=3D"$TRASH_DIRECTORY/actual"
>>  c_red=3D'\\[\\e[31m\\]'
>
> It's more of a "for bonus points", but a nic way to round-trip this
> would be to make this work with GIT_TEST_INSTALLED.
>
> I.e. source these relative to GIT_EXEC_PATH, not $GIT_BUILD_DIR, I think
> that just sourcing them as e.g.:
>
>     . git-completion.bash
>
> But the GIT_TEST_INSTALLED case is tricker, maybe we'd need to add a
> "git --share-path" :(

I forgot to include this not-working patch, i.e. I've got no idea what
the "something" should be other than the harder thing of compiling
"sharedir" into git and making "git --share-path" work.

It's not /that/ bad, see the grep for GIT_LOCALE_PATH, still a bit
painful, and maybe not worth it for this change...

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 98e20950c3..0a9fbfc253 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1301,7 +1301,7 @@ elif test -n "$GIT_TEST_INSTALLED"
 then
 	GIT_EXEC_PATH=3D$($GIT_TEST_INSTALLED/git --exec-path)  ||
 	error "Cannot run git from $GIT_TEST_INSTALLED."
-	PATH=3D$GIT_TEST_INSTALLED:$GIT_BUILD_DIR/t/helper:$PATH
+	PATH=3D$GIT_TEST_INSTALLED:$GIT_TEST_INSTALLED/something:$GIT_BUILD_DIR/t=
/helper:$PATH
 	GIT_EXEC_PATH=3D${GIT_TEST_EXEC_PATH:-$GIT_EXEC_PATH}
 else # normal case, use ../bin-wrappers only unless $with_dashes:
 	if test -n "$no_bin_wrappers"
@@ -1322,7 +1322,7 @@ else # normal case, use ../bin-wrappers only unless $=
with_dashes:
 	GIT_EXEC_PATH=3D$GIT_BUILD_DIR
 	if test -n "$with_dashes"
 	then
-		PATH=3D"$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$PATH"
+		PATH=3D"$GIT_BUILD_DIR:$GIT_BUILD_DIR/t/helper:$GIT_BUILD_DIR/extra/comp=
letion:$PATH"
 	fi
 fi
 GIT_TEMPLATE_DIR=3D"$GIT_BUILD_DIR"/templates/blt
